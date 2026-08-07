#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [A First Attempt]
  else if lang == "de" [Ein erster Versuch in Rust]
  else { todo })

= #(if lang == "en" [The Registers]
  else if lang == "de" [Die Register]
  else { todo })

#let url_arm = "http://infocenter.arm.com/help/topic/com.arm.doc.dui0553a/Babieigh.html"
#if lang == "en" [
  Let's look at the 'SysTick' peripheral - a simple timer which comes with
  every Cortex-M processor core. Typically you'll be looking these up in
  the chip manufacturer's data sheet or _Technical Reference Manual_,
  but this example is common to all ARM Cortex-M cores, let's look in the
  #link(url_arm)[ARM reference manual].
  We see there are four registers:
] else if lang == "de" [
  Betrachten wir die „SysTick"-Peripherie -- einen einfachen Timer, der in
  jedem Cortex-M-Prozessorkern enthalten ist. Normalerweise würde man
  hierfür im Datenblatt des Chip-Herstellers oder im _Technical
  Reference Manual_ nachschlagen; da dieses Beispiel jedoch für alle
  ARM-Cortex-M-Kerne gilt, werfen wir einen Blick in das
  #link(url_arm)[ARM-Referenzhandbuch].
  Wir sehen, dass es vier Register gibt:
] else { todo }

#figure(
  kind: table,
  table(
    columns: 4,
    align: (auto,auto,auto,auto,),
    table.header(
        if lang in ("en", "de") [Offset]
        else { todo },
        if lang in ("en", "de") [Name]
        else { todo },
        if lang == "en" [Description]
        else if lang == "de" [Beschreibung]
        else { todo },
        if lang == "en" [Width]
        else if lang == "de" [Breite]
        else { todo },
    ),
    [0x00], [SYST_CSR],
    if lang == "en" [Control and Status Register]
    else if lang == "de" [Steuerung und Status Register]
    else { todo },
    [32 bits],
    [0x04], [SYST_RVR],
    if lang == "en" [Reload Value Register]
    else if lang == "de" [Wert-Register neu laden]
    else { todo },
    [32 bits],
    [0x08], [SYST_CVR],
    if lang == "en" [Current Value Register]
    else if lang == "de" [Register für den aktuellen Wert]
    else { todo },
    [32 bits],
    [0x0C], [SYST_CALIB],
    if lang == "en" [Calibration Value Register]
    else if lang == "de" [Kalibrierwert-Register]
    else { todo },
    [32 bits],
  )
)

= #(if lang == "en" [The C Approach]
  else if lang == "de" [Der C-Ansatz]
  else { todo })

#if lang == "en" [
  In Rust, we can represent a collection of registers in exactly the same
  way as we do in C - with a `struct`.
] else if lang == "de" [
  In Rust können wir eine Sammlung von Registern auf genau dieselbe Weise
  darstellen wie in C -- mit einem `struct`.
] else { todo }

```rust
#[repr(C)]
struct SysTick {
    pub csr: u32,
    pub rvr: u32,
    pub cvr: u32,
    pub calib: u32,
}
```

#if lang == "en" [
  The qualifier `#[repr(C)]` tells the Rust compiler to lay this structure
  out like a C compiler would. That's very important, as Rust allows
  structure fields to be re-ordered, while C does not. You can imagine the
  debugging we'd have to do if these fields were silently re-arranged by
  the compiler! With this qualifier in place, we have our four 32-bit
  fields which correspond to the table above. But of course, this `struct`
  is of no use by itself - we need a variable.
] else if lang == "de" [
  Der Qualifizierer `#[repr(C)]` weist den Rust-Compiler an, diese
  Struktur wie ein C-Compiler anzulegen. Das ist sehr wichtig, da Rust die
  Neuordnung von Strukturfeldern zulässt, C jedoch nicht. Sie können sich
  vorstellen, wie viel Debugging wir durchführen müssten, wenn diese
  Felder vom Compiler stillschweigend neu angeordnet würden! Mit diesem
  Qualifizierer verfügen wir über unsere vier 32-Bit-Felder, die der
  obigen Tabelle entsprechen. Aber diese „Struktur" allein nützt natürlich
  nichts -- wir brauchen eine Variable.
] else { todo }

