#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [Panicking]
  else if lang == "de" [In Panik geraten]
  else { todo })
<getting-started-panicking>
#set heading(offset: whole*2)

#if lang == "en" [
  Panicking is a core part of the Rust language. Built-in operations like
  indexing are runtime checked for memory safety. When out of bounds
  indexing is attempted this results in a panic.
] else if lang == "de" [
  Das Auslösen einer Panik ist ein wesentlicher Bestandteil der Sprache
  Rust. Eingebaute Operationen wie der Zugriff per Index werden zur
  Laufzeit auf Speichersicherheit überprüft. Erfolgt ein Zugriff außerhalb
  der zulässigen Grenzen, führt dies zu einer Panik.
] else { todo }

#if lang == "en" [
  In the standard library panicking has a defined behavior: it unwinds the
  stack of the panicking thread, unless the user opted for aborting the
  program on panics.
] else if lang == "de" [
  In der Standardbibliothek ist das Verhalten bei einer Panik definiert:
  Der Stack des betroffenen Threads wird abgewickelt (Stack Unwinding), es
  sei denn, der Benutzer hat sich für einen Programmabbruch im Falle einer
  Panik entschieden.
] else { todo }

#let ln_info = link("https://doc.rust-lang.org/core/panic/struct.PanicInfo.html")[`PanicInfo`]
#if lang == "en" [
  In programs without standard library, however, the panicking behavior is
  left undefined. A behavior can be chosen by declaring a
  `#[panic_handler]` function. This function must appear exactly
  _once_ in the dependency graph of a program, and must have the
  following signature: `fn(&PanicInfo) -> !`, where #ln_info
  is a struct containing information about the location of the panic.
] else if lang == "de" [
  In Programmen ohne Standardbibliothek ist das Verhalten bei einer Panik
  hingegen nicht definiert. Ein Verhalten lässt sich durch die Deklaration
  einer `#[panic_handler]`-Funktion festlegen. Diese Funktion muss im
  Abhängigkeitsgraphen des Programms genau _einmal_ vorkommen und
  folgende Signatur aufweisen: `fn(&PanicInfo) -> !`, wobei #ln_info
  eine Struktur ist, die Informationen über den Ort des Panic enthält.
] else { todo }

#let ln_abort = link("https://crates.io/crates/panic-abort")[`panic-abort`]
#let ln_halt = link("https://crates.io/crates/panic-halt")[`panic-halt`]
#let ln_itm = link("https://crates.io/crates/panic-itm")[`panic-itm`]
#let ln_sh = link("https://crates.io/crates/panic-semihosting")[`panic-semihosting`]
#if lang == "en" [
  Given that embedded systems range from user facing to safety critical
  (cannot crash) there's no one size fits all panicking behavior but there
  are plenty of commonly used behaviors. These common behaviors have been
  packaged into crates that define the `#[panic_handler]` function. Some
  examples include:
  - #ln_abort. A panic causes the abort instruction to be executed.
  - #ln_halt. A panic causes the program, or the current thread, to halt by entering an infinite loop.
  - #ln_itm. The panicking message is logged using the ITM, an ARM Cortex-M specific peripheral.
  - #ln_sh. The panicking message is logged to the host using the semihosting technique.
] else if lang == "de" [
  Da das Spektrum eingebetteter Systeme von anwenderorientierten bis hin
  zu sicherheitskritischen Anwendungen (bei denen ein Absturz
  ausgeschlossen sein muss) reicht, gibt es kein universelles Verhalten im
  Fehlerfall („Panic"); es existieren jedoch zahlreiche gängige Ansätze.
  Diese verbreiteten Verhaltensweisen wurden in Crates zusammengefasst,
  die die Funktion `#[panic_handler]` definieren. Zu den Beispielen
  gehören:
  - #ln_abort. Eine Panic bewirkt die Ausführung der Abbruchanweisung.
  - #ln_halt. Ein Panic bewirkt, dass das Programm oder der aktuelle
    Thread anhält, indem es bzw. er in eine Endlosschleife eintritt.
  - #ln_itm. Die Panik-Meldung wird mithilfe des ITM protokolliert -- einer für ARM
    Cortex-M spezifischen Peripheriekomponente.
  - #ln_sh. Die Panik-Meldung wird mithilfe der Semihosting-Technik
    auf dem Host protokolliert.
] else { todo }

#let ln_handler = link("https://crates.io/keywords/panic-handler")[`panic-handler`]
#if lang == "en" [
  You may be able to find even more crates searching for the
  #ln_handler keyword on crates.io.
] else if lang == "de" [
  Möglicherweise findest du noch mehr Crates, wenn du auf crates.io nach
  dem Schlüsselwort #ln_handler suchst.
] else { todo }

