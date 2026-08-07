#import "../config.typ": *

#h1(offset: whole,
  [QEMU])
<getting-started-qemu>

// TODO: check
#if lang == "de" [
  QEMU (von englisch „Quick Emulator") ist eine freie
  Virtualisierungssoftware, die die gesamte Hardware eines Computers
  emuliert und durch die dynamische Übersetzung der Prozessorinstruktionen
  des Gastprozessors (englisch guest) in Instruktionen für den
  Wirtprozessor (englisch host) eine sehr gute Ausführungsgeschwindigkeit
  erreicht.

  URL: #link("https://www.qemu.org/")

  QEMU emuliert Systeme mit den folgenden Prozessorarchitekturen:
  - 68K,
  - Alpha,
  - ARM (32- und 64-Bit),
  - CHRIS,
  - HPPA,
  - LatticeMico32,
  - m68K bzw. Coldfire,
  - MicroBlaze,
  - MIPS,
  - Moxie,
  - Nios2,
  - OpenRISC,
  - PC
  - Power
  - PowerNV
  - PowerPC (32- und 64-Bit),
  - RISC-V,
  - S/390,
  - SH-4,
  - Sparc32/64,
  - TILE-Gx,
  - TriCore,
  - Unicore,
  - x86 (x86-32 und x86-64),
  - Xtensa

  (Stand 2026).
]

#let lm3s6965 = link("http://www.ti.com/product/LM3S6965")[LM3S6965]
#let url_qemu = "https://wiki.qemu.org/Documentation/Platforms/ARM#Supported_in_qemu-system-arm"
#if lang == "en" [
  We'll start writing a program for the #lm3s6965, a Cortex-M3
  microcontroller. We have chosen this as our initial target because it
  #link(url_qemu)[can be emulated]
  using QEMU so you don't need to fiddle with hardware in this section and
  we can focus on the tooling and the development process.
] else if lang == "de" [
  Wir beginnen mit der Entwicklung eines Programms für den
  #lm3s6965, einen ARM
  Cortex-M3-Mikrocontroller. Wir haben diesen als unser erstes Ziel
  ausgewählt, da er mit QEMU
  #link(url_qemu)[emuliert werden kann],
  sodass Sie sich in diesem Abschnitt nicht mit der Hardware beschäftigen
  müssen und wir uns auf die Werkzeuge und den Entwicklungsprozess
  konzentrieren können.
] else { todo }

#if lang == "en" [
  *IMPORTANT* We'll use the name "app" for the project name in this
  tutorial. Whenever you see the word "app" you should replace it with the
  name you selected for your project. Or, you could also name your project
  "app" and avoid the substitutions.
] else if lang == "de" [
  *WICHTIG* In dieser Anleitung verwenden wir den Namen „app" als
  Projektnamen. Wann immer Sie das Wort „app" sehen, sollten Sie es durch
  den Namen ersetzen, den Sie für Ihr Projekt gewählt haben. Alternativ
  können Sie Ihr Projekt auch „app" nennen und so die Ersetzungen
  vermeiden.
] else { todo }

= #(if lang == "en" [Creating a non standard Rust program]
  else if lang == "de" [Erstellen eines nicht standardmäßigen Rust-Programms]
  else { todo })

#let ln_quick = link("https://github.com/rust-embedded/cortex-m-quickstart")[`cortex-m-quickstart`]
#if lang == "en" [
  We'll use the #ln_quick
  project template to generate a new project from it. The created project
  will contain a barebone application: a good starting point for a new
  embedded rust application. In addition, the project will contain an
  `examples` directory, with several separate applications, highlighting
  some of the key embedded rust functionality.
] else if lang == "de" [
  Wir werden die Projektvorlage #ln_quick
  verwenden, um daraus ein neues Projekt zu erstellen. Das erstellte
  Projekt enthält eine Minimalanwendung: einen guten Ausgangspunkt für
  eine neue Embedded-Rust-Anwendung. Darüber hinaus enthält das Projekt
  ein Verzeichnis `examples` mit mehreren separaten Anwendungen, die
  einige der wichtigsten Funktionen von Embedded Rust veranschaulichen.
] else { todo }

== #(if lang == "en" [Using `cargo-generate`]
  else if lang == "de" [Verwendung von `cargo-generate`]
  else { todo })

#if lang == "en" [
  First install cargo-generate
] else if lang == "de" [
  Installieren Sie zunächst cargo-generate
] else { todo }

```console
cargo install cargo-generate
```

#if lang == "en" [
  Then generate a new project
] else if lang == "de" [
  Erstellen Sie anschließend ein neues Projekt
] else { todo }

```console
cargo generate --git https://github.com/knurling-rs/app-template
```

```text
 Project Name: app
 Creating project called `app`...
 Done! New project created /tmp/app
```

```console
cd app
```

== #(if lang == "en" [Using `git`]
  else if lang == "de" [Verwendung von `git`]
  else { todo })

#if lang == "en" [
  Clone the repository
] else if lang == "de" [
  Das Repository klonen
] else { todo }

```console
git clone https://github.com/rust-embedded/cortex-m-quickstart app
cd app
```

#if lang == "en" [
  And then fill in the placeholders in the `Cargo.toml` file
] else if lang == "de" [
  Und fülle dann die Platzhalter in der Datei `Cargo.toml` aus
] else { todo }

```toml
[package]
authors = ["{{authors}}"] # "{{authors}}" -> "John Smith"
edition = "2018"
name = "{{project-name}}" # "{{project-name}}" -> "app"
version = "0.1.0"

# ..

[[bin]]
name = "{{project-name}}" # "{{project-name}}" -> "app"
test = false
bench = false
```

