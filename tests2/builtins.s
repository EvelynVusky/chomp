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
	movl	$1, 12(%rsp)
	movl	$1, %edi
	callq	_print_bit
	leaq	L_fmt.3(%rip), %rbx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	12(%rsp), %edi
	callq	_print_nibble
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	12(%rsp), %edi
	callq	_print_byte
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	12(%rsp), %edi
	callq	_print_word
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	12(%rsp), %esi
	leaq	L_fmt(%rip), %r14
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$5, 8(%rsp)
	movl	$5, %edi
	callq	_print_bit
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	8(%rsp), %edi
	callq	_print_nibble
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	8(%rsp), %edi
	callq	_print_byte
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	8(%rsp), %edi
	callq	_print_word
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	8(%rsp), %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$92, 20(%rsp)
	movl	$92, %edi
	callq	_print_bit
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	20(%rsp), %edi
	callq	_print_nibble
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	20(%rsp), %edi
	callq	_print_byte
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	20(%rsp), %edi
	callq	_print_word
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$43690, 16(%rsp)                ## imm = 0xAAAA
	movl	$43690, %edi                    ## imm = 0xAAAA
	callq	_print_bit
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	16(%rsp), %edi
	callq	_print_nibble
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	16(%rsp), %edi
	callq	_print_byte
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	16(%rsp), %edi
	callq	_print_word
	movq	%rbx, %rdi
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
	.asciz	"Error: cannot call car on empty list"

L_fmt.5:                                ## @fmt.5
	.asciz	"Error: cannot call cdr on empty list"

.subsections_via_symbols
