#import "../config.typ": *

#h1(offset: whole,
  if lang in ("en", "de") [Interrupts]
  else { todo })
#set heading(offset: whole*2)

#if lang == "en" [
  Interrupts differ from exceptions in a variety of ways but their
  operation and use is largely similar and they are also handled by the
  same interrupt controller. Whereas exceptions are defined by the
  Cortex-M architecture, interrupts are always vendor (and often even
  chip) specific implementations, both in naming and functionality.
] else if lang == "de" [
  Interrupts unterscheiden sich in vielerlei Hinsicht von Exceptions; ihre
  Funktionsweise und Verwendung sind jedoch weitgehend ähnlich, und sie
  werden zudem von demselben Interrupt-Controller verwaltet. Während
  Exceptions durch die Cortex-M-Architektur definiert sind, handelt es
  sich bei Interrupts -- sowohl hinsichtlich der Benennung als auch der
  Funktionalität -- stets um herstellerspezifische (und oft sogar
  chip-spezifische) Implementierungen.
] else { todo }

#if lang == "en" [
  Interrupts do allow for a lot of flexibility which needs to be accounted
  for when attempting to use them in an advanced way. We will not cover
  those uses in this book, however it is a good idea to keep the following
  in mind:
  - Interrupts have programmable priorities which determine their
    handlers' execution order
  - Interrupts can nest and preempt, i.e.~execution of an interrupt
    handler might be interrupted by another higher-priority interrupt
  - In general the reason causing the interrupt to trigger needs to be
    cleared to prevent re-entering the interrupt handler endlessly
] else if lang == "de" [
  Interrupts bieten ein hohes Maß an Flexibilität, das bei einer
  fortgeschrittenen Nutzung berücksichtigt werden muss. Wir werden diese
  Anwendungsfälle in diesem Buch zwar nicht behandeln, dennoch ist es
  ratsam, Folgendes zu beachten:
  - Interrupts verfügen über programmierbare Prioritäten, die die
    Ausführungsreihenfolge ihrer Behandlungsroutinen bestimmen.
  - Interrupts können geschachtelt werden und einander unterbrechen
    (Preemption); das heißt, die Ausführung eines Interrupt-Handlers kann
    durch einen anderen Interrupt mit höherer Priorität unterbrochen werden.
  - Im Allgemeinen muss die Ursache für die Auslösung des Interrupts
    beseitigt werden, um zu verhindern, dass der Interrupt-Handler endlos
    erneut aufgerufen wird.
] else { todo }

#if lang == "en" [
  The general initialization steps at runtime are always the same:
  - Setup the peripheral(s) to generate interrupts requests at the desired occasions
  - Set the desired priority of the interrupt handler in the interrupt controller
  - Enable the interrupt handler in the interrupt controller
] else if lang == "de" [
  Die allgemeinen Initialisierungsschritte zur Laufzeit sind immer gleich:
  - Konfigurieren Sie die Peripheriekomponente(n) so, dass
    Interrupt-Anforderungen zu den gewünschten Zeitpunkten ausgelöst werden.
  - Legen Sie die gewünschte Priorität des Interrupt-Handlers im
    Interrupt-Controller fest.
  - Aktivieren Sie den Interrupt-Handler im Interrupt-Controller.
] else { todo }

#let ln_int = link("https://docs.rs/cortex-m-rt-macros/0.1.5/cortex_m_rt_macros/attr.interrupt.html")[`interrupt`]
#if lang == "en" [
  Similarly to exceptions, the cortex-m-rt crate exposes an #ln_int
  attribute for declaring interrupt handlers. However, this attribute is
  only available when the device feature is enabled. That said, this
  attribute is not intended to be used directly---doing so will result in
  a compilation error.
] else if lang == "de" [
  Ähnlich wie bei Exceptions stellt das `cortex-m-rt`-Crate ein
  #ln_int;-Attribut zur Deklaration von Interrupt-Handlern bereit.
  Dieses Attribut steht jedoch nur zur Verfügung,
  wenn das Device-Feature aktiviert ist. Es ist
  allerdings nicht für die direkte Verwendung vorgesehen; eine solche
  würde zu einem Kompilierfehler führen.
] else { todo }

