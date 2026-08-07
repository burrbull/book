#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [A little C with your Rust]
  else if lang == "de" [Ein bisschen C zu Ihrem Rust]
  else { todo })
<c-with-rust>

#if lang == "en" [
  Using C or C++ inside of a Rust project consists of two major parts:
  - Wrapping the exposed C API for use with Rust
  - Building your C or C++ code to be integrated with the Rust code
] else if lang == "de" [
  Die Verwendung von C oder C++ innerhalb eines Rust-Projekts umfasst zwei
  wesentliche Aspekte:
  - Einkapselung der bereitgestellten C-API für die Verwendung mit Rust
  - Erstellen Ihres C- oder C++-Codes zur Integration mit dem Rust-Code
] else { todo }

#if lang == "en" [
  As C++ does not have a stable ABI for the Rust compiler to target, it is
  recommended to use the `C` ABI when combining Rust with C or C++.
] else if lang == "de" [
  Da C++ über keine stabile ABI verfügt, auf die der Rust-Compiler
  abzielen könnte, wird empfohlen, bei der Kombination von Rust mit C oder
  C++ die `C`-ABI zu verwenden.
] else { todo }

= #(if lang == "en" [Defining the interface]
  else if lang == "de" [Definition der Schnittstelle]
  else { todo })

#if lang == "en" [
  Before consuming C or C++ code from Rust, it is necessary to define (in
  Rust) what data types and function signatures exist in the linked code.
  In C or C++, you would include a header (`.h` or `.hpp`) file which
  defines this data. In Rust, it is necessary to either manually translate
  these definitions to Rust, or use a tool to generate these definitions.
] else if lang == "de" [
  Bevor C- oder C++-Code aus Rust heraus verwendet werden kann, muss (in
  Rust) definiert werden, welche Datentypen und Funktionssignaturen im
  verlinkten Code vorhanden sind. In C oder C++ würde man eine
  Header-Datei (`.h` oder `.hpp`) einbinden, die diese Daten definiert. In
  Rust ist es erforderlich, diese Definitionen entweder manuell nach Rust
  zu übertragen oder ein Werkzeug zu ihrer Generierung zu verwenden.
] else { todo }

#if lang == "en" [
  First, we will cover manually translating these definitions from C/C++
  to Rust.
] else if lang == "de" [
  Zunächst behandeln wir die manuelle Übertragung dieser Definitionen von
  C/C++ nach Rust.
] else { todo }

== #(if lang == "en" [Wrapping C functions and Datatypes]
  else if lang == "de" [Einbinden von C-Funktionen und -Datentypen]
  else { todo })

#if lang == "en" [
  Typically, libraries written in C or C++ will provide a header file
  defining all types and functions used in public interfaces. An example
  file may look like this:
] else if lang == "de" [
  Typischerweise stellen in C oder C++ geschriebene Bibliotheken eine
  Header-Datei bereit, die alle in öffentlichen Schnittstellen verwendeten
  Typen und Funktionen definiert. Eine Beispieldatei könnte wie folgt
  aussehen:
] else { todo }

```c
/* File: cool.h */
typedef struct CoolStruct {
    int x;
    int y;
} CoolStruct;

void cool_function(int i, char c, CoolStruct* cs);
```

#if lang == "en" [
  When translated to Rust, this interface would look as such:
] else if lang == "de" [
  Nach Rust übertragen, sähe diese Schnittstelle folgendermaßen aus:
] else { todo }

```rust
/* File: cool_bindings.rs */
#[repr(C)]
pub struct CoolStruct {
    pub x: cty::c_int,
    pub y: cty::c_int,
}

extern "C" {
    pub fn cool_function(
        i: cty::c_int,
        c: cty::c_char,
        cs: *mut CoolStruct
    );
}
```

