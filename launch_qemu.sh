qemu-system-x86_64 \
    -m 512M \
    -drive if=pflash,format=raw,readonly,file=/opt/homebrew/share/qemu/edk2-x86_64-code.fd \
    -drive format=raw,file=fat:rw:. \
    -S -s