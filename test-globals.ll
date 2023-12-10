; ModuleID = 'Chomp'
source_filename = "Chomp"

@fmt = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@fmt.1 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@fmt.2 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@fmt.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@fmt.4 = private unnamed_addr constant [37 x i8] c"Error: cannot call car on empty list\00", align 1
@fmt.5 = private unnamed_addr constant [37 x i8] c"Error: cannot call cdr on empty list\00", align 1
@string = private unnamed_addr constant [8 x i8] c"Hello, \00", align 1
@string.6 = private unnamed_addr constant [6 x i8] c"World\00", align 1

declare i32 @printf(i8*, ...)

declare i32 @print_bit(i32)

declare i32 @print_nibble(i32)

declare i32 @print_byte(i32)

declare i32 @print_word(i32)

declare i32 @exit(i32, ...)

define i32 @main() {
entry:
  %a = alloca i8*, align 8
  store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @string, i32 0, i32 0), i8** %a, align 8
  %b = alloca i8*, align 8
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @string.6, i32 0, i32 0), i8** %b, align 8
  %a1 = load i8*, i8** %a, align 8
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* %a1)
  %b2 = load i8*, i8** %b, align 8
  %printf3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* %b2)
  %printf4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  ret i32 0
}
