module L = Llvm
module A = Ast
open Sast 

module StringMap = Map.Make(String)

type var_table = {
  variables: L.llvalue StringMap.t;
  parent: var_table option;
}

let translate ((vdecls : svdecl list), (fdecls : sfdecl list)) =

  (************************** Initialize **************************)

  let context    = L.global_context () in
  (* Add types to the context so we can use them in our LLVM code *)
  let (*rec*) i32_t      = L.i32_type    context (* int *)
  and i8_t       = L.i8_type     context (* llvm pointer, char *)
  and i1_t       = L.i1_type     context (* bool *)
  and void_t     = L.void_type   context (* void, polys *)
  and str_t      = L.pointer_type (L.i8_type context) (* string *)
  and bit_t      = L.i1_type      context (* bit *)
  and nibble_t   = L.integer_type context 4 (* nibble *)
  and byte_t     = L.i8_type      context (* byte *)
  and word_t     = L.i16_type     context (* word *)
  and voidptr_t  = L.pointer_type (L.i8_type context)
  and nodeptr_t  = L.pointer_type (L.named_struct_type context "Node") 
  and pointer_t  = L.pointer_type
  (* and list_t     = L.pointer_type (L.struct_type context [| voidptr_t; nodeptr_t |]) list *)

  (* Create an LLVM module -- this is a "container" into which we'll 
     generate actual code *)
  and the_module = L.create_module context "Chomp" in

  (************************** Helper Functions **************************)

  let scope_obj = {variables = StringMap.empty; parent = None;} in 
  let scope = ref scope_obj in

  (* Convert CHOMP types to LLVM types *)
  let rec ltype_of_typ = function
      A.Int   -> i32_t
    | A.Bool  -> i1_t
    | A.Void  -> void_t
    | A.Char -> i8_t
    | A.List ty -> raise (Semant.TypeError ("TODO: list typ"))
    | A.Bit -> bit_t
    | A.Nibble -> nibble_t
    | A.Byte  -> byte_t
    | A.Word -> word_t
    | A.Func (fs, ret) -> 
      let func_t =
        L.function_type (ltype_of_typ ret)
        (Array.of_list (List.map ltype_of_typ fs))
      in pointer_t func_t
    | A.String -> str_t
    | A.Poly -> raise (Semant.TypeError ("Poly type isn't accessible by user"))
    | A.Bin -> raise (Semant.TypeError ("Bin type isn't accessible by user"))
  in
    
  (* define C linked functions *)
  let printf_t : L.lltype = 
      L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
  let printf_func : L.llvalue = 
     L.declare_function "printf" printf_t the_module in

  let printbit_t = L.function_type i32_t [| bit_t |] in
  let printbit_func = L.declare_function "print_bit" printbit_t the_module in
  
  let printnibble_t = L.function_type i32_t [| nibble_t |] in
  let printnibble_func = L.declare_function "print_nibble" printnibble_t the_module in

  let printbyte_t = L.function_type i32_t [| byte_t |] in
  let printbyte_func = L.declare_function "print_byte" printbyte_t the_module in
  
  let printword_t = L.function_type i32_t [| word_t |] in
  let printword_func = L.declare_function "print_word" printword_t the_module in

  (* converts bin string to integer representation of value *)
  let rec bin_to_int (acc : int) (c : char) =
    if c = '0'
      then acc * 2
    else acc * 2 + 1
  in

  (* finds variable in given scope *)
  let rec find_variable (scope: var_table ref) name = 
    try
      StringMap.find name !scope.variables
    with Not_found -> 
      match !scope.parent with 
        Some(parent) -> find_variable (ref parent) name
        | _          -> raise (Semant.NotFoundError ("Find: unidentified id " ^ name))
  in

  (* ensure that the variable is not already in given scope *)
  let rec dont_find_variable (scope: var_table ref) name = 
    try
      let _ = StringMap.find name !scope.variables in 
      raise (Semant.DupError ("Can't redeclare id " ^ name))
    with Not_found -> 
      (match !scope.parent with 
        Some(parent) -> dont_find_variable (ref parent) name
        | _          -> true)
    | Semant.DupError err -> raise (Semant.DupError err)
  in

  (* assign variable in given scope, only call if id is declared already *)
  let rec assign_variable (scope: var_table ref) name exp = 
    try
      let _ = StringMap.find name !scope.variables in
      StringMap.add name exp !scope.variables
    with Not_found -> 
      match !scope.parent with 
        Some(parent) -> assign_variable (ref parent) name exp
        | _          -> raise (Semant.NotFoundError ("Assign: unidentified id " ^ name))
  in

  (************************** Function Decls **************************)

  (* Define each function (arguments and return type) so we can 
   * define it's body and call it later *)
  let function_decls : (L.llvalue * sfdecl) StringMap.t =
    let function_decl m fdecl =
      let name = fdecl.sfname
      and formal_types = 
	Array.of_list (List.map (fun (t,_) -> ltype_of_typ t) fdecl.sformals)
      in let ftype = L.function_type (ltype_of_typ fdecl.styp) formal_types in
      StringMap.add name (L.define_function name ftype the_module, fdecl) m in
    List.fold_left function_decl StringMap.empty fdecls in
  
  (* Fill in the body of the given function *)
  let build_function_body fdecl =
    let (the_function, _) = StringMap.find fdecl.sfname function_decls in
    let builder = L.builder_at_end context (L.entry_block the_function) in

    let int_format_str = L.build_global_stringptr "%d" "fmt" builder
    and string_format_str = L.build_global_stringptr "%s" "fmt" builder 
    and char_format_str = L.build_global_stringptr "%c" "fmt" builder
    and string_format_ln = L.build_global_stringptr "\n" "fmt" builder in

    (* Construct the function's "locals": formal arguments and locally
       declared variables.  Allocate each on the stack, initialize their
       value, if appropriate, and remember their values in the "locals" map *)
    let local_vars =
      let add_formal m (t, n) p = 
        let () = L.set_value_name n p in
	      let local = L.build_alloca (ltype_of_typ t) n builder in
        let _  = L.build_store p local builder in
	      StringMap.add n local m 
      in

      (* Allocate space for any locally declared variables and add the
       * resulting registers to our map *)
      let add_local m (t, n) =
	      let local_var = L.build_alloca (ltype_of_typ t) n builder
	      in StringMap.add n local_var m 
      in

      let formals = List.fold_left2 add_formal StringMap.empty fdecl.sformals
          (Array.to_list (L.params the_function)) 
      in List.fold_left add_local formals fdecl.sformals
    in

    (************************** Convert exprs **************************)

    (* Construct code for an expression; return its value *)
    let rec expr builder (scope: var_table ref) e (*(((ty, e) : sexpr)) *) = match e with
	      SLiteral i -> L.const_int i32_t i
      | SStringLit s -> L.build_global_stringptr s "string" builder
      | SBoolLit b -> L.const_int i1_t (if b then 1 else 0)
      | SNoexpr -> L.const_int i32_t 0
      | SId s -> L.build_load (find_variable scope s) s builder
      | SAssign (s, e) -> let e' = expr builder scope (snd e) in
                          let _ = assign_variable scope s e' in
                          L.build_store e' (find_variable scope s) builder 
      | SBitLit b -> L.const_int bit_t (if b = "0" then 0 else 1)
      | SNibbleLit b -> 
        L.const_int nibble_t (String.fold_left bin_to_int 0 b)
      | SByteLit b -> L.const_int byte_t (String.fold_left bin_to_int 0 b)
      | SWordLit b -> L.const_int word_t (String.fold_left bin_to_int 0 b)
      | SBinop (e1, op, e2) -> (*raise (Semant.TypeError ("TODO: Binop"))*)
        let (t, _) = e1
        and e1' = expr builder scope (snd e1)
        and e2' = expr builder scope (snd e2) in
        (match op with 
        | A.Add     -> L.build_add
        | A.Sub     -> L.build_sub
        | A.Mult    -> L.build_mul
        | A.Div     -> L.build_sdiv
        | A.And     -> L.build_and
        | A.Or      -> L.build_or
        | A.Equal   -> L.build_icmp L.Icmp.Eq
        | A.Neq     -> L.build_icmp L.Icmp.Ne
        | A.Less    -> L.build_icmp L.Icmp.Slt
        | A.Leq     -> L.build_icmp L.Icmp.Sle
        | A.Greater -> L.build_icmp L.Icmp.Sgt
        | A.Geq     -> L.build_icmp L.Icmp.Sge
        ) e1' e2' "tmp" builder
      | SUnop(op, e) -> raise (Semant.TypeError ("TODO: Unop"))
	  (* let (t, _) = e in
          let e' = expr builder e in
	  (match op with
	    A.Neg when t = A.Float -> L.build_fneg 
	  | A.Neg                  -> L.build_neg 
          | A.Not                  -> L.build_not) e' "tmp" builder *)
    | SCall ("println", [e]) -> 
      let e' = (expr builder scope (snd e)) in
      let _ = (match (fst e) with 
          Int -> L.build_call printf_func [| int_format_str ; e' |] "printf" builder
          | Bool -> L.build_call printf_func [| int_format_str; e' |] "printf" builder
          | Char -> L.build_call printf_func [| char_format_str ; e' |] "printf" builder
          | Bit -> L.build_call printbit_func [| e' |] "print_bit" builder
          | Nibble -> L.build_call printnibble_func [| e' |] "print_nibble" builder
          | Byte -> L.build_call printbyte_func [| e' |] "print_byte" builder
          | Word -> L.build_call printword_func [| e' |] "print_word" builder
          | String -> L.build_call printf_func [| string_format_str ; e' |] "printf" builder)
    in L.build_call printf_func [| string_format_ln |] "printf" builder
      | SCall ("print", [e]) -> 
        let e' = (expr builder scope (snd e)) in
        (match (fst e) with 
            Int -> L.build_call printf_func [| int_format_str ; e' |] "printf" builder
            | Bool -> L.build_call printf_func [| int_format_str ; e' |] "printf" builder
            | Char -> L.build_call printf_func [| char_format_str ; e' |] "printf" builder
            | Bit -> L.build_call printbit_func [| e' |] "print_bit" builder
            | Nibble -> L.build_call printnibble_func [| e' |] "print_nibble" builder
            | Byte -> L.build_call printbyte_func [| e' |] "print_byte" builder
            | Word -> L.build_call printword_func [| e' |] "print_word" builder
            | String -> L.build_call printf_func [| string_format_str ; e' |] "printf" builder)
      | SCall (f, args) ->
        let (fdef, fdecl) = StringMap.find f function_decls in
        let llargs = List.rev (List.map (expr builder scope) (List.map snd (List.rev args))) in
        let result = (match fdecl.styp with 
                        A.Void -> ""
                      | _ -> f ^ "_result") 
        in L.build_call fdef (Array.of_list llargs) result builder
      | _ -> raise (Semant.TypeError ("TODO : wildcard"))
    in

    (* declare variable; remember its value in a map, can only be called on 
       variables that have not previously been defined in the scope *)
    let add_variable (scope: var_table ref) (t : A.typ) n e builder =
      let _ = dont_find_variable scope n in
      let ltype = ltype_of_typ t in
      let e' = let (_, ex) = e in (match ex with
          SNoexpr -> L.const_null ltype
        | _ -> expr builder scope (snd e))
      in L.set_value_name n e';
      let l_var = L.build_alloca ltype n builder in
      let _ = L.build_store e' l_var builder in
      scope := {
        variables = StringMap.add n l_var !scope.variables;
        parent = !scope.parent;
      }
    in
    
    (* Each basic block in a program ends with a "terminator" instruction i.e.
    one that ends the basic block. By definition, these instructions must
    indicate which basic block comes next -- they typically yield "void" value
    and produce control flow, not values *)
    (* Invoke "instr builder" if the current block doesn't already
       have a terminator (e.g., a branch). *)
    let add_terminal builder instr =
                           (* The current block where we're inserting instr *)
      match L.block_terminator (L.insertion_block builder) with
	Some _ -> ()
      | None -> ignore (instr builder) in

    (************************** Convert Statements **************************)
	
    (* Build the code for the given statement; return the builder for
       the statement's successor (i.e., the next instruction will be built
       after the one generated by this call) *)
    (* Imperative nature of statement processing entails imperative OCaml *)
    let rec stmt builder scope = function
	    SBlock sl ->
        let scope'_obj = {
          variables = StringMap.empty;
          parent = Some(!scope);
        } in
        let scope' = ref scope'_obj in
        let build builder curr_stmt = stmt builder scope' curr_stmt in
        let _ = List.fold_left build builder sl in
        let scope = !scope.parent in builder
        (* Generate code for this expression, return resulting builder *)
      | SExpr e -> let _ = expr builder scope (snd e) in builder 
      | SVar (v) ->
        let _ = add_variable scope v.styp v.svname v.svalue builder in builder
      | SReturn e -> let _ = match fdecl.styp with
                              (* Special "return nothing" instr *)
                              A.Void -> L.build_ret_void builder 
                              (* Build return statement *)
                            | _ -> L.build_ret (expr builder scope (snd e)) builder 
                     in builder
      (* The order that we create and add the basic blocks for an If statement
      doesnt 'really' matter (seemingly). What hooks them up in the right order
      are the build_br functions used at the end of the then and else blocks (if
      they don't already have a terminator) and the build_cond_br function at
      the end, which adds jump instructions to the "then" and "else" basic blocks *)
      | SIf (predicate, then_stmt, else_stmt) ->
         let bool_val = expr builder scope (snd predicate) in
         (* Add "merge" basic block to our function's list of blocks *)
	 let merge_bb = L.append_block context "merge" the_function in
         (* Partial function used to generate branch to merge block *) 
         let branch_instr = L.build_br merge_bb in

         (* Same for "then" basic block *)
	 let then_bb = L.append_block context "then" the_function in
         (* Position builder in "then" block and build the statement *)
         let then_builder = stmt (L.builder_at_end context then_bb) scope then_stmt in
         (* Add a branch to the "then" block (to the merge block) 
           if a terminator doesn't already exist for the "then" block *)
	 let () = add_terminal then_builder branch_instr in

         (* Identical to stuff we did for "then" *)
	 let else_bb = L.append_block context "else" the_function in
         let else_builder = stmt (L.builder_at_end context else_bb) scope else_stmt in
	 let () = add_terminal else_builder branch_instr in

         (* Generate initial branch instruction perform the selection of "then"
         or "else". Note we're using the builder we had access to at the start
         of this alternative. *)
	 let _ = L.build_cond_br bool_val then_bb else_bb builder in
         (* Move to the merge block for further instruction building *)
	 L.builder_at_end context merge_bb

      | SWhile (predicate, body) ->
          (* First create basic block for condition instructions -- this will
          serve as destination in the case of a loop *)
	  let pred_bb = L.append_block context "while" the_function in
          (* In current block, branch to predicate to execute the condition *)
	  let _ = L.build_br pred_bb builder in

          (* Create the body's block, generate the code for it, and add a branch
          back to the predicate block (we always jump back at the end of a while
          loop's body, unless we returned or something) *)
	  let body_bb = L.append_block context "while_body" the_function in
          let while_builder = stmt (L.builder_at_end context body_bb) scope body in
	  let () = add_terminal while_builder (L.build_br pred_bb) in

          (* Generate the predicate code in the predicate block *)
	  let pred_builder = L.builder_at_end context pred_bb in
	  let bool_val = expr pred_builder scope (snd predicate) in

          (* Hook everything up *)
	  let merge_bb = L.append_block context "merge" the_function in
	  let _ = L.build_cond_br bool_val body_bb merge_bb pred_builder in
	  L.builder_at_end context merge_bb

      (* Implement for loops as while loops! *)
      | SFor (e1, e2, e3, body) -> stmt builder scope
	    ( SBlock [SExpr e1 ; SWhile (e2, SBlock [body ; SExpr e3]) ] )
      | _ -> raise (Semant.TypeError ("TODO: rest of stmt")) 
    in

    (************************** Driver Code **************************)

    (* load globals *)
    let _ = List.map (fun (x : svdecl) -> add_variable scope x.styp x.svname x.svalue builder) (vdecls : svdecl list) in
    (* Build the code for each statement in the function *)
    let builder = stmt builder scope (SBlock fdecl.sbody) in

    (* Add a return if the last block falls off the end *)
    add_terminal builder (match fdecl.styp with
        A.Void -> L.build_ret_void
      | t -> L.build_ret (L.const_int (ltype_of_typ t) 0))
  in

  List.iter build_function_body fdecls;
  the_module
