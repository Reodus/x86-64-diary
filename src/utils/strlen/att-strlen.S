.global _start

.data
	str:
		.asciz "Hello, World!"

.text

	# rdi: first arg
strlen:	
	mov %rdi, %rcx
	xor %rax, %rax

	strlen_loop:
		movb (%rcx), %r8b
		cmpb $0, (%rcx)
		jz strlen_end

		inc %rcx
		inc %rax
		jmp strlen_loop
	strlen_end:
		ret
		

_start:
	mov $str, %rdi
	call strlen

	mov $60, %rax
	mov $0, %rdi
	syscall 

