; ModuleID = 'Chomp'
source_filename = "Chomp"

%int_node = type <{ i32, %int_node*, i1 }>

@fmt = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@fmt.1 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@fmt.2 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@fmt.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@fmt.4 = private unnamed_addr constant [37 x i8] c"Error: cannot call car on empty list\00", align 1
@fmt.5 = private unnamed_addr constant [37 x i8] c"Error: cannot call cdr on empty list\00", align 1

declare i32 @printf(i8*, ...)

declare i32 @print_bit(i32)

declare i32 @print_nibble(i32)

declare i32 @print_byte(i32)

declare i32 @print_word(i32)

declare i32 @exit(i32, ...)

define i32 @main() {
entry:
  %last_node_var = alloca %int_node, align 8
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var, align 1
  %front_node_var = alloca %int_node, align 8
  store %int_node <{ i32 2, %int_node* null, i1 false }>, %int_node* %front_node_var, align 1
  %front_node_next = getelementptr inbounds %int_node, %int_node* %front_node_var, i32 0, i32 1
  store %int_node* %last_node_var, %int_node** %front_node_next, align 8
  %a = alloca %int_node, align 8
  store %int_node <{ i32 1, %int_node* null, i1 false }>, %int_node* %a, align 1
  %last_node_var1 = alloca %int_node, align 8
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var1, align 1
  %front_node_var2 = alloca %int_node, align 8
  store %int_node <{ i32 2, %int_node* null, i1 false }>, %int_node* %front_node_var2, align 1
  %front_node_next3 = getelementptr inbounds %int_node, %int_node* %front_node_var2, i32 0, i32 1
  store %int_node* %last_node_var1, %int_node** %front_node_next3, align 8
  %tmp = getelementptr inbounds %int_node, %int_node* %front_node_var2, i32 0, i32 2
  %tmp4 = load i1, i1* %tmp, align 1
  %cond = icmp eq i1 %tmp4, true
  %last_node_var5 = alloca %int_node, align 8
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var5, align 1
  %e1_node_next = getelementptr inbounds %int_node, %int_node* %a, i32 0, i32 1
  store %int_node* %last_node_var5, %int_node** %e1_node_next, align 8
  %e1_node_next6 = getelementptr inbounds %int_node, %int_node* %a, i32 0, i32 1
  store %int_node* %front_node_var2, %int_node** %e1_node_next6, align 8
  br i1 %cond, label %then, label %else

merge:                                            ; preds = %else, %then
  %a7 = alloca %int_node*, align 8
  store %int_node* %a, %int_node** %a7, align 8
  %a8 = load %int_node*, %int_node** %a7, align 8
  %tmp9 = getelementptr inbounds %int_node, %int_node* %a8, i32 0, i32 2
  %tmp10 = load i1, i1* %tmp9, align 1
  %cond11 = icmp eq i1 %tmp10, true
  br i1 %cond11, label %then13, label %else14

then:                                             ; preds = %entry
  br label %merge

else:                                             ; preds = %entry
  br label %merge

merge12:                                          ; preds = %else14, %then13
  %tmp15 = getelementptr inbounds %int_node, %int_node* %a8, i32 0, i32 0
  %tmp16 = load i32, i32* %tmp15, align 4
  %printf17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %tmp16)
  %printf18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %a19 = load %int_node*, %int_node** %a7, align 8
  %tmp20 = getelementptr inbounds %int_node, %int_node* %a19, i32 0, i32 2
  %tmp21 = load i1, i1* %tmp20, align 1
  %cond22 = icmp eq i1 %tmp21, true
  br i1 %cond22, label %then24, label %else27

then13:                                           ; preds = %merge
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @fmt.4, i32 0, i32 0))
  %exit = call i32 (i32, ...) @exit(i32 1)
  br label %merge12

else14:                                           ; preds = %merge
  br label %merge12

merge23:                                          ; preds = %else27, %then24
  %tmp28 = getelementptr inbounds %int_node, %int_node* %a19, i32 0, i32 1
  %tmp29 = load %int_node*, %int_node** %tmp28, align 8
  %tmp30 = getelementptr inbounds %int_node, %int_node* %tmp29, i32 0, i32 2
  %tmp31 = load i1, i1* %tmp30, align 1
  %cond32 = icmp eq i1 %tmp31, true
  br i1 %cond32, label %then34, label %else37

then24:                                           ; preds = %merge12
  %printf25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @fmt.5, i32 0, i32 0))
  %exit26 = call i32 (i32, ...) @exit(i32 1)
  br label %merge23

else27:                                           ; preds = %merge12
  br label %merge23

merge33:                                          ; preds = %else37, %then34
  %tmp38 = getelementptr inbounds %int_node, %int_node* %tmp29, i32 0, i32 0
  %tmp39 = load i32, i32* %tmp38, align 4
  %printf40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %tmp39)
  %printf41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  ret i32 0

then34:                                           ; preds = %merge23
  %printf35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @fmt.4, i32 0, i32 0))
  %exit36 = call i32 (i32, ...) @exit(i32 1)
  br label %merge33

else37:                                           ; preds = %merge23
  br label %merge33
}
