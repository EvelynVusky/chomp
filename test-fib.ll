; ModuleID = 'Chomp'
source_filename = "Chomp"

@fmt = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@fmt.1 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@fmt.2 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@fmt.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@fmt.4 = private unnamed_addr constant [37 x i8] c"Error: cannot call car on empty list\00", align 1
@fmt.5 = private unnamed_addr constant [37 x i8] c"Error: cannot call cdr on empty list\00", align 1
@string = private unnamed_addr constant [8 x i8] c"Fib of \00", align 1
@string.6 = private unnamed_addr constant [6 x i8] c" is: \00", align 1

declare i32 @printf(i8*, ...)

declare i32 @print_bit(i32)

declare i32 @print_nibble(i32)

declare i32 @print_byte(i32)

declare i32 @print_word(i32)

declare i32 @exit(i32, ...)

define i32 @main() {
entry:
  %n = alloca i32, align 4
  store i32 10, i32* %n, align 4
  %tmp1 = alloca i32, align 4
  store i32 0, i32* %tmp1, align 4
  %tmp2 = alloca i32, align 4
  store i32 1, i32* %tmp2, align 4
  %sum = alloca i32, align 4
  store i32 0, i32* %sum, align 4
  %i = alloca i32, align 4
  store i32 0, i32* %i, align 4
  store i32 2, i32* %i, align 4
  br label %while

while:                                            ; preds = %while_body, %entry
  %i7 = load i32, i32* %i, align 4
  %n8 = load i32, i32* %n, align 4
  %tmp9 = icmp sle i32 %i7, %n8
  br i1 %tmp9, label %while_body, label %merge

while_body:                                       ; preds = %while
  %tmp11 = load i32, i32* %tmp1, align 4
  %tmp22 = load i32, i32* %tmp2, align 4
  %tmp = add i32 %tmp11, %tmp22
  store i32 %tmp, i32* %sum, align 4
  %tmp23 = load i32, i32* %tmp2, align 4
  store i32 %tmp23, i32* %tmp1, align 4
  %sum4 = load i32, i32* %sum, align 4
  store i32 %sum4, i32* %tmp2, align 4
  %i5 = load i32, i32* %i, align 4
  %tmp6 = add i32 %i5, 1
  store i32 %tmp6, i32* %i, align 4
  br label %while

merge:                                            ; preds = %while
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @string, i32 0, i32 0))
  %n10 = load i32, i32* %n, align 4
  %printf11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %n10)
  %printf12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @string.6, i32 0, i32 0))
  %sum13 = load i32, i32* %sum, align 4
  %printf14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %sum13)
  %printf15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  ret i32 0
}