== #(if lang == "en" [Using neither]
  else if lang == "de" [Keines von beiden verwenden]
  else { todo })

#if lang == "en" [
  Grab the latest snapshot of the `cortex-m-quickstart` template and
  extract it.
] else if lang == "de" [
  Laden Sie den neuesten Snapshot der Vorlage `cortex-m-quickstart`
  herunter und entpacken Sie ihn.
] else { todo }

```console
curl -LO https://github.com/rust-embedded/cortex-m-quickstart/archive/master.zip
unzip master.zip
mv cortex-m-quickstart-master app
cd app
```

#if lang == "en" [
  Or you can browse to #ln_quick, click the green "Clone or download" button and then click "Download ZIP".
] else if lang == "de" [
  Oder Sie navigieren zu #ln_quick,
  klicken auf die grüne Schaltfläche „Clone or download" und anschließend
  auf „Download ZIP".
] else { todo }

#if lang == "en" [
  Then fill in the placeholders in the `Cargo.toml` file as done in the
  second part of the "Using `git`" version.
] else if lang == "de" [
  Füllen Sie anschließend die Platzhalter in der Datei `Cargo.toml` aus,
  wie im zweiten Teil der Version „Verwendung von `git` beschrieben.
] else { todo }

= #(if lang == "en" [Program Overview]
  else if lang == "de" [Programmübersicht]
  else { todo })

#if lang == "en" [
  For convenience here are the most important parts of the source code in `src/main.rs`:
] else if lang == "de" [
  Der Einfachheit halber sind hier die wichtigsten Teile des Quellcodes in
  `src/main.rs` aufgeführt:
] else { todo }

#raw(block: true, lang: "rust",
"#![no_std]
#![no_main]

use panic_halt as _;

use cortex_m_rt::entry;

#[entry]
fn main() -> ! {
    loop {
        // " + if lang == "en" {
            "your code goes here"
          } else if lang == "de" {
            "Hier kommt Ihr Code hin."
          } else { todos } + "
    }
}
")

#if lang == "en" [
  This program is a bit different from a standard Rust program so let's
  take a closer look.
] else if lang == "de" [
  Dieses Programm unterscheidet sich ein wenig von einem typischen
  Rust-Programm, schauen wir es uns also einmal genauer an.
] else { todo }

#if lang == "en" [
  `#![no_std]` indicates that this program will _not_ link to the
  standard crate, `std`. Instead it will link to its subset: the `core` crate.
] else if lang == "de" [
  `#![no_std]` gibt an, dass dieses Programm _nicht_ mit der
  Standard-Crate `std` verknüpft wird. Stattdessen wird es mit deren
  Teilmenge verknüpft: der Crate `core`.
] else { todo }

#if lang == "en" [
  `#![no_main]` indicates that this program won't use the standard `main`
  interface that most Rust programs use. The main (no pun intended) reason
  to go with `no_main` is that using the `main` interface in `no_std`
  context requires nightly.
] else if lang == "de" [
  `#![no_main]` gibt an, dass dieses Programm nicht die Standard-`main`-
  Schnittstelle verwendet, die die meisten Rust-Programme nutzen. Der
  Hauptgrund (kein Wortspiel beabsichtigt) für die Verwendung von
  `no_main` ist, dass die Nutzung der `main`-Schnittstelle im
  `no_std`-Kontext „Nightly" erfordert.
] else { todo }

#if lang == "en" [
  `use panic_halt as _;`. This crate provides a `panic_handler` that
  defines the panicking behavior of the program. We will cover this in
  more detail in the #link(<getting-started-panicking>)[Panicking] chapter of the book.
] else if lang == "de" [
  `use panic_halt as _;`. Diese Crate stellt einen `panic_handler` bereit,
  der das Verhalten des Programms im Panikfall definiert. Wir werden
  darauf im Kapitel #link(<getting-started-panicking>)[In Panik geraten] des Buches
  näher eingehen.
] else { todo }

#let ln_entry = link("https://docs.rs/cortex-m-rt-macros/latest/cortex_m_rt_macros/attr.entry.html")[`#[entry]`]
#let ln_rt = link("https://crates.io/crates/cortex-m-rt")[`cortex-m-rt`]
#if lang == "en" [
  #ln_entry is an attribute provided by the #ln_rt crate
  that's used to mark the entry point of the program. As we are not using
  the standard `main` interface we need another way to indicate the entry
  point of the program and that'd be `#[entry]`.
] else if lang == "de" [
  #ln_entry ist ein Attribut des
  #ln_rt;-Crate, das dazu dient, den Einstiegspunkt des Programms zu kennzeichnen. Da wir
  nicht die Standard-Schnittstelle `main` verwenden, benötigen wir eine
  andere Möglichkeit, den Einstiegspunkt des Programms anzugeben, und das
  wäre `#[entry]`.
] else { todo }

#let url_div = "https://doc.rust-lang.org/rust-by-example/fn/diverging.html"
#if lang == "en" [
  `fn main() -> !`. Our program will be the _only_ process running on
  the target hardware so we don't want it to end! We use a
  #link(url_div)[divergent function]
  (the `-> !` bit in the function signature) to ensure at compile time
  that'll be the case.
] else if lang == "de" [
  `fn main() -> !`. Unser Programm wird der _einzige_ Prozess sein,
  der auf der Zielhardware läuft, deshalb soll es nicht beendet werden!
  Wir verwenden eine #link(url_div)[divergent function]
  (das `-> !` in der Funktionssignatur), um bereits zur Kompilierungszeit
  sicherzustellen, dass dies auch der Fall ist.
] else { todo }

