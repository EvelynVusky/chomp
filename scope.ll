; ModuleID = 'Chomp'
source_filename = "Chomp"

%int_node = type <{ i32, %int_node*, i1 }>

@fmt = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@fmt.1 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@fmt.2 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@fmt.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@fmt.4 = private unnamed_addr constant [42 x i8] c"Error: cannot call div with divisor of 0\0A\00", align 1
@fmt.5 = private unnamed_addr constant [38 x i8] c"Error: cannot call car on empty list\0A\00", align 1
@fmt.6 = private unnamed_addr constant [38 x i8] c"Error: cannot call cdr on empty list\0A\00", align 1
@string = private unnamed_addr constant [19 x i8] c"In scope function:\00", align 1
@string.7 = private unnamed_addr constant [3 x i8] c"[ \00", align 1
@string.8 = private unnamed_addr constant [2 x i8] c" \00", align 1
@string.9 = private unnamed_addr constant [2 x i8] c"]\00", align 1
@string.10 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@string.11 = private unnamed_addr constant [18 x i8] c"In main function:\00", align 1
@string.12 = private unnamed_addr constant [3 x i8] c"[ \00", align 1
@string.13 = private unnamed_addr constant [2 x i8] c" \00", align 1
@string.14 = private unnamed_addr constant [2 x i8] c"]\00", align 1
@string.15 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@string.16 = private unnamed_addr constant [23 x i8] c"Back in main function:\00", align 1
@string.17 = private unnamed_addr constant [3 x i8] c"[ \00", align 1
@string.18 = private unnamed_addr constant [2 x i8] c" \00", align 1
@string.19 = private unnamed_addr constant [2 x i8] c"]\00", align 1
@string.20 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@string.21 = private unnamed_addr constant [23 x i8] c"In for loop nibble n: \00", align 1
@string.22 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@string.23 = private unnamed_addr constant [27 x i8] c"Out of for loop nibble n: \00", align 1
@string.24 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@string.25 = private unnamed_addr constant [26 x i8] c"Back in main function j: \00", align 1
@string.26 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1

declare i32 @get_bit(i32, i32, i32)

declare i32 @flip_bit(i32, i32, i32)

declare i32 @set_bit(i32, i32, i32, i32)

declare i32 @printf(i8*, ...)

declare i32 @print_bit(i32)

declare i32 @print_nibble(i32)

declare i32 @print_byte(i32)

declare i32 @print_word(i32)

declare i32 @exit(i32, ...)

define void @scope(i32 %b, i32 %c, %int_node* %i) {
entry:
  %malloccall = tail call i8* @malloc(i32 ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32))
  %b1 = bitcast i8* %malloccall to i32*
  store i32 %b, i32* %b1, align 4
  %malloccall2 = tail call i8* @malloc(i32 ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32))
  %c3 = bitcast i8* %malloccall2 to i32*
  store i32 %c, i32* %c3, align 4
  %malloccall4 = tail call i8* @malloc(i32 ptrtoint (%int_node** getelementptr (%int_node*, %int_node** null, i32 1) to i32))
  %i5 = bitcast i8* %malloccall4 to %int_node**
  store %int_node* %i, %int_node** %i5, align 8
  store i32 0, i32* %b1, align 4
  store i32 122, i32* %c3, align 4
  %i6 = load %int_node*, %int_node** %i5, align 8
  %tmp = getelementptr inbounds %int_node, %int_node* %i6, i32 0, i32 2
  %tmp7 = load i1, i1* %tmp, align 1
  %cond = icmp eq i1 %tmp7, true
  br i1 %cond, label %then, label %else

merge:                                            ; preds = %else, %then
  %tmp8 = getelementptr inbounds %int_node, %int_node* %i6, i32 0, i32 1
  %tmp9 = load %int_node*, %int_node** %tmp8, align 8
  store %int_node* %tmp9, %int_node** %i5, align 8
  %printf10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @string, i32 0, i32 0))
  %printf11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %b12 = load i32, i32* %b1, align 4
  %print_bit = call i32 @print_bit(i32 %b12)
  %printf13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %c14 = load i32, i32* %c3, align 4
  %printf15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.2, i32 0, i32 0), i32 %c14)
  %printf16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %i17 = load %int_node*, %int_node** %i5, align 8
  %malloccall18 = tail call i8* @malloc(i32 ptrtoint (%int_node** getelementptr (%int_node*, %int_node** null, i32 1) to i32))
  %rest_list = bitcast i8* %malloccall18 to %int_node**
  store %int_node* %i17, %int_node** %rest_list, align 8
  %printf19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @string.7, i32 0, i32 0))
  br label %pred

