.attribute arch, "rv64gc_zicsr"

# Identify for linker script memmap.ld
.section ".text.start"

.type _start, @function
.globl _start

.cfi_startproc

_start:
#   csrc    mstatus, 1<<3   # global disable interrupts, mstatus.mie = 0
#   la      t0,_trap_handler
#   csrw    mtvec,t0        # install trap handler
#   li      fp,0            # init fp
#   la      sp,__stack_top  # init sp (stack grows down)

    csrc    mstatus, 1<<3   # global disable interrupts, mstatus.mie = 0
    lui     sp,0x50000      # init stack at 0x50000000 (grows down)
    jal     _cstart

hang:
    j       hang

.cfi_endproc
.size _start, .-_start
