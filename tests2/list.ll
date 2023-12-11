; ModuleID = 'Chomp'
source_filename = "Chomp"

%int_node = type <{ i32, %int_node*, i1 }>

@fmt = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@fmt.1 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@fmt.2 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@fmt.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@fmt.4 = private unnamed_addr constant [37 x i8] c"Error: cannot call car on empty list\00", align 1
@fmt.5 = private unnamed_addr constant [37 x i8] c"Error: cannot call cdr on empty list\00", align 1
@string = private unnamed_addr constant [3 x i8] c"[ \00", align 1
@string.6 = private unnamed_addr constant [2 x i8] c" \00", align 1
@string.7 = private unnamed_addr constant [2 x i8] c"]\00", align 1
@string.8 = private unnamed_addr constant [3 x i8] c"[ \00", align 1
@string.9 = private unnamed_addr constant [2 x i8] c" \00", align 1
@string.10 = private unnamed_addr constant [2 x i8] c"]\00", align 1

declare i32 @get_bit(i32, i32, i32)

declare i32 @flip_bit(i32, i32, i32)

declare i32 @set_bit(i32, i32, i32, i32)

declare i32 @printf(i8*, ...)

declare i32 @print_bit(i32)

declare i32 @print_nibble(i32)

declare i32 @print_byte(i32)

declare i32 @print_word(i32)

declare i32 @exit(i32, ...)

define i32 @main() {
entry:
  %a = alloca %int_node, align 8
  store %int_node <{ i32 1, %int_node* null, i1 true }>, %int_node* %a, align 1
  %a1 = alloca %int_node*, align 8
  store %int_node* %a, %int_node** %a1, align 8
  %a2 = load %int_node*, %int_node** %a1, align 8
  %e1_node_var = alloca %int_node, align 8
  store %int_node zeroinitializer, %int_node* %e1_node_var, align 1
  %front_val = getelementptr inbounds %int_node, %int_node* %e1_node_var, i32 0, i32 0
  store i32 3, i32* %front_val, align 4
  %a3 = load %int_node*, %int_node** %a1, align 8
  %tmp = getelementptr inbounds %int_node, %int_node* %a3, i32 0, i32 2
  %tmp4 = load i1, i1* %tmp, align 1
  %cond = icmp eq i1 %tmp4, true
  %last_node_var = alloca %int_node, align 8
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var, align 1
  %e1_node_next = getelementptr inbounds %int_node, %int_node* %e1_node_var, i32 0, i32 1
  store %int_node* %last_node_var, %int_node** %e1_node_next, align 8
  %e1_node_next5 = getelementptr inbounds %int_node, %int_node* %e1_node_var, i32 0, i32 1
  store %int_node* %a3, %int_node** %e1_node_next5, align 8
  br i1 %cond, label %then, label %else

merge:                                            ; preds = %else, %then
  %e1_node_var6 = alloca %int_node, align 8
  store %int_node zeroinitializer, %int_node* %e1_node_var6, align 1
  %front_val7 = getelementptr inbounds %int_node, %int_node* %e1_node_var6, i32 0, i32 0
  store i32 4, i32* %front_val7, align 4
  %a8 = load %int_node*, %int_node** %a1, align 8
  %e1_node_var9 = alloca %int_node, align 8
  store %int_node zeroinitializer, %int_node* %e1_node_var9, align 1
  %front_val10 = getelementptr inbounds %int_node, %int_node* %e1_node_var9, i32 0, i32 0
  store i32 3, i32* %front_val10, align 4
  %a11 = load %int_node*, %int_node** %a1, align 8
  %tmp12 = getelementptr inbounds %int_node, %int_node* %a11, i32 0, i32 2
  %tmp13 = load i1, i1* %tmp12, align 1
  %cond14 = icmp eq i1 %tmp13, true
  %last_node_var17 = alloca %int_node, align 8
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var17, align 1
  %e1_node_next18 = getelementptr inbounds %int_node, %int_node* %e1_node_var9, i32 0, i32 1
  store %int_node* %last_node_var17, %int_node** %e1_node_next18, align 8
  %e1_node_next20 = getelementptr inbounds %int_node, %int_node* %e1_node_var9, i32 0, i32 1
  store %int_node* %a11, %int_node** %e1_node_next20, align 8
  br i1 %cond14, label %then16, label %else19

then:                                             ; preds = %entry
  br label %merge

else:                                             ; preds = %entry
  br label %merge

merge15:                                          ; preds = %else19, %then16
  %tmp21 = getelementptr inbounds %int_node, %int_node* %e1_node_var9, i32 0, i32 2
  %tmp22 = load i1, i1* %tmp21, align 1
  %cond23 = icmp eq i1 %tmp22, true
  %last_node_var26 = alloca %int_node, align 8
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var26, align 1
  %e1_node_next27 = getelementptr inbounds %int_node, %int_node* %e1_node_var6, i32 0, i32 1
  store %int_node* %last_node_var26, %int_node** %e1_node_next27, align 8
  %e1_node_next29 = getelementptr inbounds %int_node, %int_node* %e1_node_var6, i32 0, i32 1
  store %int_node* %e1_node_var9, %int_node** %e1_node_next29, align 8
  br i1 %cond23, label %then25, label %else28

then16:                                           ; preds = %merge
  br label %merge15

else19:                                           ; preds = %merge
  br label %merge15

merge24:                                          ; preds = %else28, %then25
  store %int_node* %e1_node_var6, %int_node** %a1, align 8
  %a30 = load %int_node*, %int_node** %a1, align 8
  %rest_list = alloca %int_node*, align 8
  store %int_node* %a30, %int_node** %rest_list, align 8
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @string, i32 0, i32 0))
  br label %pred

