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
@string = private unnamed_addr constant [11 x i8] c"a1 == a1: \00", align 1
@string.7 = private unnamed_addr constant [29 x i8] c"a1 == a2 (identical lists): \00", align 1
@string.8 = private unnamed_addr constant [28 x i8] c"a1 == b (different lists): \00", align 1
@string.9 = private unnamed_addr constant [28 x i8] c"a1 == c (different sizes): \00", align 1
@string.10 = private unnamed_addr constant [14 x i8] c"a1 == empty: \00", align 1
@string.11 = private unnamed_addr constant [17 x i8] c"empty == empty: \00", align 1
@string.12 = private unnamed_addr constant [11 x i8] c"[] == []: \00", align 1
@string.13 = private unnamed_addr constant [31 x i8] c"[1, 2, 3, 4] == [1, 2, 3, 5]: \00", align 1
@string.14 = private unnamed_addr constant [31 x i8] c"[1, 2, 3, 4] == [1, 2, 3, 4]: \00", align 1
@string.15 = private unnamed_addr constant [21 x i8] c"[] == [1, 2, 3, 4]: \00", align 1
@string.16 = private unnamed_addr constant [22 x i8] c"[1, 2] == [3, 4, 5]: \00", align 1

declare i32 @get_bit(i32, i32, i32)

declare i32 @flip_bit(i32, i32, i32)

declare i32 @set_bit(i32, i32, i32, i32)

declare i32 @printf(i8*, ...)

declare i32 @print_bit(i32)

declare i32 @print_nibble(i32)

declare i32 @print_byte(i32)

declare i32 @print_word(i32)

declare i32 @exit(i32, ...)

define i1 @list_equals(%int_node* %a, %int_node* %b) {
entry:
  %malloccall = tail call i8* @malloc(i32 ptrtoint (%int_node** getelementptr (%int_node*, %int_node** null, i32 1) to i32))
  %a1 = bitcast i8* %malloccall to %int_node**
  store %int_node* %a, %int_node** %a1, align 8
  %malloccall2 = tail call i8* @malloc(i32 ptrtoint (%int_node** getelementptr (%int_node*, %int_node** null, i32 1) to i32))
  %b3 = bitcast i8* %malloccall2 to %int_node**
  store %int_node* %b, %int_node** %b3, align 8
  %equal = alloca i1, align 1
  store i1 true, i1* %equal, align 1
  br label %while

while:                                            ; preds = %merge38, %entry
  %a45 = load %int_node*, %int_node** %a1, align 8
  %malloccall46 = tail call i8* @malloc(i32 ptrtoint (i1* getelementptr (i1, i1* null, i32 1) to i32))
  %bool_var = bitcast i8* %malloccall46 to i1*
  store i1 false, i1* %bool_var, align 1
  %tmp47 = getelementptr inbounds %int_node, %int_node* %a45, i32 0, i32 2
  %tmp48 = load i1, i1* %tmp47, align 1
  %cond49 = icmp eq i1 %tmp48, true
  br i1 %cond49, label %then51, label %else52

while_body:                                       ; preds = %merge61
  %a4 = load %int_node*, %int_node** %a1, align 8
  %tmp = getelementptr inbounds %int_node, %int_node* %a4, i32 0, i32 2
  %tmp5 = load i1, i1* %tmp, align 1
  %cond = icmp eq i1 %tmp5, true
  br i1 %cond, label %then, label %else

merge:                                            ; preds = %else, %then
  %tmp6 = getelementptr inbounds %int_node, %int_node* %a4, i32 0, i32 0
  %tmp7 = load i32, i32* %tmp6, align 4
  %b8 = load %int_node*, %int_node** %b3, align 8
  %tmp9 = getelementptr inbounds %int_node, %int_node* %b8, i32 0, i32 2
  %tmp10 = load i1, i1* %tmp9, align 1
  %cond11 = icmp eq i1 %tmp10, true
  br i1 %cond11, label %then13, label %else16

then:                                             ; preds = %while_body
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @fmt.5, i32 0, i32 0))
  %exit = call i32 (i32, ...) @exit(i32 1)
  br label %merge

else:                                             ; preds = %while_body
  br label %merge

