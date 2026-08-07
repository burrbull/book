#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [Exceptions]
  else if lang == "de" [Ausnahmen (Exceptions)]
  else if lang == "zh" [异常]
  else { todo })
<getting-started-exceptions>

#if lang == "en" [
  Exceptions, and interrupts, are a hardware mechanism by which the
  processor handles asynchronous events and fatal errors (e.g.~executing
  an invalid instruction). Exceptions imply preemption and involve
  exception handlers, subroutines executed in response to the signal that
  triggered the event.
] else if lang == "de" [
  Ausnahmen und Interrupts sind ein Hardwaremechanismus, mit dem der
  Prozessor asynchrone Ereignisse und schwerwiegende Fehler (z. B. die
  Ausführung einer ungültigen Anweisung) behandelt. Ausnahmen implizieren
  Präemption und erfordern Ausnahmebehandlungsroutinen, die als Reaktion
  auf das auslösende Signal ausgeführt werden.
] else if lang == "zh" [
  异常和中断，是处理器用来处理异步事件和致命错误(e.g.~执行一个无效的指令)的一种硬件机制。异常意味着抢占并涉及到异常处理程序，即响应触发事件的信号的子程序。
] else { todo }

#let ln_ex = link("https://docs.rs/cortex-m-rt-macros/latest/cortex_m_rt_macros/attr.exception.html")[`exception`]
#if lang == "en" [
  The `cortex-m-rt` crate provides an #ln_ex attribute to declare exception handlers.
] else if lang == "de" [
  Die `cortex-m-rt`-Crate bietet das Attribut #ln_ex zur Deklaration von Ausnahmebehandlungsroutinen.
] else if lang == "zh" [
  `cortex-m-rt` crate提供了一个 #ln_ex 属性去声明异常处理程序。
] else { todo }

#raw(block: true, lang: "rust",
"// " + if lang == "en" {
    "Exception handler for the SysTick (System Timer) exception"
  } else if lang == "de" {
    "Ausnahmebehandlungsroutine fuer die SysTick-Ausnahme (System-Timer)"
  } else if lang == "zh" {
    "SysTick (System计时器)异常的异常处理函数"
  } else { todos } + "
#[exception]
fn SysTick() {
    // ..
}
")

#if lang == "en" [
  Other than the `exception` attribute exception handlers look like plain
  functions but there's one more difference: `exception` handlers can
  _not_ be called by software. Following the previous example, the
  statement `SysTick();` would result in a compilation error.
] else if lang == "de" [
  Abgesehen vom `exception`-Attribut sehen Exception-Handler wie
  gewöhnliche Funktionen aus, doch es gibt noch einen weiteren
  Unterschied: `exception`-Handler können _nicht_ per Software
  aufgerufen werden. Bezogen auf das vorherige Beispiel würde die
  Anweisung `SysTick();` zu einem Kompilierfehler führen.
] else if lang == "zh" [
  除了 `exception`
  属性，异常处理函数看起来和普通函数一样，但是有一个很大的不同:
  `exception` 处理函数 _不能_ 被软件调用。在先前的例子中，语句
  `SysTick();` 将会导致一个编译错误。
] else { todo }

#if lang == "en" [
  This behavior is pretty much intended and it's required to provide a
  feature: `static mut` variables declared _inside_ `exception`
  handlers are _safe_ to use.
] else if lang == "de" [
  Dieses Verhalten ist durchaus beabsichtigt und notwendig, um eine
  bestimmte Eigenschaft zu gewährleisten: `static mut`-Variablen, die
  _innerhalb_ von `exception`-Handlern deklariert werden, sind
  _sicher_ in der Verwendung.
] else if lang == "zh" [
  这么做是有目的的，因为异常处理函数必须具有一个特性:
  在异常处理函数中被声明为`static mut`的变量能被安全(safe)地使用。
] else { todo }

