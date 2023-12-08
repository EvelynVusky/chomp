	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:                               ## %entry
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$112, %rsp
	.cfi_def_cfa_offset 128
	.cfi_offset %rbx, -16
	movb	$1, 68(%rsp)
	movq	$0, 60(%rsp)
	movl	$0, 56(%rsp)
	movl	$2, 96(%rsp)
	movb	$0, 108(%rsp)
	leaq	56(%rsp), %rax
	movq	%rax, 100(%rsp)
	movl	$1, 8(%rsp)
	movq	$0, 12(%rsp)
	movb	$0, 20(%rsp)
	movl	$0, 40(%rsp)
	movq	$0, 44(%rsp)
	movb	$1, 52(%rsp)
	movl	$2, 24(%rsp)
	movb	$0, 36(%rsp)
	leaq	40(%rsp), %rax
	movq	%rax, 28(%rsp)
	movb	$1, 92(%rsp)
	movq	$0, 84(%rsp)
	movl	$0, 80(%rsp)
	leaq	24(%rsp), %rax
	movq	%rax, 12(%rsp)
	leaq	8(%rsp), %rbx
	movq	%rbx, 72(%rsp)
	cmpb	$1, 20(%rsp)
	jne	LBB0_1
## %bb.5:                               ## %then13
	leaq	L_fmt.4(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$1, %edi
	xorl	%eax, %eax
	callq	_exit
LBB0_1:                                 ## %merge12
	movl	(%rbx), %esi
	leaq	L_fmt(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	72(%rsp), %rbx
	cmpb	$1, 12(%rbx)
	jne	LBB0_2
## %bb.6:                               ## %then24
	leaq	L_fmt.5(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$1, %edi
	xorl	%eax, %eax
	callq	_exit
LBB0_2:                                 ## %merge23
	movq	4(%rbx), %rbx
	cmpb	$1, 12(%rbx)
	jne	LBB0_4
## %bb.3:                               ## %then34
	leaq	L_fmt.4(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$1, %edi
	xorl	%eax, %eax
	callq	_exit
LBB0_4:                                 ## %merge33
	movl	(%rbx), %esi
	leaq	L_fmt(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
	addq	$112, %rsp
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
	.asciz	"Error: cannot call car on empty list"

L_fmt.5:                                ## @fmt.5
	.asciz	"Error: cannot call cdr on empty list"

.subsections_via_symbols
