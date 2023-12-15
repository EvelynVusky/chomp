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
	pushq	%r12
	pushq	%rbx
	subq	$128, %rsp
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movb	$1, -84(%rbp)
	movq	$0, -92(%rbp)
	movl	$1, -96(%rbp)
	leaq	-96(%rbp), %rax
	movq	%rax, -48(%rbp)
	movb	$0, -148(%rbp)
	movl	$3, -160(%rbp)
	movl	$0, -144(%rbp)
	movq	$0, -140(%rbp)
	movb	$1, -132(%rbp)
	movq	%rax, -156(%rbp)
	movq	$0, -76(%rbp)
	movb	$0, -68(%rbp)
	movl	$4, -80(%rbp)
	movb	$0, -52(%rbp)
	movq	$0, -60(%rbp)
	movl	$3, -64(%rbp)
	movb	$1, -116(%rbp)
	movq	$0, -124(%rbp)
	movl	$0, -128(%rbp)
	movq	%rax, -60(%rbp)
	movb	$1, -100(%rbp)
	movq	$0, -108(%rbp)
	movl	$0, -112(%rbp)
	leaq	-64(%rbp), %rax
	movq	%rax, -76(%rbp)
	leaq	-80(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	%rax, -40(%rbp)
	leaq	L_fmt.1(%rip), %rbx
	leaq	L_string(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt(%rip), %r14
	leaq	L_string.6(%rip), %r15
	.p2align	4, 0x90
LBB0_1:                                 ## %pred
                                        ## =>This Inner Loop Header: Depth=1
	movq	-40(%rbp), %rax
	cmpb	$1, 12(%rax)
	je	LBB0_3
## %bb.2:                               ## %while_body
                                        ##   in Loop: Header=BB0_1 Depth=1
	movq	-40(%rbp), %rax
	movl	(%rax), %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%rbx, %rdi
	movq	%r15, %rsi
	xorl	%eax, %eax
	callq	_printf
	movq	-40(%rbp), %rax
	movq	4(%rax), %rax
	movq	%rax, -40(%rbp)
	jmp	LBB0_1
LBB0_3:                                 ## %merge42
	leaq	L_fmt.1(%rip), %rdi
	leaq	L_string.7(%rip), %rsi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	-48(%rbp), %rbx
	cmpb	$1, 12(%rbx)
	jne	LBB0_4
## %bb.9:                               ## %then50
	leaq	L_fmt.5(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$1, %edi
	xorl	%eax, %eax
	callq	_exit
LBB0_4:                                 ## %merge49
	movq	4(%rbx), %rbx
	movq	%rbx, -48(%rbp)
	cmpb	$1, 12(%rbx)
	jne	LBB0_5
## %bb.10:                              ## %then60
	leaq	L_fmt.5(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$1, %edi
	xorl	%eax, %eax
	callq	_exit
LBB0_5:                                 ## %merge59
	movq	4(%rbx), %rax
	movq	%rax, -48(%rbp)
	movq	%rsp, %rcx
	leaq	-16(%rcx), %r12
	movq	%r12, %rsp
	movq	%rax, -16(%rcx)
	leaq	L_fmt.1(%rip), %rbx
	leaq	L_string.8(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt(%rip), %r14
	leaq	L_string.9(%rip), %r15
	.p2align	4, 0x90
LBB0_6:                                 ## %pred69
                                        ## =>This Inner Loop Header: Depth=1
	movq	(%r12), %rax
	cmpb	$1, 12(%rax)
	je	LBB0_8
## %bb.7:                               ## %while_body70
                                        ##   in Loop: Header=BB0_6 Depth=1
	movq	(%r12), %rax
	movl	(%rax), %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%rbx, %rdi
	movq	%r15, %rsi
	xorl	%eax, %eax
	callq	_printf
	movq	(%r12), %rax
	movq	4(%rax), %rax
	movq	%rax, (%r12)
	jmp	LBB0_6
LBB0_8:                                 ## %merge83
	leaq	L_fmt.1(%rip), %rdi
	leaq	L_string.10(%rip), %rsi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
	leaq	-32(%rbp), %rsp
	popq	%rbx
	popq	%r12
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
	.asciz	" "

L_string.7:                             ## @string.7
	.asciz	"]"

L_string.8:                             ## @string.8
	.asciz	"[ "

L_string.9:                             ## @string.9
	.asciz	" "

L_string.10:                            ## @string.10
	.asciz	"]"

.subsections_via_symbols