then25:                                           ; preds = %merge15
  br label %merge24

else28:                                           ; preds = %merge15
  br label %merge24

pred:                                             ; preds = %while_body, %merge24
  %rest_list38 = load %int_node*, %int_node** %rest_list, align 8
  %tmp39 = getelementptr inbounds %int_node, %int_node* %rest_list38, i32 0, i32 2
  %tmp40 = load i1, i1* %tmp39, align 1
  %cond41 = icmp eq i1 %tmp40, true
  br i1 %cond41, label %merge42, label %while_body

while_body:                                       ; preds = %pred
  %rest_list31 = load %int_node*, %int_node** %rest_list, align 8
  %tmp32 = getelementptr inbounds %int_node, %int_node* %rest_list31, i32 0, i32 0
  %tmp33 = load i32, i32* %tmp32, align 4
  %printf34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %tmp33)
  %printf35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.6, i32 0, i32 0))
  %rest_list36 = load %int_node*, %int_node** %rest_list, align 8
  %tmp37 = getelementptr inbounds %int_node, %int_node* %rest_list36, i32 0, i32 1
  %next_lst = load %int_node*, %int_node** %tmp37, align 8
  store %int_node* %next_lst, %int_node** %rest_list, align 8
  br label %pred

merge42:                                          ; preds = %pred
  %printf43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.7, i32 0, i32 0))
  %printf44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %a45 = load %int_node*, %int_node** %a1, align 8
  %tmp46 = getelementptr inbounds %int_node, %int_node* %a45, i32 0, i32 2
  %tmp47 = load i1, i1* %tmp46, align 1
  %cond48 = icmp eq i1 %tmp47, true
  br i1 %cond48, label %then50, label %else52

merge49:                                          ; preds = %else52, %then50
  %tmp53 = getelementptr inbounds %int_node, %int_node* %a45, i32 0, i32 1
  %tmp54 = load %int_node*, %int_node** %tmp53, align 8
  store %int_node* %tmp54, %int_node** %a1, align 8
  %a55 = load %int_node*, %int_node** %a1, align 8
  %tmp56 = getelementptr inbounds %int_node, %int_node* %a55, i32 0, i32 2
  %tmp57 = load i1, i1* %tmp56, align 1
  %cond58 = icmp eq i1 %tmp57, true
  br i1 %cond58, label %then60, label %else63

then50:                                           ; preds = %merge42
  %printf51 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @fmt.5, i32 0, i32 0))
  %exit = call i32 (i32, ...) @exit(i32 1)
  br label %merge49

else52:                                           ; preds = %merge42
  br label %merge49

merge59:                                          ; preds = %else63, %then60
  %tmp64 = getelementptr inbounds %int_node, %int_node* %a55, i32 0, i32 1
  %tmp65 = load %int_node*, %int_node** %tmp64, align 8
  store %int_node* %tmp65, %int_node** %a1, align 8
  %a66 = load %int_node*, %int_node** %a1, align 8
  %rest_list67 = alloca %int_node*, align 8
  store %int_node* %a66, %int_node** %rest_list67, align 8
  %printf68 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @string.8, i32 0, i32 0))
  br label %pred69

then60:                                           ; preds = %merge49
  %printf61 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @fmt.5, i32 0, i32 0))
  %exit62 = call i32 (i32, ...) @exit(i32 1)
  br label %merge59

else63:                                           ; preds = %merge49
  br label %merge59

pred69:                                           ; preds = %while_body70, %merge59
  %rest_list79 = load %int_node*, %int_node** %rest_list67, align 8
  %tmp80 = getelementptr inbounds %int_node, %int_node* %rest_list79, i32 0, i32 2
  %tmp81 = load i1, i1* %tmp80, align 1
  %cond82 = icmp eq i1 %tmp81, true
  br i1 %cond82, label %merge83, label %while_body70

while_body70:                                     ; preds = %pred69
  %rest_list71 = load %int_node*, %int_node** %rest_list67, align 8
  %tmp72 = getelementptr inbounds %int_node, %int_node* %rest_list71, i32 0, i32 0
  %tmp73 = load i32, i32* %tmp72, align 4
  %printf74 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %tmp73)
  %printf75 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.9, i32 0, i32 0))
  %rest_list76 = load %int_node*, %int_node** %rest_list67, align 8
  %tmp77 = getelementptr inbounds %int_node, %int_node* %rest_list76, i32 0, i32 1
  %next_lst78 = load %int_node*, %int_node** %tmp77, align 8
  store %int_node* %next_lst78, %int_node** %rest_list67, align 8
  br label %pred69

merge83:                                          ; preds = %pred69
  %printf84 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.10, i32 0, i32 0))
  %printf85 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  ret i32 0
}
