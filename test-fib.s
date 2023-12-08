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
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movl	$10, 20(%rsp)
	movl	$0, 16(%rsp)
	movl	$1, 12(%rsp)
	movl	$0, 8(%rsp)
	movl	$2, 4(%rsp)
	.p2align	4, 0x90
LBB0_1:                                 ## %while
                                        ## =>This Inner Loop Header: Depth=1
	movl	4(%rsp), %eax
	cmpl	20(%rsp), %eax
	jg	LBB0_3
## %bb.2:                               ## %while_body
                                        ##   in Loop: Header=BB0_1 Depth=1
	movl	12(%rsp), %eax
	movl	16(%rsp), %ecx
	addl	%eax, %ecx
	movl	%ecx, 8(%rsp)
	movl	%eax, 16(%rsp)
	movl	%ecx, 12(%rsp)
	incl	4(%rsp)
	jmp	LBB0_1
LBB0_3:                                 ## %merge
	leaq	L_fmt.1(%rip), %rbx
	leaq	L_string(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	20(%rsp), %esi
	leaq	L_fmt(%rip), %r14
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.5(%rip), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	8(%rsp), %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
	addq	$24, %rsp
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

L_string:                               ## @string
	.asciz	"Fib of "

L_string.5:                             ## @string.5
	.asciz	" is: "

.subsections_via_symbols
