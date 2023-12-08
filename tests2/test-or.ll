; ModuleID = 'Chomp'
source_filename = "Chomp"

@fmt = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@fmt.1 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@fmt.2 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@fmt.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@fmt.4 = private unnamed_addr constant [30 x i8] c"cannot call car on empty list\00", align 1

declare i32 @printf(i8*, ...)

declare i32 @print_bit(i32)

declare i32 @print_nibble(i32)

declare i32 @print_byte(i32)

declare i32 @print_word(i32)

declare i32 @exit(i32, ...)

define i32 @main() {
entry:
  %a = alloca i32, align 4
  store i32 9, i32* %a, align 4
  %b = alloca i32, align 4
  store i32 213, i32* %b, align 4
  %a1 = load i32, i32* %a, align 4
  %b2 = load i32, i32* %b, align 4
  %tmp = shl i32 %a1, 8
  %tmp3 = and i32 %b2, 255
  %c = or i32 %tmp, %tmp3
  %c5 = alloca i32, align 4
  store i32 %c, i32* %c5, align 4
  %c6 = load i32, i32* %c5, align 4
  %print_word = call i32 @print_word(i32 %c6)
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  ret i32 0
}