merge12:                                          ; preds = %else16, %then13
  %tmp17 = getelementptr inbounds %int_node, %int_node* %b8, i32 0, i32 0
  %tmp18 = load i32, i32* %tmp17, align 4
  %tmp19 = icmp ne i32 %tmp7, %tmp18
  br i1 %tmp19, label %then21, label %else22

then13:                                           ; preds = %merge
  %printf14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @fmt.5, i32 0, i32 0))
  %exit15 = call i32 (i32, ...) @exit(i32 1)
  br label %merge12

else16:                                           ; preds = %merge
  br label %merge12

merge20:                                          ; preds = %else22, %then21
  %a23 = load %int_node*, %int_node** %a1, align 8
  %tmp24 = getelementptr inbounds %int_node, %int_node* %a23, i32 0, i32 2
  %tmp25 = load i1, i1* %tmp24, align 1
  %cond26 = icmp eq i1 %tmp25, true
  br i1 %cond26, label %then28, label %else31

then21:                                           ; preds = %merge12
  store i1 false, i1* %equal, align 1
  br label %merge20

else22:                                           ; preds = %merge12
  br label %merge20

merge27:                                          ; preds = %else31, %then28
  %tmp32 = getelementptr inbounds %int_node, %int_node* %a23, i32 0, i32 1
  %tmp33 = load %int_node*, %int_node** %tmp32, align 8
  store %int_node* %tmp33, %int_node** %a1, align 8
  %b34 = load %int_node*, %int_node** %b3, align 8
  %tmp35 = getelementptr inbounds %int_node, %int_node* %b34, i32 0, i32 2
  %tmp36 = load i1, i1* %tmp35, align 1
  %cond37 = icmp eq i1 %tmp36, true
  br i1 %cond37, label %then39, label %else42

then28:                                           ; preds = %merge20
  %printf29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @fmt.6, i32 0, i32 0))
  %exit30 = call i32 (i32, ...) @exit(i32 1)
  br label %merge27

else31:                                           ; preds = %merge20
  br label %merge27

merge38:                                          ; preds = %else42, %then39
  %tmp43 = getelementptr inbounds %int_node, %int_node* %b34, i32 0, i32 1
  %tmp44 = load %int_node*, %int_node** %tmp43, align 8
  store %int_node* %tmp44, %int_node** %b3, align 8
  br label %while

then39:                                           ; preds = %merge27
  %printf40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @fmt.6, i32 0, i32 0))
  %exit41 = call i32 (i32, ...) @exit(i32 1)
  br label %merge38

else42:                                           ; preds = %merge27
  br label %merge38

merge50:                                          ; preds = %else52, %then51
  %tmp53 = load i1, i1* %bool_var, align 1
  %tmp54 = xor i1 %tmp53, true
  %b55 = load %int_node*, %int_node** %b3, align 8
  %malloccall56 = tail call i8* @malloc(i32 ptrtoint (i1* getelementptr (i1, i1* null, i32 1) to i32))
  %bool_var57 = bitcast i8* %malloccall56 to i1*
  store i1 false, i1* %bool_var57, align 1
  %tmp58 = getelementptr inbounds %int_node, %int_node* %b55, i32 0, i32 2
  %tmp59 = load i1, i1* %tmp58, align 1
  %cond60 = icmp eq i1 %tmp59, true
  br i1 %cond60, label %then62, label %else63

then51:                                           ; preds = %while
  store i1 true, i1* %bool_var, align 1
  br label %merge50

else52:                                           ; preds = %while
  br label %merge50

merge61:                                          ; preds = %else63, %then62
  %tmp64 = load i1, i1* %bool_var57, align 1
  %tmp65 = xor i1 %tmp64, true
  %tmp66 = and i1 %tmp54, %tmp65
  br i1 %tmp66, label %while_body, label %merge67

then62:                                           ; preds = %merge50
  store i1 true, i1* %bool_var57, align 1
  br label %merge61

else63:                                           ; preds = %merge50
  br label %merge61

merge67:                                          ; preds = %merge61
  %a68 = load %int_node*, %int_node** %a1, align 8
  %malloccall69 = tail call i8* @malloc(i32 ptrtoint (i1* getelementptr (i1, i1* null, i32 1) to i32))
  %bool_var70 = bitcast i8* %malloccall69 to i1*
  store i1 false, i1* %bool_var70, align 1
  %tmp71 = getelementptr inbounds %int_node, %int_node* %a68, i32 0, i32 2
  %tmp72 = load i1, i1* %tmp71, align 1
  %cond73 = icmp eq i1 %tmp72, true
  br i1 %cond73, label %then75, label %else76

