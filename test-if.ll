; ModuleID = 'Chomp'
source_filename = "Chomp"

@fmt = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@fmt.1 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@fmt.2 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@fmt.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@fmt.4 = private unnamed_addr constant [30 x i8] c"cannot call car on empty list\00", align 1
@string = private unnamed_addr constant [4 x i8] c"yes\00", align 1
@string.5 = private unnamed_addr constant [5 x i8] c"true\00", align 1
@string.6 = private unnamed_addr constant [6 x i8] c"false\00", align 1
@string.7 = private unnamed_addr constant [3 x i8] c"no\00", align 1

declare i32 @printf(i8*, ...)

declare i32 @print_bit(i32)

declare i32 @print_nibble(i32)

declare i32 @print_byte(i32)

declare i32 @print_word(i32)

declare i32 @exit(i32, ...)

define i32 @main() {
entry:
  %i = alloca i32, align 4
  store i32 0, i32* %i, align 4
  %b = alloca i1, align 1
  store i1 true, i1* %b, align 1
  %i1 = load i32, i32* %i, align 4
  %tmp = icmp eq i32 %i1, 0
  br i1 %tmp, label %then, label %else10

merge:                                            ; preds = %else10, %merge4
  ret i32 0

then:                                             ; preds = %entry
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @string, i32 0, i32 0))
  %printf2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %b3 = load i1, i1* %b, align 1
  br i1 %b3, label %then5, label %else

merge4:                                           ; preds = %else, %then5
  br label %merge

then5:                                            ; preds = %then
  %printf6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @string.5, i32 0, i32 0))
  %printf7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  br label %merge4

else:                                             ; preds = %then
  %printf8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @string.6, i32 0, i32 0))
  %printf9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  br label %merge4

else10:                                           ; preds = %entry
  %printf11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt.1, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @string.7, i32 0, i32 0))
  %printf12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  br label %merge
}
