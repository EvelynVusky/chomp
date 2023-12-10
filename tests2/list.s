	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0
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
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset %rbx, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movb	$1, -36(%rbp)
	movq	$0, -44(%rbp)
	movl	$1, -48(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, -32(%rbp)
	leaq	L_fmt.1(%rip), %rbx
	leaq	L_string(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.7(%rip), %r14
	.p2align	4, 0x90
LBB0_1:                                 ## %pred
                                        ## =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	cmpb	$1, 12(%rax)
	je	LBB0_3
## %bb.2:                               ## %while_body
                                        ##   in Loop: Header=BB0_1 Depth=1
	movq	%rbx, %rdi
	movq	%r14, %rsi
	xorl	%eax, %eax
	callq	_printf
	movq	-32(%rbp), %rax
	movq	4(%rax), %rax
	movq	%rax, -32(%rbp)
	jmp	LBB0_1
LBB0_3:                                 ## %merge
	leaq	L_fmt.1(%rip), %rbx
	leaq	L_string.8(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%rsp, %rax
	leaq	-32(%rax), %rcx
	movq	%rcx, %rsp
	movb	$1, -16(%rax)
	movq	$0, -24(%rax)
	movq	$0, -32(%rax)
	movq	%rsp, %rax
	leaq	-32(%rax), %rdx
	movq	%rdx, %rsp
	leaq	L_string.9(%rip), %rsi
	movq	%rsi, -32(%rax)
	movb	$0, -16(%rax)
	movq	%rcx, -24(%rax)
	movq	%rsp, %rax
	leaq	-32(%rax), %rcx
	movq	%rcx, %rsp
	leaq	L_string.10(%rip), %rsi
	movq	%rsi, -32(%rax)
	movb	$0, -16(%rax)
	movq	%rdx, -24(%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %rsp
	movq	%rcx, -16(%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %r15
	movq	%r15, %rsp
	movq	%rcx, -16(%rax)
	leaq	L_string.11(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.12(%rip), %r14
	.p2align	4, 0x90
LBB0_4:                                 ## %pred19
                                        ## =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpb	$1, 16(%rax)
	je	LBB0_6
## %bb.5:                               ## %while_body20
                                        ##   in Loop: Header=BB0_4 Depth=1
	movq	(%r15), %rax
	movq	(%rax), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%rbx, %rdi
	movq	%r14, %rsi
	xorl	%eax, %eax
	callq	_printf
	movq	(%r15), %rax
	movq	8(%rax), %rax
	movq	%rax, (%r15)
	jmp	LBB0_4
LBB0_6:                                 ## %merge33
	leaq	L_fmt.1(%rip), %rbx
	leaq	L_string.13(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, %rsp
	movb	$1, -4(%rax)
	movq	$0, -12(%rax)
	movl	$0, -16(%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, %rsp
	movb	$0, -4(%rax)
	movl	$1, -16(%rax)
	movq	%rcx, -12(%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, %rsp
	movb	$0, -4(%rax)
	movl	$0, -16(%rax)
	movq	%rdx, -12(%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %rdx
	movq	%rdx, %rsp
	movb	$0, -4(%rax)
	movl	$0, -16(%rax)
	movq	%rcx, -12(%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, %rsp
	movb	$0, -4(%rax)
	movl	$1, -16(%rax)
	movq	%rdx, -12(%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %rsp
	movq	%rcx, -16(%rax)
	movq	%rsp, %rax
	leaq	-16(%rax), %r15
	movq	%r15, %rsp
	movq	%rcx, -16(%rax)
	leaq	L_string.14(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.15(%rip), %r14
	.p2align	4, 0x90
LBB0_7:                                 ## %pred49
                                        ## =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpb	$1, 12(%rax)
	je	LBB0_9
## %bb.8:                               ## %while_body50
                                        ##   in Loop: Header=BB0_7 Depth=1
	movq	(%r15), %rax
	movl	(%rax), %edi
	callq	_print_bit
	movq	%rbx, %rdi
	movq	%r14, %rsi
	xorl	%eax, %eax
	callq	_printf
	movq	(%r15), %rax
	movq	4(%rax), %rax
	movq	%rax, (%r15)
	jmp	LBB0_7
LBB0_9:                                 ## %merge62
	leaq	L_fmt.1(%rip), %rdi
	leaq	L_string.16(%rip), %rsi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$21, %edi
	callq	_print_byte
	xorl	%eax, %eax
	leaq	-24(%rbp), %rsp
	popq	%rbx
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
	.asciz	"Error: cannot call car on empty list"

L_fmt.5:                                ## @fmt.5
	.asciz	"Error: cannot call cdr on empty list"

L_string:                               ## @string
	.asciz	"[ "

L_string.6:                             ## @string.6
	.space	1

L_string.7:                             ## @string.7
	.asciz	" "

L_string.8:                             ## @string.8
	.asciz	"]"

L_string.9:                             ## @string.9
	.asciz	"b"

L_string.10:                            ## @string.10
	.asciz	"a"

L_string.11:                            ## @string.11
	.asciz	"[ "

L_string.12:                            ## @string.12
	.asciz	" "

L_string.13:                            ## @string.13
	.asciz	"]"

L_string.14:                            ## @string.14
	.asciz	"[ "

L_string.15:                            ## @string.15
	.asciz	" "

L_string.16:                            ## @string.16
	.asciz	"]"

.subsections_via_symbols
