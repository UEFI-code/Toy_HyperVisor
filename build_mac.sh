/opt/homebrew/opt/llvm/bin/clang \
  -target x86_64-unknown-windows \
  -ffreestanding \
  -c 1.s \
  -o 1.o

/opt/homebrew/opt/lld/bin/ld.lld \
  -shared \
  -m i386pep \
  --subsystem=efi_application \
  -e efi_main \
  1.o \
  -o 1.efi