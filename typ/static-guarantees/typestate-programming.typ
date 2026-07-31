#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [Typestate Programming]
  else if lang == "de" [Typgestützte Programmierung]
  else { todo })
#set heading(offset: whole*2)

#let url_ts = "https://en.wikipedia.org/wiki/Typestate_analysis"
#let url_builders = "https://doc.rust-lang.org/1.0.0/style/ownership/builders.html"
#if lang == "en" [
  The concept of
  #link(url_ts)[typestates]
  describes the encoding of information about the current state of an
  object into the type of that object. Although this can sound a little
  arcane, if you have used the #link(url_builders)[Builder Pattern]
  in Rust, you have already started using Typestate Programming!
] else if lang == "de" [
  Das Konzept der #link(url_ts)[typestates]
  beschreibt die Kodierung von Informationen über den aktuellen Zustand
  eines Objekts direkt in dessen Typ. Auch wenn dies zunächst etwas
  abstrakt oder kompliziert klingen mag: Wenn Sie in Rust bereits das
  #link(url_builders)[Builder-Muster]
  verwendet haben, sind Sie schon mit der Typestate-Programmierung in
  Berührung gekommen!
] else { todo }


```rust
pub mod foo_module {
    #[derive(Debug)]
    pub struct Foo {
        inner: u32,
    }

    pub struct FooBuilder {
        a: u32,
        b: u32,
    }

    impl FooBuilder {
        pub fn new(starter: u32) -> Self {
            Self {
                a: starter,
                b: starter,
            }
        }

        pub fn double_a(self) -> Self {
            Self {
                a: self.a * 2,
                b: self.b,
            }
        }

        pub fn into_foo(self) -> Foo {
            Foo {
                inner: self.a + self.b,
            }
        }
    }
}

fn main() {
    let x = foo_module::FooBuilder::new(10)
        .double_a()
        .into_foo();

    println!("{:#?}", x);
}
```

#if lang == "en" [
  In this example, there is no direct way to create a `Foo` object. We
  must create a `FooBuilder`, and properly initialize it before we can
  obtain the `Foo` object we want.
] else if lang == "de" [
  In diesem Beispiel gibt es keine direkte Möglichkeit, ein `Foo`-Objekt
  zu erstellen. Wir müssen einen `FooBuilder` erstellen und ihn korrekt
  initialisieren, bevor wir das gewünschte `Foo`-Objekt erhalten können.
] else { todo }

#if lang == "en" [
  This minimal example encodes two states:
  - `FooBuilder`, which represents an "unconfigured", or "configuration in
    process" state
  - `Foo`, which represents a "configured", or "ready to use" state.
] else if lang == "de" [
  Dieses Minimalbeispiel kodiert zwei Zustände:
  - `FooBuilder`, das einen „unkonfigurierten" Zustand oder einen Zustand
    der „laufenden Konfiguration" repräsentiert
  - `Foo`, das einen „konfigurierten" oder „einsatzbereiten" Zustand
    repräsentiert.
] else { todo }

= #(if lang == "en" [Strong Types]
  else if lang == "de" [Starke Typen]
  else { todo })

#let url_strong = "https://en.wikipedia.org/wiki/Strong_and_weak_typing"
#if lang == "en" [
  Because Rust has a #link(url_strong)[Strong Type System],
  there is no easy way to magically create an instance of `Foo`, or to
  turn a `FooBuilder` into a `Foo` without calling the `into_foo()`
  method. Additionally, calling the `into_foo()` method consumes the
  original `FooBuilder` structure, meaning it can not be reused without
  the creation of a new instance.
] else if lang == "de" [
  Da Rust über ein
  #link(url_strong)[starkes Typsystem]
  verfügt, gibt es keine einfache Möglichkeit, auf magische Weise eine
  Instanz von `Foo` zu erzeugen oder einen `FooBuilder` in ein `Foo`
  umzuwandeln, ohne die Methode `into_foo()` aufzurufen. Zudem verbraucht
  der Aufruf der Methode `into_foo()` die ursprüngliche
  `FooBuilder`-Struktur; das bedeutet, dass sie nicht ohne die Erstellung
  einer neuen Instanz wiederverwendet werden kann.
] else { todo }

#if lang == "en" [
  This allows us to represent the states of our system as types, and to
  include the necessary actions for state transitions into the methods
  that exchange one type for another. By creating a `FooBuilder`, and
  exchanging it for a `Foo` object, we have walked through the steps of a
  basic state machine.
] else if lang == "de" [
  Dies ermöglicht es uns, die Zustände unseres Systems als Typen
  darzustellen und die für Zustandsübergänge erforderlichen Aktionen in
  jene Methoden zu integrieren, die einen Typ gegen einen anderen
  austauschen. Indem wir einen `FooBuilder` erstellen und diesen gegen ein
  `Foo`-Objekt austauschen, haben wir die Schritte einer einfachen
  Zustandsmaschine durchlaufen.
] else { todo }