#if lang == "en" [
  Let's take a look at this definition one piece at a time, to explain
  each of the parts.
] else if lang == "de" [
  Schauen wir uns diese Definition Schritt für Schritt an, um die
  einzelnen Bestandteile zu erläutern.
] else { todo }

```rust
#[repr(C)]
pub struct CoolStruct { ... }
```

#if lang == "en" [
  By default, Rust does not guarantee order, padding, or the size of data
  included in a `struct`. In order to guarantee compatibility with C code,
  we include the `#[repr(C)]` attribute, which instructs the Rust compiler
  to always use the same rules C does for organizing data within a struct.
] else if lang == "de" [
  Standardmäßig garantiert Rust weder die Reihenfolge noch das Padding
  oder die Größe der in einer `struct` enthaltenen Daten. Um die
  Kompatibilität mit C-Code zu gewährleisten, verwenden wir das Attribut
  `#[repr(C)]`; dieses weist den Rust-Compiler an, für die Anordnung der
  Daten innerhalb der Struktur stets dieselben Regeln wie C anzuwenden.
] else { todo }


```rust
pub x: cty::c_int,
pub y: cty::c_int,
```

#if lang == "en" [
  Due to the flexibility of how C or C++ defines an `int` or `char`, it is
  recommended to use primitive data types defined in `cty`, which will map
  types from C to types in Rust.
] else if lang == "de" [
  Aufgrund der Flexibilität, wie C oder C++ ein „int" oder „char"
  definiert, wird empfohlen, in „cty" definierte primitive Datentypen zu
  verwenden, die Typen von C auf Typen in Rust abbilden.
] else { todo }

```rust
extern "C" { pub fn cool_function( ... ); }
```

#if lang == "en" [
  This statement defines the signature of a function that uses the C ABI,
  called `cool_function`. By defining the signature without defining the
  body of the function, the definition of this function will need to be
  provided elsewhere, or linked into the final library or binary from a
  static library.
] else if lang == "de" [
  Diese Anweisung definiert die Signatur einer Funktion namens
  `cool_function`, die die C-ABI verwendet. Da die Signatur ohne den
  Funktionsrumpf definiert wird, muss die eigentliche Funktionsdefinition
  an anderer Stelle bereitgestellt oder aus einer statischen Bibliothek in
  die endgültige Bibliothek bzw. das fertige Binärprogramm eingebunden
  werden.
] else { todo }

```rust
    i: cty::c_int,
    c: cty::c_char,
    cs: *mut CoolStruct
```

#if lang == "en" [
  Similar to our datatype above, we define the datatypes of the function
  arguments using C-compatible definitions. We also retain the same
  argument names, for clarity.
] else if lang == "de" [
  Ähnlich wie bei unserem obigen Datentyp definieren wir die Datentypen
  der Funktionsargumente mithilfe von C-kompatiblen Definitionen. Der
  Übersichtlichkeit halber behalten wir zudem die ursprünglichen
  Argumentnamen bei.
] else { todo }

#if lang == "en" [
  We have one new type here, `*mut CoolStruct`. As C does not have a
  concept of Rust's references, which would look like this:
  `&mut CoolStruct`, we instead have a raw pointer. As dereferencing this
  pointer is `unsafe`, and the pointer may in fact be a `null` pointer,
  care must be taken to ensure the guarantees typical of Rust when
  interacting with C or C++ code.
] else if lang == "de" [
  Hier begegnet uns ein neuer Typ: `*mut CoolStruct`. Da C das Konzept der
  Rust-Referenzen (die etwa so aussehen: `&mut CoolStruct`) nicht kennt,
  verwenden wir stattdessen einen sogenannten „Raw Pointer" (Rohzeiger).
  Da das Dereferenzieren dieses Zeigers als `unsafe` gilt und es sich
  tatsächlich um einen `null`-Zeiger handeln kann, ist bei der Interaktion
  mit C- oder C++-Code besondere Sorgfalt geboten, um die für Rust
  typischen Garantien zu wahren.
] else { todo }

