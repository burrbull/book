#import "../config.typ": *

#h1(if lang == "en" [Interoperability]
  else if lang == "de" [Interoperabilität]
  else { todo })

#let ln_ffi = link("https://doc.rust-lang.org/std/ffi/index.html")[`std::ffi`]
#if lang == "en" [
  Interoperability between Rust and C code is always dependent on
  transforming data between the two languages. For this purpose, there is
  a dedicated module in the `stdlib` called #ln_ffi.
] else if lang == "de" [
  Die Interoperabilität zwischen Rust- und C-Code hängt stets von der
  Umwandlung von Daten zwischen den beiden Sprachen ab. Hierfür gibt es in
  der Standardbibliothek (`stdlib`) ein spezielles Modul namens #ln_ffi.
] else { todo }

#if lang == "en" [
  `std::ffi` provides type definitions for C primitive types, such as
  `char`, `int`, and `long`. It also provides some utility for converting
  more complex types such as strings, mapping both `&str` and `String` to
  C types that are easier and safer to handle.
] else if lang == "de" [
  `std::ffi` stellt Typdefinitionen für primitive C-Datentypen bereit, wie
  etwa `char`, `int` und `long`. Zudem bietet es Hilfsmittel zur
  Konvertierung komplexerer Typen wie Strings, indem es sowohl `&str` als
  auch `String` auf C-Typen abbildet, die sich einfacher und sicherer
  handhaben lassen.
] else { todo }

#let ln_cty = link("https://crates.io/crates/cty")[`cty`]
#let ln_cstr = link("https://crates.io/crates/cstr_core")[`cstr_core`]
#if lang == "en" [
  As of Rust 1.30, functionalities of `std::ffi` are available in either
  `core::ffi` or `alloc::ffi` depending on whether or not memory
  allocation is involved. The #ln_cty crate and the #ln_cstr
  crate also offer similar functionalities.
] else if lang == "de" [
  Seit Rust 1.30 stehen die Funktionalitäten von `std::ffi` wahlweise in
  `core::ffi` oder `alloc::ffi` zur Verfügung, je nachdem, ob
  Speicherreservierungen erforderlich sind oder nicht.
  Auch die Crates #ln_cty und #ln_cstr bieten vergleichbare Funktionalitäten an.
] else { todo }

#figure(
  kind: table,
  table(
    columns: 3,
    align: (auto,auto,auto,),
    table.header(
      if lang == "en" [Rust type]
      else if lang == "de" [Rusttyp]
      else { todo },
      if lang == "en" [Intermediate]
      else if lang == "de" [Dazwischenliegend]
      else { todo },
      if lang == "en" [C type]
      else if lang == "de" [C-Typ]
      else { todo },
    ),
    `String`, `CString`, `char *`,
    `&str`, `CStr`, `const char *`,
    `()`, `c_void`, `void`,
    if lang in ("en", "de") [`u32` or `u64`]
    else { todo },
    `c_uint`, `unsigned int`,
    if lang == "en" [etc]
    else if lang == "de" [usw.]
    else { todo },
    […], […],
  )
)

#if lang == "en" [
  A value of a C primitive type can be used as one of the corresponding
  Rust type and vice versa, since the former is simply a type alias of the
  latter. For example, the following code compiles on platforms where
  `unsigned int` is 32-bit long.
] else if lang == "de" [
  Ein Wert eines primitiven C-Datentyps kann als Wert des entsprechenden
  Rust-Datentyps verwendet werden und umgekehrt, da der erstere lediglich
  ein Typalias des letzteren ist. Beispielsweise lässt sich der folgende
  Code auf Plattformen kompilieren, auf denen `unsigned int` 32 Bit lang
  ist.
] else { todo }

```rust
fn foo(num: u32) {
    let c_num: c_uint = num;
    let r_num: u32 = c_num;
}
```

== #(if lang == "en" [Interoperability with other build systems]
  else if lang == "de" [Interoperabilität mit anderen Build-Systemen]
  else { todo })

#if lang == "en" [
  A common requirement for including Rust in your embedded project is
  combining Cargo with your existing build system, such as make or cmake.
] else if lang == "de" [
  Eine häufige Voraussetzung für die Einbindung von Rust in
  Embedded-Projekte ist die Kombination von Cargo mit Ihrem bestehenden
  Build-System, beispielsweise Make oder CMake.
] else { todo }

#let url_issue61 = "https://github.com/rust-embedded/book/issues/61"
#if lang == "en" [
  We are collecting examples and use cases for this on our issue tracker
  in #link(url_issue61)[issue \#61].
] else if lang == "de" [
  Wir sammeln Beispiele und Anwendungsfälle hierzu in unserem
  Problem-Verfolgungswerkzeug unter #link(url_issue61)[Issue \#61].
] else { todo }

== #(if lang == "en" [Interoperability with RTOSs]
  else if lang == "de" [Interoperabilität mit RTOS]
  else { todo })

#if lang == "en" [
  Integrating Rust with an RTOS such as FreeRTOS or ChibiOS is still a
  work in progress; especially calling RTOS functions from Rust can be
  tricky.
] else if lang == "de" [
  Die Integration von Rust in ein RTOS wie FreeRTOS oder ChibiOS befindet
  sich noch in der Entwicklung; insbesondere der Aufruf von
  RTOS-Funktionen aus Rust heraus kann sich als schwierig erweisen.
] else { todo }

#let url_zephyr = "https://docs.zephyrproject.org/latest/develop/languages/rust/index.html"
#if lang == "en" [
  Currently, the following projects publicly support Rust\<-\>RTOS
  interoperability:
  - #link(url_zephyr)[Zephyr Project]
] else if lang == "de" [
  Derzeit unterstützen die folgenden Projekte öffentlich die
  Interoperabilität zwischen Rust und RTOS:
  - #link(url_zephyr)[Zephyr-Projekt]
] else { todo }

#let url_issue62 = "https://github.com/rust-embedded/book/issues/62"
#if lang == "en" [
  We are collecting examples and use cases for this on our issue tracker
  in #link(url_issue62)[issue \#62].
] else if lang == "de" [
  Wir sammeln hierfür Beispiele und Anwendungsfälle in unserem
  Problem-Verfolgungswerkzeug unter
  #link(url_issue62)[Issue \#62].
] else { todo }
