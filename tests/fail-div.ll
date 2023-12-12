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
  br i1 true, label %then, label %else

merge:                                            ; preds = %else, %then
  %a = alloca i32, align 4
  store i32 poison, i32* %a, align 4
  %a1 = load i32, i32* %a, align 4
  %printf2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %a1)
  ret i32 0

then:                                             ; preds = %entry
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @fmt.4, i32 0, i32 0))
  %exit = call i32 (i32, ...) @exit(i32 1)
  br label %merge

else:                                             ; preds = %entry
  br label %merge
}
