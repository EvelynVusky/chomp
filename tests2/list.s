	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:                               ## %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$48, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -16
	movl	$0, 24(%rsp)
	movq	$0, 28(%rsp)
	movb	$1, 36(%rsp)
	movq	$0, 4(%rsp)
	movb	$0, 12(%rsp)
	movl	$1, (%rsp)
	movq	$0, 8(%rsp)
	movb	$1, 16(%rsp)
	movl	$0, 4(%rsp)
	movq	%rsp, %rbx
	movq	%rbx, 40(%rsp)
	movl	$0, 20(%rsp)
	cmpb	$1, 12(%rsp)
	jne	LBB0_2
## %bb.1:                               ## %then
	leaq	L_fmt.4(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$1, %edi
	xorl	%eax, %eax
	callq	_exit
LBB0_2:                                 ## %merge
	movl	(%rbx), %esi
	movl	%esi, 20(%rsp)
	leaq	L_fmt(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
	addq	$48, %rsp
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
	.asciz	"cannot call car on empty list"

.subsections_via_symbols
