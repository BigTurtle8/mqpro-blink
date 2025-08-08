# About
This is mainly an experiment to see if I could run code on the Mango Pi MQ Pro using Rust. I had used the MQ Pro previously in a class, which made life significantly easier. For instance, I had already used `xfel`, the tool to flash onto board's Allwinner D1-H chip.

In the end, I was able to get blinking working in this incredibly crude and rudimentary program. I think future experiments will use at least basic crates like `riscv-rt` (https://crates.io/crates/riscv-rt) and `riscv` (https://crates.io/crates/riscv) to have a more solid software foundation.

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