#raw(block: true, lang: "rust",
"#[exception]
fn SysTick() {
    static mut COUNT: u32 = 0;
    // " + if lang == "en" {
        "`COUNT` has transformed to type `&mut u32` and it's safe to use"
      } else if lang == "de" {
        "`COUNT` wurde in den Typ `&mut u32` umgewandelt und ist sicher in der 
    // Verwendung."
      } else if lang == "zh" {
        "`COUNT` 被转换到了 `&mut u32` 类型且它用起来是安全的"
      } else { todos } + "
    *COUNT += 1;
")

#let url_re = "https://en.wikipedia.org/wiki/Reentrancy_(computing)"
#if lang == "en" [
  As you may know, using `static mut` variables in a function makes it
  #link(url_re)[_non-reentrant_].
  It's undefined behavior to call a non-reentrant function, directly or
  indirectly, from more than one exception / interrupt handler or from
  `main` and one or more exception / interrupt handlers.
] else if lang == "de" [
  Wie Ihnen vielleicht bekannt ist, führt die Verwendung von
  `static mut`-Variablen in einer Funktion dazu, dass diese
  #link(url_re)[_nicht wiedereintrittsfähig_]
  ist. Es stellt undefiniertes Verhalten dar, eine nicht
  wiedereintrittsfähige Funktion direkt oder indirekt aus mehr als einem
  Ausnahme- oder Interrupt-Handler oder aus `main` und einem oder mehreren
  Ausnahme- oder Interrupt-Handlern heraus aufzurufen.
] else if lang == "zh" [
  就像你可能已经知道的那样，在一个函数里使用`static mut`变量，会让函数变成#link(url_re)[_非可重入函数(non-reentrancy)_]。从多个异常/中断处理函数，或者从`main`函数和多个异常/中断处理函数中，直接或者间接地调用一个非可重入(non-reentrancy)函数是未定义的行为。
] else { todo }

#if lang == "en" [
  Safe Rust must never result in undefined behavior so non-reentrant
  functions must be marked as `unsafe`. Yet I just told that `exception`
  handlers can safely use `static mut` variables. How is this possible?
  This is possible because `exception` handlers can _not_ be called
  by software thus reentrancy is not possible. These handlers are called
  by the hardware itself which is assumed to be physically non-concurrent.
] else if lang == "de" [
  Safe Rust darf niemals zu undefiniertem Verhalten führen; daher müssen
  nicht-wiedereintrittsfähige Funktionen als `unsafe` gekennzeichnet
  werden. Dennoch habe ich gerade erwähnt, dass Ausnahme-Handler
  (`exception handlers`) sicher `static mut`-Variablen verwenden können.
  Wie ist das möglich? Dies ist möglich, da Ausnahme-Handler _nicht_
  per Software aufgerufen werden können und somit kein Wiedereintritt
  (Reentrancy) stattfinden kann. Diese Handler werden von der Hardware
  selbst aufgerufen, bei der davon ausgegangen wird, dass sie physisch
  keine Nebenläufigkeit aufweist.
] else if lang == "zh" [
  #todoupd("zh")
  安全的Rust不能导致未定义的行为出现，所以非可重入函数必须被标记为
  `unsafe`。然而，我刚说了`exception`处理函数能安全地使用`static mut`变量。这怎么可能？因为`exception`处理函数
  _不_ 能被软件调用因此重入(reentrancy)不会发生，所以这才变得可能。
] else { todo }

#if lang == "en" [
  As a result, in the context of exception handlers in embedded systems,
  the absence of concurrent invocations of the same handler ensures that
  there are no reentrancy issues, even if the handler uses static mutable
  variables.
] else if lang == "de" [
  Im Kontext von Ausnahme-Handlern in eingebetteten Systemen stellt das
  Ausbleiben gleichzeitiger Aufrufe desselben Handlers folglich sicher,
  dass keine Probleme mit der Wiedereintrittsfähigkeit auftreten -- selbst
  dann nicht, wenn der Handler veränderbare statische Variablen verwendet
] else { todo }

