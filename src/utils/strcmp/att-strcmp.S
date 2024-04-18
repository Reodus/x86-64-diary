# as -32 -o strcmp.o att-strcmp.S
# ld -melf_i386 -o strcmp strcmp.o
 
.data
str1:
	.asciz "Hello"
str2:
	.asciz "Hello"

.text
.global _start

strcmp:
    push   %esi # save 2nd arg
    push   %edi # save 1st arg
    xor    %eax,%eax # set eax to 0

    # STRLEN 1st arg
    mov    $0xffffffff,%ecx
    repnz scas %es:(%edi),%al # scan edi to find al register value which is NULL byte. 
    add    $0x2,%ecx
    neg    %ecx # length of str1

    mov    %ecx,%edx # copy str1 len to edx
    xor    %eax,%eax # set eax to 0
    mov    %esi,%edi # copy str2 addr from esi to edi

    # STRLEN 2nd arg
    mov    $0xffffffff,%ecx
    repnz scas %es:(%edi),%al
    add    $0x2,%ecx
    neg    %ecx # length of str2

    mov    %ecx,%ebx # copy str2 len to ecx
    cmp    %ebx,%edx # compare the str2 and str1 length
    jne    wrong # jump to wrong if len(str2) != len(str1)

    # Compare str1 and str2
    pop    %edi
    pop    %esi
    mov    %edx,%ecx
    repz cmpsb %es:(%edi),%ds:(%esi)
    jne    wrong

correct:
    mov    $0x0,%eax
    jmp    end

wrong:
    mov    $0xffffffff,%eax

end:
    ret

_start:
    
    mov    $str1,%edi
    mov    $str2,%esi
    call   strcmp

exit:
    mov    $0x1,%eax
    int    $0x80

