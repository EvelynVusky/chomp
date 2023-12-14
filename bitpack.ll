; ModuleID = 'Chomp'
source_filename = "Chomp"

@fmt = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@fmt.1 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@fmt.2 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@fmt.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@fmt.4 = private unnamed_addr constant [42 x i8] c"Error: cannot call div with divisor of 0\0A\00", align 1
@fmt.5 = private unnamed_addr constant [38 x i8] c"Error: cannot call car on empty list\0A\00", align 1
@fmt.6 = private unnamed_addr constant [38 x i8] c"Error: cannot call cdr on empty list\0A\00", align 1

declare i32 @get_bit(i32, i32, i32)

declare i32 @flip_bit(i32, i32, i32)

declare i32 @set_bit(i32, i32, i32, i32)

declare i32 @printf(i8*, ...)

declare i32 @print_bit(i32)

declare i32 @print_nibble(i32)

declare i32 @print_byte(i32)

declare i32 @print_word(i32)

declare i32 @exit(i32, ...)

define i32 @pack(i32 %in1, i32 %in2, i32 %age, i32 %grade, i32 %credits) {
entry:
  %malloccall = tail call i8* @malloc(i32 ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32))
  %in11 = bitcast i8* %malloccall to i32*
  store i32 %in1, i32* %in11, align 4
  %malloccall2 = tail call i8* @malloc(i32 ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32))
  %in23 = bitcast i8* %malloccall2 to i32*
  store i32 %in2, i32* %in23, align 4
  %malloccall4 = tail call i8* @malloc(i32 ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32))
  %age5 = bitcast i8* %malloccall4 to i32*
  store i32 %age, i32* %age5, align 4
  %malloccall6 = tail call i8* @malloc(i32 ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32))
  %grade7 = bitcast i8* %malloccall6 to i32*
  store i32 %grade, i32* %grade7, align 4
  %malloccall8 = tail call i8* @malloc(i32 ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32))
  %credits9 = bitcast i8* %malloccall8 to i32*
  store i32 %credits, i32* %credits9, align 4
  %in1_new = load i32, i32* %in11, align 4
  %in1_new11 = alloca i32, align 4
  store i32 %in1_new, i32* %in1_new11, align 4
  %in2_new = load i32, i32* %in23, align 4
  %in2_new13 = alloca i32, align 4
  store i32 %in2_new, i32* %in2_new13, align 4
  %in1_new14 = load i32, i32* %in1_new11, align 4
  %in2_new15 = load i32, i32* %in2_new13, align 4
  %tmp = shl i32 %in1_new14, 8
  %tmp16 = and i32 %in2_new15, 255
  %in_new = or i32 %tmp, %tmp16
  %in_new18 = alloca i32, align 4
  store i32 %in_new, i32* %in_new18, align 4
  %age_new = load i32, i32* %age5, align 4
  %age_new20 = alloca i32, align 4
  store i32 %age_new, i32* %age_new20, align 4
  %grade_new = load i32, i32* %grade7, align 4
  %grade_new22 = alloca i32, align 4
  store i32 %grade_new, i32* %grade_new22, align 4
  %credits_new = load i32, i32* %credits9, align 4
  %credits_new24 = alloca i32, align 4
  store i32 %credits_new, i32* %credits_new24, align 4
  %age_new25 = load i32, i32* %age_new20, align 4
  %grade_new26 = load i32, i32* %grade_new22, align 4
  %credits_new27 = load i32, i32* %credits_new24, align 4
  %tmp28 = shl i32 %grade_new26, 4
  %tmp29 = and i32 %credits_new27, 15
  %tmp30 = or i32 %tmp28, %tmp29
  %tmp31 = shl i32 %age_new25, 8
  %tmp32 = and i32 %tmp30, 255
  %w2 = or i32 %tmp31, %tmp32
  %w234 = alloca i32, align 4
  store i32 %w2, i32* %w234, align 4
  %in_new35 = load i32, i32* %in_new18, align 4
  %w236 = load i32, i32* %w234, align 4
  %tmp37 = shl i32 %in_new35, 16
  %tmp38 = and i32 %w236, 65535
  %tmp39 = or i32 %tmp37, %tmp38
  ret i32 %tmp39
}

define i32 @main() {
entry:
  %first_initial = alloca i32, align 4
  store i32 97, i32* %first_initial, align 4
  %last_initial = alloca i32, align 4
  store i32 100, i32* %last_initial, align 4
  %age = alloca i32, align 4
  store i32 23, i32* %age, align 4
  %grade = alloca i32, align 4
  store i32 14, i32* %grade, align 4
  %credits = alloca i32, align 4
  store i32 15, i32* %credits, align 4
  %credits1 = load i32, i32* %credits, align 4
  %grade2 = load i32, i32* %grade, align 4
  %age3 = load i32, i32* %age, align 4
  %last_initial4 = load i32, i32* %last_initial, align 4
  %first_initial5 = load i32, i32* %first_initial, align 4
  %student = call i32 @pack(i32 %first_initial5, i32 %last_initial4, i32 %age3, i32 %grade2, i32 %credits1)
  %student6 = alloca i32, align 4
  store i32 %student, i32* %student6, align 4
  %student7 = load i32, i32* %student6, align 4
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %student7)
  ret i32 0
}

declare noalias i8* @malloc(i32)