#if lang == "en" [
  In a multicore system, where multiple processor cores are executing code
  concurrently, the potential for reentrancy issues becomes relevant
  again, even within exception handlers. While each core may have its own
  set of exception handlers, there can still be scenarios where multiple
  cores attempt to execute the same exception handler simultaneously. \
  To address this concern in a multicore environment, proper synchronization
  mechanisms need to be employed within the exception handlers to ensure
  that access to shared resources is properly coordinated among the cores.
  This typically involves the use of techniques such as locks, semaphores,
  or atomic operations to prevent data races and maintain data integrity
] else if lang == "de" [
  In einem Multicore-System, in dem mehrere Prozessorkerne gleichzeitig
  Code ausführen, gewinnt die Problematik der Wiedereintrittsfähigkeit
  (Reentrancy) erneut an Bedeutung -- selbst innerhalb von
  Exception-Handlern. Auch wenn jeder Kern über eigene Exception-Handler
  verfügen mag, kann es dennoch zu Situationen kommen, in denen mehrere
  Kerne versuchen, denselben Exception-Handler simultan auszuführen. Um
  dieser Herausforderung in einer Multicore-Umgebung zu begegnen, müssen
  innerhalb der Exception-Handler geeignete Synchronisationsmechanismen
  eingesetzt werden; so wird sichergestellt, dass der Zugriff auf
  gemeinsam genutzte Ressourcen zwischen den Kernen korrekt koordiniert
  wird. Dies geschieht typischerweise durch den Einsatz von Techniken wie
  Locks, Semaphoren oder atomaren Operationen, um Race Conditions zu
  vermeiden und die Datenintegrität zu wahren.
] else { todo }

#quote(block: true)[
#if lang == "en" [
  Note that the `exception` attribute transforms definitions of static
  variables inside the function by wrapping them into `unsafe` blocks and
  providing us with new appropriate variables of type `&mut` of the same
  name. Thus we can dereference the reference via `*` to access the values
  of the variables without needing to wrap them in an `unsafe` block.
] else if lang == "de" [
  Beachten Sie, dass das Attribut `exception` Definitionen statischer
  Variablen innerhalb der Funktion umwandelt, indem es sie in
  `unsafe`-Blöcke einschließt und uns neue, passende Variablen des Typs
  `&mut` mit demselben Namen zur Verfügung stellt. Auf diese Weise können
  wir die Referenz mittels `*` dereferenzieren, um auf die Werte der
  Variablen zuzugreifen, ohne sie selbst in einen `unsafe`-Block
  einschließen zu müssen.
] else if lang == "zh" [
  注意，`exception`属性，通过将静态变量封装进`unsafe`块中并为我们提供了名字相同的，类型为
  `&mut` 的，合适的新变量，转换了函数中静态变量的定义。因此我们可以通过
  `*` 解引用访问变量的值而不需要将它们打包进一个 `unsafe` 块中。
] else { todo }
]

= #(if lang == "en" [A complete example]
  else if lang == "de" [Ein vollständiges Beispiel]
  else if lang == "zh" [一个完整的例子]
  else { todo })

#if lang == "en" [
  Here's an example that uses the system timer to raise a `SysTick`
  exception roughly every second. The `SysTick` exception handler keeps
  track of how many times it has been called in the `COUNT` variable and
  then prints the value of `COUNT` to the host console using semihosting.
  of the variables without needing to wrap them in an `unsafe` block.
] else if lang == "de" [
  Hier ist ein Beispiel, das den System-Timer verwendet, um etwa jede
  Sekunde eine `SysTick`-Exception auszulösen. Der
  `SysTick`-Exception-Handler protokolliert in der Variablen `COUNT`, wie
  oft er aufgerufen wurde, und gibt anschließend den Wert von `COUNT`
  mittels Semihosting auf der Host-Konsole aus.
] else if lang == "zh" [
  这里有个例子，使用系统计时器大概每秒抛出一个 `SysTick`
  异常。异常处理函数使用 `COUNT`
  变量追踪它自己被调用了多少次，然后使用半主机模式(semihosting)打印
  `COUNT` 的值到主机控制台上。
] else { todo }

