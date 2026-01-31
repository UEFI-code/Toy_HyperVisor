.intel_syntax noprefix
.global efi_main

efi_main:
    mov rax, 0      # EFI_SUCCESS
    ret