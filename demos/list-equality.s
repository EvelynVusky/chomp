	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0
	.globl	_list_equals                    ## -- Begin function list_equals
	.p2align	4, 0x90
_list_equals:                           ## @list_equals
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
	movq	%rsi, %r15
	movq	%rdi, %rbx
	movl	$8, %edi
	callq	_malloc
	movq	%rax, %r14
	movq	%rbx, (%rax)
	movl	$8, %edi
	callq	_malloc
	movq	%rax, %rbx
	movq	%r15, (%rax)
	movb	$1, 7(%rsp)
	leaq	L_fmt.5(%rip), %r15
	leaq	L_fmt.6(%rip), %r12
	jmp	LBB0_1
	.p2align	4, 0x90
LBB0_9:                                 ## %merge38
                                        ##   in Loop: Header=BB0_1 Depth=1
	movq	4(%r13), %rax
	movq	%rax, (%rbx)
LBB0_1:                                 ## %while
                                        ## =>This Inner Loop Header: Depth=1
	movq	(%r14), %r13
	movl	$1, %edi
	callq	_malloc
	movb	$0, (%rax)
	cmpb	$1, 12(%r13)
	jne	LBB0_2
## %bb.11:                              ## %then51
                                        ##   in Loop: Header=BB0_1 Depth=1
	movb	$1, (%rax)
LBB0_2:                                 ## %merge50
                                        ##   in Loop: Header=BB0_1 Depth=1
	movzbl	(%rax), %ebp
	movq	(%rbx), %r13
	movl	$1, %edi
	callq	_malloc
	movb	$0, (%rax)
	cmpb	$1, 12(%r13)
	jne	LBB0_3
## %bb.12:                              ## %then62
                                        ##   in Loop: Header=BB0_1 Depth=1
	movb	$1, (%rax)
LBB0_3:                                 ## %merge61
                                        ##   in Loop: Header=BB0_1 Depth=1
	xorb	$1, %bpl
	movzbl	(%rax), %eax
	notb	%al
	andb	%bpl, %al
	testb	$1, %al
	je	LBB0_13
## %bb.4:                               ## %while_body
                                        ##   in Loop: Header=BB0_1 Depth=1
	movq	(%r14), %r13
	cmpb	$1, 12(%r13)
	jne	LBB0_5
## %bb.18:                              ## %then
                                        ##   in Loop: Header=BB0_1 Depth=1
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$1, %edi
	xorl	%eax, %eax
	callq	_exit
LBB0_5:                                 ## %merge
                                        ##   in Loop: Header=BB0_1 Depth=1
	movl	(%r13), %ebp
	movq	(%rbx), %r13
	cmpb	$1, 12(%r13)
	jne	LBB0_6
## %bb.19:                              ## %then13
                                        ##   in Loop: Header=BB0_1 Depth=1
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$1, %edi
	xorl	%eax, %eax
	callq	_exit
LBB0_6:                                 ## %merge12
                                        ##   in Loop: Header=BB0_1 Depth=1
	cmpl	(%r13), %ebp
	je	LBB0_7
## %bb.20:                              ## %then21
                                        ##   in Loop: Header=BB0_1 Depth=1
	movb	$0, 7(%rsp)
LBB0_7:                                 ## %merge20
                                        ##   in Loop: Header=BB0_1 Depth=1
	movq	(%r14), %r13
	cmpb	$1, 12(%r13)
	jne	LBB0_8
## %bb.21:                              ## %then28
                                        ##   in Loop: Header=BB0_1 Depth=1
	movq	%r12, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$1, %edi
	xorl	%eax, %eax
	callq	_exit
LBB0_8:                                 ## %merge27
                                        ##   in Loop: Header=BB0_1 Depth=1
	movq	4(%r13), %rax
	movq	%rax, (%r14)
	movq	(%rbx), %r13
	cmpb	$1, 12(%r13)
	jne	LBB0_9
## %bb.10:                              ## %then39
                                        ##   in Loop: Header=BB0_1 Depth=1
	movq	%r12, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$1, %edi
	xorl	%eax, %eax
	callq	_exit
	jmp	LBB0_9
LBB0_13:                                ## %merge67
	movq	(%r14), %r14
	movl	$1, %edi
	callq	_malloc
	movb	$0, (%rax)
	cmpb	$1, 12(%r14)
	jne	LBB0_14
