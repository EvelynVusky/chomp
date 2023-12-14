	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0
	.globl	_add                            ## -- Begin function add
	.p2align	4, 0x90
_add:                                   ## @add
	.cfi_startproc
## %bb.0:                               ## %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %rbp, -16
	movl	%esi, %ebx
	movl	%edi, %ebp
	movl	$4, %edi
	callq	_malloc
	movq	%rax, %r14
	movl	%ebp, (%rax)
	movl	$4, %edi
	callq	_malloc
	movl	%ebx, (%rax)
	addl	(%r14), %ebx
	movl	%ebx, %eax
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_minus                          ## -- Begin function minus
	.p2align	4, 0x90
_minus:                                 ## @minus
	.cfi_startproc
## %bb.0:                               ## %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	%esi, %ebx
	movl	%edi, %ebp
	movl	$4, %edi
	callq	_malloc
	movq	%rax, %r14
	movl	%ebp, (%rax)
	movl	$4, %edi
	callq	_malloc
	movq	%rax, %r15
	movl	%ebx, (%rax)
	movl	(%r14), %edi
	movl	%ebx, %esi
	callq	_add
	subl	(%r15), %eax
	addq	$8, %rsp
	popq	%rbx
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
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$4, %edi
	movl	$8, %esi
	callq	_minus
	leaq	L_fmt(%rip), %rdi
	movl	%eax, %esi
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
	.asciz	"Error: cannot call div with divisor of 0\n"

L_fmt.5:                                ## @fmt.5
	.asciz	"Error: cannot call car on empty list\n"

L_fmt.6:                                ## @fmt.6
	.asciz	"Error: cannot call cdr on empty list\n"

.subsections_via_symbols
