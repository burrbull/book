#import "../config.typ": *

#h1(offset: whole,
  if lang in ("en", "de") [Interrupts]
  else if lang == "ja" [割り込み]
  else if lang == "zh" [中断]
  else { todo })

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
] else if lang == "ja" [
  割り込みは様々な点で例外と違いますが、その動作と使用方法は、ほとんど同じで、同じ割り込みコントローラによって処理されます。
  例外がCortex-Mアーキテクチャで定義されているのに対し、割り込みは、命名と機能との両方において、常にベンダ（もっと言うとチップ）固有の実装です。
] else if lang == "zh" [
  虽然中断和异常在很多方面都不一样，但是它们的操作和使用几乎是一样的，且它们也能被同一个中断控制器处理。然而异常是由Cortex-M微架构定义的，中断在命名和功能上总是由特定厂商(经常甚至是芯片)实现的。
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
] else if lang == "ja" [
  割り込みは、高度な使い方をしようとする時に必要とされる様々な柔軟性を考慮に入れています。
  本書では、そのような高度な使い方は対象外です。しかし、次の点に留意することをお勧めします。
  - 割り込みは、ハンドラの実行順序を決めるプログラム可能な優先度を持ちます。
  - 割り込みは、ネストとプリエンプションが可能です。つまり、割り込みハンドラの実行は、より優先度の高い割り込みに割り込まれる場合があります。
  - 通常、割り込み要因は、割り込みハンドラが無限に再呼び出しされないようにするため、クリアされる必要があります。
] else if lang == "zh" [
  中断提供了更多的灵活性，当尝试用一种高级的方法使用它们时，我们需要对这种灵活性进行解释。但我们将不会在这本书里涵盖这些内容，最好把下面的东西记在心里:
  - 中断有可以编程的优先级，其决定了它们的处理函数的执行顺序。
  - 中断能嵌套且抢占，i.e.~一个中断处理函数的执行可以被其它更高优先级的中断打断。
  - 通常需要清除掉导致中断被触发的原因，避免无限地再次进入中断处理函数。
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
] else if lang == "ja" [
  ランタイムでの一般的な初期化手順は、常に同じです。
  - 必要な時に割り込み要求を起こすように、ペリフェラルを設定します
  - 割り込みコントローラで割り込みハンドラの優先度をセットします
  - 割り込みコントローラで割り込みハンドラを有効化します
] else if lang == "zh" [
  运行时的初始化步骤总是相同的:
  - 设置外设在想要的事件发生时产生中断请求
  - 在中断控制器中设置需要的中断处理函数的优先级 
  - 在中断控制器中使能中断处理函数
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
] else if lang == "ja" [
  例外と同様に、例外ハンドラを宣言するために、`cortex-m-rt`クレートは、#ln_int;属性を提供しています。
  利用可能な割り込み（そして割り込みハンドラテーブルでの配置）は、通常、`svd2rust`を使ってSVDから自動生成されます。
] else if lang == "zh" [
  #todoupd("zh")
  与异常相似，`cortex-m-rt`
  crate提供了一个#ln_int;属性去声明中断处理函数。可用的中断(及它们在中断向量表中的位置)通常由`svd2rust`从一个SVD描述文件自动地生成。
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

#raw(block: true, lang: "rust",
"rust
use lm3s6965::interrupt; // " + if lang == "en" {
                            "Re-exported attribute from the device crate"
                          } else if lang == "de" {
                            "Aus dem Device-Crate zurueck-exportiertes Attribut"
                          } else { todos } + "

// " + if lang == "en" {
    "Interrupt handler for the Timer2 interrupt"
  } else if lang == "de" {
    "Interrupt-Handler fuer den Timer2-Interrupt"
  } else if lang == "ja" {
    "タイマ2割り込みの割り込みハンドラ"
  } else if lang == "zh" {
    "Timer2中断的中断处理函数"
  } else { todos } + "
#[interrupt]
fn TIMER2A() {
    // ..
    // " + if lang == "en" {
        "Clear reason for the generated interrupt request"
      } else if lang == "de" {
        "Eindeutiger Grund fuer die generierte Interrupt-Anforderung"
      } else if lang == "ja" {
        "発生した割り込み要求の原因をクリアします"
      } else if lang == "zh" {
        "清除生成中断请求的原因"
      } else { todos } + "
}
")

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
] else if lang == "ja" [
  割り込みハンドラは、通常の関数のように見え、例外ハンドラに似ています（引数がないことを除いて）。
  しかし、割り込みハンドラは、特別な呼び出し規約のため、ファームウェアの他の部分から直接呼び出すことができません。
  ソフトウェアで割り込み要求を起こし、割り込みハンドラへの転送を発生させることは可能です。
] else if lang == "zh" [
  中断处理函数和异常处理函数一样看起来像是普通的函数(除了没有入参)。然而由于特殊的调用规定，它不能被固件的其它部分直接调用。然而，可以在软件中生成中断请求，转移到中断处理函数中。
] else { todo }

#if lang == "en" [
  Similar to exception handlers it is also possible to declare
  `static mut` variables inside the interrupt handlers for _safe_ state keeping.
] else if lang == "de" [
  Ähnlich wie bei Exception-Handlern ist es auch hier möglich,
  `static mut`-Variablen innerhalb der Interrupt-Handler zu deklarieren,
  um den Zustand auf _sichere_ Weise zu speichern.
] else if lang == "ja" [
  例外ハンドラと同様に、割り込みハンドラ内で`static mut`変数を宣言し、状態を_安全_に保持することができます。
] else if lang == "zh" [
  与异常处理函数一样，也能在中断处理函数中声明`static mut`变量且保持
  _safe_ 状态。
] else { todo }

#raw(block: true, lang: "rust",
"#[interrupt]
fn TIMER2A() {
    static mut COUNT: u32 = 0;

    // " + if lang == "en" {
        "`COUNT` has type `&mut u32` and it's safe to use"
      } else if lang == "de" {
        "`COUNT` hat den Typ `&mut u32` und ist sicher zu verwenden."
      } else if lang == "ja" {
        "`COUNT`は`&mut u32`の型を持っており、その使用は安全です"
      } else if lang == "zh" {
        "`COUNT` 的类型是 `&mut u32` 且它用起来安全"
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
] else if lang == "ja" [
  ここで示した仕組みの詳細については、#link(<getting-started-exceptions>)[例外セクション]を参照して下さい。
] else if lang == "zh" [
  关于这里所说的机制的更多细节描述，请参考#link(<getting-started-exceptions>)[异常章节]。
] else { todo }