#if lang == "en" [
  A program can pick one of these behaviors simply by linking to the
  corresponding crate. The fact that the panicking behavior is expressed
  in the source of an application as a single line of code is not only
  useful as documentation but can also be used to change the panicking
  behavior according to the compilation profile. For example:
] else if lang == "de" [
  Ein Programm kann eines dieser Verhalten einfach dadurch auswählen, dass
  es das entsprechende Crate einbindet. Dass das Verhalten im Fehlerfall
  (Panic-Verhalten) im Quellcode einer Anwendung als einzelne Codezeile
  ausgedrückt wird, ist nicht nur als Dokumentation nützlich, sondern
  ermöglicht es auch, dieses Verhalten je nach Kompilierungsprofil
  anzupassen. Zum Beispiel:
] else { todo }

#raw(block: true, lang: "rust",
"#![no_main]
#![no_std]

// " + if lang == "en" {
    "dev profile: easier to debug panics; can put a breakpoint on `rust_begin_unwind`"
  } else if lang == "de" {
    "dev-Profil: einfacheres Debuggen von Panics; man kann einen Breakpoint bei 
// `rust_begin_unwind` setzen."
  } else { todos } + "
#[cfg(debug_assertions)]
use panic_halt as _;

// " + if lang == "en" {
    "release profile: minimize the binary size of the application"
  } else if lang == "de" {
    "Release-Profil: Minimierung der Binaergroesse der Anwendung"
  } else { todos } + "
#[cfg(not(debug_assertions))]
use panic_abort as _;

// ..
")

#if lang == "en" [
  In this example the crate links to the `panic-halt` crate when built
  with the dev profile (`cargo build`), but links to the `panic-abort`
  crate when built with the release profile (`cargo build --release`).
] else if lang == "de" [
In diesem Beispiel verlinkt der Crate beim Bauen mit dem Dev-Profil
(`cargo build`) auf den `panic-halt`-Crate, beim Bauen mit dem
Release-Profil (`cargo build --release`) hingegen auf den
`panic-abort`-Crate.
] else { todo }

#quote(block: true)[
#if lang == "en" [
  The `use panic_abort as _;` form of the `use` statement is used to
  ensure the `panic_abort` panic handler is included in our final
  executable while making it clear to the compiler that we won't
  explicitly use anything from the crate. Without the `as _` rename, the
  compiler would warn that we have an unused import. Sometimes you might
  see `extern crate panic_abort` instead, which is an older style used
  before the 2018 edition of Rust, and should now only be used for
  "sysroot" crates (those distributed with Rust itself) such as
  `proc_macro`, `alloc`, `std`, and `test`.
] else if lang == "de" [
  Die `use panic_abort as _;`-Variante der `use`-Anweisung wird verwendet,
  um sicherzustellen, dass der `panic_abort`-Panic-Handler in die fertige
  ausführbare Datei aufgenommen wird, während dem Compiler gleichzeitig
  signalisiert wird, dass wir nichts aus diesem Crate explizit verwenden
  werden. Ohne die Umbenennung mittels `as _` würde der Compiler eine
  Warnung wegen eines ungenutzten Imports ausgeben. Gelegentlich stößt man
  stattdessen auf `extern crate panic_abort`\; dabei handelt es sich um
  einen älteren Stil, der vor der Rust-Edition 2018 üblich war und heute
  nur noch für sogenannte „sysroot"-Crates (die gemeinsam mit Rust selbst
  ausgeliefert werden) -- wie etwa `proc_macro`, `alloc`, `std` und `test`
  -- verwendet werden sollte.
] else { todo }
]

= #(if lang == "en" [An example]
  else if lang == "de" [Ein Beispiel]
  else { todo })

#if lang == "en" [
  Here's an example that tries to index an array beyond its length. The
  operation results in a panic.
] else if lang == "de" [
  Hier ist ein Beispiel, das versucht, auf ein Array an einer Position
  zuzugreifen, die über dessen Länge hinausgeht. Der Vorgang führt zu einer Panic.
] else { todo }

#raw(block: true, lang: "rust",
"#![no_main]
#![no_std]

use panic_semihosting as _;

use cortex_m_rt::entry;

#[entry]
fn main() -> ! {
    let xs = [0, 1, 2];
    let i = xs.len();
    let _y = xs[i]; // " + if lang == "en" {
                        "out of bounds access"
                      } else if lang == "de" {
                        "Zugriff ausserhalb der zulaessigen Grenzen"
                      } else { todos } + "

    loop {}
}
")

#if lang == "en" [
  This example chose the `panic-semihosting` behavior which prints the
  panic message to the host console using semihosting.
] else if lang == "de" [
Für dieses Beispiel wurde das Verhalten `panic-semihosting` gewählt, das
die Panic-Meldung mittels Semihosting auf der Host-Konsole ausgibt.
] else { todo }

```text
$ cargo run
     Running `qemu-system-arm -cpu cortex-m3 -machine lm3s6965evb (..)
panicked at 'index out of bounds: the len is 3 but the index is 4', src/main.rs:12:13
```

#if lang == "en" [
  You can try changing the behavior to `panic-halt` and confirm that no
  message is printed in that case.
] else if lang == "de" [
Sie können versuchen, das Verhalten auf `panic-halt` zu ändern, und
bestätigen, dass in diesem Fall keine Meldung ausgegeben wird.
] else { todo }