= #(if lang == "en" [Cross compiling]
  else if lang == "de" [Cross-Kompilierung]
  else { todo })

#if lang == "en" [
  First of all we will need the memory layout for the target
  microcontroller, the LM3S6965 in our case. Otherwise the build will fail
  to link the image. Create a file named `memory.x` at the root of the
  project and paste the following content:
] else if lang == "de" [
  Zunächst benötigen wir das Speicherlayout für den Ziel-Mikrocontroller,
  in unserem Fall den LM3S6965. Andernfalls schlägt die Verknüpfung des
  Images beim Build fehl. Erstellen Sie eine Datei mit dem Namen
  `memory.x` im Stammverzeichnis des Projekts und fügen Sie den folgenden
  Inhalt ein:
] else { todo }

#raw(block: true, lang: "text",
"MEMORY
{
  /* " + if lang == "en" {
      "NOTE 1 K = 1 KiBi = 1024 bytes */
  /* TODO Adjust these memory regions to match your device memory layout */
  /* These values correspond to the LM3S6965, one of the few devices
  /* QEMU can emulate */"
    } else if lang == "de" {
      "Hinweis: 1 K = 1 KiBi = 1024 bytes */
  /* TODO Passen Sie diese Speicherbereiche an das Speicherlayout Ihres Geräts an. */
  /* Diese Werte entsprechen dem LM3S6965, einem der wenigen Bausteine, die 
  QEMU emulieren kann */"
    } else { todos } + "
  FLASH : ORIGIN = 0x00000000, LENGTH = 256K
  RAM : ORIGIN = 0x20000000, LENGTH = 64K
}

/* " + if lang == "en" {
    "This is where the call stack will be allocated. */
/* The stack is of the full descending type. */
/* You may want to use this variable to locate the call stack and static
   variables in different memory regions. Below is shown the default value */"
  } else if lang == "de" {
    "Hier wird der Aufrufstapel zugewiesen. */
/* Der Stapel ist vom Typ „vollständig absteigend“. */
/* Möglicherweise möchten Sie diese Variable verwenden, um den Aufrufstapel und 
  statische Variablen in verschiedenen Speicherbereichen zu lokalisieren. 
  Nachstehend ist der Standardwert aufgeführt */"
  } else { todos } + "
/* _stack_start = ORIGIN(RAM) + LENGTH(RAM); */

/* " + if lang == "en" {
    "You can use this symbol to customize the location of the .text section */
/* If omitted the .text section will be placed right after the .vector_table
   section */
/* This is required only on microcontrollers that store some configuration right
   after the vector table */"
  } else if lang == "de" {
    "Mit diesem Symbol können Sie den Speicherort des .text-Abschnitts anpassen. */
/* Wird dies weggelassen, wird der .text-Abschnitt direkt nach dem .vector_table-
  Abschnitt platziert */
/* Dies ist nur bei Mikrocontrollern erforderlich, die bestimmte 
  Konfigurationsdaten direkthinter der Vektortabelle speichern */"
  } else { todos } + "
/* _stext = ORIGIN(FLASH) + 0x400; */

/* " + if lang == "en" {
    "Example of putting non-initialized variables into custom RAM locations. */
/* This assumes you have defined a region RAM2 above, and in the Rust
  sources added the attribute `#[link_section = \".ram2bss\"]` to the data
  you want to place there. */
/* Note that the section will not be zero-initialized by the runtime! */"
  } else if lang == "de" {
    "Beispiel für die Zuweisung nicht initialisierter Variablen zu 
benutzerdefinierten RAM-Speicherplätzen. */
/* Dies setzt voraus, dass Sie oben einen Bereich namens „RAM2“ definiert und 
in den Rust-Quelldateien das Attribut `#[link_section = „.ram2bss“]` zu den 
Daten hinzugefügt haben, die Sie dort platzieren möchten. */
/* Beachten Sie, dass der Bereich von der Laufzeitumgebung nicht auf Null 
initialisiert wird! */"
  } else { todos } + "
/* SECTIONS {
     .ram2bss (NOLOAD) : ALIGN(4) {
       *(.ram2bss);
       . = ALIGN(4);
     } > RAM2
   } INSERT AFTER .bss;
*/
")

#if lang == "en" [
  The next step is to _cross_ compile the program for the Cortex-M3
  architecture. That's as simple as running `cargo build --target $TRIPLE`
  if you know what the compilation target (`$TRIPLE`) should be. Luckily,
  the `.cargo/config.toml` in the template has the answer:
] else if lang == "de" [
  Der nächste Schritt besteht darin, das Programm für die
  Cortex-M3-Architektur _cross_ zu kompilieren. Das geht ganz einfach
  mit dem Befehl `cargo build --target $TRIPLE`, sofern Sie wissen, wie
  das Kompilierungsziel (`$TRIPLE`) lauten soll. Glücklicherweise finden
  Sie die Antwort in der Datei `.cargo/config.toml` in der Vorlage:
] else { todo }

```console
tail -n6 .cargo/config.toml
```

