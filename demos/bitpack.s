	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0
	.globl	_pack                           ## -- Begin function pack
	.p2align	4, 0x90
_pack:                                  ## @pack
	.cfi_startproc
## %bb.0:                               ## %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	%r8d, %ebx
	movl	%ecx, %ebp
	movl	%edx, %r14d
	movl	%esi, %r15d
	movl	%edi, %r12d
	movl	$4, %edi
	callq	_malloc
	movq	%rax, %r13
	movl	%r12d, (%rax)
	movl	$4, %edi
	callq	_malloc
	movq	%rax, %r12
	movl	%r15d, (%rax)
	movl	$4, %edi
	callq	_malloc
	movq	%rax, %r15
	movl	%r14d, (%rax)
	movl	$4, %edi
	callq	_malloc
	movq	%rax, %r14
	movl	%ebp, (%rax)
	movl	$4, %edi
	callq	_malloc
	movq	%rax, %rcx
	movl	%ebx, (%rax)
	movl	(%r13), %eax
	movl	%eax, 36(%rsp)
	movl	(%r12), %edx
	movl	%edx, 32(%rsp)
	movzbl	%dl, %edx
	shll	$8, %eax
	orl	%edx, %eax
	movl	%eax, 28(%rsp)
	movl	(%r15), %edx
	movl	%edx, 24(%rsp)
	movl	(%r14), %esi
	movl	%esi, 20(%rsp)
	movl	(%rcx), %ecx
	movl	%ecx, 16(%rsp)
	shll	$4, %esi
	andl	$15, %ecx
	orl	%esi, %ecx
	shll	$8, %edx
	movzbl	%cl, %ecx
	orl	%edx, %ecx
	movl	%ecx, 12(%rsp)
	movzwl	%cx, %ecx
	shll	$16, %eax
	orl	%ecx, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:                               ## %entry
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	$97, 20(%rsp)
	movl	$100, 16(%rsp)
	movl	$23, 12(%rsp)
	movl	$14, 8(%rsp)
	movl	$15, 4(%rsp)
	movl	$97, %edi
	movl	$100, %esi
	movl	$23, %edx
	movl	$14, %ecx
	movl	$15, %r8d
	callq	_pack
	movl	%eax, (%rsp)
	leaq	L_fmt(%rip), %rdi
	movl	%eax, %esi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
	addq	$24, %rsp
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
