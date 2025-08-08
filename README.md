# How To
To make binary, run:
```shell
cargo objcopy --release -- -O binary mqpro-blink.bin
```

## Useful Commands
To fully disassemble build:
```shell
cargo objdump --release -- -D
```

To see elf output:
```shell
cargo readobj --release -- -a
```
