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
  %first_initial1 = load i32, i32* %first_initial, align 4
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.2, i32 0, i32 0), i32 %first_initial1)
  %last_initial2 = load i32, i32* %last_initial, align 4
  %printf3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.2, i32 0, i32 0), i32 %last_initial2)
  %age4 = load i32, i32* %age, align 4
  %printf5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %age4)
  %grade6 = load i32, i32* %grade, align 4
  %printf7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %grade6)
  %credits8 = load i32, i32* %credits, align 4
  %printf9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %credits8)
  ret i32 0
}