#quote(block: true)[
#if lang == "en" [
  *NOTE*: You can run this example on any Cortex-M device; you can
  also run it on QEMU
] else if lang == "de" [
  *HINWEIS*: Sie können dieses Beispiel auf jedem Cortex-M-Gerät
  ausführen; es lässt sich auch unter QEMU ausführen.
] else if lang == "zh" [
  *注意*: 你能在任何Cortex-M设备上运行这个例子;你也能在QEMU运行它。
] else { todo }
]

#raw(block: true, lang: "rust",
"#![deny(unsafe_code)]
#![no_main]
#![no_std]

use panic_halt as _;

use core::fmt::Write;

use cortex_m::peripheral::syst::SystClkSource;
use cortex_m_rt::{entry, exception};
use cortex_m_semihosting::{
    debug,
    hio::{self, HostStream},
};

#[entry]
fn main() -> ! {
    let p = cortex_m::Peripherals::take().unwrap();
    let mut syst = p.SYST;

    // " + if lang == "en" {
        "configures the system timer to trigger a SysTick exception every second"
      } else if lang == "de" {
        "konfiguriert den System-Timer so, dass er jede Sekunde eine SysTick-
    // Exception ausloest"
      } else if lang == "zh" {
        "配置系统的计时器每秒去触发一个SysTick异常"
      } else { todos } + "
    syst.set_clock_source(SystClkSource::Core);
    // " + if lang == "en" {
        "this is configured for the LM3S6965 which has a default CPU clock of 12 MHz"
      } else if lang == "de" {
        "Dies ist für den LM3S6965 konfiguriert, der einen Standard-CPU-Takt von 
    // 12 MHz hat"
      } else if lang == "zh" {
        "这是关于LM3S6965的配置，其有一个12MHz的默认CPU时钟"
      } else { todos } + "
    syst.set_reload(12_000_000);
    syst.clear_current();
    syst.enable_counter();
    syst.enable_interrupt();

    loop {}
}

#[exception]
fn SysTick() {
    static mut COUNT: u32 = 0;
    static mut STDOUT: Option<HostStream> = None;

    *COUNT += 1;

    // " + if lang == "en" {
        "Lazy initialization"
      } else if lang == "de" {
        "Verzoegerte Initialisierung"
      } else if lang == "zh" {
        "惰性初始化(Lazy initialization)"
      } else { todos } + "
    if STDOUT.is_none() {
        *STDOUT = hio::hstdout().ok();
    }

    if let Some(hstdout) = STDOUT.as_mut() {
        write!(hstdout, \"{}\", *COUNT).ok();
    }

    // " + if lang == "en" {
        "IMPORTANT omit this `if` block if running on real hardware or your
    // debugger will end in an inconsistent state"
      } else if lang == "de" {
        "WICHTIG: Lassen Sie diesen `if`-Block weg, wenn Sie das Programm auf 
    //          echter Hardware ausfuehren, da sich Ihr Debugger sonst in 
    //          einem inkonsistenten Zustand befinden wird."
      } else if lang == "zh" {
        "重要信息 如果运行在真正的硬件上，去掉这个 `if` 块，
    // 否则你的调试器将会以一种不一致的状态结束"
      } else { todos } + "
    if *COUNT == 9 {
        // " + if lang == "en" {
            "This will terminate the QEMU process"
          } else if lang == "de" {
            "Dies beendet den QEMU-Prozess."
          } else if lang == "zh" {
            "这将终结QEMU进程"
          } else { todos } + "
        debug::exit(debug::EXIT_SUCCESS);
    }
}
")

```console
tail -n5 Cargo.toml
```

```toml
[dependencies]
cortex-m = "0.5.7"
cortex-m-rt = "0.6.3"
panic-halt = "0.2.0"
cortex-m-semihosting = "0.3.1"
```

```text
$ cargo run --release
     Running `qemu-system-arm -cpu cortex-m3 -machine lm3s6965evb (..)
