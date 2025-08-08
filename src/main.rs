#![no_main]
#![no_std]

use core::arch::global_asm;
use core::panic::PanicInfo;
use core::ptr;

global_asm!(include_str!("start.s"));

/// First function called, after the program starts
/// at `_start` defined in `start.s`.
///
/// For the MQ Pro, zeroes the BSS section, turns on
/// the blue onboard LED, then calls main.
#[unsafe(no_mangle)]
pub fn _cstart() {
    unsafe extern "C" {
        static mut __text_end: u8;
        static mut __bss_start: u8;
        static mut __bss_end: u8;
    }

    unsafe {
        // Zero all out the bytes in BSS
        let count = &raw const __bss_end as *const u8 as usize - &raw const __bss_start as *const u8 as usize;
        ptr::write_bytes(&raw mut __bss_start as *mut u8, 0, count);

        let pd_cfg2 = 0x2000098 as *mut usize;
        let pd_data = 0x20000a0 as *mut usize;

        // Config PD18 for output
        ptr::write_volatile(pd_cfg2, 0x1ff);
        // Turn on PD18
        ptr::write_volatile(pd_data, 1 << 18);
    }

    main();
}

pub fn main() -> i32 {
    let pd_data = 0x20000a0 as *mut usize;

    // Should be a 50% duty cycle PWM
    unsafe {
        for _ in 1..100000 {
            // Turn on PD18
            ptr::write_volatile(pd_data, 1 << 18);
            // Turn off PD18
            ptr::write_volatile(pd_data, 0);
        }
    }

    0
}

#[panic_handler]
fn panic(_panic: &PanicInfo<'_>) -> ! {
    loop {}
}
