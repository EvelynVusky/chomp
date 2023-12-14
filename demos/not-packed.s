	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:                               ## %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -16
	movl	$97, 28(%rsp)
	movl	$100, 24(%rsp)
	movl	$23, 20(%rsp)
	movl	$14, 16(%rsp)
	movl	$15, 12(%rsp)
	leaq	L_fmt.2(%rip), %rbx
	movq	%rbx, %rdi
	movl	$97, %esi
	xorl	%eax, %eax
	callq	_printf
	movl	24(%rsp), %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	20(%rsp), %esi
	leaq	L_fmt(%rip), %rbx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	16(%rsp), %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	12(%rsp), %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbx
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
	.asciz	"Error: cannot call div with divisor of 0\n"

L_fmt.5:                                ## @fmt.5
	.asciz	"Error: cannot call car on empty list\n"

L_fmt.6:                                ## @fmt.6
	.asciz	"Error: cannot call cdr on empty list\n"

.subsections_via_symbols