#if lang == "en" [
  ```toml
  [build]
  # Pick ONE of these compilation targets
  # target = "thumbv6m-none-eabi"    # Cortex-M0 and Cortex-M0+
  target = "thumbv7m-none-eabi"    # Cortex-M3
  # target = "thumbv7em-none-eabi"   # Cortex-M4 and Cortex-M7 (no FPU)
  # target = "thumbv7em-none-eabihf" # Cortex-M4F and Cortex-M7F (with FPU)
  ```
] else if lang == "de" [
  ```toml
  [build]
  # Waehlen Sie EINES dieser Kompilierungsziele aus
  # target = "thumbv6m-none-eabi"    # Cortex-M0 and Cortex-M0+
  target = "thumbv7m-none-eabi"    # Cortex-M3
  # target = "thumbv7em-none-eabi"   # Cortex-M4 and Cortex-M7 (no FPU)
  # target = "thumbv7em-none-eabihf" # Cortex-M4F and Cortex-M7F (with FPU)
  ```
] else { todo }

#if lang == "en" [
  To cross compile for the Cortex-M3 architecture we have to use
  `thumbv7m-none-eabi`. That target is not automatically installed when
  installing the Rust toolchain, it would now be a good time to add that
  target to the toolchain, if you haven't done it yet:
] else if lang == "de" [
  Für die Cross-Kompilierung für die Cortex-M3-Architektur müssen wir
  `thumbv7m-none-eabi` verwenden. Dieses Ziel wird bei der Installation
  der Rust-Werkzeuge nicht automatisch installiert. Jetzt wäre ein guter
  Zeitpunkt, dieses Ziel zu den Werkzeugen hinzuzufügen, falls Sie dies
  noch nicht getan haben:
] else { todo }

```console
rustup target add thumbv7m-none-eabi
```

#if lang == "en" [
  Since the `thumbv7m-none-eabi` compilation target has been set as the
  default in your `.cargo/config.toml` file, the two commands below do the same:
] else if lang == "de" [
  Da das Kompilierungsziel `thumbv7m-none-eabi` in Ihrer Datei
  `.cargo/config.toml` als Standard festgelegt wurde, haben die beiden
  folgenden Befehle dieselbe Wirkung:
] else { todo }

```console
cargo build --target thumbv7m-none-eabi
cargo build
```

= #(if lang == "en" [Inspecting]
  else if lang == "de" [Überprüfen]
  else { todo })

#if lang == "en" [
  Now we have a non-native ELF binary in
  `target/thumbv7m-none-eabi/debug/app`. We can inspect it using
  `cargo-binutils`.
] else if lang == "de" [
  Nun haben wir eine nicht-native ELF-Binärdatei in
  `target/thumbv7m-none-eabi/debug/app`. Wir können sie mit
  `cargo-binutils` untersuchen.
] else { todo }

#if lang == "en" [
  With `cargo-readobj` we can print the ELF headers to confirm that this
  is an ARM binary.
] else if lang == "de" [
  Mit `cargo-readobj` können wir die ELF-Header ausgeben, um zu
  überprüfen, ob es sich um eine ARM- Binärdatei handelt.
] else { todo }

```console
cargo readobj --bin app -- --file-headers
```

#if lang == "en" [
  Note that:
  - `--bin app` is sugar for inspect the binary at `target/$TRIPLE/debug/app`
  - `--bin app` will also (re)compile the binary, if necessary
] else if lang == "de" [
  Bitte beachten Sie:
  - `--bin app` ist eine vereinfachte Schreibweise
    für die Überprüfung der Binärdatei unter `target/$TRIPLE/debug/app`
  - `--bin app` kompiliert die Binärdatei bei Bedarf auch (neu)
] else { todo }

```text
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0x0
  Type:                              EXEC (Executable file)
  Machine:                           ARM
  Version:                           0x1
  Entry point address:               0x405
  Start of program headers:          52 (bytes into file)
  Start of section headers:          153204 (bytes into file)
  Flags:                             0x5000200
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         2
  Size of section headers:           40 (bytes)
  Number of section headers:         19
  Section header string table index: 18
```

#if lang == "en" [
  `cargo-size` can print the size of the linker sections of the binary.
] else if lang == "de" [
  Mit `cargo-size` lässt sich die Größe der Linker-Abschnitte der
  Binärdatei anzeigen.
] else { todo }

```console
cargo size --bin app --release -- -A
```

#if lang == "en" [
  we use `--release` to inspect the optimized version
] else if lang == "de" [
  Wir verwenden `--release`, um die optimierte Version zu überprüfen.
] else { todo }

```text
app  :
section             size        addr
.vector_table       1024         0x0
.text                 92       0x400
.rodata                0       0x45c
.data                  0  0x20000000
.bss                   0  0x20000000
.debug_str          2958         0x0
.debug_loc            19         0x0
.debug_abbrev        567         0x0
.debug_info         4929         0x0
.debug_ranges         40         0x0
.debug_macinfo         1         0x0
.debug_pubnames     2035         0x0
.debug_pubtypes     1892         0x0
.ARM.attributes       46         0x0
.debug_frame         100         0x0
.debug_line          867         0x0
Total              14570
```

