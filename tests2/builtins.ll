; ModuleID = 'Chomp'
source_filename = "Chomp"

@fmt = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@fmt.1 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@fmt.2 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@fmt.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@fmt.4 = private unnamed_addr constant [37 x i8] c"Error: cannot call car on empty list\00", align 1
@fmt.5 = private unnamed_addr constant [37 x i8] c"Error: cannot call cdr on empty list\00", align 1

declare i32 @printf(i8*, ...)

declare i32 @print_bit(i32)

declare i32 @print_nibble(i32)

declare i32 @print_byte(i32)

declare i32 @print_word(i32)

declare i32 @exit(i32, ...)

define i32 @main() {
entry:
  %b = alloca i32, align 4
  store i32 1, i32* %b, align 4
  %b1 = load i32, i32* %b, align 4
  %print_bit = call i32 @print_bit(i32 %b1)
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %b2 = load i32, i32* %b, align 4
  %print_nibble = call i32 @print_nibble(i32 %b2)
  %printf3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %b4 = load i32, i32* %b, align 4
  %print_byte = call i32 @print_byte(i32 %b4)
  %printf5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %b6 = load i32, i32* %b, align 4
  %print_word = call i32 @print_word(i32 %b6)
  %printf7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %b8 = load i32, i32* %b, align 4
  %printf9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %b8)
  %printf10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %c = alloca i32, align 4
  store i32 5, i32* %c, align 4
  %c11 = load i32, i32* %c, align 4
  %print_bit12 = call i32 @print_bit(i32 %c11)
  %printf13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %c14 = load i32, i32* %c, align 4
  %print_nibble15 = call i32 @print_nibble(i32 %c14)
  %printf16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %c17 = load i32, i32* %c, align 4
  %print_byte18 = call i32 @print_byte(i32 %c17)
  %printf19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %c20 = load i32, i32* %c, align 4
  %print_word21 = call i32 @print_word(i32 %c20)
  %printf22 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %c23 = load i32, i32* %c, align 4
  %printf24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %c23)
  %printf25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %d = alloca i32, align 4
  store i32 92, i32* %d, align 4
  %d26 = load i32, i32* %d, align 4
  %print_bit27 = call i32 @print_bit(i32 %d26)
  %printf28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %d29 = load i32, i32* %d, align 4
  %print_nibble30 = call i32 @print_nibble(i32 %d29)
  %printf31 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %d32 = load i32, i32* %d, align 4
  %print_byte33 = call i32 @print_byte(i32 %d32)
  %printf34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %d35 = load i32, i32* %d, align 4
  %print_word36 = call i32 @print_word(i32 %d35)
  %printf37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %w = alloca i32, align 4
  store i32 43690, i32* %w, align 4
  %w38 = load i32, i32* %w, align 4
  %print_bit39 = call i32 @print_bit(i32 %w38)
  %printf40 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %w41 = load i32, i32* %w, align 4
  %print_nibble42 = call i32 @print_nibble(i32 %w41)
  %printf43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %w44 = load i32, i32* %w, align 4
  %print_byte45 = call i32 @print_byte(i32 %w44)
  %printf46 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  %w47 = load i32, i32* %w, align 4
  %print_word48 = call i32 @print_word(i32 %w47)
  %printf49 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @fmt.3, i32 0, i32 0))
  ret i32 0
}
