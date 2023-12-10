	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:                               ## %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$0, 4(%rsp)
	movb	$1, 3(%rsp)
	movb	$1, %al
	leaq	L_fmt.1(%rip), %rdi
	testb	%al, %al
	jne	LBB0_1
## %bb.5:                               ## %else10
	leaq	L_string.8(%rip), %rsi
	jmp	LBB0_3
LBB0_1:                                 ## %then
	leaq	L_string(%rip), %rsi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	cmpb	$1, 3(%rsp)
	jne	LBB0_4
## %bb.2:                               ## %then5
	leaq	L_fmt.1(%rip), %rdi
	leaq	L_string.6(%rip), %rsi
	jmp	LBB0_3
LBB0_4:                                 ## %else
	leaq	L_fmt.1(%rip), %rdi
	leaq	L_string.7(%rip), %rsi
LBB0_3:                                 ## %merge
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
	popq	%rcx
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_fmt:                                  ## @fmt
	.asciz	"%d"

L_fmt.1:                                ## @fmt.1
	.asciz	"%s"

L_fmt.2:                                ## @fmt.2
	.asciz	"%c"

L_fmt.3:                                ## @fmt.3
	.asciz	"\n"

L_fmt.4:                                ## @fmt.4
	.asciz	"Error: cannot call car on empty list"

L_fmt.5:                                ## @fmt.5
	.asciz	"Error: cannot call cdr on empty list"

L_string:                               ## @string
	.asciz	"yes"

L_string.6:                             ## @string.6
	.asciz	"true"

L_string.7:                             ## @string.7
	.asciz	"false"

L_string.8:                             ## @string.8
	.asciz	"no"

.subsections_via_symbols