#quote(block: true)[
#if lang == "en" [
  A refresher on ELF linker sections
  - `.text` contains the program instructions
  - `.rodata` contains constant values like strings
  - `.data` contains statically allocated variables whose initial values
    are _not_ zero
  - `.bss` also contains statically allocated variables whose initial
    values _are_ zero
  - `.vector_table` is a _non_-standard section that we use to store
    the vector (interrupt) table
  - `.ARM.attributes` and the `.debug_*` sections contain metadata and
    will _not_ be loaded onto the target when flashing the binary.
] else if lang == "de" [
  Eine Auffrischung zum Thema ELF-Linker-Abschnitte
  - `.text` enthält die Programmbefehle
  - `.rodata` enthält konstante Werte wie Zeichenfolgen
  - `.data` enthält statisch zugewiesene Variablen, deren Anfangswerte
    _nicht_ Null
  - Die Datei `.bss` enthält außerdem statisch zugewiesene Variablen,
    deren Anfangswerte _sind_ Null
  - `.vector_table` ist ein _nicht_ standardmäßiger Abschnitt, in dem
    wir den Vektor speichern (interrupt) table
  - Die Abschnitte `.ARM.attributes` und `.debug_*` enthalten Metadaten
    und werden _nicht_ beim Flashen der Binärdatei auf das Zielgerät
    geladen werden.
] else { todo }
]

#if lang == "en" [
  *IMPORTANT*: ELF files contain metadata like debug information so
  their _size on disk_ does _not_ accurately reflect the space
  the program will occupy when flashed on a device. _Always_ use
  `cargo-size` to check how big a binary really is.
] else if lang == "de" [
  *WICHTIG*: ELF-Dateien enthalten Metadaten wie
  Debug-Informationen, sodass ihre _Größe auf der Festplatte_
  _nicht_ genau den Speicherplatz widerspiegelt, den das Programm
  beanspruchen wird, wenn es auf ein Gerät geflasht wird. Verwenden Sie
  _immer_ `cargo-size`, um zu überprüfen, wie groß eine Binärdatei
  tatsächlich ist.
]

#if lang == "en" [
`cargo-objdump` can be used to disassemble the binary.
] else if lang == "de" [
  Mit `cargo-objdump` lässt sich die Binärdatei disassemblieren.
]

```console
cargo objdump --bin app --release -- --disassemble --no-show-raw-insn --print-imm-hex
```

#quote(block: true)[
#let ln = link("https://github.com/rust-embedded/book/issues/269")
#if lang == "en" [
  *NOTE* if the above command complains about
  `Unknown command line argument` see the following bug report: #ln
] else if lang == "de" [
  *HINWEIS*: Falls der obige Befehl die Fehlermeldung „Unbekanntes
  Befehlszeilenargument" ausgibt, siehe den folgenden Fehlerbericht: #ln
] else { todo }
]

#quote(block: true)[
#if lang == "en" [
  *NOTE* this output can differ on your system. New versions of
  rustc, LLVM and libraries can generate different assembly. We truncated
  some of the instructions to keep the snippet small.
] else if lang == "de" [
  *HINWEIS* Diese Ausgabe kann auf Ihrem System abweichen. Neuere
  Versionen von rustc, LLVM und Bibliotheken können unterschiedlichen
  Assemblercode erzeugen. Wir haben einige der Befehle gekürzt, um den
  Ausschnitt kurz zu halten.
] else { todo }
]

```text
app:  file format ELF32-arm-little

Disassembly of section .text:
main:
     400: bl  #0x256
     404: b #-0x4 <main+0x4>

Reset:
     406: bl  #0x24e
     40a: movw  r0, #0x0
     < .. truncated any more instructions .. >

DefaultHandler_:
     656: b #-0x4 <DefaultHandler_>

UsageFault:
     657: strb  r7, [r4, #0x3]

DefaultPreInit:
     658: bx  lr

__pre_init:
     659: strb  r7, [r0, #0x1]

__nop:
     65a: bx  lr

HardFaultTrampoline:
     65c: mrs r0, msp
     660: b #-0x2 <HardFault_>

HardFault_:
     662: b #-0x4 <HardFault_>

HardFault:
     663: <unknown>
```

= #(if lang == "en" [Running]
  else if lang == "de" [Ausführen]
  else { todo })

#if lang == "en" [
  Next, let's see how to run an embedded program on QEMU! This time we'll
  use the `hello` example which actually does something. By default, this
  example uses `[defmt]` and RTT to print text.
] else if lang == "de" [
  Als Nächstes schauen wir uns an, wie man ein eingebettetes Programm auf
  QEMU ausführt! Diesmal verwenden wir das `hello`-Beispiel, das
  tatsächlich etwas tut. Standardmäßig nutzt dieses Beispiel `[defmt]` und
  RTT, um Text auszugeben.
] else { todo }

#quote(block: true)[
#if lang == "en" [
  *NOTE* `defmt` is a third-party dependency (i.e.~non-core) widely
  used in the Embedded Rust ecosystem.
] else if lang == "de" [
  *HINWEIS* `defmt` ist eine Abhängigkeit eines Drittanbieters
  (d. h. keine Kernkomponente), die im Embedded-Rust-Ökosystem weit
  verbreitet ist.
] else { todo }
]

#if lang == "en" [
  In order to read and decode the messages produced by `defmt` in the
  host, we need to switch the RTT transport output to semihosting. When
  using real hardware this requires a debug session but when using QEMU
  this Just Works.
] else if lang == "de" [
  Um die von `defmt` im Host erzeugten Nachrichten lesen und entschlüsseln
  zu können, müssen wir die RTT-Transportausgabe auf „Semihosting"
  umstellen. Bei Verwendung von echter Hardware erfordert dies eine
  Debug-Sitzung, bei Verwendung von QEMU funktioniert dies jedoch einfach
  so.
] else { todo }

#if lang == "en" [
  Let's switch the dependencies:
] else if lang == "de" [
  Stellen wir die Abhängigkeiten um:
] else { todo }

```console
cargo remove defmt-rtt
cargo add defmt-semihosting
```