## %bb.22:                              ## %then75
	movb	$1, (%rax)
LBB0_14:                                ## %merge74
	movzbl	(%rax), %ebp
	xorb	$1, %bpl
	movq	(%rbx), %rbx
	movl	$1, %edi
	callq	_malloc
	movb	$0, (%rax)
	cmpb	$1, 12(%rbx)
	jne	LBB0_15
## %bb.23:                              ## %then86
	movb	$1, (%rax)
LBB0_15:                                ## %merge85
	movzbl	(%rax), %eax
	notb	%al
	orb	%al, %bpl
	testb	$1, %bpl
	je	LBB0_17
## %bb.16:                              ## %then92
	movb	$0, 7(%rsp)
LBB0_17:                                ## %merge91
	movzbl	7(%rsp), %eax
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
	movl	$4, (%rax)
	movq	%rbx, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %rbx
	movb	$0, 12(%rax)
	movl	$3, (%rax)
	movq	%r14, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r14
	movb	$0, 12(%rax)
	movl	$2, (%rax)
	movq	%rbx, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movb	$0, 12(%rax)
	movl	$1, (%rax)
	movq	%r14, 4(%rax)
	movq	%rax, (%rsp)
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
	movl	$4, (%rax)
	movq	%rbx, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %rbx
	movb	$0, 12(%rax)
	movl	$3, (%rax)
	movq	%r14, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r14
	movb	$0, 12(%rax)
	movl	$2, (%rax)
	movq	%rbx, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movb	$0, 12(%rax)
	movl	$1, (%rax)
	movq	%r14, 4(%rax)
	movq	%rax, 32(%rsp)
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
	movl	$5, (%rax)
	movq	%rbx, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %rbx
	movb	$0, 12(%rax)
	movl	$4, (%rax)
	movq	%r14, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r14
	movb	$0, 12(%rax)
	movl	$3, (%rax)
	movq	%rbx, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movb	$0, 12(%rax)
	movl	$2, (%rax)
	movq	%r14, 4(%rax)
	movq	%rax, 24(%rsp)
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
	movl	$3, (%rax)
	movq	%rbx, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %rbx
	movb	$0, 12(%rax)
	movl	$2, (%rax)
	movq	%r14, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movb	$0, 12(%rax)
	movl	$1, (%rax)
	movq	%rbx, 4(%rax)
	movq	%rax, 16(%rsp)
	movl	$13, %edi
	callq	_malloc
	movl	$0, (%rax)
	movq	$0, 4(%rax)
	movb	$1, 12(%rax)
	movq	%rax, 8(%rsp)
	leaq	L_fmt.1(%rip), %r15
	leaq	L_string(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	(%rsp), %rdi
	movq	%rdi, %rsi
	callq	_list_equals
	movzbl	%al, %esi
	leaq	L_fmt(%rip), %rbx
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_fmt.3(%rip), %r14
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.7(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	32(%rsp), %rsi
	movq	(%rsp), %rdi
	callq	_list_equals
	movzbl	%al, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.8(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	24(%rsp), %rsi
	movq	(%rsp), %rdi
	callq	_list_equals
	movzbl	%al, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.9(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	16(%rsp), %rsi
	movq	(%rsp), %rdi
	callq	_list_equals
	movzbl	%al, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.10(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	8(%rsp), %rsi
	movq	(%rsp), %rdi
	callq	_list_equals
	movzbl	%al, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.11(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	8(%rsp), %rdi
	movq	%rdi, %rsi
	callq	_list_equals
	movzbl	%al, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.12(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r12
	movl	$0, (%rax)
	movq	$0, 4(%rax)
	movb	$1, 12(%rax)
	movl	$13, %edi
	callq	_malloc
	movl	$0, (%rax)
	movq	$0, 4(%rax)
	movb	$1, 12(%rax)
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	_list_equals
	movzbl	%al, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.13(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r12
	movl	$0, (%rax)
	movq	$0, 4(%rax)
	movb	$1, 12(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r13
	movb	$0, 12(%rax)
	movl	$5, (%rax)
	movq	%r12, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r12
	movb	$0, 12(%rax)
	movl	$3, (%rax)
	movq	%r13, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r13
	movb	$0, 12(%rax)
	movl	$2, (%rax)
	movq	%r12, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r12
	movb	$0, 12(%rax)
	movl	$1, (%rax)
	movq	%r13, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r13
	movl	$0, (%rax)
	movq	$0, 4(%rax)
	movb	$1, 12(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %rbp
	movb	$0, 12(%rax)
	movl	$4, (%rax)
	movq	%r13, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r13
	movb	$0, 12(%rax)
	movl	$3, (%rax)
	movq	%rbp, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %rbp
	movb	$0, 12(%rax)
	movl	$2, (%rax)
	movq	%r13, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movb	$0, 12(%rax)
	movl	$1, (%rax)
	movq	%rbp, 4(%rax)
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	_list_equals
	movzbl	%al, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.14(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r12
	movl	$0, (%rax)
	movq	$0, 4(%rax)
	movb	$1, 12(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r13
	movb	$0, 12(%rax)
	movl	$4, (%rax)
	movq	%r12, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r12
	movb	$0, 12(%rax)
	movl	$3, (%rax)
	movq	%r13, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r13
	movb	$0, 12(%rax)
	movl	$2, (%rax)
	movq	%r12, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r12
	movb	$0, 12(%rax)
	movl	$1, (%rax)
	movq	%r13, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r13
	movl	$0, (%rax)
	movq	$0, 4(%rax)
	movb	$1, 12(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %rbp
	movb	$0, 12(%rax)
	movl	$4, (%rax)
	movq	%r13, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r13
	movb	$0, 12(%rax)
	movl	$3, (%rax)
	movq	%rbp, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %rbp
	movb	$0, 12(%rax)
	movl	$2, (%rax)
	movq	%r13, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movb	$0, 12(%rax)
	movl	$1, (%rax)
	movq	%rbp, 4(%rax)
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	_list_equals
	movzbl	%al, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.15(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r12
	movl	$0, (%rax)
	movq	$0, 4(%rax)
	movb	$1, 12(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r13
	movb	$0, 12(%rax)
	movl	$4, (%rax)
	movq	%r12, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r12
	movb	$0, 12(%rax)
	movl	$3, (%rax)
	movq	%r13, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r13
	movb	$0, 12(%rax)
	movl	$2, (%rax)
	movq	%r12, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r12
	movb	$0, 12(%rax)
	movl	$1, (%rax)
	movq	%r13, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movl	$0, (%rax)
	movq	$0, 4(%rax)
	movb	$1, 12(%rax)
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	_list_equals
	movzbl	%al, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_string.16(%rip), %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r15
	movl	$0, (%rax)
	movq	$0, 4(%rax)
	movb	$1, 12(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r12
	movb	$0, 12(%rax)
	movl	$5, (%rax)
	movq	%r15, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r15
	movb	$0, 12(%rax)
	movl	$4, (%rax)
	movq	%r12, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r12
	movb	$0, 12(%rax)
	movl	$3, (%rax)
	movq	%r15, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r15
	movl	$0, (%rax)
	movq	$0, 4(%rax)
	movb	$1, 12(%rax)
	movl	$13, %edi
	callq	_malloc
	movq	%rax, %r13
	movb	$0, 12(%rax)
	movl	$2, (%rax)
	movq	%r15, 4(%rax)
	movl	$13, %edi
	callq	_malloc
	movb	$0, 12(%rax)
	movl	$1, (%rax)
	movq	%r13, 4(%rax)
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	_list_equals
	movzbl	%al, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	callq	_printf
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	_printf
	xorl	%eax, %eax
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
	.asciz	"a1 == a1: "

L_string.7:                             ## @string.7
	.asciz	"a1 == a2 (identical lists): "

L_string.8:                             ## @string.8
	.asciz	"a1 == b (different lists): "

L_string.9:                             ## @string.9
	.asciz	"a1 == c (different sizes): "

L_string.10:                            ## @string.10
	.asciz	"a1 == empty: "

L_string.11:                            ## @string.11
	.asciz	"empty == empty: "

L_string.12:                            ## @string.12
	.asciz	"[] == []: "

L_string.13:                            ## @string.13
	.asciz	"[1, 2, 3, 4] == [1, 2, 3, 5]: "

L_string.14:                            ## @string.14
	.asciz	"[1, 2, 3, 4] == [1, 2, 3, 4]: "

L_string.15:                            ## @string.15
	.asciz	"[] == [1, 2, 3, 4]: "

L_string.16:                            ## @string.16
	.asciz	"[1, 2] == [3, 4, 5]: "

.subsections_via_symbols
