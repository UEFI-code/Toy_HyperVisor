.intel_syntax noprefix
.global efi_main

efi_main:
    #mov dx, 0x2333
    #in al, dx
    #int 3

    mov rax, 0x08000000
    xor rbx, rbx
    mov [rax], rbx

    loop:
    nop
    nop
    nop
    nop
    jmp loop # attach gdb or JTAG here

    mov rax, 0 # EFI_SUCCESS
    ret