#if lang == "en" [
  Open `src/lib.rs` and replace `use defmt_rtt as _;` by `use defmt_semihosting as _;`
] else if lang == "de" [
  Öffnen Sie `src/lib.rs` und ersetzen Sie `use defmt_rtt as _;` durch
  `use defmt_semihosting as _;`.
] else { todo }

#if lang == "en" [
  Now we can build the example:
] else if lang == "de" [
  Nun können wir das Beispiel kompilieren:
] else { todo }

```console
cargo build --bin hello
```

#if lang == "en" [
  The output binary will be located at `target/thumbv7m-none-eabi/debug/hello`.
] else if lang == "de" [
  Die ausgegebene Binärdatei befindet sich unter
  `target/thumbv7m-none-eabi/debug/hello`.
] else { todo }

#if lang == "en" [
  To run this binary on QEMU, the following command would be usually enough:
] else if lang == "de" [
  Um diese Binärdatei unter QEMU auszuführen, reicht in der Regel der
  folgende Befehl aus:
] else { todo }

```console
qemu-system-arm \
  -cpu cortex-m3 \
  -machine lm3s6965evb \
  -nographic \
  -semihosting-config enable=on,target=native \
  -kernel target/thumbv7m-none-eabi/debug/hello
```

#let ln_run = link("https://github.com/knurling-rs/defmt/tree/main/qemu-run/")[`qemu-run`]
#if lang == "en" [
  In our case, since we use `defmt`, the host will not be able to decode
  the output. Instead, we will need a tool by Ferrous Systems named #ln_run:
] else if lang == "de" [
  Da wir in unserem Fall `defmt` verwenden, kann der Host die Ausgabe
  nicht dekodieren. Stattdessen benötigen wir ein Werkzeug von Ferrous
  Systems namens #ln_run:
] else { todo }

```console
git clone git@github.com:knurling-rs/defmt.git
cd defmt/qemu-run/
cargo run -- --machine lm3s6965evb ../qemu-rs/target/thumbv7m-none-eabi/debug/hello
```

```text
Hello, world!
```

#if lang == "en" [
  The command should successfully exit (exit code = 0) after printing the
  text. On \*nix you can check that with the following command:
] else if lang == "de" [
  Der Befehl sollte nach der Ausgabe des Textes erfolgreich beendet werden
  (Exit-Code = 0). Unter \*nix können Sie dies mit dem folgenden Befehl überprüfen:
] else { todo }

```console
echo $?
```

```text
0
```

#if lang == "en" [
  Let's break down that QEMU command:
  - `qemu-system-arm`. This is the QEMU emulator. There are a few variants
    of these QEMU binaries; this one does full _system_ emulation of
    _ARM_ machines hence the name.
  - `-cpu cortex-m3`. This tells QEMU to emulate a Cortex-M3 CPU.
    Specifying the CPU model lets us catch some miscompilation errors: for
    example, running a program compiled for the Cortex-M4F, which has a
    hardware FPU, will make QEMU error during its execution.
  - `-machine lm3s6965evb`. This tells QEMU to emulate the LM3S6965EVB, an
    evaluation board that contains a LM3S6965 microcontroller.
  - `-nographic`. This tells QEMU to not launch its GUI.
  - `-semihosting-config (..)`. This tells QEMU to enable semihosting.
    Semihosting lets the emulated device, among other things, use the host
    stdout, stderr and stdin and create files on the host.
  - `-kernel $file`. This tells QEMU which binary to load and run on the
    emulated machine.
] else if lang == "de" [
  Schauen wir uns diesen QEMU-Befehl einmal genauer an:
  - `qemu-system-arm`. Dies ist der QEMU-Emulator. Es gibt einige
    Varianten dieser QEMU-Binärdateien; diese hier führt eine vollständige
    _System_-Emulation von _ARM_-Rechnern durch, daher der Name.
  - `-cpu cortex-m3`. Damit wird QEMU angewiesen, eine Cortex-M3-CPU zu
    emulieren. Durch die Angabe des CPU-Modells lassen sich einige
    Kompilierungsfehler erkennen: Wenn man beispielsweise ein Programm
    ausführt, das für den Cortex-M4F kompiliert wurde, der über eine
    Hardware-FPU verfügt, löst dies bei QEMU während der Ausführung einen Fehler aus.
  - `-machine lm3s6965evb`. Damit wird QEMU angewiesen, das LM3S6965EVB zu
    emulieren, ein Evaluierungsboard, das einen LM3S6965-Mikrocontroller enthält.
  - `-nographic`. Damit wird QEMU angewiesen, seine grafische
    Benutzeroberfläche nicht zu starten.
  - `-semihosting-config (..)`. Damit wird QEMU angewiesen, Semihosting zu
    aktivieren. Semihosting ermöglicht es dem emulierten Gerät unter
    anderem, die Host-Ausgabe (stdout), die Host-Fehlerausgabe (stderr)
    und die Host-Eingabe (stdin) zu nutzen sowie Dateien auf dem Host zu erstellen.
  - `-kernel $file`. Damit wird QEMU mitgeteilt, welche Binärdatei auf der
    emulierten Maschine geladen und ausgeführt werden soll.
] else { todo }

#if lang == "en" [
  Typing out that long QEMU command is too much work! We can set a custom
  runner to simplify the process. `.cargo/config.toml` has a commented out
  runner that invokes QEMU; let's uncomment it:
] else if lang == "de" [
  Das Eintippen dieses langen QEMU-Befehls ist viel zu mühsam! Wir können
  einen benutzerdefinierten Runner einrichten, um den Vorgang zu
  vereinfachen. In der Datei `.cargo/config.toml` gibt es einen
  auskommentierten Runner, der QEMU aufruft; entfernen wir die
  Auskommentierung:
] else { todo }