then:                                             ; preds = %entry
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @fmt.6, i32 0, i32 0))
  %exit = call i32 (i32, ...) @exit(i32 1)
  br label %merge

else:                                             ; preds = %entry
  br label %merge

pred:                                             ; preds = %while_body, %merge
  %rest_list27 = load %int_node*, %int_node** %rest_list, align 8
  %tmp28 = getelementptr inbounds %int_node, %int_node* %rest_list27, i32 0, i32 2
  %tmp29 = load i1, i1* %tmp28, align 1
  %cond30 = icmp eq i1 %tmp29, true
  br i1 %cond30, label %merge31, label %while_body

while_body:                                       ; preds = %pred
  %rest_list20 = load %int_node*, %int_node** %rest_list, align 8
  %tmp21 = getelementptr inbounds %int_node, %int_node* %rest_list20, i32 0, i32 0
  %tmp22 = load i32, i32* %tmp21, align 4
  %printf23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %tmp22)
  %printf24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.8, i32 0, i32 0))
  %rest_list25 = load %int_node*, %int_node** %rest_list, align 8
  %tmp26 = getelementptr inbounds %int_node, %int_node* %rest_list25, i32 0, i32 1
  %next_lst = load %int_node*, %int_node** %tmp26, align 8
  store %int_node* %next_lst, %int_node** %rest_list, align 8
  br label %pred

merge31:                                          ; preds = %pred
  %printf32 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.9, i32 0, i32 0))
  %printf33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.10, i32 0, i32 0))
  %printf35 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  ret void
}

define i32 @main() {
entry:
  %b = alloca i32, align 4
  store i32 1, i32* %b, align 4
  %c = alloca i32, align 4
  store i32 97, i32* %c, align 4
  %malloccall = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var = bitcast i8* %malloccall to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var, align 1
  %malloccall1 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var = bitcast i8* %malloccall1 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var, align 1
  %front_val = getelementptr inbounds %int_node, %int_node* %front_node_var, i32 0, i32 0
  store i32 44, i32* %front_val, align 4
  %front_node_next = getelementptr inbounds %int_node, %int_node* %front_node_var, i32 0, i32 1
  store %int_node* %last_node_var, %int_node** %front_node_next, align 8
  %malloccall2 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var3 = bitcast i8* %malloccall2 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var3, align 1
  %front_val4 = getelementptr inbounds %int_node, %int_node* %front_node_var3, i32 0, i32 0
  store i32 32, i32* %front_val4, align 4
  %front_node_next5 = getelementptr inbounds %int_node, %int_node* %front_node_var3, i32 0, i32 1
  store %int_node* %front_node_var, %int_node** %front_node_next5, align 8
  %malloccall6 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %i = bitcast i8* %malloccall6 to %int_node*
  store %int_node zeroinitializer, %int_node* %i, align 1
  %front_val8 = getelementptr inbounds %int_node, %int_node* %i, i32 0, i32 0
  store i32 123, i32* %front_val8, align 4
  %front_node_next9 = getelementptr inbounds %int_node, %int_node* %i, i32 0, i32 1
  store %int_node* %front_node_var3, %int_node** %front_node_next9, align 8
  %i10 = alloca %int_node*, align 8
  store %int_node* %i, %int_node** %i10, align 8
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @string.11, i32 0, i32 0))
  %printf11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %b12 = load i32, i32* %b, align 4
  %print_bit = call i32 @print_bit(i32 %b12)
  %printf13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %c14 = load i32, i32* %c, align 4
  %printf15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.2, i32 0, i32 0), i32 %c14)
  %printf16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %i17 = load %int_node*, %int_node** %i10, align 8
  %malloccall18 = tail call i8* @malloc(i32 ptrtoint (%int_node** getelementptr (%int_node*, %int_node** null, i32 1) to i32))
  %rest_list = bitcast i8* %malloccall18 to %int_node**
  store %int_node* %i17, %int_node** %rest_list, align 8
  %printf19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @string.12, i32 0, i32 0))
  br label %pred

pred:                                             ; preds = %while_body, %entry
  %rest_list26 = load %int_node*, %int_node** %rest_list, align 8
  %tmp27 = getelementptr inbounds %int_node, %int_node* %rest_list26, i32 0, i32 2
  %tmp28 = load i1, i1* %tmp27, align 1
  %cond = icmp eq i1 %tmp28, true
  br i1 %cond, label %merge, label %while_body

