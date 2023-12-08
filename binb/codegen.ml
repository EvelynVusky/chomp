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
  let i32_t      = L.i32_type    context (* int, char *)
  and i8_t       = L.i8_type     context (* llvm pointer *)
  and i1_t       = L.i1_type     context (* bool *)
  and void_t     = L.void_type   context (* void *)
  and str_t      = L.pointer_type (L.i8_type context) (* string *)
  and bit_t      = L.i32_type     context (* bit *)
  and nibble_t   = L.i32_type     context (* nibble *)
  and byte_t     = L.i32_type     context (* byte *)
  and word_t     = L.i32_type     context (* word *)
  and pointer_t  = L.pointer_type

  (* Create an LLVM module -- this is a "container" into which we'll 
     generate actual code *)
  and the_module = L.create_module context "Chomp" in

  (* Define list structs & helper functions *)
  let int_node_struct = L.named_struct_type context "int_node" in
  let bool_node_struct = L.named_struct_type context "bool_node" in
  let string_node_struct = L.named_struct_type context "string_node" in 
  let bit_node_struct = L.named_struct_type context "bit_node" in 
  let nibble_node_struct = L.named_struct_type context "nibble_node" in 
  let byte_node_struct = L.named_struct_type context "byte_node" in 
  let word_node_struct = L.named_struct_type context "word_node" in 
  let char_node_struct = L.named_struct_type context "char_node" in 
  (*list node*)

  let int_node_pointer = L.pointer_type int_node_struct in
  let bool_node_pointer = L.pointer_type bool_node_struct in
  let string_node_pointer = L.pointer_type string_node_struct in
  let bit_node_pointer = L.pointer_type bit_node_struct in
  let nibble_node_pointer = L.pointer_type nibble_node_struct in
  let byte_node_pointer = L.pointer_type byte_node_struct in
  let word_node_pointer = L.pointer_type word_node_struct in 
  let char_node_pointer = L.pointer_type char_node_struct in

  let define_struct struct_ty args =
    L.struct_set_body struct_ty (Array.of_list args) true
  in

  let _ = define_struct int_node_struct [i32_t; int_node_pointer; i1_t]
  in
  let _ = define_struct bool_node_struct [i1_t; bool_node_pointer; i1_t]
  in
  let _ = define_struct string_node_struct [str_t; string_node_pointer; i1_t]
  in
  let _ = define_struct bit_node_struct [bit_t; bit_node_pointer; i1_t]
  in
  let _ = define_struct nibble_node_struct [nibble_t; nibble_node_pointer; i1_t]
  in
  let _ = define_struct byte_node_struct [byte_t; byte_node_pointer; i1_t]
  in
  let _ = define_struct word_node_struct [word_t; word_node_pointer; i1_t]
  in
  let _ = define_struct char_node_struct [i32_t; char_node_pointer; i1_t]
  in

  let get_node_ty ty = match ty with
      A.Int -> int_node_struct
    | A.Bool -> bool_node_struct
    | A.String -> string_node_struct
    | A.Bit -> bit_node_struct
    | A.Nibble -> nibble_node_struct
    | A.Byte -> byte_node_struct
    | A.Word -> word_node_struct
    | A.Char -> char_node_struct
    | A.Poly -> int_node_struct
    (*A.List TODO*)
    | _ -> raise (Semant.TypeError ("Invalid list type: " ^ A.string_of_typ ty))
  in

  let get_node_ptr_ty ty = (match ty with
      A.Int -> int_node_pointer
    | A.Bool -> bool_node_pointer
    | A.String -> string_node_pointer
    | A.Bit -> bit_node_pointer
    | A.Nibble -> nibble_node_pointer
    | A.Byte -> byte_node_pointer
    | A.Word -> word_node_pointer
    | A.Char -> char_node_pointer
    | A.Poly -> int_node_pointer
  (*A.List TODO*)
    | _ -> raise (Semant.TypeError ("Invalid list pointer type: " ^ A.string_of_typ ty)))
  in

  (************************** Helper Functions **************************)

  (* Convert CHOMP types to LLVM types *)
  let rec ltype_of_typ = function
      A.Int   -> i32_t
    | A.Bool  -> i1_t
    | A.Void  -> void_t
    | A.Char -> i8_t
    | A.List ty -> get_node_ptr_ty ty
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

  let exit_t : L.lltype = 
    L.var_arg_function_type i32_t [| i32_t |] in
  let exit_func : L.llvalue = 
    L.declare_function "exit" exit_t the_module in

  (* converts bin string to integer representation of value *)
  let bin_to_int (acc : int) (c : char) =
    if c = '0'
      then acc * 2
    else acc * 2 + 1
  in 

  (* finds variable in given scope *)
  let rec find_variable (scope: var_table) name = 
    try
      StringMap.find name scope.variables
    with Not_found -> 
      match scope.parent with 
        Some(parent) -> find_variable (parent) name
        | _          -> raise (Semant.NotFoundError ("Find: unidentified id " ^ name))
  in

  (* ensure that the variable is not already in given scope *)
  let rec dont_find_variable (scope: var_table) name = 
    try
      let _ = StringMap.find name scope.variables in 
      raise (Semant.DupError ("Can't redeclare id " ^ name))
    with Not_found -> 
      (match scope.parent with 
        Some(parent) -> dont_find_variable (parent) name
        | _          -> true)
    | Semant.DupError err -> raise (Semant.DupError err)
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

  (* let dump_scope scope acc = 
    let lst = ref [] in
    let _ = StringMap.iter (fun key _ -> ignore (lst := List.cons key !lst)) scope.variables in
    let str = List.fold_left (fun s acc -> acc ^ " " ^ s) acc !lst in
    raise (Semant.TypeError str)
  in *)

  (************************** Function Decls **************************)

  (* Define each function (arguments and return type) so we can 
   * define it's body and call it later *)
  let function_decls : (L.llvalue * sfdecl) StringMap.t =
    let function_decl m fdecl =
      let name = fdecl.sfname
        and formal_types = Array.of_list (List.map (fun (t,_) -> ltype_of_typ t) fdecl.sformals)
      in 
      let ftype = L.function_type (ltype_of_typ fdecl.styp) formal_types 
      in StringMap.add name (L.define_function name ftype the_module, fdecl) m 
    in
    List.fold_left function_decl StringMap.empty fdecls
  in
  
  (* Fill in the body of the given function *)
  let build_program =
    let (the_function, _) = StringMap.find "main" function_decls in
    (* create builder for program *)
    let builder = L.builder_at_end context (L.entry_block the_function) in

    (* define format strings *)
    let int_format_str = L.build_global_stringptr "%d" "fmt" builder
    and string_format_str = L.build_global_stringptr "%s" "fmt" builder 
    and char_format_str = L.build_global_stringptr "%c" "fmt" builder
    and string_format_ln = L.build_global_stringptr "\n" "fmt" builder 
    and car_err_format_str = L.build_global_stringptr "Error: cannot call car on empty list" "fmt" builder
    and cdr_err_format_str = L.build_global_stringptr "Error: cannot call cdr on empty list" "fmt" builder in


    (************************** Convert exprs **************************)

    (* TODO: cons, cdr, call (built-ins) *)
    (* Construct code for an expression; return its value *)
    let rec expr builder (scope: var_table) (e: sexpr) = match (snd e) with
	      SLiteral i -> (scope, L.const_int i32_t i)
      | SStringLit s -> (scope, L.build_global_stringptr s "string" builder)
      | SBoolLit b -> (scope, L.const_int i1_t (if b then 1 else 0))
      | SNoexpr -> (scope, L.const_int i32_t 0)
      | SNull -> (scope, L.const_null void_t)
      | SCharLit c -> (scope, L.const_int i32_t (Char.code c))
      | SId s -> 
        (scope, L.build_load (find_variable scope s) s builder)
      | SAssign (s, e) -> let (scope, e') = expr builder scope e in
                          (scope, L.build_store e' (find_variable scope s) builder)
      | SBitLit b -> (scope, L.const_int bit_t (if b = "0" then 0 else 1))
      | SNibbleLit b -> 
        (scope, L.const_int nibble_t (String.fold_left bin_to_int 0 b))
      | SByteLit b -> (scope, L.const_int byte_t (String.fold_left bin_to_int 0 b))
      | SWordLit b -> (scope, L.const_int word_t (String.fold_left bin_to_int 0 b))
      | SList lst -> 
        if (fst e) = List(Poly) then 
          let node_struct = L.const_named_struct int_node_struct
                                (Array.of_list [(L.const_int i32_t 1); 
                                (L.const_pointer_null (L.pointer_type int_node_struct)); 
                                (L.const_int i1_t 1)]) in
          let node_var = L.build_alloca int_node_struct "front_node_var" builder in
          let _ = ignore(L.build_store node_struct node_var builder) in
          (scope, node_var)
         else
        (let list_ty = match (fst e) with 
          | List ty -> ty
          | _ -> raise (Semant.InvalidError "Not a list")
        in
        let list_node_ty = get_node_ty list_ty in
        let build_list acc curr = 
          let (_, e1) = (expr builder scope curr) in
          (* make & populate struct node with curr's value *)
          let front_node_struct = L.const_named_struct list_node_ty
                           (Array.of_list [e1; 
                            L.const_pointer_null (L.pointer_type list_node_ty);
                            L.const_int i1_t 0]) in
          (* save current node *)
          let front_node_var = L.build_alloca list_node_ty "front_node_var" builder in
          let _ = ignore(L.build_store front_node_struct front_node_var builder) in
          (* set prev's next to current *)
          let front_node_next = L.build_struct_gep front_node_var 1 "front_node_next" builder in
          let _ = ignore(L.build_store acc front_node_next builder) in
          front_node_var
        in 
        let last_node = L.const_named_struct list_node_ty
          (Array.of_list [L.const_null (ltype_of_typ list_ty); 
          L.const_pointer_null (L.pointer_type list_node_ty); L.const_int i1_t 1])
        in
        let last_node_var = L.build_alloca list_node_ty "last_node_var" builder in
        let _ = ignore(L.build_store last_node last_node_var builder) in
        (scope, List.fold_left build_list last_node_var lst))
      | SBinop (e1, op, e2) ->
        let (scope, e1') = expr builder scope e1 in 
        let (scope, e2') = expr builder scope e2 in
        (scope, (match op with
        | A.Add     -> L.build_add e1' e2' "tmp" builder
        | A.Sub     -> L.build_sub e1' e2' "tmp" builder
        | A.Mult    -> L.build_mul e1' e2' "tmp" builder
        | A.Div     -> L.build_sdiv e1' e2' "tmp" builder
        | A.And | A.Binand -> L.build_and e1' e2' "tmp" builder
        | A.Or | A.Binor -> L.build_or e1' e2' "tmp" builder
        | A.Equal   -> L.build_icmp L.Icmp.Eq e1' e2' "tmp" builder
        | A.Neq     -> L.build_icmp L.Icmp.Ne e1' e2' "tmp" builder
        | A.Less    -> L.build_icmp L.Icmp.Slt e1' e2' "tmp" builder
        | A.Leq     -> L.build_icmp L.Icmp.Sle e1' e2' "tmp" builder
        | A.Greater -> L.build_icmp L.Icmp.Sgt e1' e2' "tmp" builder
        | A.Geq     -> L.build_icmp L.Icmp.Sge e1' e2' "tmp" builder
        | A.Lshift  -> L.build_shl e1' e2' "tmp" builder
        | A.Rshift  -> L.build_ashr e1' e2' "tmp" builder
        | A.Concat  -> (match (fst e1, fst e2) with
            | (_, Bit) -> 
              let e1' = L.build_shl e1' (L.const_int i32_t 1) "tmp" builder in
              let e2' = L.build_and e2' (L.const_int i32_t 1) "tmp" builder in
              L.build_or e1' e2' "tmp" builder
            | (_, Nibble) -> 
              let e1' = L.build_shl e1' (L.const_int i32_t 4) "tmp" builder in
              let e2' = L.build_and e2' (L.const_int i32_t 15) "tmp" builder in
              L.build_or e1' e2' "tmp" builder
            | (_, Byte) ->
              let e1' = L.build_shl e1' (L.const_int i32_t 8) "tmp" builder in
              let e2' = L.build_and e2' (L.const_int i32_t 255) "tmp" builder in
              L.build_or e1' e2' "tmp" builder
            | (Word, _) -> e1'
            | (_, Word) -> e2'
            | _ -> raise (Semant.InvalidError ("Concat is only applicable to Bin types")))
        | A.Binxor  -> L.build_xor e1' e2' "tmp" builder
        | A.Cons    -> 
          (* make e1 node *)
          let (scope, e1') = expr builder scope e1 in
          let list_node_ty = get_node_ty (fst e1) in
          let e1_node =  L.const_named_struct list_node_ty
          (Array.of_list [e1'; 
            L.const_pointer_null (L.pointer_type list_node_ty); L.const_int i1_t 0]) in
          let e1_node_var = L.build_alloca list_node_ty "e1_node_var" builder in
          let _ = ignore(L.build_store e1_node e1_node_var builder) in

          (* conditional *)
          let (scope, e2') = expr builder scope e2 in
          let list_ptr = L.build_struct_gep e2' 2 "tmp" builder in
          let list_val = L.build_load list_ptr "tmp" builder in
          let cond = L.build_icmp L.Icmp.Eq list_val (L.const_int i1_t 1) "cond" builder in
          let merge_bb = L.append_block context "merge" the_function in
          let branch_instr = L.build_br merge_bb in
          
          (*then block*)
          let then_bb = L.append_block context "then" the_function in
          let then_builder = L.builder_at_end context then_bb in
          (* build new list with e1 *)
          let last_node = L.const_named_struct list_node_ty
          (Array.of_list [L.const_null (ltype_of_typ (fst e1)); 
            L.const_pointer_null (L.pointer_type list_node_ty); L.const_int i1_t 1])
          in
          let last_node_var = L.build_alloca list_node_ty "last_node_var" builder in
          let _ = ignore(L.build_store last_node last_node_var builder) in
          let e1_next_ptr = L.build_struct_gep e1_node_var 1 "e1_node_next" builder in
          let _ = ignore(L.build_store last_node_var e1_next_ptr builder) in
          let _ = add_terminal then_builder branch_instr in
         
          (*else block*)
          let else_bb = L.append_block context "else" the_function in
          let else_builder = L.builder_at_end context else_bb in
          (* add e1 node to e2 *)
          let e1_next_ptr = L.build_struct_gep e1_node_var 1 "e1_node_next" builder in
          let _ = ignore(L.build_store e2' e1_next_ptr builder) in
          let _ = add_terminal else_builder branch_instr in

          (*put together if statement*)  (*put the next lines in the merge block*)
          let _ = L.build_cond_br cond then_bb else_bb builder in
          let merge_builder = (L.position_at_end merge_bb builder) in
          e1_node_var
        ))
      | SUnop(op, e) ->
        let (scope, e') = expr builder scope e in
        (match op with
          A.Neg     -> (scope, L.build_neg e' "tmp" builder)
          | A.Not | A.Binnot     -> (scope, L.build_not e' "tmp" builder)
          | A.Car     ->
            (* conditional *)
            let list_ptr = L.build_struct_gep e' 2 "tmp" builder in
            let list_val = L.build_load list_ptr "tmp" builder in
            let cond = L.build_icmp L.Icmp.Eq list_val (L.const_int i1_t 1) "cond" builder in
            let merge_bb = L.append_block context "merge" the_function in
            let branch_instr = L.build_br merge_bb in
            
            (*then block*)
            let then_bb = L.append_block context "then" the_function in
            let then_builder = L.builder_at_end context then_bb in
            let print_err = L.build_call printf_func [| car_err_format_str |] "printf" then_builder in
            let call_exit = L.build_call exit_func [| L.const_int i32_t 1 |] "exit" then_builder in
            let _ = add_terminal then_builder branch_instr in
           
            (*else block*)
            let else_bb = L.append_block context "else" the_function in
            let else_builder = L.builder_at_end context else_bb in
            (* let value_ptr = L.build_struct_gep e' 0 "tmp" else_builder in *)
            (* let else_res = L.build_load value_ptr "tmp" builder in *)
            let _ = add_terminal else_builder branch_instr in

            (*put together if statement*)  (*put the next lines in the merge block*)
            let _ = L.build_cond_br cond then_bb else_bb builder in
            let merge_builder = (L.position_at_end merge_bb builder) in
            let value_ptr = L.build_struct_gep e' 0 "tmp" builder in (*notes for OH: we printed out value_ptr and it has an address*)
            (scope, L.build_load value_ptr "tmp" builder) (* PROBLEM LINE *)
          | A.Cdr     -> 
            (* conditional *)
            let list_ptr = L.build_struct_gep e' 2 "tmp" builder in
            let list_val = L.build_load list_ptr "tmp" builder in
            let cond = L.build_icmp L.Icmp.Eq list_val (L.const_int i1_t 1) "cond" builder in
            let merge_bb = L.append_block context "merge" the_function in
            let branch_instr = L.build_br merge_bb in
            
            (*then block*)
            let then_bb = L.append_block context "then" the_function in
            let then_builder = L.builder_at_end context then_bb in
            let print_err = L.build_call printf_func [| cdr_err_format_str |] "printf" then_builder in
            let call_exit = L.build_call exit_func [| L.const_int i32_t 1 |] "exit" then_builder in
            let _ = add_terminal then_builder branch_instr in
           
            (*else block*)
            let else_bb = L.append_block context "else" the_function in
            let else_builder = L.builder_at_end context else_bb in
            let _ = add_terminal else_builder branch_instr in

            (*put together if statement*)  (*put the next lines in the merge block*)
            let _ = L.build_cond_br cond then_bb else_bb builder in
            let merge_builder = (L.position_at_end merge_bb builder) in
            let list_ptr = L.build_struct_gep e' 1 "tmp" builder in
            (scope, L.build_load list_ptr "tmp" builder))
      | SCall ("println", [e]) -> 
        let (scope, e') = (expr builder scope e) in
        let _ = (match (fst e) with
            Int -> L.build_call printf_func [| int_format_str ; e' |] "printf" builder
            | Bool -> L.build_call printf_func [| int_format_str ; e' |] "printf" builder
            | Char -> L.build_call printf_func [| char_format_str ; e' |] "printf" builder
            | Bit -> L.build_call printbit_func [| e' |] "print_bit" builder
            | Nibble -> L.build_call printnibble_func [| e' |] "print_nibble" builder
            | Byte -> L.build_call printbyte_func [| e' |] "print_byte" builder
            | Word -> L.build_call printword_func [| e' |] "print_word" builder
            | String -> L.build_call printf_func [| string_format_str ; e' |] "printf" builder
            | _ -> raise (Semant.TypeError ("TODO: rest of println")))
        in (scope, L.build_call printf_func [| string_format_ln |] "printf" builder)
      | SCall ("print", [e]) -> 
        let (scope, e') = (expr builder scope e) in
        (scope, (match (fst e) with 
            Int -> L.build_call printf_func [| int_format_str ; e' |] "printf" builder
            | Bool -> L.build_call printf_func [| int_format_str ; e' |] "printf" builder
            | Char -> L.build_call printf_func [| char_format_str ; e' |] "printf" builder
            | Bit -> L.build_call printbit_func [| e' |] "print_bit" builder
            | Nibble -> L.build_call printnibble_func [| e' |] "print_nibble" builder
            | Byte -> L.build_call printbyte_func [| e' |] "print_byte" builder
            | Word -> L.build_call printword_func [| e' |] "print_word" builder
            | String -> L.build_call printf_func [| string_format_str ; e' |] "printf" builder
            | _ -> raise (Semant.TypeError ("TODO: rest of print"))))
      | SCall (f, args) ->
        let (fdef, fdecl) = StringMap.find f function_decls in
        let llargs = List.rev (List.map snd (List.map (expr builder scope) (List.rev args))) in
        let result = (match fdecl.styp with 
                        A.Void -> ""
                      | _ -> f ^ "_result") 
        in (scope, L.build_call fdef (Array.of_list llargs) result builder)
    in

    (* declare variable; remember its value in a map, can only be called on 
       variables that have not previously been defined in the scope *)
      let add_variable (scope: var_table) (t : A.typ) n e builder =
      let _ = dont_find_variable scope n in
      let ltype = ltype_of_typ t in
      let (scope, e') = let (_, ex) = e in (match ex with
          SNoexpr -> (scope, L.const_null ltype)
        | _ -> expr builder scope e)
      in L.set_value_name n e';
      let l_var = L.build_alloca ltype n builder in
      let _ = L.build_store e' l_var builder in
      ({ scope with variables = StringMap.add n l_var scope.variables }, builder)
    in

    (************************** Convert Statements **************************)
	
    (* Build the code for the given statement; return the builder for
       the statement's successor (i.e., the next instruction will be built
       after the one generated by this call) *)
    (* Imperative nature of statement processing entails imperative OCaml *)
    let rec stmt builder scope fdecl = function
	    SBlock sl ->
        let scope' = {
          variables = StringMap.empty;
          parent = Some(scope);
        } in
        let (_, builder) = List.fold_left (fun (s, b) curr -> (stmt b s fdecl curr)) (scope', builder) sl in (scope, builder)
        (* let (_, builder) = List.fold_left stmt (scope', builder, fdecl) sl in (scope, builder) *)
        (* Generate code for this expression, return resulting builder *)
      | SExpr e -> let (scope, _) = expr builder scope e in (scope, builder) 
      | SVar (v) -> add_variable scope v.styp v.svname v.svalue builder
        (* let (s, b) = add_variable scope v.styp v.svname v.svalue builder in
        dump_scope s ("<var>") *)
      | SReturn e -> 
        let _ = match fdecl.styp with
          (* Special "return nothing" instr *)
          A.Void -> L.build_ret_void builder
          (* Build return statement *)
          | _ ->
          let (_, e') = expr builder scope e in L.build_ret e' builder
        in (scope, builder)
      (* The order that we create and add the basic blocks for an If statement
      doesnt 'really' matter (seemingly). What hooks them up in the right order
      are the build_br functions used at the end of the then and else blocks (if
      they don't already have a terminator) and the build_cond_br function at
      the end, which adds jump instructions to the "then" and "else" basic blocks *)
      | SIf (predicate, then_stmt, else_stmt) ->
        let (scope, bool_val) = expr builder scope predicate in
         (* Add "merge" basic block to our function's list of blocks *)
	      let merge_bb = L.append_block context "merge" the_function in
         (* Partial function used to generate branch to merge block *)
        let branch_instr = L.build_br merge_bb in

         (* Same for "then" basic block *)
	      let then_bb = L.append_block context "then" the_function in
         (* Position builder in "then" block and build the statement *)
        let (scope, then_builder) = stmt (L.builder_at_end context then_bb) scope fdecl then_stmt in
         (* Add a branch to the "then" block (to the merge block) 
           if a terminator doesn't already exist for the "then" block *)
	      let () = add_terminal then_builder branch_instr in

         (* Identical to stuff we did for "then" *)
	      let else_bb = L.append_block context "else" the_function in
        let (scope, else_builder) = stmt (L.builder_at_end context else_bb) scope fdecl else_stmt in
	      let () = add_terminal else_builder branch_instr in

         (* Generate initial branch instruction perform the selection of "then"
         or "else". Note we're using the builder we had access to at the start
         of this alternative. *)
	      let _ = L.build_cond_br bool_val then_bb else_bb builder in
         (* Move to the merge block for further instruction building *)
	      (scope, L.builder_at_end context merge_bb)

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
        let (scope, while_builder) = stmt (L.builder_at_end context body_bb) scope fdecl body in
        let () = add_terminal while_builder (L.build_br pred_bb) in

        (* Generate the predicate code in the predicate block *)
        let pred_builder = L.builder_at_end context pred_bb in
        let (scope, bool_val) = expr pred_builder scope predicate in

        (* Hook everything up *)
        let merge_bb = L.append_block context "merge" the_function in
        let _ = L.build_cond_br bool_val body_bb merge_bb pred_builder in
        (scope, L.builder_at_end context merge_bb)

      (* Implement for loops as while loops! *)
      | SFor (e1, e2, e3, body) -> stmt builder scope fdecl
	    ( SBlock [SExpr e1 ; SWhile (e2, SBlock [body ; SExpr e3]) ] )
    in
    
    (************************** Driver Code **************************)

    (* load global scope *)
    let global_scope = {
      variables = StringMap.empty;
      parent = None;
    } in

    let (global_scope, builder) = List.fold_left 
      (fun (global_scope, builder) (x : svdecl) -> add_variable global_scope x.styp x.svname x.svalue builder) 
      (global_scope, builder) vdecls
    in

    (* let _ = dump_scope global_scope "<global scope>" in *)

    (* wrapper function for build_program, creates global scope *)
    let build_function_body fdecl = 
      let (the_function, _) = StringMap.find fdecl.sfname function_decls in

      let func_builder = L.builder_at_end context (L.entry_block the_function) in

      let scope = {
        variables = StringMap.empty;
        parent = Some(global_scope);
      }
      in
      
      let scope = 
        let add_formal scope (t, n) p = 
          let () = L.set_value_name n p in
          let var = L.build_alloca (ltype_of_typ t) n func_builder in
          let _  = L.build_store p var func_builder in
          { scope with variables = StringMap.add n var scope.variables }
        in
        List.fold_left2 (fun s f p -> add_formal s f p) scope fdecl.sformals
            (Array.to_list (L.params the_function)) 
      in

      (* let _ = dump_scope scope fdecl.sfname in *)

      (* build function body from statements *)
      let (_, func_builder) = stmt func_builder scope fdecl (SBlock fdecl.sbody) in 

      (* let parent = match scope.parent with
        Some(parent) -> parent
        | _ -> raise (Semant.InvalidError "")
      in *)

      (* let _ = dump_scope scope "<main scope>" in
      let _ = dump_scope global_scope "<global scope>" in *)

      add_terminal func_builder 
      (match fdecl.styp with
        A.Void -> L.build_ret_void
        | t -> L.build_ret (L.const_null (ltype_of_typ t))
      )
    in
      
    (* or all functions, build the function body *)
    let _ = 
      List.iter build_function_body fdecls
    in

    (* build the code for each statement in the main function body *)
    (* let (scope, builder) = stmt builder scope fdecls (SBlock fdecl.sbody) in *)

    (* add a return if the last block falls off the end *)
    add_terminal builder (L.build_ret (L.const_int i32_t 0))
  in

  build_program;
  the_module
