SECTIONS {
    .text 0x40000000        : { *(.text.start) *(.text*) }
    __text_end              = .;
    .rodata                 : { *(.rodata*) *(.srodata*) }
    .data   ALIGN(0x20000)  : { *(.sdata*) }
    __bss_start             = .;
    .bss                    : { *(.bss*) *(.sbss*) *(COMMON) }
    __bss_end               = .;

    /DISCARD/ :
    {
        *(.eh_frame, .comment, .riscv.attributes);
    }
}

ENTRY(_start_gdb)              /* control entry point, ensure _start symbol is linked */
ASSERT(_start == ADDR(.text),  /* error if _start not at correct address */
       "_start symbol must be placed first in text section")