== #(if lang == "en" [Automatically generating the interface]
  else if lang == "de" [Automatische Generierung der Schnittstelle]
  else { todo })

#let url_bindgen = "https://github.com/rust-lang/rust-bindgen"
#let ln_cty = link("https://crates.io/crates/cty")[`cty`]
#if lang == "en" [
  Rather than manually generating these interfaces, which may be tedious
  and error prone, there is a tool called
  #link(url_bindgen)[bindgen] which will
  perform these conversions automatically. For instructions of the usage
  of #link(url_bindgen)[bindgen], please
  refer to the #link(url_bindgen)[bindgen user's manual],
  however the typical process consists of the following:
  + Gather all C or C++ headers defining interfaces or datatypes you would
    like to use with Rust.
  + Write a `bindings.h` file, which `#include "..."`'s each of the files
    you gathered in step one.
  + Feed this `bindings.h` file, along with any compilation flags used to
    compile your code into `bindgen`. Tip: use
    `Builder.ctypes_prefix("cty")` / `--ctypes-prefix=cty` and
    `Builder.use_core()` / `--use-core` to make the generated code
    `#![no_std]` compatible.
  + `bindgen` will produce the generated Rust code to the output of the
    terminal window. This output may be piped to a file in your project,
    such as `bindings.rs`. You may use this file in your Rust project to
    interact with C/C++ code compiled and linked as an external library.
    Tip: don't forget to use the #ln_cty crate if your types in
    the generated bindings are prefixed with `cty`.
] else if lang == "de" [
  Anstatt diese Schnittstellen manuell zu erstellen -- was mühsam und
  fehleranfällig sein kann --, gibt es ein Werkzeug namens
  #link(url_bindgen)[bindgen], das diese
  Konvertierungen automatisch durchführt. Hinweise zur Verwendung von
  #link(url_bindgen)[bindgen] finden Sie im
  #link(url_bindgen)[bindgen-Benutzerhandbuch]\;
  der typische Ablauf sieht jedoch folgendermaßen aus:
  + Sammeln Sie alle C- oder C++-Header, die Schnittstellen oder
    Datentypen definieren, die Sie mit Rust verwenden möchten.
  + Erstelle eine Datei namens `bindings.h`, die mittels `#include "..."`
    jede der Dateien einbindet, die du in Schritt eins zusammengetragen
    hast.
  + Übergeben Sie diese `bindings.h`-Datei zusammen mit den für die
    Kompilierung Ihres Codes verwendeten Flags an `bindgen`. Tipp:
    Verwenden Sie `Builder.ctypes_prefix("cty")` / `--ctypes-prefix=cty`
    und `Builder.use_core()` / `--use-core`, um den generierten Code
    `#![no_std]`-kompatibel zu machen.
  + `bindgen` gibt den generierten Rust-Code direkt im Terminal aus. Diese
    Ausgabe lässt sich in eine Datei Ihres Projekts umleiten,
    beispielsweise `bindings.rs`. Sie können diese Datei in Ihrem
    Rust-Projekt verwenden, um mit C/C++-Code zu interagieren, der als
    externe Bibliothek kompiliert und gelinkt wurde. Tipp: Vergessen Sie
    nicht, das #ln_cty;-Crate zu
    verwenden, falls die Typen in den generierten Bindings das Präfix
    `cty` aufweisen.
] else { todo }

= #(if lang == "en" [Building your C/C++ code]
  else if lang == "de" [Erstellen Ihres C/C++-Codes]
  else { todo })

#if lang == "en" [
  As the Rust compiler does not directly know how to compile C or C++ code
  (or code from any other language, which presents a C interface), it is
  necessary to compile your non-Rust code ahead of time.
] else if lang == "de" [
  Da der Rust-Compiler nicht direkt weiß, wie man C- oder C++-Code (oder
  Code einer anderen Sprache mit C-Schnittstelle) kompiliert, muss der
  Nicht-Rust-Code vorab kompiliert werden.
] else { todo }

