#import "../config.typ": *

#h1(offset: whole, tr((
  en: [Mutable Global State],
  de: [Veränderbarer globaler Zustand],
  zh: [可变的全局状态],
)))

#tr((
en: [
  Unfortunately, hardware is basically nothing but mutable global state,
  which can feel very frightening for a Rust developer. Hardware exists
  independently from the structures of the code we write, and can be
  modified at any time by the real world.
],
de: [
  Leider ist Hardware im Grunde nichts anderes als veränderbarer globaler
  Zustand, was auf einen Rust-Entwickler sehr beängstigend wirken kann.
  Hardware existiert unabhängig von den Strukturen des Codes, den wir
  schreiben, und kann jederzeit durch die reale Welt verändert werden.
],
zh: [
  不幸的是，硬件本质上是个可变的全局状态，Rust开发者可能会对此感到很害怕。因为硬件独立于我们所写的代码的结构，能被真实世界在任何时候改变。
]))

= #tr((
  en: [What should our rules be?],
  de: [Wie sollten unsere Regeln sein?],
  zh: [我们应该遵循什么规则?],
))

#tr((
en: [
How can we reliably interact with these peripherals?
+ Always use `volatile` methods to read or write to peripheral memory,
  as it can change at any time
+ In software, we should be able to share any number of read-only
  accesses to these peripherals
+ If some software should have read-write access to a peripheral, it
  should hold the only reference to that peripheral
],
de: [
  Wie können wir zuverlässig mit diesen Peripheriegeräten interagieren?
  + Verwenden Sie stets `volatile`-Methoden für Lese- oder Schreibzugriffe
    auf Peripheriespeicher, da sich dieser jederzeit ändern kann.
  + Auf Softwareebene sollten wir in der Lage sein, eine beliebige Anzahl
    von Lesezugriffen auf diese Peripheriegeräte bereitzustellen.
  + Wenn eine Software Lese- und Schreibzugriff auf ein Peripheriegerät
    haben soll, sollte sie die einzige Referenz auf dieses Peripheriegerät
    besitzen.
],
zh: [
  我们如何才能做到可靠地与这些外设交互?
  + 总是使用 `volatile` 方法去读或者写外设存储器。因为它随时会改变。
  + 在软件中，我们应该能共享任何数量的关于这些外设的只读访问
  + 如果某个软件可以读写一个外设，它应该保有对那个外设的唯一引用。
]))

= #tr((
  en: [The Borrow Checker],
  de: [Der Borrow-Checker],
  zh: [借用检查器],
))

#tr((
en: [
  The last two of these rules sound suspiciously similar to what the
  Borrow Checker does already!
],
de: [
  Die letzten beiden dieser Regeln klingen verdächtig ähnlich wie das, was
  der Borrow Checker bereits tut!
],
zh: [
  这些规则最后两个听起来与借用检查器在做的事情很像！
]))

#tr((
en: [
  Imagine if we could pass around ownership of these peripherals, or offer
  immutable or mutable references to them?
],
de: [
  Stellen Sie sich vor, wir könnten die Besitzrechte an diesen
  Peripheriegeräten weitergeben oder unveränderliche bzw. veränderliche
  Referenzen darauf anbieten?
],
zh: [
  思考一下，我们是否可以传递这些外设的所有权，或者提供对它们的可变或者不可变的引用？
]))

#tr((
en: [
  Well, we can, but for the Borrow Checker, we need to have exactly one
  instance of each peripheral, so Rust can handle this correctly. Well,
  luckily in the hardware, there is only one instance of any given
  peripheral, but how can we expose that in the structure of our code?
],
de: [
  Nun, das ist möglich, aber für den Borrow Checker benötigen wir genau
  eine Instanz jedes Peripheriegeräts, damit Rust dies korrekt verarbeiten
  kann. Glücklicherweise existiert in der Hardware nur eine Instanz jedes
  Peripheriegeräts, aber wie können wir dies in der Struktur unseres Codes
  sichtbar machen?
],
zh: [
  我们当然可以，但是对于借用检查器来说，每个外设只有一个实例的话，Rust才可以正确地处理这件事。幸运的是，在硬件中，任何给定的外设，只有一个实例，但是我们该如何将它暴露在代码的结构中呢？
]))
