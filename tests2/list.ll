; ModuleID = 'Chomp'
source_filename = "Chomp"

%int_node = type <{ i32, %int_node*, i1 }>
%string_node = type <{ i8*, %string_node*, i1 }>
%bit_node = type <{ i32, %bit_node*, i1 }>

@fmt = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@fmt.1 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@fmt.2 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@fmt.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@fmt.4 = private unnamed_addr constant [37 x i8] c"Error: cannot call car on empty list\00", align 1
@fmt.5 = private unnamed_addr constant [37 x i8] c"Error: cannot call cdr on empty list\00", align 1
@string = private unnamed_addr constant [3 x i8] c"[ \00", align 1
@string.6 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@string.7 = private unnamed_addr constant [2 x i8] c" \00", align 1
@string.8 = private unnamed_addr constant [2 x i8] c"]\00", align 1
@string.9 = private unnamed_addr constant [2 x i8] c"b\00", align 1
@string.10 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@string.11 = private unnamed_addr constant [3 x i8] c"[ \00", align 1
@string.12 = private unnamed_addr constant [2 x i8] c" \00", align 1
@string.13 = private unnamed_addr constant [2 x i8] c"]\00", align 1
@string.14 = private unnamed_addr constant [3 x i8] c"[ \00", align 1
@string.15 = private unnamed_addr constant [2 x i8] c" \00", align 1
@string.16 = private unnamed_addr constant [2 x i8] c"]\00", align 1

declare i32 @printf(i8*, ...)

declare i32 @print_bit(i32)

declare i32 @print_nibble(i32)

declare i32 @print_byte(i32)

declare i32 @print_word(i32)

declare i32 @exit(i32, ...)

define i32 @main() {
entry:
  %front_node_var = alloca %int_node, align 8
  store %int_node <{ i32 1, %int_node* null, i1 true }>, %int_node* %front_node_var, align 1
  %rest_list = alloca %int_node*, align 8
  store %int_node* %front_node_var, %int_node** %rest_list, align 8
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @string, i32 0, i32 0))
  br label %pred
  %printf3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.6, i32 0, i32 0))
  ret i32 0

pred:                                             ; preds = %while_body, %entry
  %rest_list7 = load %int_node*, %int_node** %rest_list, align 8
  %tmp8 = getelementptr inbounds %int_node, %int_node* %rest_list7, i32 0, i32 2
  %tmp9 = load i1, i1* %tmp8, align 1
  %cond = icmp eq i1 %tmp9, true
  br i1 %cond, label %merge, label %while_body

while_body:                                       ; preds = %pred
  %rest_list1 = load %int_node*, %int_node** %rest_list, align 8
  %tmp = getelementptr inbounds %int_node, %int_node* %rest_list1, i32 0, i32 0
  %tmp2 = load i32, i32* %tmp, align 4
  %printf4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.7, i32 0, i32 0))
  %rest_list5 = load %int_node*, %int_node** %rest_list, align 8
  %tmp6 = getelementptr inbounds %int_node, %int_node* %rest_list5, i32 0, i32 1
  %next_lst = load %int_node*, %int_node** %tmp6, align 8
  store %int_node* %next_lst, %int_node** %rest_list, align 8
  br label %pred

merge:                                            ; preds = %pred
  %printf10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.8, i32 0, i32 0))
  %printf11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %last_node_var = alloca %string_node, align 8
  store %string_node <{ i8* null, %string_node* null, i1 true }>, %string_node* %last_node_var, align 1
  %front_node_var12 = alloca %string_node, align 8
  store %string_node <{ i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.9, i32 0, i32 0), %string_node* null, i1 false }>, %string_node* %front_node_var12, align 1
  %front_node_next = getelementptr inbounds %string_node, %string_node* %front_node_var12, i32 0, i32 1
  store %string_node* %last_node_var, %string_node** %front_node_next, align 8
  %a = alloca %string_node, align 8
  store %string_node <{ i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.10, i32 0, i32 0), %string_node* null, i1 false }>, %string_node* %a, align 1
  %front_node_next14 = getelementptr inbounds %string_node, %string_node* %a, i32 0, i32 1
  store %string_node* %front_node_var12, %string_node** %front_node_next14, align 8
  %a15 = alloca %string_node*, align 8
  store %string_node* %a, %string_node** %a15, align 8
  %a16 = load %string_node*, %string_node** %a15, align 8
  %rest_list17 = alloca %string_node*, align 8
  store %string_node* %a16, %string_node** %rest_list17, align 8
  %printf18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @string.11, i32 0, i32 0))
  br label %pred19

