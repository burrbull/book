#import "../config.typ": *

#h1(offset: whole, tr((
  en: [Zero Cost Abstractions],
  de: [Abstraktionen ohne Kosten],
  zh: [零成本抽象],
)))

#tr((
en: [
  Type states are also an excellent example of Zero Cost Abstractions -
  the ability to move certain behaviors to compile time execution or
  analysis. These type states contain no actual data, and are instead used
  as markers. Since they contain no data, they have no actual
  representation in memory at runtime:
],
de: [
  Typzustände (Type States) sind zudem ein hervorragendes Beispiel für
  „Zero-Cost Abstractions" -- also die Möglichkeit, bestimmte
  Verhaltensweisen in die Kompilierzeit zu verlagern (sei es zur
  Ausführung oder zur Analyse). Diese Typzustände enthalten keine
  eigentlichen Daten, sondern dienen als Markierungen. Da sie keine Daten
  enthalten, besitzen sie zur Laufzeit keine tatsächliche Repräsentation
  im Speicher:
],
zh: [
  类型状态是一个零成本抽象的杰出案例 -
  把某些行为移到编译时执行或者分析的能力。这些类型状态不包含真实的数据，只用来作为标记。因为它们不包含数据，在运行时它们在内存中不存在实际的表示。
]))

```rust
use core::mem::size_of;

let _ = size_of::<Enabled>();    // == 0
let _ = size_of::<Input>();      // == 0
let _ = size_of::<PulledHigh>(); // == 0
let _ = size_of::<GpioConfig<Enabled, Input, PulledHigh>>(); // == 0
```

= #tr((
  en: [Zero Sized Types],
  de: [Typen der Größe Null],
  zh: [零大小的类型(Zero Sized Types)],
))

```rust
struct Enabled;
```

#tr((
en: [
  Structures defined like this are called Zero Sized Types, as they
  contain no actual data. Although these types act "real"
  at compile time - you can copy them, move them,
  take references to them, etc., however
  the optimizer will completely strip them away.
],
de: [
  Strukturen dieser Art werden als Null-Typen bezeichnet, da sie keine
  tatsächlichen Daten enthalten. Obwohl sich diese Typen zur Kompilierzeit
  „real" verhalten -- man kann sie kopieren, verschieben, Referenzen
  darauf erstellen usw. --, werden sie vom Optimierer vollständig
  entfernt.
],
zh: [
  像这样定义的结构体被称为零大小的类型，因为它们不包含实际数据。虽然这些类型在编译时像是"真实的"(real) - 你可以拷贝它们，移动它们，引用它们，等等，然而优化器将会完全跳过它们。
]))

#tr((
en: [
  In this snippet of code:
],
de: [
  In diesem Code-Ausschnitt:
],
zh: [
  在这个代码片段里:
]))

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

#tr((
en: [
  The GpioConfig we return never exists at runtime. Calling this function
  will generally boil down to a single assembly instruction - storing a
  constant register value to a register location. This means that the type
  state interface we've developed is a zero cost abstraction - it uses no
  more CPU, RAM, or code space tracking the state of `GpioConfig`, and
  renders to the same machine code as a direct register access.
],
de: [
  Das von uns zurückgegebene `GpioConfig`-Objekt existiert zur Laufzeit
  nicht. Der Aufruf dieser Funktion läuft im Wesentlichen auf einen
  einzigen Assembler-Befehl hinaus: das Speichern eines konstanten
  Registerwerts an einer bestimmten Registeradresse. Das bedeutet, dass
  die von uns entwickelte „Type-State"-Schnittstelle eine Abstraktion ohne
  Laufzeitkosten (Zero-Cost-Abstraction) darstellt -- sie verbraucht weder
  zusätzliche CPU- oder RAM-Ressourcen noch zusätzlichen Programmspeicher
  für die Zustandsverwaltung von `GpioConfig` und führt zu demselben
  Maschinencode wie ein direkter Registerzugriff.
],
zh: [
  我们返回的GpioConfig在运行时并不存在。对这个函数的调用通常会被归纳为一条汇编指令
  - 把一个常量寄存器值存进一个寄存器里。这意味着我们开发的类型状态接口是一个零成本抽象
  - 它不会用更多的CPU，RAM，或者代码空间去跟踪`GpioConfig`的状态，会被渲染成和直接访问寄存器一样的机器码。
]))

= #tr((
  en: [Nesting],
  de: [Verschachtelung],
  zh: [嵌套],
))

#tr((
en: [
  In general, these abstractions may be nested as deeply as you would
  like. As long as all components used are zero sized types, the whole
  structure will not exist at runtime.
],
de: [
  Im Allgemeinen lassen sich diese Abstraktionen beliebig tief
  verschachteln. Solange es sich bei allen verwendeten Komponenten um
  Typen ohne Größe (Zero-Sized Types) handelt, existiert die gesamte
  Struktur zur Laufzeit nicht.
],
zh: [
  通常，这些抽象可能会被深深地嵌套起来。一旦结构体使用的所有的组件是零大小类型的，整个结构体将不会在运行时存在。
]))

#tr((
en: [
  For complex or deeply nested structures, it may be tedious to define all
  possible combinations of state. In these cases, macros may be used to
  generate all implementations.
],
de: [
  Bei komplexen oder tief verschachtelten Strukturen kann es mühsam sein,
  alle möglichen Zustandskombinationen zu definieren. In solchen Fällen
  lassen sich Makros verwenden, um sämtliche Implementierungen zu
  generieren.
],
zh: [
  对于复杂或者深度嵌套的结构体，定义所有可能的状态组合可能很乏味。在这些例子中，宏可能可以被用来生成所有的实现。
]))