merge74:                                          ; preds = %else76, %then75
  %tmp77 = load i1, i1* %bool_var70, align 1
  %tmp78 = xor i1 %tmp77, true
  %b79 = load %int_node*, %int_node** %b3, align 8
  %malloccall80 = tail call i8* @malloc(i32 ptrtoint (i1* getelementptr (i1, i1* null, i32 1) to i32))
  %bool_var81 = bitcast i8* %malloccall80 to i1*
  store i1 false, i1* %bool_var81, align 1
  %tmp82 = getelementptr inbounds %int_node, %int_node* %b79, i32 0, i32 2
  %tmp83 = load i1, i1* %tmp82, align 1
  %cond84 = icmp eq i1 %tmp83, true
  br i1 %cond84, label %then86, label %else87

then75:                                           ; preds = %merge67
  store i1 true, i1* %bool_var70, align 1
  br label %merge74

else76:                                           ; preds = %merge67
  br label %merge74

merge85:                                          ; preds = %else87, %then86
  %tmp88 = load i1, i1* %bool_var81, align 1
  %tmp89 = xor i1 %tmp88, true
  %tmp90 = or i1 %tmp78, %tmp89
  br i1 %tmp90, label %then92, label %else93

then86:                                           ; preds = %merge74
  store i1 true, i1* %bool_var81, align 1
  br label %merge85

else87:                                           ; preds = %merge74
  br label %merge85

merge91:                                          ; preds = %else93, %then92
  %equal94 = load i1, i1* %equal, align 1
  ret i1 %equal94

then92:                                           ; preds = %merge85
  store i1 false, i1* %equal, align 1
  br label %merge91

else93:                                           ; preds = %merge85
  br label %merge91
}

