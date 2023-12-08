	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:                               ## %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movl	$4, (%rsp)
	leaq	L_fmt(%rip), %rbx
	movq	%rbx, %rdi
	movl	$4, %esi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %r14
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$3, 4(%rsp)
	movq	%rbx, %rdi
	movl	$3, %esi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$1, (%rsp)
	movq	%rbx, %rdi
	movl	$1, %esi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	(%rsp), %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
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
