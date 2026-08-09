#import "../config.typ": *

#h1(offset: whole, tr((
  en: [Typestate Programming],
  de: [Typgestützte Programmierung],
  zh: [类型状态编程(Typestate Programming)],
)))

#let url_ts = "https://en.wikipedia.org/wiki/Typestate_analysis"
#let url_builders = "https://doc.rust-lang.org/1.0.0/style/ownership/builders.html"
#tr((
en: [
  The concept of
  #link(url_ts)[typestates]
  describes the encoding of information about the current state of an
  object into the type of that object. Although this can sound a little
  arcane, if you have used the #link(url_builders)[Builder Pattern]
  in Rust, you have already started using Typestate Programming!
],
de: [
  Das Konzept der #link(url_ts)[typestates]
  beschreibt die Kodierung von Informationen über den aktuellen Zustand
  eines Objekts direkt in dessen Typ. Auch wenn dies zunächst etwas
  abstrakt oder kompliziert klingen mag: Wenn Sie in Rust bereits das
  #link(url_builders)[Builder-Muster]
  verwendet haben, sind Sie schon mit der Typestate-Programmierung in
  Berührung gekommen!
],
zh: [
  #link(url_ts)[typestates]的概念是指将有关对象当前状态的信息编码进该对象的类型中。虽然这听起来有点神秘，如果你在Rust中用过#link(url_builders))[建造者模式]，你就已经开始使用类型状态编程了！
]))


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

#tr((
en: [
  In this example, there is no direct way to create a `Foo` object. We
  must create a `FooBuilder`, and properly initialize it before we can
  obtain the `Foo` object we want.
],
de: [
  In diesem Beispiel gibt es keine direkte Möglichkeit, ein `Foo`-Objekt
  zu erstellen. Wir müssen einen `FooBuilder` erstellen und ihn korrekt
  initialisieren, bevor wir das gewünschte `Foo`-Objekt erhalten können.
],
zh: [
  在这个例子里，不能直接生成一个`Foo`对象。必须先生成一个`FooBuilder`，并且恰当地初始化`FooBuilder`后，才能获取到需要的`Foo`对象。
]))

#tr((
en: [
  This minimal example encodes two states:
  - `FooBuilder`, which represents an "unconfigured", or "configuration in
    process" state
  - `Foo`, which represents a "configured", or "ready to use" state.
],
de: [
  Dieses Minimalbeispiel kodiert zwei Zustände:
  - `FooBuilder`, das einen „unkonfigurierten" Zustand oder einen Zustand
    der „laufenden Konfiguration" repräsentiert
  - `Foo`, das einen „konfigurierten" oder „einsatzbereiten" Zustand repräsentiert.
],
zh: [
  这个最小的例子编码了两个状态:
  - `FooBuilder`，其表示一个"没有被配置"，或者"正在配置"状态
  - `Foo`，其表示了一个"被配置"，或者"可以使用"状态。
]))

= #tr((
  en: [Strong Types],
  de: [Starke Typen],
  zh: [强类型],
))

#let url_strong = "https://en.wikipedia.org/wiki/Strong_and_weak_typing"
#tr((
en: [
  Because Rust has a #link(url_strong)[Strong Type System],
  there is no easy way to magically create an instance of `Foo`, or to
  turn a `FooBuilder` into a `Foo` without calling the `into_foo()`
  method. Additionally, calling the `into_foo()` method consumes the
  original `FooBuilder` structure, meaning it can not be reused without
  the creation of a new instance.
],
de: [
  Da Rust über ein
  #link(url_strong)[starkes Typsystem]
  verfügt, gibt es keine einfache Möglichkeit, auf magische Weise eine
  Instanz von `Foo` zu erzeugen oder einen `FooBuilder` in ein `Foo`
  umzuwandeln, ohne die Methode `into_foo()` aufzurufen. Zudem verbraucht
  der Aufruf der Methode `into_foo()` die ursprüngliche
  `FooBuilder`-Struktur; das bedeutet, dass sie nicht ohne die Erstellung
  einer neuen Instanz wiederverwendet werden kann.
],
zh: [
  因为Rust有一个#link(url_strong)[强类型系统]，没有什么简单的方法可以奇迹般地生成一个`Foo`实例，也没有简单的方法可以不用调用`into_foo()`方法而把一个`FooBuilder`变成一个`Foo`。另外，调用`into_foo()`方法消费了最初的`FooBuilder`结构体，意味着不生成一个新的实例就不能被再次使用它。
]))

#tr((
en: [
  This allows us to represent the states of our system as types, and to
  include the necessary actions for state transitions into the methods
  that exchange one type for another. By creating a `FooBuilder`, and
  exchanging it for a `Foo` object, we have walked through the steps of a
  basic state machine.
],
de: [
  Dies ermöglicht es uns, die Zustände unseres Systems als Typen
  darzustellen und die für Zustandsübergänge erforderlichen Aktionen in
  jene Methoden zu integrieren, die einen Typ gegen einen anderen
  austauschen. Indem wir einen `FooBuilder` erstellen und diesen gegen ein
  `Foo`-Objekt austauschen, haben wir die Schritte einer einfachen
  Zustandsmaschine durchlaufen.
],
zh: [
  这允许我们可以将系统的状态表示成类型，把状态转换必须的动作包括进转换两个类型的方法中。通过生成一个
  `FooBuilder`，转换成一个 `Foo` 对象，我们已经使用了一个基本的状态机。
]))