```rust
let systick = 0xE000_E010 as *mut SysTick;
let time = unsafe { (*systick).cvr };
```

= #(if lang == "en" [Volatile Accesses]
  else if lang == "de" [Volatile-Zugriffe]
  else { todo })

#if lang == "en" [
  Now, there are a couple of problems with the approach above.
  + We have to use unsafe every time we want to access our Peripheral.
  + We've got no way of specifying which registers are read-only or
    read-write.
  + Any piece of code anywhere in your program could access the hardware
    through this structure.
  + Most importantly, it doesn't actually work…
] else if lang == "de" [
  Nun gibt es bei dem oben genannten Ansatz einige Probleme.
  + Wir müssen `unsafe` verwenden, wann immer wir auf unsere Peripherie
    zugreifen wollen.
  + Wir haben keine Möglichkeit festzulegen, welche Register nur lesbar
    oder sowohl les- als auch schreibbar sind.
  + Jeder Code-Abschnitt an beliebiger Stelle Ihres Programms könnte über
    diese Struktur auf die Hardware zugreifen.
  + Vor allem aber funktioniert es eigentlich nicht …
] else { todo }

#if lang == "en" [
  Now, the problem is that compilers are clever. If you make two writes to
  the same piece of RAM, one after the other, the compiler can notice this
  and just skip the first write entirely. In C, we can mark variables as
  `volatile` to ensure that every read or write occurs as intended. In
  Rust, we instead mark the _accesses_ as volatile, not the variable.
] else if lang == "de" [
  Das Problem ist nun, dass Compiler clever sind. Wenn man zwei
  Schreibzugriffe nacheinander auf denselben Speicherbereich durchführt,
  kann der Compiler dies erkennen und den ersten Schreibvorgang einfach
  komplett überspringen. In C können wir Variablen als `volatile`
  kennzeichnen, um sicherzustellen, dass jeder Lese- oder Schreibvorgang
  wie vorgesehen ausgeführt wird. In Rust hingegen kennzeichnen wir die
  _Zugriffe_ als volatile, nicht die Variable.
] else { todo }

```rust
let systick = unsafe { &mut *(0xE000_E010 as *mut SysTick) };
let time = unsafe { core::ptr::read_volatile(&mut systick.cvr) };
```

#let ln_volatile = link("https://crates.io/crates/volatile_register")[`volatile_register`]
#if lang == "en" [
  So, we've fixed one of our four problems, but now we have even more
  `unsafe` code! Fortunately, there's a third party crate which can help - #ln_volatile.
] else if lang == "de" [
  Wir haben also eines unserer vier Probleme gelöst, aber jetzt haben wir
  noch mehr `unsafe`-Code! Glücklicherweise gibt es ein Crate eines
  Drittanbieters, das hierbei helfen kann -- #ln_volatile.
] else { todo }

```rust
use volatile_register::{RW, RO};

#[repr(C)]
struct SysTick {
    pub csr: RW<u32>,
    pub rvr: RW<u32>,
    pub cvr: RW<u32>,
    pub calib: RO<u32>,
}

fn get_systick() -> &'static mut SysTick {
    unsafe { &mut *(0xE000_E010 as *mut SysTick) }
}

fn get_time() -> u32 {
    let systick = get_systick();
    systick.cvr.read()
}
```

#if lang == "en" [
  Now, the volatile accesses are performed automatically through the
  `read` and `write` methods. It's still `unsafe` to perform writes, but
  to be fair, hardware is a bunch of mutable state and there's no way for
  the compiler to know whether these writes are actually safe, so this is
  a good default position.
] else if lang == "de" [
  Die volatilen Zugriffe erfolgen nun automatisch über die Methoden `read`
  und `write`. Schreibzugriffe sind zwar weiterhin als `unsafe`
  eingestuft, doch fairerweise muss man sagen, dass Hardware im Grunde aus
  veränderlichem Zustand besteht und der Compiler nicht wissen kann, ob
  diese Schreibvorgänge tatsächlich sicher sind; daher ist dies eine
  sinnvolle Standardeinstellung.
] else { todo }