while_body:                                       ; preds = %pred
  %rest_list20 = load %int_node*, %int_node** %rest_list, align 8
  %tmp = getelementptr inbounds %int_node, %int_node* %rest_list20, i32 0, i32 0
  %tmp21 = load i32, i32* %tmp, align 4
  %printf22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %tmp21)
  %printf23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.13, i32 0, i32 0))
  %rest_list24 = load %int_node*, %int_node** %rest_list, align 8
  %tmp25 = getelementptr inbounds %int_node, %int_node* %rest_list24, i32 0, i32 1
  %next_lst = load %int_node*, %int_node** %tmp25, align 8
  store %int_node* %next_lst, %int_node** %rest_list, align 8
  br label %pred

merge:                                            ; preds = %pred
  %printf29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.14, i32 0, i32 0))
  %printf30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.15, i32 0, i32 0))
  %printf32 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %i33 = load %int_node*, %int_node** %i10, align 8
  %c34 = load i32, i32* %c, align 4
  %b35 = load i32, i32* %b, align 4
  call void @scope(i32 %b35, i32 %c34, %int_node* %i33)
  %printf36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @string.16, i32 0, i32 0))
  %printf37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %b38 = load i32, i32* %b, align 4
  %print_bit39 = call i32 @print_bit(i32 %b38)
  %printf40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %c41 = load i32, i32* %c, align 4
  %printf42 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.2, i32 0, i32 0), i32 %c41)
  %printf43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %i44 = load %int_node*, %int_node** %i10, align 8
  %malloccall45 = tail call i8* @malloc(i32 ptrtoint (%int_node** getelementptr (%int_node*, %int_node** null, i32 1) to i32))
  %rest_list46 = bitcast i8* %malloccall45 to %int_node**
  store %int_node* %i44, %int_node** %rest_list46, align 8
  %printf47 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @string.17, i32 0, i32 0))
  br label %pred48

pred48:                                           ; preds = %while_body49, %merge
  %rest_list58 = load %int_node*, %int_node** %rest_list46, align 8
  %tmp59 = getelementptr inbounds %int_node, %int_node* %rest_list58, i32 0, i32 2
  %tmp60 = load i1, i1* %tmp59, align 1
  %cond61 = icmp eq i1 %tmp60, true
  br i1 %cond61, label %merge62, label %while_body49

while_body49:                                     ; preds = %pred48
  %rest_list50 = load %int_node*, %int_node** %rest_list46, align 8
  %tmp51 = getelementptr inbounds %int_node, %int_node* %rest_list50, i32 0, i32 0
  %tmp52 = load i32, i32* %tmp51, align 4
  %printf53 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %tmp52)
  %printf54 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.18, i32 0, i32 0))
  %rest_list55 = load %int_node*, %int_node** %rest_list46, align 8
  %tmp56 = getelementptr inbounds %int_node, %int_node* %rest_list55, i32 0, i32 1
  %next_lst57 = load %int_node*, %int_node** %tmp56, align 8
  store %int_node* %next_lst57, %int_node** %rest_list46, align 8
  br label %pred48

merge62:                                          ; preds = %pred48
  %printf63 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @string.19, i32 0, i32 0))
  %printf64 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf65 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.20, i32 0, i32 0))
  %printf66 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %j = alloca i32, align 4
  store i32 0, i32* %j, align 4
  store i32 0, i32* %j, align 4
  br label %while

while:                                            ; preds = %while_body67, %merge62
  %j73 = load i32, i32* %j, align 4
  %tmp74 = icmp slt i32 %j73, 1
  br i1 %tmp74, label %while_body67, label %merge75

while_body67:                                     ; preds = %while
  %n = alloca i32, align 4
  store i32 11, i32* %n, align 4
  %printf68 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @string.21, i32 0, i32 0))
  %n69 = load i32, i32* %n, align 4
  %print_nibble = call i32 @print_nibble(i32 %n69)
  %printf70 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %j71 = load i32, i32* %j, align 4
  %tmp72 = add i32 %j71, 1
  store i32 %tmp72, i32* %j, align 4
  br label %while

merge75:                                          ; preds = %while
  %printf76 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.22, i32 0, i32 0))
  %printf77 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %n78 = alloca i32, align 4
  store i32 6, i32* %n78, align 4
  %printf79 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([27 x i8], [27 x i8]* @string.23, i32 0, i32 0))
  %n80 = load i32, i32* %n78, align 4
  %print_nibble81 = call i32 @print_nibble(i32 %n80)
  %printf82 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf83 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.24, i32 0, i32 0))
  %printf84 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf85 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([26 x i8], [26 x i8]* @string.25, i32 0, i32 0))
  %j86 = load i32, i32* %j, align 4
  %printf87 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %j86)
  %printf88 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf89 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @string.26, i32 0, i32 0))
  %printf90 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  ret i32 0
}

declare noalias i8* @malloc(i32)
