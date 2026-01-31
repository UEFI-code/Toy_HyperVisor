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

    mov ecx, 0xC0000080 # IA32_FEATURE_CONTROL MSR
    rdmsr
    or eax, 0x4 # 
    wrmsr

    mov rdi, 0x08000000
    vmxon [rdi]

    mov rdi, 0x08001000 
    vmclear [rdi]
    vmptrld [rdi]

    mov rcx, 0x6800 # VMCS_GUEST_CR0
    mov rax, cr0
    vmwrite rcx, rax
    mov rcx, 0x6802 # VMCS_GUEST_CR3
    mov rax, cr3
    vmwrite rcx, rax
    mov rcx, 0x6804 # VMCS_GUEST_CR4
    mov rax, cr4
    vmwrite rcx, rax
    mov rcx, 0x6808 # VMCS_GUEST_CS
    mov rax, cs
    vmwrite rcx, rax
    mov rcx, 0x6816 # VMCS_GUEST_GDTR_BASE
    sgdt [rsp-0x10]
    mov rax, [rsp-0x8]
    vmwrite rcx, rax
    mov rcx, 0x681E # VMCS_GUEST_RIP
    mov rax, guest_code
    vmwrite rcx, rax
    mov rcx, 0x6820 # VMCS_GUEST_RFLAGS
    pushfq
    pop rax
    vmwrite rcx, rax

    vmlaunch

    guest_code:
    nop
    nop
    nop
    nop
    jmp guest_code

    mov rax, 0 # EFI_SUCCESS
    ret