#if lang == "en" [
  Instead, you should use the re-exported version of the interrupt
  attribute provided by the device crate (usually generated using
  svd2rust). This ensures that the compiler can verify that the interrupt
  actually exists on the target device. The list of available
  interrupts---and their position in the interrupt vector table---is
  typically auto-generated from an SVD file by svd2rust.
] else if lang == "de" [
  Stattdessen sollten Sie die vom Device-Crate (das üblicherweise mit
  `svd2rust` generiert wird) bereitgestellte, re-exportierte Version des
  `interrupt`-Attributs verwenden. Dies stellt sicher, dass der Compiler
  überprüfen kann, ob der Interrupt auf dem Zielgerät tatsächlich
  existiert. Die Liste der verfügbaren Interrupts -- sowie deren Position
  in der Interrupt-Vektortabelle -- wird typischerweise von `svd2rust`
  automatisch aus einer SVD-Datei generiert.
] else { todo }

#if lang == "en" [
  ```rust
  use lm3s6965::interrupt; // Re-exported attribute from the device crate

  // Interrupt handler for the Timer2 interrupt
  #[interrupt]
  fn TIMER2A() {
      // ..
      // Clear reason for the generated interrupt request
  }
  ```
] else if lang == "de" [
  ```rust
  use lm3s6965::interrupt; // Aus dem Device-Crate zurueck-exportiertes Attribut

  // Interrupt-Handler fuer den Timer2-Interrupt
  #[interrupt]
  fn TIMER2A() {
      // ..
      // Eindeutiger Grund fuer die generierte Interrupt-Anforderung
  }
  ```
] else { todo }

#if lang == "en" [
  Interrupt handlers look like plain functions (except for the lack of
  arguments) similar to exception handlers. However they can not be called
  directly by other parts of the firmware due to the special calling
  conventions. It is however possible to generate interrupt requests in
  software to trigger a diversion to the interrupt handler.
] else if lang == "de" [
  Interrupt-Handler ähneln -- abgesehen vom Fehlen von Argumenten --
  gewöhnlichen Funktionen, ganz wie Exception-Handler. Aufgrund spezieller
  Aufrufkonventionen können sie jedoch nicht direkt von anderen Teilen der
  Firmware aufgerufen werden. Es ist allerdings möglich,
  Interrupt-Anforderungen per Software zu erzeugen, um einen Sprung zum
  Interrupt-Handler auszulösen.
] else { todo }

#if lang == "en" [
  Similar to exception handlers it is also possible to declare
  `static mut` variables inside the interrupt handlers for _safe_ state keeping.
] else if lang == "de" [
  Ähnlich wie bei Exception-Handlern ist es auch hier möglich,
  `static mut`-Variablen innerhalb der Interrupt-Handler zu deklarieren,
  um den Zustand auf _sichere_ Weise zu speichern.
] else { todo }

#raw(block: true, lang: "rust",
"#[interrupt]
fn TIMER2A() {
    static mut COUNT: u32 = 0;

    // " + if lang == "en" {
        "`COUNT` has type `&mut u32` and it's safe to use"
      } else if lang == "de" {
        "`COUNT` hat den Typ `&mut u32` und ist sicher zu verwenden."
      } else { todos } + "
    *COUNT += 1;
}
")

#if lang == "en" [
  For a more detailed description about the mechanisms demonstrated here
  please refer to the #link(<getting-started-exceptions>)[exceptions section].
] else if lang == "de" [
  Für eine detailliertere Beschreibung der hier veranschaulichten
  Mechanismen konsultieren Sie bitte den
  #link(<getting-started-exceptions>)[Abschnitt zu Ausnahmen].
] else { todo }