123456789
```

#if lang == "en" [
  If you run this on the Discovery board you'll see the output on the
  OpenOCD console. Also, the program will _not_ stop when the count
  reaches 9.
] else if lang == "de" [
  Wenn Sie dies auf dem Discovery-Board ausführen, sehen Sie die Ausgabe
  in der OpenOCD-Konsole. Außerdem hält das Programm _nicht_ an, wenn
  der Zählerstand 9 erreicht.
] else if lang == "zh" [
  如果你在Discovery开发板上运行这个例子，你将会在OpenOCD控制台上看到输出。还有，当计数到达9的时候，程序将 _会_ 停止。
] else { todo }

= #(if lang == "en" [The default exception handler]
  else if lang == "de" [Der Standard-Exception-Handler]
  else if lang == "zh" [默认异常处理函数]
  else { todo })

#if lang == "en" [
  What the `exception` attribute actually does is _override_ the
  default exception handler for a specific exception. If you don't
  override the handler for a particular exception it will be handled by
  the `DefaultHandler` function, which defaults to:
] else if lang == "de" [
  Das `exception`-Attribut bewirkt eigentlich, dass der
  Standard-Exception-Handler für eine bestimmte Exception
  _überschrieben_ wird. Wenn Sie den Handler für eine bestimmte
  Exception nicht überschreiben, wird sie von der Funktion
  `DefaultHandler` behandelt, die standardmäßig Folgendes tut:
] else if lang == "zh" [
  `exception` 属性真正做的是，_覆盖_
  了一个特定异常的默认异常处理函数。如果你不覆盖一个特定异常的处理函数，它将会被
  `DefaultHandler` 函数处理，其默认的是:
] else { todo }

```rust
fn DefaultHandler() {
    loop {}
}
```

#if lang == "en" [
  This function is provided by the `cortex-m-rt` crate and marked as
  `#[no_mangle]` so you can put a breakpoint on "DefaultHandler" and catch
  _unhandled_ exceptions.
] else if lang == "de" [
  Diese Funktion wird vom `cortex-m-rt`-Crate bereitgestellt und ist mit
  `#[no_mangle]` markiert, sodass Sie einen Breakpoint auf
  „DefaultHandler" setzen und _unbehandelte_ Exceptions abfangen
  können.
] else if lang == "zh" [
  这个函数是 `cortex-m-rt` crate提供的，且被标记为 `#[no_mangle]`
  因此你能在 "DefaultHandler" 上放置一个断点并捕获 _unhandled_ 异常。
] else { todo }

#if lang == "en" [
  It's possible to override this `DefaultHandler` using the `exception`
  attribute:
] else if lang == "de" [
  Es ist möglich, diesen `DefaultHandler` mithilfe des
  `exception`-Attributs zu überschreiben:
] else if lang == "zh" [
  可以使用 `exception` 属性覆盖这个 `DefaultHandler`:
] else { todo }

#raw(block: true, lang: "rust",
"#[exception]
fn DefaultHandler(irqn: i16) {
    // " + if lang == "en" {
        "custom default handler"
      } else if lang == "de" {
        "benutzerdefinierter Standard-Handler"
      } else if lang == "zh" {
        "自定义默认处理函数"
      } else { todos } + "
}
")

#if lang == "en" [
  The `irqn` argument indicates which exception is being serviced. A
  negative value indicates that a Cortex-M exception is being serviced;
  and zero or a positive value indicate that a device specific exception,
  AKA interrupt, is being serviced.
] else if lang == "de" [
  Das Argument `irqn` gibt an, welche Exception gerade bearbeitet wird.
  Ein negativer Wert zeigt an, dass eine Cortex-M-Exception bearbeitet
  wird, während ein Wert von null oder ein positiver Wert darauf hinweist,
  dass eine gerätespezifische Exception -- auch als Interrupt bezeichnet
  -- bearbeitet wird.
] else if lang == "zh" [
  `irqn` 参数指出了被服务的是哪个异常。一个负数值指出了被服务的是一个Cortex-M异常;0或者一个正数值指出了被服务的是一个设备特定的异常，也就是中断。
] else { todo }