= #(if lang == "en" [The Rusty Wrapper]
  else if lang == "de" [Der Rusty Wrapper]
  else { todo })

#if lang == "en" [
  We need to wrap this `struct` up into a higher-layer API that is safe
  for our users to call. As the driver author, we manually verify the
  unsafe code is correct, and then present a safe API for our users so
  they don't have to worry about it (provided they trust us to get it
  right!).
] else if lang == "de" [
  Wir müssen diese `struct` in eine API der höheren Ebene verpacken, deren
  Aufruf für unsere Nutzer sicher ist. Als Treiberentwickler überprüfen
  wir manuell die Korrektheit des `unsafe`-Codes und stellen unseren
  Nutzern dann eine sichere API zur Verfügung, sodass sie sich darum nicht
  kümmern müssen (vorausgesetzt, sie vertrauen darauf, dass wir alles
  richtig gemacht haben!).
] else { todo }

#if lang == "en" [
  One example might be:
] else if lang == "de" [
  Ein Beispiel hierfür wäre:
] else { todo }

```rust
use volatile_register::{RW, RO};

pub struct SystemTimer {
    p: &'static mut RegisterBlock
}

#[repr(C)]
struct RegisterBlock {
    pub csr: RW<u32>,
    pub rvr: RW<u32>,
    pub cvr: RW<u32>,
    pub calib: RO<u32>,
}

impl SystemTimer {
    pub fn new() -> SystemTimer {
        SystemTimer {
            p: unsafe { &mut *(0xE000_E010 as *mut RegisterBlock) }
        }
    }

    pub fn get_time(&self) -> u32 {
        self.p.cvr.read()
    }

    pub fn set_reload(&mut self, reload_value: u32) {
        unsafe { self.p.rvr.write(reload_value) }
    }
}

pub fn example_usage() -> String {
    let mut st = SystemTimer::new();
    st.set_reload(0x00FF_FFFF);
    format!("Time is now 0x{:08x}", st.get_time())
}
```

#if lang == "en" [
  Now, the problem with this approach is that the following code is
  perfectly acceptable to the compiler:
] else if lang == "de" [
  Das Problem bei diesem Ansatz ist nun, dass der folgende Code für den
  Compiler völlig zulässig ist:
] else { todo }

```rust
fn thread1() {
    let mut st = SystemTimer::new();
    st.set_reload(2000);
}

fn thread2() {
    let mut st = SystemTimer::new();
    st.set_reload(1000);
}
```

#if lang == "en" [
  Our `&mut self` argument to the `set_reload` function checks that there
  are no other references to _that_ particular `SystemTimer` struct,
  but they don't stop the user creating a second `SystemTimer` which
  points to the exact same peripheral! Code written in this fashion will
  work if the author is diligent enough to spot all of these 'duplicate'
  driver instances, but once the code is spread out over multiple modules,
  drivers, developers, and days, it gets easier and easier to make these
  kinds of mistakes.
] else if lang == "de" [
  Das `&mut self`-Argument der Funktion `set_reload` stellt zwar sicher,
  dass keine weiteren Referenzen auf _genau diese_
  `SystemTimer`-Struktur existieren, verhindert jedoch nicht, dass der
  Benutzer einen zweiten `SystemTimer` erstellt, der auf dieselbe
  Peripherieeinheit verweist. Auf diese Weise geschriebener Code
  funktioniert zwar, sofern der Autor sorgfältig genug ist, all diese
  „doppelten" Treiberinstanzen zu erkennen; sobald sich der Code jedoch
  über mehrere Module, Treiber, Entwickler und Zeiträume hinweg erstreckt,
  schleichen sich derartige Fehler immer leichter ein.
] else { todo }
