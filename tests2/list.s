	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:                               ## %entry
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	$0, 12(%rsp)
	movb	$0, 20(%rsp)
	movl	$2, 8(%rsp)
	movb	$1, 24(%rsp)
	movl	$0, 12(%rsp)
	movq	$0, 16(%rsp)
	movl	$1, 24(%rsp)
	movb	$0, 36(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 28(%rsp)
	leaq	24(%rsp), %rax
	movq	%rax, 48(%rsp)
	movl	$1, 44(%rsp)
	leaq	L_fmt(%rip), %rdi
	movl	$1, %esi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
	addq	$56, %rsp
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
