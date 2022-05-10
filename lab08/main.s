	.file	"main.c"
	.text
	.def	printf;	.scl	3;	.type	32;	.endef
	.seh_proc	printf
printf:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp
	.seh_stackalloc	56
	leaq	48(%rsp), %rbp
	.seh_setframe	%rbp, 48
	.seh_endprologue
	movq	%rcx, 32(%rbp)
	movq	%rdx, 40(%rbp)
	movq	%r8, 48(%rbp)
	movq	%r9, 56(%rbp)
	leaq	40(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rbx
	movl	$1, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rbx, %r8
	movq	32(%rbp), %rdx
	movq	%rax, %rcx
	call	__mingw_vfprintf
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	addq	$56, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.seh_endproc
	.globl	my_strlen
	.def	my_strlen;	.scl	2;	.type	32;	.endef
	.seh_proc	my_strlen
my_strlen:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$16, %rsp
	.seh_stackalloc	16
	leaq	16(%rsp), %rbp
	.seh_setframe	%rbp, 16
	.seh_endprologue
	movq	%rcx, 32(%rbp)
	movq	32(%rbp), %rdx
	movq	%rdx, %rdi
/APP
 # 10 "main.c" 1
	movl %edi, %ebx
	inc %ebx
	xor %al, %al
	next:
		scasb
		JNE next
	sub %ebx, %edi
	
 # 0 "" 2
/NO_APP
	movl	%edi, %edx
	movl	%edx, -4(%rbp)
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "String length = %d\12\0"
.LC1:
	.ascii "Coppied string: %s\12\0"
.LC2:
	.ascii "Copy after pointer: %s\12\0"
.LC3:
	.ascii "Identic strings: %s\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	addq	$-128, %rsp
	.seh_stackalloc	128
	.seh_endprologue
	call	__main
	movq	$48, -64(%rbp)
	movq	$0, -56(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	leaq	-64(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	addq	$2, %rax
	movq	%rax, -16(%rbp)
	movabsq	$8247343400852088148, %rax
	movabsq	$2334111870319748460, %rdx
	movq	%rax, -96(%rbp)
	movq	%rdx, -88(%rbp)
	movl	$1668445299, -80(%rbp)
	movw	$31088, -76(%rbp)
	movb	$0, -74(%rbp)
	leaq	-96(%rbp), %rax
	movq	%rax, %rcx
	call	my_strlen
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	-20(%rbp), %ecx
	leaq	-96(%rbp), %rdx
	movq	-8(%rbp), %rax
	movl	%ecx, %r8d
	movq	%rax, %rcx
	call	my_strcpy
	movq	-8(%rbp), %rax
	movq	%rax, %rdx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	-20(%rbp), %ecx
	movq	-8(%rbp), %rdx
	leaq	-64(%rbp), %rax
	movl	%ecx, %r8d
	movq	%rax, %rcx
	call	my_strcpy
	movl	-20(%rbp), %ecx
	leaq	-64(%rbp), %rdx
	movq	-16(%rbp), %rax
	movl	%ecx, %r8d
	movq	%rax, %rcx
	call	my_strcpy
	movq	-16(%rbp), %rax
	movq	%rax, %rdx
	leaq	.LC2(%rip), %rcx
	call	printf
	movl	-20(%rbp), %ecx
	movq	-16(%rbp), %rdx
	movq	-16(%rbp), %rax
	movl	%ecx, %r8d
	movq	%rax, %rcx
	call	my_strcpy
	movq	-16(%rbp), %rax
	movq	%rax, %rdx
	leaq	.LC3(%rip), %rcx
	call	printf
	movl	$0, %eax
	subq	$-128, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (Rev5, Built by MSYS2 project) 10.3.0"
	.def	__mingw_vfprintf;	.scl	2;	.type	32;	.endef
	.def	my_strcpy;	.scl	2;	.type	32;	.endef
