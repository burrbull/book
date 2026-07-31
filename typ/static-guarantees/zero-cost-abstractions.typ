#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [Zero Cost Abstractions]
  else if lang == "de" [Abstraktionen ohne Kosten]
  else { todo })
#set heading(offset: whole*2)

#if lang == "en" [
  Type states are also an excellent example of Zero Cost Abstractions -
  the ability to move certain behaviors to compile time execution or
  analysis. These type states contain no actual data, and are instead used
  as markers. Since they contain no data, they have no actual
  representation in memory at runtime:
] else if lang == "de" [
  Typzustände (Type States) sind zudem ein hervorragendes Beispiel für
  „Zero-Cost Abstractions" -- also die Möglichkeit, bestimmte
  Verhaltensweisen in die Kompilierzeit zu verlagern (sei es zur
  Ausführung oder zur Analyse). Diese Typzustände enthalten keine
  eigentlichen Daten, sondern dienen als Markierungen. Da sie keine Daten
  enthalten, besitzen sie zur Laufzeit keine tatsächliche Repräsentation
  im Speicher:
] else { todo }

```rust
use core::mem::size_of;

let _ = size_of::<Enabled>();    // == 0
let _ = size_of::<Input>();      // == 0
let _ = size_of::<PulledHigh>(); // == 0
let _ = size_of::<GpioConfig<Enabled, Input, PulledHigh>>(); // == 0
```

= #(if lang == "en" [Zero Sized Types]
  else if lang == "de" [Typen der Größe Null]
  else { todo })

```rust
struct Enabled;
```

#if lang == "en" [
  Structures defined like this are called Zero Sized Types, as they
  contain no actual data. Although these types act "real"
  at compile time - you can copy them, move them,
  take references to them, etc., however
  the optimizer will completely strip them away.
] else if lang == "de" [
  Strukturen dieser Art werden als Null-Typen bezeichnet, da sie keine
  tatsächlichen Daten enthalten. Obwohl sich diese Typen zur Kompilierzeit
  „real" verhalten -- man kann sie kopieren, verschieben, Referenzen
  darauf erstellen usw. --, werden sie vom Optimierer vollständig
  entfernt.
] else { todo }

#if lang == "en" [
  In this snippet of code:
] else if lang == "de" [
  In diesem Code-Ausschnitt:
] else { todo }

```rust
pub fn into_input_high_z(self) -> GpioConfig<Enabled, Input, HighZ> {
    self.periph.modify(|_r, w| w.input_mode().high_z());
    GpioConfig {
        periph: self.periph,
        enabled: Enabled,
        direction: Input,
        mode: HighZ,
    }
}
```

#if lang == "en" [
  The GpioConfig we return never exists at runtime. Calling this function
  will generally boil down to a single assembly instruction - storing a
  constant register value to a register location. This means that the type
  state interface we've developed is a zero cost abstraction - it uses no
  more CPU, RAM, or code space tracking the state of `GpioConfig`, and
  renders to the same machine code as a direct register access.
] else if lang == "de" [
  Das von uns zurückgegebene `GpioConfig`-Objekt existiert zur Laufzeit
  nicht. Der Aufruf dieser Funktion läuft im Wesentlichen auf einen
  einzigen Assembler-Befehl hinaus: das Speichern eines konstanten
  Registerwerts an einer bestimmten Registeradresse. Das bedeutet, dass
  die von uns entwickelte „Type-State"-Schnittstelle eine Abstraktion ohne
  Laufzeitkosten (Zero-Cost-Abstraction) darstellt -- sie verbraucht weder
  zusätzliche CPU- oder RAM-Ressourcen noch zusätzlichen Programmspeicher
  für die Zustandsverwaltung von `GpioConfig` und führt zu demselben
  Maschinencode wie ein direkter Registerzugriff.
] else { todo }

= #(if lang == "en" [Nesting]
  else if lang == "de" [Verschachtelung]
  else { todo })

#if lang == "en" [
  In general, these abstractions may be nested as deeply as you would
  like. As long as all components used are zero sized types, the whole
  structure will not exist at runtime.
] else if lang == "de" [
  Im Allgemeinen lassen sich diese Abstraktionen beliebig tief
  verschachteln. Solange es sich bei allen verwendeten Komponenten um
  Typen ohne Größe (Zero-Sized Types) handelt, existiert die gesamte
  Struktur zur Laufzeit nicht.
] else { todo }

#if lang == "en" [
  For complex or deeply nested structures, it may be tedious to define all
  possible combinations of state. In these cases, macros may be used to
  generate all implementations.
] else if lang == "de" [
  Bei komplexen oder tief verschachtelten Strukturen kann es mühsam sein,
  alle möglichen Zustandskombinationen zu definieren. In solchen Fällen
  lassen sich Makros verwenden, um sämtliche Implementierungen zu
  generieren.
] else { todo }