= #(if lang == "en" [The hard fault handler]
  else if lang == "de" [Der "Schwere Fehler"-Handler]
  else if lang == "zh" [硬错误(Hard Fault)处理函数]
  else { todo })

#if lang == "en" [
  The `HardFault` exception is a bit special. This exception is fired when
  the program enters an invalid state so its handler can _not_ return
  as that could result in undefined behavior. Also, the runtime crate does
  a bit of work before the user defined `HardFault` handler is invoked to
  improve debuggability.
] else if lang == "de" [
  Die `HardFault`-Exception nimmt eine Sonderstellung ein. Sie wird
  ausgelöst, wenn das Programm in einen ungültigen Zustand gerät; daher
  darf ihr Handler nicht zurückkehren, da dies zu undefiniertem Verhalten
  führen könnte. Zudem führt die Runtime-Crate einige Vorarbeiten durch,
  bevor der benutzerdefinierte `HardFault`-Handler aufgerufen wird, um die
  Fehlersuche (Debugging) zu erleichtern.
] else if lang == "zh" [
  `HardFault`异常有点特别。当程序进入一个无法工作的状态时，这个异常被触发，因此它的处理函数
  _不能_ 返回，因为这么做可能导致一个未定义的行为。在用户定义的
  `HardFault`
  处理函数被调用之前，运行时crate还做了一些工作以改进调试功能。
] else { todo }

#if lang == "en" [
  The result is that the `HardFault` handler must have the following
  signature: `fn(&ExceptionFrame) -> !`. The argument of the handler is a
  pointer to registers that were pushed into the stack by the exception.
  These registers are a snapshot of the processor state at the moment the
  exception was triggered and are useful to diagnose a hard fault.
] else if lang == "de" [
  Daraus ergibt sich, dass der `HardFault`-Handler folgende Signatur
  aufweisen muss: `fn(&ExceptionFrame) -> !`. Das Argument des Handlers
  ist ein Zeiger auf Register, die beim Auftreten der Exception auf den
  Stack gesichert wurden. Diese Register stellen eine Momentaufnahme des
  Prozessorzustands zum Zeitpunkt der Auslösung der Exception dar und sind
  für die Diagnose eines Hard Faults hilfreich.
] else if lang == "zh" [
  结果是，`HardFault`处理函数必须有下列的签名: `fn(&ExceptionFrame) -> !`
  。处理函数的参数是一个指针，它指向被异常推入栈中的寄存器。这些寄存器是异常被触发那刻，处理器状态的一个记录，能被用来分析一个硬错误。
] else { todo }

#if lang == "en" [
  Here's an example that performs an illegal operation: a read to a
  nonexistent memory location.
] else if lang == "de" [
  Hier ist ein Beispiel für eine unzulässige Operation: der Lesezugriff
  auf eine nicht existierende Speicheradresse.
] else if lang == "zh" [
  这里有个执行不合法操作的案例: 读取一个不存在的存储位置。
] else { todo }

#quote(block: true)[
#if lang == "en" [
  *NOTE*: This program won't work, i.e.~it won't crash, on QEMU
  because `qemu-system-arm -machine lm3s6965evb` doesn't check memory
  loads and will happily return `0`on reads to invalid memory.
] else if lang == "de" [
  *HINWEIS*: Dieses Programm wird unter QEMU nicht fehlschlagen
  (d.~h. es stürzt nicht ab), da `qemu-system-arm -machine lm3s6965evb`
  keine Überprüfung von Speicherzugriffen durchführt und beim Lesen von
  ungültigem Speicher problemlos den Wert `0` zurückgibt.
] else if lang == "zh" [
  *注意*: 这个程序在QEMU上不能起作用，i.e.~它不会崩溃，因为
  `qemu-system-arm -machine lm3s6965evb`
  不对读取存储的操作进行检查，且读取无效存储时将会开心地返回 `0`。
] else { todo }
]


