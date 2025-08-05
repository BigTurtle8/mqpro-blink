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

    /*
# blink program, onboard PD18 LED
    lui     a0,0x2000       # base address for PB group
    addi    a1,zero,0x1ff   # constant to set PD18 as output
    sw      a1,0x98(a0)     # config PD18 as output
    addi    a1,zero,0x1     # initialize a1 as 1

loop:
    xori    a1,a1,0x1       # invert a1
    slli    a3,a1,0x12      # shift `1` to 18th place
    sw      a3,0xa0(a0)     # set data value of PD18 to a1

    lui     a2,50000        # init countdown value

delay:
    addi    a2,a2,-1        # decrement a2
    bne     a2,zero,delay   # keep counting down until a2 is zero

    j       loop
    */
    csrc    mstatus, 1<<3   # global disable interrupts, mstatus.mie = 0
    lui     sp,0x50000      # init stack at 0x50000000 (grows down)
    jal     _cstart

hang:
    j       hang

.cfi_endproc
.size _start, .-_start