#if lang == "en" [
  For embedded projects, this most commonly means compiling the C/C++ code
  to a static archive (such as `cool-library.a`), which can then be
  combined with your Rust code at the final linking step.
] else if lang == "de" [
  Bei Embedded-Projekten bedeutet dies meist, dass der C/C++-Code zu einem
  statischen Archiv (z. B. `cool-library.a`) kompiliert wird, welches dann
  im abschließenden Link-Schritt mit dem Rust-Code zusammengeführt werden
  kann.
] else { todo }

#if lang == "en" [
  If the library you would like to use is already distributed as a static
  archive, it is not necessary to rebuild your code. Just convert the
  provided interface header file as described above, and include the
  static archive at compile/link time.
] else if lang == "de" [
  Wenn die gewünschte Bibliothek bereits als statisches Archiv vorliegt,
  ist eine erneute Kompilierung des Codes nicht erforderlich. Es genügt,
  die bereitgestellte Header-Datei für die Schnittstelle wie oben
  beschrieben umzuwandeln und das statische Archiv beim Kompilieren bzw.
  Linken einzubinden.
] else { todo }

#if lang == "en" [
  If your code exists as a source project, it will be necessary to compile
  your C/C++ code to a static library, either by triggering your existing
  build system (such as `make`, `CMake`, etc.), or by porting the
  necessary compilation steps to use a tool called the `cc` crate. For
  both of these steps, it is necessary to use a `build.rs` script.
] else if lang == "de" [
  Liegt der Code als Quellcode-Projekt vor, muss der C/C++-Code in eine
  statische Bibliothek kompiliert werden. Dies kann entweder durch Aufruf
  des vorhandenen Build-Systems (z. B. `make`, `CMake` usw.) oder durch
  Portierung der erforderlichen Kompilierungsschritte auf das sogenannte
  `cc`-Crate erfolgen. Für beide Vorgehensweisen ist die Verwendung eines
  `build.rs`-Skripts erforderlich.
] else { todo }

== #(if lang == "en" [Rust `build.rs` build scripts]
  else if lang == "de" [Rust-`build.rs`-Build-Skripte]
  else { todo })

#if lang == "en" [
  A `build.rs` script is a file written in Rust syntax, that is executed
  on your compilation machine, AFTER dependencies of your project have
  been built, but BEFORE your project is built.
] else if lang == "de" [
  Ein `build.rs`-Skript ist eine in Rust-Syntax verfasste Datei, die auf
  dem Kompilierrechner ausgeführt wird -- und zwar _nachdem_ die
  Abhängigkeiten Ihres Projekts erstellt wurden, aber _bevor_ Ihr
  Projekt selbst kompiliert wird.
] else { todo }

#let url_build_scripts = "https://doc.rust-lang.org/cargo/reference/build-scripts.html"
#if lang == "en" [
  The full reference may be found #link(url_build_scripts)[here].
  `build.rs` scripts are useful for generating code
  (such as via #link(url_bindgen)[bindgen]), calling
  out to external build systems such as `Make`, or directly compiling
  C/C++ through use of the `cc` crate.
] else if lang == "de" [
  Die vollständige Referenz finden Sie #link(url_build_scripts)[hier].
  `build.rs`-Skripte eignen sich beispielsweise zur Code-Generierung (etwa
  mittels #link(url_bindgen)[bindgen]),
  zum Aufruf externer Build-Systeme wie `Make` oder zur direkten
  Kompilierung von C/C++-Code unter Verwendung des `cc`-Crates.
] else { todo }

== #(if lang == "en" [Triggering external build systems]
  else if lang == "de" [Auslösen externer Build-Systeme]
  else { todo })

