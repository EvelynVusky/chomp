; ModuleID = 'Chomp'
source_filename = "Chomp"

%int_node = type <{ i32, %int_node*, i1 }>

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
  %last_node_var = alloca %int_node, align 8
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node* %last_node_var, align 1
  %front_node_var = alloca %int_node, align 8
  store %int_node <{ i32 2, %int_node* null, i1 false }>, %int_node* %front_node_var, align 1
  %front_node_next = getelementptr inbounds %int_node, %int_node* %front_node_var, i32 0, i32 1
  store %int_node <{ i32 0, %int_node* null, i1 true }>, %int_node** %front_node_next, align 1
  %a = alloca %int_node, align 8
  store %int_node <{ i32 1, %int_node* null, i1 false }>, %int_node* %a, align 1
  %front_node_next2 = getelementptr inbounds %int_node, %int_node* %a, i32 0, i32 1
  store %int_node* %front_node_var, %int_node** %front_node_next2, align 8
  %a3 = alloca %int_node*, align 8
  store %int_node* %a, %int_node** %a3, align 8
  %a4 = load %int_node*, %int_node** %a3, align 8
  %tmp = getelementptr inbounds %int_node, %int_node* %a4, i32 0, i32 2
  %tmp5 = load i1, i1* %tmp, align 1
  %cond = icmp eq i1 %tmp5, true
  br i1 %cond, label %then, label %else

merge:                                            ; preds = %else, %then
  %tmp6 = getelementptr inbounds %int_node, %int_node* %a4, i32 0, i32 0
  %b = load i32, i32* %tmp6, align 4
  %b8 = alloca i32, align 4
  store i32 %b, i32* %b8, align 4
  %b9 = load i32, i32* %b8, align 4
  %printf10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @fmt, i32 0, i32 0), i32 %b9)
  ret i32 0

then:                                             ; preds = %entry
  %printf = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @fmt.4, i32 0, i32 0))
  %exit = call i32 (i32, ...) @exit(i32 1)
  br label %merge

else:                                             ; preds = %entry
  br label %merge
}