```console
head -n3 .cargo/config.toml
```

#raw(block: true, lang: "toml",
"[target.thumbv7m-none-eabi]
# " + if lang == "en" {
    "uncomment this to make `cargo run` execute programs on QEMU"
  } else if lang == "de" {
    "Entferne den Kommentar hier, damit `cargo run` Programme auf QEMU ausfuehrt"
  } else { todos } + "
runner = \"qemu-system-arm -cpu cortex-m3 -machine lm3s6965evb -nographic -semihosting-config enable=on,target=native -kernel\"
")

#if lang == "en" [
  This runner only applies to the `thumbv7m-none-eabi` target, which is
  our default compilation target. Now `cargo run` will compile the program
  and run it on QEMU:
] else if lang == "de" [
  Dieser Runner gilt nur für das Ziel `thumbv7m-none-eabi`, das unser
  Standard-Kompilierungsziel ist. Nun kompiliert `cargo run` das Programm
  und führt es auf QEMU aus:
] else { todo }

```console
cargo ru(
  level: 2 + whole
)--release
```

```text
   Compiling app v0.1.0 (file:///tmp/app)
    Finished release [optimized + debuginfo] target(s) in 0.26s
     Running `qemu-system-arm -cpu cortex-m3 -machine lm3s6965evb -nographic -semihosting-config enable=on,target=native -kernel target/thumbv7m-none-eabi/release/examples/hello`
Hello, world!
```

= #(if lang == "en" [Debugging]
  else if lang == "de" [Fehlerbehebung (Debugging)]
  else { todo })

#if lang == "en" [
  Debugging is critical to embedded development. Let's see how it's done.
] else if lang == "de" [
  Das Debuggen ist für die Embedded-Entwicklung von entscheidender
  Bedeutung. Schauen wir uns einmal an, wie es funktioniert.
] else { todo }

#if lang == "en" [
  Debugging an embedded device involves _remote_ debugging as the
  program that we want to debug won't be running on the machine that's
  running the debugger program (GDB or LLDB).
] else if lang == "de" [
  Das Debuggen eines Embedded-Geräts erfolgt _remote_, da das
  Programm, das wir debuggen möchten, nicht auf dem Rechner läuft, auf dem
  das Debugger-Programm (GDB oder LLDB) ausgeführt wird.
] else { todo }

#if lang == "en" [
  Remote debugging involves a client and a server. In a QEMU setup, the
  client will be a GDB (or LLDB) process and the server will be the QEMU
  process that's also running the embedded program.
] else if lang == "de" [
  Beim Remote-Debugging sind ein Client und ein Server beteiligt. In einer
  QEMU-Umgebung ist der Client ein GDB- (oder LLDB-)Prozess und der Server
  der QEMU-Prozess, auf dem auch das eingebettete Programm läuft.
] else { todo }

#if lang == "en" [
  In this section we'll use the `hello` example we already compiled.
] else if lang == "de" [
  In diesem Abschnitt verwenden wir das bereits kompilierte Beispiel `hello`.
] else { todo }

#if lang == "en" [
  The first debugging step is to launch QEMU in debugging mode:
] else if lang == "de" [
  Der erste Schritt beim Debuggen besteht darin, QEMU im Debugging-Modus zu starten:
] else { todo }

```console
qemu-system-arm \
  -cpu cortex-m3 \
  -machine lm3s6965evb \
  -nographic \
  -semihosting-config enable=on,target=native \
  -gdb tcp::3333 \
  -S \
  -kernel target/thumbv7m-none-eabi/debug/examples/hello
```

#if lang == "en" [
  This command won't print anything to the console and will block the
  terminal. We have passed two extra flags this time:
  - `-gdb tcp::3333`. This tells QEMU to wait for a GDB connection on TCP
    port 3333.
  - `-S`. This tells QEMU to freeze the machine at startup. Without this
    the program would have reached the end of main before we had a chance
    to launch the debugger!
] else if lang == "de" [
  Dieser Befehl gibt nichts auf der Konsole aus und blockiert das
  Terminal. Wir haben diesmal zwei zusätzliche Flags übergeben:
  - `-gdb tcp::3333`. Damit wird QEMU angewiesen, auf eine GDB-Verbindung
    über den TCP-Port 3333 zu warten.
  - `-S`. Damit wird QEMU angewiesen, die Maschine beim Start
    einzufrieren. Ohne diese Option hätte das Programm das Ende der
    Funktion `main` erreicht, bevor wir die Gelegenheit gehabt hätten, den
    Debugger zu starten!
] else { todo }

#if lang == "en" [
  Next we launch GDB in another terminal and tell it to load the debug
  symbols of the example:
] else if lang == "de" [
  Als Nächstes starten wir GDB in einem anderen Terminal und weisen es an,
  die Debug-Symbole des Beispiels zu laden:
] else { todo }

```console
gdb-multiarch -q target/thumbv7m-none-eabi/debug/examples/hello
```

#if lang == "en" [
  *NOTE*: you might need another version of gdb instead of
  `gdb-multiarch` depending on which one you installed in the installation
  chapter. This could also be `arm-none-eabi-gdb` or just `gdb`.
] else if lang == "de" [
  *HINWEIS*: Möglicherweise benötigen Sie anstelle von
  `gdb-multiarch` eine andere Version von gdb, je nachdem, welche Sie im
  Kapitel zur Installation installiert haben. Dies könnte auch
  `arm-none-eabi-gdb` oder einfach nur `gdb` sein.
] else { todo }

