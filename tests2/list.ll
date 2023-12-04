; ModuleID = 'Chomp'
source_filename = "Chomp"

%int_node = type <{ i32, %int_node* }>

@fmt = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@fmt.1 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@fmt.2 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@fmt.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1

declare i32 @printf(i8*, ...)

declare i32 @print_bit(i1)

declare i32 @print_nibble(i4)

declare i32 @print_byte(i8)

declare i32 @print_word(i16)

define void @main() {
entry:
  %a = alloca %int_node*, align 8
  store i8 0, %int_node** %a, align 1
  %a1 = load %int_node*, %int_node** %a, align 8
  %tmp = getelementptr inbounds %int_node, %int_node* %a1, i32 0, i32 0
  %tmp2 = load i32, i32* %tmp, align 4
  ret void
}