pred19:                                           ; preds = %while_body20, %merge
  %rest_list29 = load %string_node*, %string_node** %rest_list17, align 8
  %tmp30 = getelementptr inbounds %string_node, %string_node* %rest_list29, i32 0, i32 2
  %tmp31 = load i1, i1* %tmp30, align 1
  %cond32 = icmp eq i1 %tmp31, true
  br i1 %cond32, label %merge33, label %while_body20

while_body20:                                     ; preds = %pred19
  %rest_list21 = load %string_node*, %string_node** %rest_list17, align 8
  %tmp22 = getelementptr inbounds %string_node, %string_node* %rest_list21, i32 0, i32 0
  %tmp23 = load i8*, i8** %tmp22, align 8
  %printf24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* %tmp23)
  %printf25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.12, i32 0, i32 0))
  %rest_list26 = load %string_node*, %string_node** %rest_list17, align 8
  %tmp27 = getelementptr inbounds %string_node, %string_node* %rest_list26, i32 0, i32 1
  %next_lst28 = load %string_node*, %string_node** %tmp27, align 8
  store %string_node* %next_lst28, %string_node** %rest_list17, align 8
  br label %pred19

merge33:                                          ; preds = %pred19
  %printf34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.13, i32 0, i32 0))
  %printf35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %last_node_var36 = alloca %bit_node, align 8
  store %bit_node <{ i32 0, %bit_node* null, i1 true }>, %bit_node* %last_node_var36, align 1
  %front_node_var37 = alloca %bit_node, align 8
  store %bit_node <{ i32 1, %bit_node* null, i1 false }>, %bit_node* %front_node_var37, align 1
  %front_node_next38 = getelementptr inbounds %bit_node, %bit_node* %front_node_var37, i32 0, i32 1
  store %bit_node* %last_node_var36, %bit_node** %front_node_next38, align 8
  %front_node_var39 = alloca %bit_node, align 8
  store %bit_node zeroinitializer, %bit_node* %front_node_var39, align 1
  %front_node_next40 = getelementptr inbounds %bit_node, %bit_node* %front_node_var39, i32 0, i32 1
  store %bit_node* %front_node_var37, %bit_node** %front_node_next40, align 8
  %front_node_var41 = alloca %bit_node, align 8
  store %bit_node zeroinitializer, %bit_node* %front_node_var41, align 1
  %front_node_next42 = getelementptr inbounds %bit_node, %bit_node* %front_node_var41, i32 0, i32 1
  store %bit_node* %front_node_var39, %bit_node** %front_node_next42, align 8
  %bit_list = alloca %bit_node, align 8
  store %bit_node <{ i32 1, %bit_node* null, i1 false }>, %bit_node* %bit_list, align 1
  %front_node_next44 = getelementptr inbounds %bit_node, %bit_node* %bit_list, i32 0, i32 1
  store %bit_node* %front_node_var41, %bit_node** %front_node_next44, align 8
  %bit_list45 = alloca %bit_node*, align 8
  store %bit_node* %bit_list, %bit_node** %bit_list45, align 8
  %bit_list46 = load %bit_node*, %bit_node** %bit_list45, align 8
  %rest_list47 = alloca %bit_node*, align 8
  store %bit_node* %bit_list46, %bit_node** %rest_list47, align 8
  %printf48 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @string.14, i32 0, i32 0))
  br label %pred49

pred49:                                           ; preds = %while_body50, %merge33
  %rest_list58 = load %bit_node*, %bit_node** %rest_list47, align 8
  %tmp59 = getelementptr inbounds %bit_node, %bit_node* %rest_list58, i32 0, i32 2
  %tmp60 = load i1, i1* %tmp59, align 1
  %cond61 = icmp eq i1 %tmp60, true
  br i1 %cond61, label %merge62, label %while_body50

while_body50:                                     ; preds = %pred49
  %rest_list51 = load %bit_node*, %bit_node** %rest_list47, align 8
  %tmp52 = getelementptr inbounds %bit_node, %bit_node* %rest_list51, i32 0, i32 0
  %tmp53 = load i32, i32* %tmp52, align 4
  %print_bit = call i32 @print_bit(i32 %tmp53)
  %printf54 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.15, i32 0, i32 0))
  %rest_list55 = load %bit_node*, %bit_node** %rest_list47, align 8
  %tmp56 = getelementptr inbounds %bit_node, %bit_node* %rest_list55, i32 0, i32 1
  %next_lst57 = load %bit_node*, %bit_node** %tmp56, align 8
  store %bit_node* %next_lst57, %bit_node** %rest_list47, align 8
  br label %pred49

merge62:                                          ; preds = %pred49
  %printf63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.16, i32 0, i32 0))
  %printf64 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %print_byte = call i32 @print_byte(i32 21)
  ret i32 0
}
