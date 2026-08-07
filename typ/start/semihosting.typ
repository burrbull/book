#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [Semihosting]
  else if lang == "de" [Semihosting]
  else { todo })

#if lang == "en" [
  Semihosting is a mechanism that lets embedded devices do I/O on the host
  and is mainly used to log messages to the host console. Semihosting
  requires a debug session and pretty much nothing else (no extra wires!)
  so it's super convenient to use. The downside is that it's super slow:
  each write operation can take several milliseconds depending on the
  hardware debugger (e.g.~ST-Link) you use.
] else if lang == "de" [
  Semihosting ist ein Mechanismus, der es eingebetteten Systemen
  ermöglicht, Ein-/Ausgabeoperationen über den eigenen Rechner (Host)
  durchzuführen; er wird hauptsächlich dazu genutzt, Meldungen auf der
  Host-Konsole zu protokollieren. Da Semihosting lediglich eine
  Debug-Sitzung und sonst so gut wie nichts (keine zusätzlichen Kabel!)
  erfordert, ist es äußerst komfortabel in der Anwendung. Der Nachteil ist
  jedoch die sehr geringe Geschwindigkeit: Je nach verwendetem
  Hardware-Debugger (z. B. ST-Link) kann jeder Schreibvorgang mehrere
  Millisekunden in Anspruch nehmen.
] else { todo }

#let ln_sh = link("https://crates.io/crates/cortex-m-semihosting")[`cortex-m-semihosting`]
#if lang == "en" [
  The #ln_sh crate provides an API to do semihosting
  operations on Cortex-M devices.
  The program below is the semihosting version of "Hello, world!":
] else if lang == "de" [
  Das #ln_sh;-Crate
  stellt eine API für Semihosting-Operationen auf Cortex-M-Geräten bereit.
  Das folgende Programm ist die Semihosting-Version von „Hello, world!":
] else { todo }

```rust
#![no_main]
#![no_std]

use panic_halt as _;

use cortex_m_rt::entry;
use cortex_m_semihosting::hprintln;

#[entry]
fn main() -> ! {
    hprintln!("Hello, world!").unwrap();

    loop {}
}
```

#if lang == "en" [
  If you run this program on hardware you'll see the "Hello, world!"
  message within the OpenOCD logs.
] else if lang == "de" [
  Wenn Sie dieses Programm auf der Hardware ausführen, sehen Sie die
  Meldung „Hello, world!" in den OpenOCD-Protokollen.
] else { todo }

```text
$ openocd
(..)
Hello, world!
(..)
```

#if lang == "en" [
  You do need to enable semihosting in OpenOCD from GDB first:
] else if lang == "de" [
  Sie müssen zunächst Semihosting in OpenOCD über GDB aktivieren:
] else { todo }

```console
(gdb) monitor arm semihosting enable
semihosting is enabled
```

#if lang == "en" [
  QEMU understands semihosting operations so the above program will also
  work with `qemu-system-arm` without having to start a debug session.
  Note that you'll need to pass the `-semihosting-config` flag to QEMU to
  enable semihosting support; these flags are already included in the
  `.cargo/config.toml` file of the template.
] else if lang == "de" [
  QEMU unterstützt Semihosting-Operationen, sodass das obige Programm auch
  mit `qemu-system-arm` funktioniert, ohne dass eine Debug-Sitzung
  gestartet werden muss. Beachten Sie, dass Sie QEMU die Option
  `-semihosting-config` übergeben müssen, um die Semihosting-Unterstützung
  zu aktivieren; diese Optionen sind bereits in der Datei
  `.cargo/config.toml` der Vorlage enthalten.
] else { todo }

#raw(block: true, lang: "text",
"$ # " + if lang == "en" {
    "this program will block the terminal"
  } else if lang == "de" {
    "Dieses Programm wird das Terminal blockieren."
  } else { todos } + "
