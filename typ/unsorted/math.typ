#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [Performing math functionality with `#[no_std]`]
  else if lang == "de" [Mathematische Funktionen mit `#[no_std]` nutzen]
  else { todo })
#set heading(offset: whole*2)

#if lang == "en" [
  If you want to perform math related functionality like calculating the
  squareroot or the exponential of a number and you have the full standard
  library available, your code might look like this:
] else if lang == "de" [
  Wenn Sie mathematische Operationen durchführen möchten -- wie etwa die
  Berechnung der Quadratwurzel aus der Exponentialfunktion einer Zahl --
  und Ihnen die vollständige Standardbibliothek zur Verfügung steht,
  könnte Ihr Code folgendermaßen aussehen:
] else { todo }

#raw(block: true, lang: "rust",
"//! " + if lang == "en" {
    "Some mathematical functions with standard support available"
  } else if lang == "de" {
    "Einige mathematische Funktionen mit Standardunterstützung verfügbar"
  } else { todos } + "

fn main() {
    let float: f32 = 4.82832;
    let floored_float = float.floor();

    let sqrt_of_four = floored_float.sqrt();

    let sinus_of_four = floored_float.sin();

    let exponential_of_four = floored_float.exp();
    println!(\"Floored test float {} to {}\", float, floored_float);
    println!(\"The square root of {} is {}\", floored_float, sqrt_of_four);
    println!(\"The sinus of four is {}\", sinus_of_four);
    println!(
        \"The exponential of four to the base e is {}\",
        exponential_of_four
    )
}
")

#let ln_libm = link("https://crates.io/crates/libm")[`libm`]
#if lang == "en" [
  Without standard library support, these functions are not available. An
  external crate like #ln_libm can
  be used instead. The example code would then look like this:
] else if lang == "de" [
  Ohne Unterstützung durch die Standardbibliothek stehen diese Funktionen
  nicht zur Verfügung. Stattdessen kann ein externes Crate wie
  #link("https://crates.io/crates/libm")[`libm`] verwendet werden. Der
  Beispielcode sähe dann folgendermaßen aus:
] else { todo }

#raw(block: true, lang: "rust",
"#![no_main]
#![no_std]

use panic_halt as _;

use cortex_m_rt::entry;
use cortex_m_semihosting::{debug, hprintln};
use libm::{exp, floorf, sin, sqrtf};

#[entry]
fn main() -> ! {
    let float = 4.82832;
    let floored_float = floorf(float);

    let sqrt_of_four = sqrtf(floored_float);

    let sinus_of_four = sin(floored_float.into());

    let exponential_of_four = exp(floored_float.into());
    hprintln!(\"Floored test float {} to {}\", float, floored_float).unwrap();
    hprintln!(\"The square root of {} is {}\", floored_float, sqrt_of_four).unwrap();
    hprintln!(\"The sinus of four is {}\", sinus_of_four).unwrap();
    hprintln!(
        \"The exponential of four to the base e is {}\",
        exponential_of_four
    )
    .unwrap();
    // " + if lang == "en" {
        "exit QEMU
    // NOTE do not run this on hardware; it can corrupt OpenOCD state"
      } else if lang == "de" {
        "exit QEMU
    // HINWEIS: Fuehren Sie dies nicht auf der Hardware aus; es kann den 
    //          OpenOCD-Zustand beschaedigen."
      } else { todos } + "
    // debug::exit(debug::EXIT_SUCCESS);

    loop {}
}
")

#if lang == "en" [
  If you need to perform more complex operations like DSP signal
  processing or advanced linear algebra on your MCU, the following crates
  might help you
] else if lang == "de" [
  Wenn Sie komplexere Operationen wie DSP-Signalverarbeitung oder
  fortgeschrittene lineare Algebra auf Ihrem Mikrocontroller durchführen
  müssen, könnten Ihnen die folgenden Crates weiterhelfen.
] else { todo }
- #link("https://github.com/jacobrosenthal/cmsis-dsp-sys")[CMSIS DSP library binding]
- #link("https://crates.io/crates/constgebra")[`constgebra`]
- #link("https://github.com/tarcieri/micromath")[`micromath`]
- #link("https://crates.io/crates/microfft")[`microfft`]
- #link("https://github.com/dimforge/nalgebra")[`nalgebra`]