#raw(block: true, lang: "rust",
"#![no_main]
#![no_std]

use panic_halt as _;

use core::fmt::Write;
use core::ptr;

use cortex_m_rt::{entry, exception, ExceptionFrame};
use cortex_m_semihosting::hio;

#[entry]
fn main() -> ! {
    // " + if lang == "en" {
        "read a nonexistent memory location"
      } else if lang == "de" {
        "liest einen nicht existierenden Speicherbereich"
      } else if lang == "zh" {
        "读取一个无效的存储位置"
      } else { todos } + "
    unsafe {
        ptr::read_volatile(0x3FFF_0000 as *const u32);
    }

    loop {}
}

#[exception]
fn HardFault(ef: &ExceptionFrame) -> ! {
    if let Ok(mut hstdout) = hio::hstdout() {
        writeln!(hstdout, \"{:#?}\", ef).ok();
    }

    loop {}
}
")

#if lang == "en" [
  The `HardFault` handler prints the `ExceptionFrame` value. If you run
  this you'll see something like this on the OpenOCD console.
] else if lang == "de" [
  Der `HardFault`-Handler gibt den Wert des `ExceptionFrame` aus. Wenn Sie
  dies ausführen, sehen Sie auf der OpenOCD-Konsole eine Ausgabe wie diese.
] else if lang == "zh" [
  `HardFault`处理函数打印了`ExceptionFrame`值。如果你运行这个，你将会看到下面的东西打印到OpenOCD控制台上。
] else { todo }

```text
$ openocd
(..)
ExceptionFrame {
    r0: 0x3fff0000,
    r1: 0x00000003,
    r2: 0x080032e8,
    r3: 0x00000000,
    r12: 0x00000000,
    lr: 0x080016df,
    pc: 0x080016e2,
    xpsr: 0x61000000,
}
```

#if lang == "en" [
  The `pc` value is the value of the Program Counter at the time of the
  exception and it points to the instruction that triggered the exception.
] else if lang == "de" [
  Der Wert `pc` ist der Wert des Programmzählers zum Zeitpunkt der
  Ausnahme und verweist auf die Anweisung, die die Ausnahme ausgelöst hat.
] else if lang == "zh" [
  `pc`值是异常时程序计数器(Program Counter)的值，它指向触发了异常的指令。
] else { todo }

#if lang == "en" [
  If you look at the disassembly of the program:
] else if lang == "de" [
  Wenn Sie sich den Disassembler des Programms ansehen:
] else if lang == "zh" [
  如果你看向程序的反汇编:
] else { todo }

```text
$ cargo objdump --bin app --release -- -d --no-show-raw-insn --print-imm-hex
(..)
ResetTrampoline:
 8000942:       movw    r0, #0xfffe
 8000946:       movt    r0, #0x3fff
 800094a:       ldr     r0, [r0]
 800094c:       b       #-0x4 <ResetTrampoline+0xa>
```

#if lang == "en" [
  You can lookup the value of the program counter `0x0800094a` in the
  disassembly. You'll see that a load operation (`ldr r0, [r0]` ) caused
  the exception. The `r0` field of `ExceptionFrame` will tell you the
  value of register `r0` was `0x3fff_fffe` at that time.
] else if lang == "de" [
  Den Wert des Programmzählers `0x0800094a` können Sie in der
  Disassemblierung nachschlagen.

  Sie werden sehen, dass eine Ladeoperation (`ldr r0, [r0]`) die Ausnahme
  verursacht hat.

  Das Feld `r0` von `ExceptionFrame` gibt an, dass der Wert des Registers
  `r0` zu diesem Zeitpunkt `0x3fff_fffe` war.
] else if lang == "zh" [
  你可以在反汇编中搜索程序计数器`0x0800094a`的值。你将会看到一个读取操作(`ldr r0, [r0]`)导致了异常。`ExceptionFrame`的`r0`字段将告诉你，那时寄存器`r0`的值是`0x3fff_fffe`
  。
] else { todo }
