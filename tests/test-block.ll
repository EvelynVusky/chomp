; ModuleID = 'Chomp'
source_filename = "Chomp"

@fmt = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@fmt.1 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@fmt.2 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@fmt.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@fmt.4 = private unnamed_addr constant [37 x i8] c"Error: cannot call car on empty list\00", align 1
@fmt.5 = private unnamed_addr constant [37 x i8] c"Error: cannot call cdr on empty list\00", align 1

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
  %a = alloca i32, align 4
  store i32 4, i32* %a, align 4
  %b = alloca i32, align 4
  store i32 5, i32* %b, align 4
  %a1 = load i32, i32* %a, align 4
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %a1)
  %printf2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %a3 = load i32, i32* %a, align 4
  %b4 = load i32, i32* %b, align 4
  %tmp = add i32 %a3, %b4
  store i32 %tmp, i32* %a, align 4
  %c = alloca i32, align 4
  store i32 6, i32* %c, align 4
  %c5 = load i32, i32* %c, align 4
  %tmp6 = mul i32 %c5, 7
  %tmp7 = add i32 %tmp6, 3
  store i32 %tmp7, i32* %c, align 4
  %c8 = load i32, i32* %c, align 4
  %printf9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %c8)
  %printf10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %a11 = load i32, i32* %a, align 4
  %printf12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %a11)
  %printf13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  ret i32 0
}
