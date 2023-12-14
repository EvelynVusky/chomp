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

define i32 @add(i32 %a, i32 %b) {
entry:
  %malloccall = tail call i8* @malloc(i32 ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32))
  %a1 = bitcast i8* %malloccall to i32*
  store i32 %a, i32* %a1, align 4
  %malloccall2 = tail call i8* @malloc(i32 ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32))
  %b3 = bitcast i8* %malloccall2 to i32*
  store i32 %b, i32* %b3, align 4
  %a4 = load i32, i32* %a1, align 4
  %b5 = load i32, i32* %b3, align 4
  %tmp = add i32 %a4, %b5
  ret i32 %tmp
}

define i32 @minus(i32 %a, i32 %b) {
entry:
  %malloccall = tail call i8* @malloc(i32 ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32))
  %a1 = bitcast i8* %malloccall to i32*
  store i32 %a, i32* %a1, align 4
  %malloccall2 = tail call i8* @malloc(i32 ptrtoint (i32* getelementptr (i32, i32* null, i32 1) to i32))
  %b3 = bitcast i8* %malloccall2 to i32*
  store i32 %b, i32* %b3, align 4
  %b4 = load i32, i32* %b3, align 4
  %a5 = load i32, i32* %a1, align 4
  %add_result = call i32 @add(i32 %a5, i32 %b4)
  %b6 = load i32, i32* %b3, align 4
  %tmp = sub i32 %add_result, %b6
  ret i32 %tmp
}

define i32 @main() {
entry:
  %minus_result = call i32 @minus(i32 4, i32 8)
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %minus_result)
  %printf1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  ret i32 0
}

declare noalias i8* @malloc(i32)