define i32 @main() {
entry:
  %malloccall = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var = bitcast i8* %malloccall to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var, align 1
  %malloccall1 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var = bitcast i8* %malloccall1 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var, align 1
  %front_val = getelementptr inbounds %int_node, %int_node* %front_node_var, i32 0, i32 0
  store i32 4, i32* %front_val, align 4
  %front_node_next = getelementptr inbounds %int_node, %int_node* %front_node_var, i32 0, i32 1
  store %int_node* %last_node_var, %int_node** %front_node_next, align 8
  %malloccall2 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var3 = bitcast i8* %malloccall2 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var3, align 1
  %front_val4 = getelementptr inbounds %int_node, %int_node* %front_node_var3, i32 0, i32 0
  store i32 3, i32* %front_val4, align 4
  %front_node_next5 = getelementptr inbounds %int_node, %int_node* %front_node_var3, i32 0, i32 1
  store %int_node* %front_node_var, %int_node** %front_node_next5, align 8
  %malloccall6 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var7 = bitcast i8* %malloccall6 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var7, align 1
  %front_val8 = getelementptr inbounds %int_node, %int_node* %front_node_var7, i32 0, i32 0
  store i32 2, i32* %front_val8, align 4
  %front_node_next9 = getelementptr inbounds %int_node, %int_node* %front_node_var7, i32 0, i32 1
  store %int_node* %front_node_var3, %int_node** %front_node_next9, align 8
  %malloccall10 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %a1 = bitcast i8* %malloccall10 to %int_node*
  store %int_node zeroinitializer, %int_node* %a1, align 1
  %front_val12 = getelementptr inbounds %int_node, %int_node* %a1, i32 0, i32 0
  store i32 1, i32* %front_val12, align 4
  %front_node_next13 = getelementptr inbounds %int_node, %int_node* %a1, i32 0, i32 1
  store %int_node* %front_node_var7, %int_node** %front_node_next13, align 8
  %a114 = alloca %int_node*, align 8
  store %int_node* %a1, %int_node** %a114, align 8
  %malloccall15 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var16 = bitcast i8* %malloccall15 to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var16, align 1
  %malloccall17 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var18 = bitcast i8* %malloccall17 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var18, align 1
  %front_val19 = getelementptr inbounds %int_node, %int_node* %front_node_var18, i32 0, i32 0
  store i32 4, i32* %front_val19, align 4
  %front_node_next20 = getelementptr inbounds %int_node, %int_node* %front_node_var18, i32 0, i32 1
  store %int_node* %last_node_var16, %int_node** %front_node_next20, align 8
  %malloccall21 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var22 = bitcast i8* %malloccall21 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var22, align 1
  %front_val23 = getelementptr inbounds %int_node, %int_node* %front_node_var22, i32 0, i32 0
  store i32 3, i32* %front_val23, align 4
  %front_node_next24 = getelementptr inbounds %int_node, %int_node* %front_node_var22, i32 0, i32 1
  store %int_node* %front_node_var18, %int_node** %front_node_next24, align 8
  %malloccall25 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var26 = bitcast i8* %malloccall25 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var26, align 1
  %front_val27 = getelementptr inbounds %int_node, %int_node* %front_node_var26, i32 0, i32 0
  store i32 2, i32* %front_val27, align 4
  %front_node_next28 = getelementptr inbounds %int_node, %int_node* %front_node_var26, i32 0, i32 1
  store %int_node* %front_node_var22, %int_node** %front_node_next28, align 8
  %malloccall29 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %a2 = bitcast i8* %malloccall29 to %int_node*
  store %int_node zeroinitializer, %int_node* %a2, align 1
  %front_val31 = getelementptr inbounds %int_node, %int_node* %a2, i32 0, i32 0
  store i32 1, i32* %front_val31, align 4
  %front_node_next32 = getelementptr inbounds %int_node, %int_node* %a2, i32 0, i32 1
  store %int_node* %front_node_var26, %int_node** %front_node_next32, align 8
  %a233 = alloca %int_node*, align 8
  store %int_node* %a2, %int_node** %a233, align 8
  %malloccall34 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var35 = bitcast i8* %malloccall34 to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var35, align 1
  %malloccall36 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var37 = bitcast i8* %malloccall36 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var37, align 1
  %front_val38 = getelementptr inbounds %int_node, %int_node* %front_node_var37, i32 0, i32 0
  store i32 5, i32* %front_val38, align 4
  %front_node_next39 = getelementptr inbounds %int_node, %int_node* %front_node_var37, i32 0, i32 1
  store %int_node* %last_node_var35, %int_node** %front_node_next39, align 8
  %malloccall40 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var41 = bitcast i8* %malloccall40 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var41, align 1
  %front_val42 = getelementptr inbounds %int_node, %int_node* %front_node_var41, i32 0, i32 0
  store i32 4, i32* %front_val42, align 4
  %front_node_next43 = getelementptr inbounds %int_node, %int_node* %front_node_var41, i32 0, i32 1
  store %int_node* %front_node_var37, %int_node** %front_node_next43, align 8
  %malloccall44 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var45 = bitcast i8* %malloccall44 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var45, align 1
  %front_val46 = getelementptr inbounds %int_node, %int_node* %front_node_var45, i32 0, i32 0
  store i32 3, i32* %front_val46, align 4
  %front_node_next47 = getelementptr inbounds %int_node, %int_node* %front_node_var45, i32 0, i32 1
  store %int_node* %front_node_var41, %int_node** %front_node_next47, align 8
  %malloccall48 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %b = bitcast i8* %malloccall48 to %int_node*
  store %int_node zeroinitializer, %int_node* %b, align 1
  %front_val50 = getelementptr inbounds %int_node, %int_node* %b, i32 0, i32 0
  store i32 2, i32* %front_val50, align 4
  %front_node_next51 = getelementptr inbounds %int_node, %int_node* %b, i32 0, i32 1
  store %int_node* %front_node_var45, %int_node** %front_node_next51, align 8
  %b52 = alloca %int_node*, align 8
  store %int_node* %b, %int_node** %b52, align 8
  %malloccall53 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var54 = bitcast i8* %malloccall53 to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var54, align 1
  %malloccall55 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var56 = bitcast i8* %malloccall55 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var56, align 1
  %front_val57 = getelementptr inbounds %int_node, %int_node* %front_node_var56, i32 0, i32 0
  store i32 3, i32* %front_val57, align 4
  %front_node_next58 = getelementptr inbounds %int_node, %int_node* %front_node_var56, i32 0, i32 1
  store %int_node* %last_node_var54, %int_node** %front_node_next58, align 8
  %malloccall59 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var60 = bitcast i8* %malloccall59 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var60, align 1
  %front_val61 = getelementptr inbounds %int_node, %int_node* %front_node_var60, i32 0, i32 0
  store i32 2, i32* %front_val61, align 4
  %front_node_next62 = getelementptr inbounds %int_node, %int_node* %front_node_var60, i32 0, i32 1
  store %int_node* %front_node_var56, %int_node** %front_node_next62, align 8
  %malloccall63 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %c = bitcast i8* %malloccall63 to %int_node*
  store %int_node zeroinitializer, %int_node* %c, align 1
  %front_val65 = getelementptr inbounds %int_node, %int_node* %c, i32 0, i32 0
  store i32 1, i32* %front_val65, align 4
  %front_node_next66 = getelementptr inbounds %int_node, %int_node* %c, i32 0, i32 1
  store %int_node* %front_node_var60, %int_node** %front_node_next66, align 8
  %c67 = alloca %int_node*, align 8
  store %int_node* %c, %int_node** %c67, align 8
  %malloccall68 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %empty = bitcast i8* %malloccall68 to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %empty, align 1
  %empty70 = alloca %int_node*, align 8
  store %int_node* %empty, %int_node** %empty70, align 8
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @string, i32 0, i32 0))
  %a171 = load %int_node*, %int_node** %a114, align 8
  %a172 = load %int_node*, %int_node** %a114, align 8
  %list_equals_result = call i1 @list_equals(%int_node* %a172, %int_node* %a171)
  %printf73 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i1 %list_equals_result)
  %printf74 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf75 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([29 x i8], [29 x i8]* @string.7, i32 0, i32 0))
  %a276 = load %int_node*, %int_node** %a233, align 8
  %a177 = load %int_node*, %int_node** %a114, align 8
  %list_equals_result78 = call i1 @list_equals(%int_node* %a177, %int_node* %a276)
  %printf79 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i1 %list_equals_result78)
  %printf80 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf81 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @string.8, i32 0, i32 0))
  %b82 = load %int_node*, %int_node** %b52, align 8
  %a183 = load %int_node*, %int_node** %a114, align 8
  %list_equals_result84 = call i1 @list_equals(%int_node* %a183, %int_node* %b82)
  %printf85 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i1 %list_equals_result84)
  %printf86 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf87 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @string.9, i32 0, i32 0))
  %c88 = load %int_node*, %int_node** %c67, align 8
  %a189 = load %int_node*, %int_node** %a114, align 8
  %list_equals_result90 = call i1 @list_equals(%int_node* %a189, %int_node* %c88)
  %printf91 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i1 %list_equals_result90)
  %printf92 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf93 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @string.10, i32 0, i32 0))
  %empty94 = load %int_node*, %int_node** %empty70, align 8
  %a195 = load %int_node*, %int_node** %a114, align 8
  %list_equals_result96 = call i1 @list_equals(%int_node* %a195, %int_node* %empty94)
  %printf97 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i1 %list_equals_result96)
  %printf98 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf99 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @string.11, i32 0, i32 0))
  %empty100 = load %int_node*, %int_node** %empty70, align 8
  %empty101 = load %int_node*, %int_node** %empty70, align 8
  %list_equals_result102 = call i1 @list_equals(%int_node* %empty101, %int_node* %empty100)
  %printf103 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i1 %list_equals_result102)
  %printf104 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf105 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @string.12, i32 0, i32 0))
  %malloccall106 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var107 = bitcast i8* %malloccall106 to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var107, align 1
  %malloccall108 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var109 = bitcast i8* %malloccall108 to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var109, align 1
  %list_equals_result110 = call i1 @list_equals(%int_node* %last_node_var109, %int_node* %last_node_var107)
  %printf111 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i1 %list_equals_result110)
  %printf112 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf113 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([31 x i8], [31 x i8]* @string.13, i32 0, i32 0))
  %malloccall114 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var115 = bitcast i8* %malloccall114 to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var115, align 1
  %malloccall116 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var117 = bitcast i8* %malloccall116 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var117, align 1
  %front_val118 = getelementptr inbounds %int_node, %int_node* %front_node_var117, i32 0, i32 0
  store i32 5, i32* %front_val118, align 4
  %front_node_next119 = getelementptr inbounds %int_node, %int_node* %front_node_var117, i32 0, i32 1
  store %int_node* %last_node_var115, %int_node** %front_node_next119, align 8
  %malloccall120 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var121 = bitcast i8* %malloccall120 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var121, align 1
  %front_val122 = getelementptr inbounds %int_node, %int_node* %front_node_var121, i32 0, i32 0
  store i32 3, i32* %front_val122, align 4
  %front_node_next123 = getelementptr inbounds %int_node, %int_node* %front_node_var121, i32 0, i32 1
  store %int_node* %front_node_var117, %int_node** %front_node_next123, align 8
  %malloccall124 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var125 = bitcast i8* %malloccall124 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var125, align 1
  %front_val126 = getelementptr inbounds %int_node, %int_node* %front_node_var125, i32 0, i32 0
  store i32 2, i32* %front_val126, align 4
  %front_node_next127 = getelementptr inbounds %int_node, %int_node* %front_node_var125, i32 0, i32 1
  store %int_node* %front_node_var121, %int_node** %front_node_next127, align 8
  %malloccall128 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var129 = bitcast i8* %malloccall128 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var129, align 1
  %front_val130 = getelementptr inbounds %int_node, %int_node* %front_node_var129, i32 0, i32 0
  store i32 1, i32* %front_val130, align 4
  %front_node_next131 = getelementptr inbounds %int_node, %int_node* %front_node_var129, i32 0, i32 1
  store %int_node* %front_node_var125, %int_node** %front_node_next131, align 8
  %malloccall132 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var133 = bitcast i8* %malloccall132 to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var133, align 1
  %malloccall134 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var135 = bitcast i8* %malloccall134 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var135, align 1
  %front_val136 = getelementptr inbounds %int_node, %int_node* %front_node_var135, i32 0, i32 0
  store i32 4, i32* %front_val136, align 4
  %front_node_next137 = getelementptr inbounds %int_node, %int_node* %front_node_var135, i32 0, i32 1
  store %int_node* %last_node_var133, %int_node** %front_node_next137, align 8
  %malloccall138 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var139 = bitcast i8* %malloccall138 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var139, align 1
  %front_val140 = getelementptr inbounds %int_node, %int_node* %front_node_var139, i32 0, i32 0
  store i32 3, i32* %front_val140, align 4
  %front_node_next141 = getelementptr inbounds %int_node, %int_node* %front_node_var139, i32 0, i32 1
  store %int_node* %front_node_var135, %int_node** %front_node_next141, align 8
  %malloccall142 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var143 = bitcast i8* %malloccall142 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var143, align 1
  %front_val144 = getelementptr inbounds %int_node, %int_node* %front_node_var143, i32 0, i32 0
  store i32 2, i32* %front_val144, align 4
  %front_node_next145 = getelementptr inbounds %int_node, %int_node* %front_node_var143, i32 0, i32 1
  store %int_node* %front_node_var139, %int_node** %front_node_next145, align 8
  %malloccall146 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var147 = bitcast i8* %malloccall146 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var147, align 1
  %front_val148 = getelementptr inbounds %int_node, %int_node* %front_node_var147, i32 0, i32 0
  store i32 1, i32* %front_val148, align 4
  %front_node_next149 = getelementptr inbounds %int_node, %int_node* %front_node_var147, i32 0, i32 1
  store %int_node* %front_node_var143, %int_node** %front_node_next149, align 8
  %list_equals_result150 = call i1 @list_equals(%int_node* %front_node_var147, %int_node* %front_node_var129)
  %printf151 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i1 %list_equals_result150)
  %printf152 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf153 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([31 x i8], [31 x i8]* @string.14, i32 0, i32 0))
  %malloccall154 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var155 = bitcast i8* %malloccall154 to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var155, align 1
  %malloccall156 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var157 = bitcast i8* %malloccall156 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var157, align 1
  %front_val158 = getelementptr inbounds %int_node, %int_node* %front_node_var157, i32 0, i32 0
  store i32 4, i32* %front_val158, align 4
  %front_node_next159 = getelementptr inbounds %int_node, %int_node* %front_node_var157, i32 0, i32 1
  store %int_node* %last_node_var155, %int_node** %front_node_next159, align 8
  %malloccall160 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var161 = bitcast i8* %malloccall160 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var161, align 1
  %front_val162 = getelementptr inbounds %int_node, %int_node* %front_node_var161, i32 0, i32 0
  store i32 3, i32* %front_val162, align 4
  %front_node_next163 = getelementptr inbounds %int_node, %int_node* %front_node_var161, i32 0, i32 1
  store %int_node* %front_node_var157, %int_node** %front_node_next163, align 8
  %malloccall164 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var165 = bitcast i8* %malloccall164 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var165, align 1
  %front_val166 = getelementptr inbounds %int_node, %int_node* %front_node_var165, i32 0, i32 0
  store i32 2, i32* %front_val166, align 4
  %front_node_next167 = getelementptr inbounds %int_node, %int_node* %front_node_var165, i32 0, i32 1
  store %int_node* %front_node_var161, %int_node** %front_node_next167, align 8
  %malloccall168 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var169 = bitcast i8* %malloccall168 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var169, align 1
  %front_val170 = getelementptr inbounds %int_node, %int_node* %front_node_var169, i32 0, i32 0
  store i32 1, i32* %front_val170, align 4
  %front_node_next171 = getelementptr inbounds %int_node, %int_node* %front_node_var169, i32 0, i32 1
  store %int_node* %front_node_var165, %int_node** %front_node_next171, align 8
  %malloccall172 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var173 = bitcast i8* %malloccall172 to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var173, align 1
  %malloccall174 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var175 = bitcast i8* %malloccall174 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var175, align 1
  %front_val176 = getelementptr inbounds %int_node, %int_node* %front_node_var175, i32 0, i32 0
  store i32 4, i32* %front_val176, align 4
  %front_node_next177 = getelementptr inbounds %int_node, %int_node* %front_node_var175, i32 0, i32 1
  store %int_node* %last_node_var173, %int_node** %front_node_next177, align 8
  %malloccall178 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var179 = bitcast i8* %malloccall178 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var179, align 1
  %front_val180 = getelementptr inbounds %int_node, %int_node* %front_node_var179, i32 0, i32 0
  store i32 3, i32* %front_val180, align 4
  %front_node_next181 = getelementptr inbounds %int_node, %int_node* %front_node_var179, i32 0, i32 1
  store %int_node* %front_node_var175, %int_node** %front_node_next181, align 8
  %malloccall182 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var183 = bitcast i8* %malloccall182 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var183, align 1
  %front_val184 = getelementptr inbounds %int_node, %int_node* %front_node_var183, i32 0, i32 0
  store i32 2, i32* %front_val184, align 4
  %front_node_next185 = getelementptr inbounds %int_node, %int_node* %front_node_var183, i32 0, i32 1
  store %int_node* %front_node_var179, %int_node** %front_node_next185, align 8
  %malloccall186 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var187 = bitcast i8* %malloccall186 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var187, align 1
  %front_val188 = getelementptr inbounds %int_node, %int_node* %front_node_var187, i32 0, i32 0
  store i32 1, i32* %front_val188, align 4
  %front_node_next189 = getelementptr inbounds %int_node, %int_node* %front_node_var187, i32 0, i32 1
  store %int_node* %front_node_var183, %int_node** %front_node_next189, align 8
  %list_equals_result190 = call i1 @list_equals(%int_node* %front_node_var187, %int_node* %front_node_var169)
  %printf191 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i1 %list_equals_result190)
  %printf192 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf193 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([21 x i8], [21 x i8]* @string.15, i32 0, i32 0))
  %malloccall194 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var195 = bitcast i8* %malloccall194 to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var195, align 1
  %malloccall196 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var197 = bitcast i8* %malloccall196 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var197, align 1
  %front_val198 = getelementptr inbounds %int_node, %int_node* %front_node_var197, i32 0, i32 0
  store i32 4, i32* %front_val198, align 4
  %front_node_next199 = getelementptr inbounds %int_node, %int_node* %front_node_var197, i32 0, i32 1
  store %int_node* %last_node_var195, %int_node** %front_node_next199, align 8
  %malloccall200 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var201 = bitcast i8* %malloccall200 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var201, align 1
  %front_val202 = getelementptr inbounds %int_node, %int_node* %front_node_var201, i32 0, i32 0
  store i32 3, i32* %front_val202, align 4
  %front_node_next203 = getelementptr inbounds %int_node, %int_node* %front_node_var201, i32 0, i32 1
  store %int_node* %front_node_var197, %int_node** %front_node_next203, align 8
  %malloccall204 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var205 = bitcast i8* %malloccall204 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var205, align 1
  %front_val206 = getelementptr inbounds %int_node, %int_node* %front_node_var205, i32 0, i32 0
  store i32 2, i32* %front_val206, align 4
  %front_node_next207 = getelementptr inbounds %int_node, %int_node* %front_node_var205, i32 0, i32 1
  store %int_node* %front_node_var201, %int_node** %front_node_next207, align 8
  %malloccall208 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var209 = bitcast i8* %malloccall208 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var209, align 1
  %front_val210 = getelementptr inbounds %int_node, %int_node* %front_node_var209, i32 0, i32 0
  store i32 1, i32* %front_val210, align 4
  %front_node_next211 = getelementptr inbounds %int_node, %int_node* %front_node_var209, i32 0, i32 1
  store %int_node* %front_node_var205, %int_node** %front_node_next211, align 8
  %malloccall212 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var213 = bitcast i8* %malloccall212 to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var213, align 1
  %list_equals_result214 = call i1 @list_equals(%int_node* %last_node_var213, %int_node* %front_node_var209)
  %printf215 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i1 %list_equals_result214)
  %printf216 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %printf217 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([22 x i8], [22 x i8]* @string.16, i32 0, i32 0))
  %malloccall218 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var219 = bitcast i8* %malloccall218 to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var219, align 1
  %malloccall220 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var221 = bitcast i8* %malloccall220 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var221, align 1
  %front_val222 = getelementptr inbounds %int_node, %int_node* %front_node_var221, i32 0, i32 0
  store i32 5, i32* %front_val222, align 4
  %front_node_next223 = getelementptr inbounds %int_node, %int_node* %front_node_var221, i32 0, i32 1
  store %int_node* %last_node_var219, %int_node** %front_node_next223, align 8
  %malloccall224 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var225 = bitcast i8* %malloccall224 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var225, align 1
  %front_val226 = getelementptr inbounds %int_node, %int_node* %front_node_var225, i32 0, i32 0
  store i32 4, i32* %front_val226, align 4
  %front_node_next227 = getelementptr inbounds %int_node, %int_node* %front_node_var225, i32 0, i32 1
  store %int_node* %front_node_var221, %int_node** %front_node_next227, align 8
  %malloccall228 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var229 = bitcast i8* %malloccall228 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var229, align 1
  %front_val230 = getelementptr inbounds %int_node, %int_node* %front_node_var229, i32 0, i32 0
  store i32 3, i32* %front_val230, align 4
  %front_node_next231 = getelementptr inbounds %int_node, %int_node* %front_node_var229, i32 0, i32 1
  store %int_node* %front_node_var225, %int_node** %front_node_next231, align 8
  %malloccall232 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %last_node_var233 = bitcast i8* %malloccall232 to %int_node*
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var233, align 1
  %malloccall234 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var235 = bitcast i8* %malloccall234 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var235, align 1
  %front_val236 = getelementptr inbounds %int_node, %int_node* %front_node_var235, i32 0, i32 0
  store i32 2, i32* %front_val236, align 4
  %front_node_next237 = getelementptr inbounds %int_node, %int_node* %front_node_var235, i32 0, i32 1
  store %int_node* %last_node_var233, %int_node** %front_node_next237, align 8
  %malloccall238 = tail call i8* @malloc(i32 ptrtoint (%int_node* getelementptr (%int_node, %int_node* null, i32 1) to i32))
  %front_node_var239 = bitcast i8* %malloccall238 to %int_node*
  store %int_node zeroinitializer, %int_node* %front_node_var239, align 1
  %front_val240 = getelementptr inbounds %int_node, %int_node* %front_node_var239, i32 0, i32 0
  store i32 1, i32* %front_val240, align 4
  %front_node_next241 = getelementptr inbounds %int_node, %int_node* %front_node_var239, i32 0, i32 1
  store %int_node* %front_node_var235, %int_node** %front_node_next241, align 8
  %list_equals_result242 = call i1 @list_equals(%int_node* %front_node_var239, %int_node* %front_node_var229)
  %printf243 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i1 %list_equals_result242)
  %printf244 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  ret i32 0
}

declare noalias i8* @malloc(i32)
