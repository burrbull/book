#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [Mutable Global State]
  else if lang == "de" [Veränderbarer globaler Zustand]
  else { todo })

#if lang == "en" [
  Unfortunately, hardware is basically nothing but mutable global state,
  which can feel very frightening for a Rust developer. Hardware exists
  independently from the structures of the code we write, and can be
  modified at any time by the real world.
] else if lang == "de" [
  Leider ist Hardware im Grunde nichts anderes als veränderbarer globaler
  Zustand, was auf einen Rust-Entwickler sehr beängstigend wirken kann.
  Hardware existiert unabhängig von den Strukturen des Codes, den wir
  schreiben, und kann jederzeit durch die reale Welt verändert werden.
] else { todo }

= #(if lang == "en" [What should our rules be?]
  else if lang == "de" [Wie sollten unsere Regeln sein?]
  else { todo })

#if lang == "en" [
How can we reliably interact with these peripherals?
+ Always use `volatile` methods to read or write to peripheral memory,
  as it can change at any time
+ In software, we should be able to share any number of read-only
  accesses to these peripherals
+ If some software should have read-write access to a peripheral, it
  should hold the only reference to that peripheral
] else if lang == "de" [
  Wie können wir zuverlässig mit diesen Peripheriegeräten interagieren?
  + Verwenden Sie stets `volatile`-Methoden für Lese- oder Schreibzugriffe
    auf Peripheriespeicher, da sich dieser jederzeit ändern kann.
  + Auf Softwareebene sollten wir in der Lage sein, eine beliebige Anzahl
    von Lesezugriffen auf diese Peripheriegeräte bereitzustellen.
  + Wenn eine Software Lese- und Schreibzugriff auf ein Peripheriegerät
    haben soll, sollte sie die einzige Referenz auf dieses Peripheriegerät
    besitzen.
] else { todo }

= #(if lang == "en" [The Borrow Checker]
  else if lang == "de" [Der Borrow-Checker]
  else { todo })

#if lang == "en" [
  The last two of these rules sound suspiciously similar to what the
  Borrow Checker does already!
] else if lang == "de" [
  Die letzten beiden dieser Regeln klingen verdächtig ähnlich wie das, was
  der Borrow Checker bereits tut!
] else { todo }

#if lang == "en" [
  Imagine if we could pass around ownership of these peripherals, or offer
  immutable or mutable references to them?
] else if lang == "de" [
  Stellen Sie sich vor, wir könnten die Besitzrechte an diesen
  Peripheriegeräten weitergeben oder unveränderliche bzw. veränderliche
  Referenzen darauf anbieten?
] else { todo }

#if lang == "en" [
  Well, we can, but for the Borrow Checker, we need to have exactly one
  instance of each peripheral, so Rust can handle this correctly. Well,
  luckily in the hardware, there is only one instance of any given
  peripheral, but how can we expose that in the structure of our code?
] else if lang == "de" [
  Nun, das ist möglich, aber für den Borrow Checker benötigen wir genau
  eine Instanz jedes Peripheriegeräts, damit Rust dies korrekt verarbeiten
  kann. Glücklicherweise existiert in der Hardware nur eine Instanz jedes
  Peripheriegeräts, aber wie können wir dies in der Struktur unseres Codes
  sichtbar machen?
] else { todo }