#if lang == "en" [
  Then within the GDB shell we connect to QEMU, which is waiting for a
  connection on TCP port 3333.
] else if lang == "de" [
  Anschließend stellen wir innerhalb der GDB-Shell eine Verbindung zu QEMU
  her, das auf dem TCP-Port 3333 auf eine Verbindung wartet.
] else { todo }

```console
target remote :3333
```

```text
Remote debugging using :3333
Reset () at $REGISTRY/cortex-m-rt-0.6.1/src/lib.rs:473
473     pub unsafe extern "C" fn Reset() -> ! {
```

#if lang == "en" [
  You'll see that the process is halted and that the program counter is
  pointing to a function named `Reset`. That is the reset handler: what
  Cortex-M cores execute upon booting.
] else if lang == "de" [
  Sie werden feststellen, dass der Prozess angehalten wurde und der
  Programmzähler auf eine Funktion namens `Reset` zeigt. Das ist der
  Reset-Handler: das, was Cortex-M-Kerne beim Booten ausführen.
] else { todo }

#quote(block: true)[
#if lang == "en" [
  Note that on some setup, instead of displaying the line
  `Reset () at $REGISTRY/cortex-m-rt-0.6.1/src/lib.rs:473` as shown above,
  gdb may print some warnings like:
] else if lang == "de" [
  Beachten Sie, dass gdb in manchen Konfigurationen anstelle der oben
  gezeigten Zeile `Reset () at $REGISTRY/cortex-m-rt-0.6.1/src/lib.rs:473`
  möglicherweise Warnungen wie die folgenden ausgibt:
] else { todo }

`core::num::bignum::Big32x40::mul_small () at src/libcore/num/bignum.rs:254`
`src/libcore/num/bignum.rs: No such file or directory.`

#if lang == "en" [
  That's a known glitch. You can safely ignore those warnings, you're most
  likely at Reset().
] else if lang == "de" [
  Das ist ein bekannter Fehler. Sie können diese Warnungen getrost
  ignorieren, da Sie sich höchstwahrscheinlich bei `Reset()` befinden.
] else { todo }
]

#if lang == "en" [
  This reset handler will eventually call our main function. Let's skip
  all the way there using a breakpoint and the `continue` command. To set
  the breakpoint, let's first take a look where we would like to break in
  our code, with the `list` command.
] else if lang == "de" [
  Dieser Reset-Handler ruft schließlich unsere Hauptfunktion auf. Lassen
  Sie uns den gesamten Weg dorthin mithilfe eines Haltepunkts und des
  Befehls `continue` überspringen. Um den Haltepunkt zu setzen, schauen
  wir uns zunächst mit dem Befehl `list` an, an welcher Stelle in unserem
  Code wir anhalten möchten.
] else { todo }

```console
list main
```

#if lang == "en" [
  This will show the source code, from the file examples/hello.rs.
] else if lang == "de" [
  Dadurch wird der Quellcode aus der Datei „examples/hello.rs" angezeigt.
] else { todo }

```text
6       use panic_halt as _;
7
8       use cortex_m_rt::entry;
9       use cortex_m_semihosting::{debug, hprintln};
10
11      #[entry]
12      fn main() -> ! {
13          hprintln!("Hello, world!").unwrap();
14
15          // exit QEMU
```

#if lang == "en" [
  We would like to add a breakpoint just before the "Hello, world!", which
  is on line 13. We do that with the `break` command:
] else if lang == "de" [
  Wir möchten einen Haltepunkt direkt vor „Hello, world!" setzen, das sich
  in Zeile 13 befindet. Dazu verwenden wir den Befehl `break`:
] else { todo }

```console
break 13
```

#if lang == "en" [
  We can now instruct gdb to run up to our main function, with the
  `continue` command:
] else if lang == "de" [
  Wir können gdb nun mit dem Befehl `continue` anweisen, bis zu unserer
  Hauptfunktion weiterzulaufen:
] else { todo }

```console
continue
```

```text
Continuing.

Breakpoint 1, hello::__cortex_m_rt_main () at examples\hello.rs:13
13          hprintln!("Hello, world!").unwrap();
```

#if lang == "en" [
  We are now close to the code that prints "Hello, world!". Let's move
  forward using the `next` command.
] else if lang == "de" [
  Wir sind nun fast bei dem Code angelangt, der „Hello, world!" ausgibt.
  Machen wir weiter mit dem Befehl `next`.
] else { todo }

```console
next
```

```text
16          debug::exit(debug::EXIT_SUCCESS);
```

#if lang == "en" [
  At this point you should see "Hello, world!" printed on the terminal
  that's running `qemu-system-arm`.
] else if lang == "de" [
  An dieser Stelle sollte auf dem Terminal, auf dem `qemu-system-arm`
  läuft, „Hello, world!" angezeigt werden.
] else { todo }

```text
$ qemu-system-arm (..)
Hello, world!
```

#if lang == "en" [
  Calling `next` again will terminate the QEMU process.
] else if lang == "de" [
  Ein erneuter Aufruf von `next` beendet den QEMU-Prozess.
] else { todo }

```console
next
```

```text
[Inferior 1 (Remote target) exited normally]
```

#if lang == "en" [
  You can now exit the GDB session.
] else if lang == "de" [
  Sie können die GDB-Sitzung nun beenden.
] else { todo }

```console
quit
```