#let ln_command = link("https://doc.rust-lang.org/std/process/struct.Command.html")[`std::process::Command`]
#if lang == "en" [
  For projects with complex external projects or build systems,
  it may be easiest to use #ln_command
  to "shell out" to your other build systems by traversing relative paths,
  calling a fixed command (such as `make library`), and then copying the
  resulting static library to the proper location in the `target` build
  directory.
] else if lang == "de" [
  Bei Projekten, die komplexe externe Projekte oder Build-Systeme
  einbinden, ist es oft am einfachsten, #ln_command
  zu verwenden, um andere Build-Systeme aufzurufen (sogenanntes
  „Shelling-out"). Dabei navigieren Sie über relative Pfade, führen einen
  festen Befehl aus (wie etwa `make library`) und kopieren anschließend
  die erzeugte statische Bibliothek an den entsprechenden Ort im
  `target`-Build-Verzeichnis.
] else { todo }

#if lang == "en" [
  While your crate may be targeting a `no_std` embedded platform, your
  `build.rs` executes only on machines compiling your crate. This means
  you may use any Rust crates which will run on your compilation host.
] else if lang == "de" [
  Auch wenn Ihre Crate für eine eingebettete Plattform ohne
  Standardbibliothek (`no_std`) gedacht ist, wird die `build.rs`
  ausschließlich auf dem Rechner ausgeführt, der die Crate kompiliert. Das
  bedeutet, dass Sie beliebige Rust-Crates verwenden können, die auf Ihrem
  Kompilier-Host lauffähig sind.
] else { todo }

== #(if lang == "en" [Building C/C++ code with the `cc` crate]
  else if lang == "de" [Kompilieren von C/C++-Code mit dem `cc`-Crate]
  else { todo })

#let url_cc = "https://github.com/alexcrichton/cc-rs"
#if lang == "en" [
  For projects with limited dependencies or complexity, or for projects
  where it is difficult to modify the build system to produce a static
  library (rather than a final binary or executable), it may be easier to
  instead utilize the #link(url_cc)[`cc` crate], which
  provides an idiomatic Rust interface to the compiler provided by the
  host.
] else if lang == "de" [
  Bei Projekten mit geringen Abhängigkeiten oder überschaubarer
  Komplexität -- oder wenn es schwierig ist, das Build-System so
  anzupassen, dass eine statische Bibliothek (statt einer fertigen
  Binärdatei oder eines ausführbaren Programms) erzeugt wird -- kann es
  einfacher sein, stattdessen das
  #link(url_cc)[`cc`-Crate] zu verwenden;
  dieses bietet eine idiomatische Rust-Schnittstelle zu dem vom Host
  bereitgestellten Compiler.
] else { todo }

#if lang == "en" [
  In the simplest case of compiling a single C file as a dependency to a
  static library, an example `build.rs` script using the
  #link(url_cc)[`cc` crate] would look like this:
] else if lang == "de" [
  Im einfachsten Fall, bei dem eine einzelne C-Datei als Abhängigkeit für
  eine statische Bibliothek kompiliert wird, sähe ein Beispiel für ein
  `build.rs`-Skript, das das
  #link(url_cc)[`cc`-Crate] verwendet,
  folgendermaßen aus:
] else { todo }

```rust
fn main() {
    cc::Build::new()
        .file("src/foo.c")
        .compile("foo");
}
```

#if lang == "en" [
  The `build.rs` is placed at the root of the package. Then `cargo build`
  will compile and execute it before the build of the package. A static
  archive named `libfoo.a` is generated and placed in the `target` directory.
] else if lang == "de" [
  Die Datei `build.rs` befindet sich im Wurzelverzeichnis des Pakets.
  `cargo build` kompiliert und führt sie dann vor dem eigentlichen
  Build-Vorgang des Pakets aus. Dabei wird ein statisches Archiv namens
  `libfoo.a` erstellt und im Verzeichnis `target` abgelegt.
] else { todo }
