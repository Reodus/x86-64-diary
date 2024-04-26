.global _start

.data
	src: .asciz "Test Text"
	dst: .quad 0

.text
	# rdi: dest
	# rsi: src
	# rdx: size
memcpy:
	xor %rcx, %rcx # Counter = 0
	memcpy_counter:
		cmp %rdx, %rcx # Compare counter and given size
		jae memcpy_end

		# Copy one byte from src to dst
		movb (%rsi, %rcx), %r8b 
		movb %r8b, (%rdi, %rcx) 

		inc %rcx # Counter ++
		jmp memcpy_counter
	memcpy_end:
		ret

_start:
	mov $dst, %rdi
	mov $src, %rsi
	mov  $4, %rdx

	call memcpy
	
	mov $60, %rax
	mov $0, %rdi
	syscall
	
		
