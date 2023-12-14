	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0
	.globl	_scope                          ## -- Begin function scope
	.p2align	4, 0x90
_scope:                                 ## @scope
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
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rdx, %rbx
	movl	%esi, %ebp
	movl	%edi, %r14d
	movl	$4, %edi
	callq	_malloc
	movq	%rax, %r12
	movl	%r14d, (%rax)
	movl	$4, %edi
	callq	_malloc
	movq	%rax, %r15
	movl	%ebp, (%rax)
	movl	$8, %edi
	callq	_malloc
	movq	%rax, %r14
	movq	%rbx, (%rax)
	movl	$0, (%r12)
	movl	$122, (%r15)
	movq	(%rax), %rbx
	cmpb	$1, 12(%rbx)
	jne	LBB0_1
## %bb.5:                               ## %then
	leaq	L_fmt.6(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$1, %edi
	xorl	%eax, %eax
	callq	_exit
LBB0_1:                                 ## %merge
	movq	4(%rbx), %rax
	movq	%rax, (%r14)
	leaq	L_fmt.1(%rip), %rbx
	leaq	L_string(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %r13
	movq	%r13, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	(%r12), %edi
	callq	_print_bit
	movq	%r13, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	(%r15), %esi
	leaq	L_fmt.2(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r13, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	(%r14), %r15
	movl	$8, %edi
	callq	_malloc
	movq	%rax, %r14
	movq	%r15, (%rax)
	leaq	L_string.7(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt(%rip), %r15
	leaq	L_string.8(%rip), %r12
	.p2align	4, 0x90
LBB0_2:                                 ## %pred
                                        ## =>This Inner Loop Header: Depth=1
	movq	(%r14), %rax
	cmpb	$1, 12(%rax)
	je	LBB0_4
## %bb.3:                               ## %while_body
                                        ##   in Loop: Header=BB0_2 Depth=1
	movq	(%r14), %rax
	movl	(%rax), %esi
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%rbx, %rdi
	movq	%r12, %rsi
	xorl	%eax, %eax
	callq	_printf
	movq	(%r14), %rax
	movq	4(%rax), %rax
	movq	%rax, (%r14)
	jmp	LBB0_2
LBB0_4:                                 ## %merge31
	leaq	L_fmt.1(%rip), %rbx
	leaq	L_string.9(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %r14
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.10(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	addq	$8, %rsp
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movl	$1, -48(%rbp)
	movl	$97, -44(%rbp)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %rbx
	movl	$0, (%rax)
	movq	$0, 4(%rax)
	movb	$1, 12(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r14
	movb	$0, 12(%rax)
	movl	$44, (%rax)
	movq	%rbx, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %rbx
	movb	$0, 12(%rax)
	movl	$32, (%rax)
	movq	%r14, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movb	$0, 12(%rax)
	movl	$123, (%rax)
	movq	%rbx, 4(%rax)
	movq	%rax, -56(%rbp)
	leaq	L_fmt.1(%rip), %rbx
	leaq	L_string.11(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %r14
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	-48(%rbp), %edi
	callq	_print_bit
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	-44(%rbp), %esi
	leaq	L_fmt.2(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	-56(%rbp), %r15
	movl	$8, %edi
	callq	_malloc
	movq	%rax, %r14
	movq	%r15, (%rax)
	leaq	L_string.12(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt(%rip), %r15
	leaq	L_string.13(%rip), %r12
	.p2align	4, 0x90
LBB1_1:                                 ## %pred
                                        ## =>This Inner Loop Header: Depth=1
	movq	(%r14), %rax
	cmpb	$1, 12(%rax)
	je	LBB1_3
## %bb.2:                               ## %while_body
                                        ##   in Loop: Header=BB1_1 Depth=1
	movq	(%r14), %rax
	movl	(%rax), %esi
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%rbx, %rdi
	movq	%r12, %rsi
	xorl	%eax, %eax
	callq	_printf
	movq	(%r14), %rax
	movq	4(%rax), %rax
	movq	%rax, (%r14)
	jmp	LBB1_1
LBB1_3:                                 ## %merge
	leaq	L_fmt.1(%rip), %rbx
	leaq	L_string.14(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %r14
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.15(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	-56(%rbp), %rdx
	movl	-44(%rbp), %esi
	movl	-48(%rbp), %edi
	callq	_scope
	leaq	L_string.16(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	-48(%rbp), %edi
	callq	_print_bit
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	-44(%rbp), %esi
	leaq	L_fmt.2(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	-56(%rbp), %r15
	movl	$8, %edi
	callq	_malloc
	movq	%rax, %r14
	movq	%r15, (%rax)
	leaq	L_string.17(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt(%rip), %r15
	leaq	L_string.18(%rip), %r12
	.p2align	4, 0x90
LBB1_4:                                 ## %pred48
                                        ## =>This Inner Loop Header: Depth=1
	movq	(%r14), %rax
	cmpb	$1, 12(%rax)
	je	LBB1_6
## %bb.5:                               ## %while_body49
                                        ##   in Loop: Header=BB1_4 Depth=1
	movq	(%r14), %rax
	movl	(%rax), %esi
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%rbx, %rdi
	movq	%r12, %rsi
	xorl	%eax, %eax
	callq	_printf
	movq	(%r14), %rax
	movq	4(%rax), %rax
	movq	%rax, (%r14)
	jmp	LBB1_4
LBB1_6:                                 ## %merge62
	leaq	L_fmt.1(%rip), %rbx
	leaq	L_string.19(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %r14
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.20(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%rsp, %rax
	leaq	-16(%rax), %r12
	movq	%r12, %rsp
	movl	$0, -16(%rax)
	leaq	L_string.21(%rip), %r15
	cmpl	$0, (%r12)
	jg	LBB1_9
	.p2align	4, 0x90
LBB1_8:                                 ## %while_body67
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rsp, %r13
	leaq	-16(%r13), %rsp
	movl	$11, -16(%r13)
	movq	%rbx, %rdi
	movq	%r15, %rsi
	xorl	%eax, %eax
	callq	_printf
	movl	-16(%r13), %edi
	callq	_print_nibble
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	incl	(%r12)
	cmpl	$0, (%r12)
	jle	LBB1_8
LBB1_9:                                 ## %merge75
	leaq	L_fmt.1(%rip), %rbx
	leaq	L_string.22(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %r14
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%rsp, %r15
	leaq	-16(%r15), %rsp
	movl	$6, -16(%r15)
	leaq	L_string.23(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	-16(%r15), %edi
	callq	_print_nibble
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.24(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.25(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	(%r12), %esi
	leaq	L_fmt(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.26(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
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

L_string:                               ## @string
	.asciz	"In scope function:"

L_string.7:                             ## @string.7
	.asciz	"[ "

L_string.8:                             ## @string.8
	.asciz	" "

L_string.9:                             ## @string.9
	.asciz	"]"

L_string.10:                            ## @string.10
	.space	1

L_string.11:                            ## @string.11
	.asciz	"In main function:"

L_string.12:                            ## @string.12
	.asciz	"[ "

L_string.13:                            ## @string.13
	.asciz	" "

L_string.14:                            ## @string.14
	.asciz	"]"

L_string.15:                            ## @string.15
	.space	1

L_string.16:                            ## @string.16
	.asciz	"Back in main function:"

L_string.17:                            ## @string.17
	.asciz	"[ "

L_string.18:                            ## @string.18
	.asciz	" "

L_string.19:                            ## @string.19
	.asciz	"]"

L_string.20:                            ## @string.20
	.space	1

L_string.21:                            ## @string.21
	.asciz	"In for loop nibble n: "

L_string.22:                            ## @string.22
	.space	1

L_string.23:                            ## @string.23
	.asciz	"Out of for loop nibble n: "

L_string.24:                            ## @string.24
	.space	1

L_string.25:                            ## @string.25
	.asciz	"Back in main function j: "

L_string.26:                            ## @string.26
	.space	1

.subsections_via_symbols
