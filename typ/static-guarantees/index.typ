#import "../config.typ": *

#h1(if lang == "en" [Static Guarantees]
  else if lang == "de" [Statische Garantien]
  else { todo })
#set heading(offset: whole)

#let ln_send = link("https://doc.rust-lang.org/core/marker/trait.Send.html")[`Send`]
#let ln_sync = link("https://doc.rust-lang.org/core/marker/trait.Sync.html")[`Sync`]
#if lang == "en" [
  Rust's type system prevents data races at compile time
  (see #ln_send and #ln_sync traits).
  The type system can also be used to check other properties at
  compile time; reducing the need for runtime checks in some cases.
] else if lang == "de" [
  Das Typsystem von Rust verhindert Data Races zur Kompilierzeit
  (siehe die Traits #ln_send und #ln_sync).
  Zudem lässt sich das Typsystem nutzen, um weitere Eigenschaften bereits
  zur Kompilierzeit zu überprüfen, wodurch in einigen Fällen
  Laufzeitprüfungen überflüssig werden.
] else { todo }

#if lang == "en" [
  When applied to embedded programs these _static checks_ can be
  used, for example, to enforce that configuration of I/O interfaces is
  done properly. For instance, one can design an API where it is only
  possible to initialize a serial interface by first configuring the pins
  that will be used by the interface.
] else if lang == "de" [
  Bei Embedded-Programmen lassen sich diese _statischen Prüfungen_
  beispielsweise nutzen, um sicherzustellen, dass die Konfiguration von
  E/A-Schnittstellen korrekt erfolgt. So lässt sich etwa eine API
  entwerfen, bei der die Initialisierung einer seriellen Schnittstelle nur
  möglich ist, wenn zuvor die für diese Schnittstelle vorgesehenen Pins
  konfiguriert wurden.
] else { todo }

#if lang == "en" [
  One can also statically check that operations, like setting a pin low,
  can only be performed on correctly configured peripherals. For example,
  trying to change the output state of a pin configured in floating input
  mode would raise a compile error.
] else if lang == "de" [
  Zudem lässt sich statisch überprüfen, ob Operationen -- wie etwa das
  Setzen eines Pins auf den Pegel „Low" -- nur an korrekt konfigurierten
  Peripheriekomponenten ausgeführt werden. Der Versuch, den
  Ausgangszustand eines Pins zu ändern, der als „Floating Input" (Eingang
  mit undefiniertem Pegel) konfiguriert ist, würde beispielsweise zu einem
  Kompilierfehler führen.
] else { todo }

#if lang == "en" [
  And, as seen in the previous chapter, the concept of ownership can be
  applied to peripherals to ensure that only certain parts of a program
  can modify a peripheral. This _access control_ makes software
  easier to reason about compared to the alternative of treating
  peripherals as global mutable state.
] else if lang == "de" [
  Wie bereits im vorherigen Kapitel erläutert, lässt sich auch das Konzept
  des „Ownership" (Besitzverhältnis) auf Peripheriekomponenten anwenden,
  um sicherzustellen, dass nur bestimmte Programmteile diese modifizieren
  können. Diese _Zugriffskontrolle_ erleichtert das Verständnis und
  die Analyse der Software im Vergleich zu dem alternativen Ansatz,
  Peripheriekomponenten als globalen, veränderbaren Zustand zu behandeln.
] else { todo }