$ cargo run
     Running `qemu-system-arm (..)
Hello, world!
")

#if lang == "en" [
  There's also an `exit` semihosting operation that can be used to
  terminate the QEMU process. Important: do *not* use `debug::exit`
  on hardware; this function can corrupt your OpenOCD session and you will
  not be able to debug more programs until you restart it.
] else if lang == "de" [
  Es gibt auch eine `exit`-Semihosting-Operation, mit der sich der
  QEMU-Prozess beenden lässt. Wichtig: Verwenden Sie `debug::exit`
  *nicht* auf echter Hardware; diese Funktion kann Ihre
  OpenOCD-Sitzung beschädigen, sodass Sie keine weiteren Programme mehr
  debuggen können, bis Sie die Sitzung neu starten.
] else { todo }

```rust
#![no_main]
#![no_std]

use panic_halt as _;

use cortex_m_rt::entry;
use cortex_m_semihosting::debug;

#[entry]
fn main() -> ! {
    let roses = "blue";

    if roses == "red" {
        debug::exit(debug::EXIT_SUCCESS);
    } else {
        debug::exit(debug::EXIT_FAILURE);
    }

    loop {}
}
```

```text
$ cargo run
     Running `qemu-system-arm (..)

$ echo $?
1
```

#if lang == "en" [
  One last tip: you can set the panicking behavior to
  `exit(EXIT_FAILURE)`. This will let you write `no_std` run-pass tests
  that you can run on QEMU.
] else if lang == "de" [
  Ein letzter Tipp: Du kannst das Verhalten bei einem Panic auf
  `exit(EXIT_FAILURE)` einstellen. Dadurch lassen sich `no_std`-Tests
  schreiben, die erfolgreich durchlaufen und unter QEMU ausgeführt werden
  können.
] else { todo }

#if lang == "en" [
  For convenience, the `panic-semihosting` crate has an "exit" feature
  that when enabled invokes `exit(EXIT_FAILURE)` after logging the panic
  message to the host stderr.
] else if lang == "de" [
  Praktischerweise bietet der `panic-semihosting`-Crate ein „exit"-Feature
  an; ist dieses aktiviert, wird `exit(EXIT_FAILURE)` aufgerufen, nachdem
  die Panic-Meldung auf dem `stderr` des Hosts ausgegeben wurde.
] else { todo }

```rust
#![no_main]
#![no_std]

use panic_semihosting as _; // features = ["exit"]

use cortex_m_rt::entry;
use cortex_m_semihosting::debug;

#[entry]
fn main() -> ! {
    let roses = "blue";

    assert_eq!(roses, "red");

    loop {}
}
```

```text
$ cargo run
     Running `qemu-system-arm (..)
panicked at 'assertion failed: `(left == right)`
  left: `"blue"`,
 right: `"red"`', examples/hello.rs:15:5

$ echo $?
1
```

#if lang == "en" [
  *NOTE*: To enable this feature on `panic-semihosting`, edit your
  `Cargo.toml` dependencies section where `panic-semihosting` is specified
  with:
] else if lang == "de" [
  *HINWEIS*: Um diese Funktion für `panic-semihosting` zu
  aktivieren, bearbeiten Sie den Abschnitt „dependencies" in Ihrer
  `Cargo.toml`, in dem `panic-semihosting` wie folgt angegeben ist:
] else { todo }

```toml
panic-semihosting = { version = "VERSION", features = ["exit"] }
```

#if lang == "en" [
  where `VERSION` is the version desired. For more information on
  dependencies features check the
  #link("https://doc.rust-lang.org/cargo/reference/specifying-dependencies.html")[`specifying dependencies`]
  section of the Cargo book.
] else if lang == "de" [
  wobei `VERSION` für die gewünschte Version steht. Weitere Informationen
  zu Abhängigkeiten und Funktionen finden Sie im Abschnitt
  "#link("https://doc.rust-lang.org/cargo/reference/specifying-dependencies.html")[`specifying dependencies`]"
  des Cargo-Buchs.
] else { todo }
