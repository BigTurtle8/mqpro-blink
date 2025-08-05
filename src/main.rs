#![no_main]
#![no_std]

use core::arch::global_asm;
use core::panic::PanicInfo;
use core::ptr;

global_asm!(include_str!("start.s"));


#[unsafe(no_mangle)]
pub unsafe extern "C" fn _cstart() -> ! {
    unsafe extern "C" {
        static mut __text_end: u8;
        static mut __bss_start: u8;
        static mut __bss_end: u8;
    }

    unsafe {
        // Zero all out the bytes in BSS
        /*
        let count = &raw const __bss_end as *const u8 as usize - &raw const __bss_start as *const u8 as usize;
        ptr::write_bytes(&raw mut __bss_start as *mut u8, 0, count);
        */

        let PD_CFG2: *mut usize = 0x2000098 as *mut usize;
        let PD_DATA: *mut usize = 0x20000a0 as *mut usize;

        // Config PD18 for output
        ptr::write_volatile(PD_CFG2, 0x1ff);
        // Turn on PD18
        ptr::write_volatile(PD_DATA, 1 << 18);
    }

    loop {}
}

#[panic_handler]
fn panic(_panic: &PanicInfo<'_>) -> ! {
    loop {}
}
