global _start

section .text

strcmp:
        push ebp
        mov ebp, esp
        sub esp, 24h ; Prologue

        push esi ; save esi
        push edi ; save edi

        ; strlen(edi)
        xor eax, eax
        mov ecx, 0xffffffff
        repne scasb
        add ecx, 2
        neg ecx ; size of edi
        mov edx, ecx

        ; strlen(esi)
        xor eax, eax
        mov edi, esi
        mov ecx, 0xffffffff
        repne scasb
        add ecx, 2
        neg ecx ; size of esi
        mov ebx, ecx

        cmp edx, ebx ; Are they same size?
        jne wrong

        pop edi ; restore edi
        pop esi ; restor esi

        mov ecx, edx ; ecx = size of strings
        rep cmpsb         ; comparison of ECX number of bytes

        mov eax, 4        ; does not modify flags
        mov ebx, 1        ; does not modify flags
        jne wrong

right:
        mov eax, 0
        jmp end
wrong:
        mov eax, 0xffffffff

end:
        leave ; Epilogue
        ret

_start:
        push ebp
        mov ebp, esp
        sub esp, 20h

        mov edi, var1
        mov esi, var2
        call strcmp

exit:
        mov eax, 1
        int 0x80

section .data
        var1 db "Hello",0
        var2 db "Hell0",0
