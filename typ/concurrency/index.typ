#import "../config.typ": *

#h1(if lang == "en" [Concurrency]
  else if lang == "de" [Nebenläufigkeit]
  else { todo })
<concurrency>
#set heading(offset: whole)

#if lang == "en" [
  Concurrency happens whenever different parts of your program might
  execute at different times or out of order. In an embedded context, this
  includes:
  - interrupt handlers, which run whenever the associated interrupt
    happens,
  - various forms of multithreading, where your microprocessor regularly
    swaps between parts of your program,
  - and in some systems, multiple-core microprocessors, where each core
    can be independently running a different part of your program at the
    same time.
] else if lang == "de" [
  Nebenläufigkeit tritt immer dann auf, wenn verschiedene Teile Ihres
  Programms zu unterschiedlichen Zeiten oder in einer anderen als der
  vorgesehenen Reihenfolge ausgeführt werden können. Im Kontext
  eingebetteter Systeme umfasst dies:
  - Interrupt-Handler, die immer dann ausgeführt werden, wenn der
    zugehörige Interrupt auftritt,
  - verschiedene Formen des Multithreadings, bei denen Ihr Mikroprozessor
    regelmäßig zwischen Teilen Ihres Programms wechselt,
  - und in einigen Systemen Mehrkern-Mikroprozessoren, bei denen jeder
    Kern gleichzeitig und unabhängig voneinander einen anderen Teil Ihres
    Programms ausführen kann.
] else { todo }

#if lang == "en" [
  Since many embedded programs need to deal with interrupts, concurrency
  will usually come up sooner or later, and it's also where many subtle
  and difficult bugs can occur. Luckily, Rust provides a number of
  abstractions and safety guarantees to help us write correct code.
] else if lang == "de" [
  Da viele eingebettete Programme mit Interrupts umgehen müssen, spielt
  Nebenläufigkeit früher oder später meist eine Rolle -- und genau hier
  können auch viele schwer zu findende und komplexe Fehler auftreten.
  Glücklicherweise bietet Rust eine Reihe von Abstraktionen und
  Sicherheitsgarantien, die uns dabei helfen, korrekten Code zu schreiben.
] else { todo }

== #(if lang == "en" [No Concurrency]
  else if lang == "de" [Keine Nebenläufigkeit]
  else { todo })

#if lang == "en" [
  The simplest concurrency for an embedded program is no concurrency: your
  software consists of a single main loop which just keeps running, and
  there are no interrupts at all. Sometimes this is perfectly suited to
  the problem at hand! Typically your loop will read some inputs, perform
  some processing, and write some outputs.
] else if lang == "de" [
  Die einfachste Form der Nebenläufigkeit für ein Embedded-Programm ist
  der Verzicht darauf: Die Software besteht aus einer einzigen
  Hauptschleife, die kontinuierlich durchlaufen wird, und es kommen
  keinerlei Interrupts zum Einsatz. Manchmal ist genau dieser Ansatz für
  die vorliegende Aufgabenstellung ideal! Typischerweise liest die
  Schleife Eingabewerte ein, führt Berechnungen oder Verarbeitungen durch
  und gibt Ergebnisse aus.
] else { todo }

```rust
#[entry]
fn main() {
    let peripherals = setup_peripherals();
    loop {
        let inputs = read_inputs(&peripherals);
        let outputs = process(inputs);
        write_outputs(&peripherals, outputs);
    }
}
```

#if lang == "en" [
  Since there's no concurrency, there's no need to worry about sharing
  data between parts of your program or synchronising access to
  peripherals. If you can get away with such a simple approach this can be
  a great solution.
] else if lang == "de" [
  Da keine Nebenläufigkeit vorliegt, müssen Sie sich keine Gedanken über
  die gemeinsame Datennutzung zwischen verschiedenen Programmteilen oder
  die Synchronisierung des Zugriffs auf Peripheriegeräte machen. Wenn ein
  solch einfacher Ansatz ausreicht, kann dies eine hervorragende Lösung sein.
] else { todo }

== #(if lang == "en" [Global Mutable Data]
  else if lang == "de" [Globale veränderliche Daten]
  else { todo })

#if lang == "en" [
  Unlike non-embedded Rust, we will not usually have the luxury of
  creating heap allocations and passing references to that data into a
  newly-created thread. Instead, our interrupt handlers might be called at
  any time and must know how to access whatever shared memory we are
  using. At the lowest level, this means we must have _statically allocated_
  mutable memory, which both the interrupt handler and the main
  code can refer to.
] else if lang == "de" [
  Im Gegensatz zu Rust-Anwendungen außerhalb des Embedded-Bereichs haben
  wir meist nicht den Luxus, Speicher auf dem Heap zu reservieren und
  Referenzen auf diese Daten an einen neu erstellten Thread zu übergeben.
  Stattdessen können unsere Interrupt-Handler jederzeit aufgerufen werden
  und müssen wissen, wie sie auf den jeweils genutzten gemeinsamen
  Speicher zugreifen können. Auf unterster Ebene bedeutet dies, dass wir
  über _statisch reservierten_, veränderbaren Speicher verfügen
  müssen, auf den sowohl der Interrupt-Handler als auch der
  Hauptprogrammcode zugreifen können.
] else { todo }

#let ln_staticmut = link("https://doc.rust-lang.org/book/ch19-01-unsafe-rust.html#accessing-or-modifying-a-mutable-static-variable")[`static mut`]
#if lang == "en" [
  In Rust, such #ln_staticmut
  variables are always unsafe to read or write, because without taking
  special care, you might trigger a race condition, where your access to
  the variable is interrupted halfway through by an interrupt which also
  accesses that variable.
] else if lang == "de" [
  In Rust ist der Lese- oder Schreibzugriff auf solche
  #ln_staticmut;-Variablen
  stets als `unsafe` (unsicher) eingestuft. Ohne besondere
  Vorsichtsmaßnahmen könnte es nämlich zu einer sogenannten Race Condition
  (Wettlaufsituation) kommen: Der Zugriff auf die Variable wird mitten im
  Vorgang durch einen Interrupt unterbrochen, der seinerseits ebenfalls
  auf diese Variable zugreift.
] else { todo }

#if lang == "en" [
  For an example of how this behaviour can cause subtle errors in your
  code, consider an embedded program which counts rising edges of some
  input signal in each one-second period (a frequency counter):
] else if lang == "de" [
  Um zu veranschaulichen, wie dieses Verhalten subtile Fehler in Ihrem
  Code verursachen kann, betrachten Sie ein eingebettetes Programm, das
  die steigenden Flanken eines Eingangssignals innerhalb jedes
  Ein-Sekunden-Intervalls zählt (einen Frequenzzähler):
] else { todo }

#raw(block: true, lang: "rust",
"static mut COUNTER: u32 = 0;

#[entry]
fn main() -> ! {
    set_timer_1hz();
    let mut last_state = false;
    loop {
        let state = read_signal_level();
        if state && !last_state {
            // " + if lang == "en" {
                "DANGER - Not actually safe! Could cause data races."
              } else if lang == "de" {
                "GEFAHR – Nicht wirklich sicher! Koennte zu Datenwettlaeufen 
            //          fuehren."
              } else { todos } + "
            unsafe { COUNTER += 1 };
        }
        last_state = state;
    }
}

#[interrupt]
fn timer() {
    unsafe { COUNTER = 0; }
}
")

#if lang == "en" [
  Each second, the timer interrupt sets the counter back to 0. Meanwhile,
  the main loop continually measures the signal, and incremements the
  counter when it sees a change from low to high. We've had to use
  `unsafe` to access `COUNTER`, as it's `static mut`, and that means we're
  promising the compiler we won't cause any undefined behaviour. Can you
  spot the race condition? The increment on `COUNTER` is _not_
  guaranteed to be atomic --- in fact, on most embedded platforms, it will
  be split into a load, then the increment, then a store. If the interrupt
  fired after the load but before the store, the reset back to 0 would be
  ignored after the interrupt returns --- and we would count twice as many
  transitions for that period.
] else if lang == "de" [
  Sekündlich setzt der Timer-Interrupt den Zähler auf 0 zurück.
  Währenddessen misst die Hauptschleife kontinuierlich das Signal und
  erhöht den Zähler, sobald ein Wechsel von „Low" auf „High" erkannt wird.
  Wir mussten das Schlüsselwort `unsafe` verwenden, um auf `COUNTER`
  zuzugreifen, da es als `static mut` deklariert ist; damit versichern wir
  dem Compiler, dass wir kein undefiniertes Verhalten verursachen.
  Erkennst du die Race Condition? Die Inkrementierung von `COUNTER` ist
  _nicht_ garantiert atomar -- tatsächlich wird sie auf den meisten
  Embedded-Plattformen in die Schritte Laden, Inkrementieren und Speichern
  aufgeteilt. Würde der Interrupt nach dem Laden, aber vor dem Speichern
  ausgelöst, ginge das Zurücksetzen auf 0 nach der Rückkehr aus dem
  Interrupt verloren -- und wir würden für diesen Zeitraum doppelt so
  viele Signalwechsel zählen.
] else { todo }

== #(if lang == "en" [Critical Sections]
  else if lang == "de" [Kritische Abschnitte]
  else { todo })

#if lang == "en" [
  So, what can we do about data races? A simple approach is to use
  _critical sections_, a context where interrupts are disabled. By
  wrapping the access to `COUNTER` in `main` in a critical section, we can
  be sure the timer interrupt will not fire until we're finished
  incrementing `COUNTER`:
] else if lang == "de" [
  Was können wir also gegen Data Races unternehmen? Ein einfacher Ansatz
  ist die Verwendung von _kritischen Abschnitten_ -- also Bereichen,
  in denen Interrupts deaktiviert sind. Indem wir den Zugriff auf
  `COUNTER` in der Funktion `main` in einen kritischen Abschnitt
  einbetten, stellen wir sicher, dass der Timer-Interrupt erst ausgelöst
  wird, nachdem wir das Inkrementieren von `COUNTER` abgeschlossen haben:
] else { todo }

#raw(block: true, lang: "rust",
"static mut COUNTER: u32 = 0;

#[entry]
fn main() -> ! {
    set_timer_1hz();
    let mut last_state = false;
    loop {
        let state = read_signal_level();
        if state && !last_state {
            // " + if lang == "en" {
                "New critical section ensures synchronised access to COUNTER"
              } else if lang == "de" {
                "Ein neuer kritischer Abschnitt gewaehrleistet den 
            // synchronisierten Zugriff auf COUNTER."
              } else { todos } + "
            cortex_m::interrupt::free(|_| {
                unsafe { COUNTER += 1 };
            });
        }
        last_state = state;
    }
}

#[interrupt]
fn timer() {
    unsafe { COUNTER = 0; }
}
")

#if lang == "en" [
  In this example, we use `cortex_m::interrupt::free`, but other platforms
  will have similar mechanisms for executing code in a critical section.
  This is also the same as disabling interrupts, running some code, and
  then re-enabling interrupts.
] else if lang == "de" [
  In diesem Beispiel verwenden wir `cortex_m::interrupt::free`, doch auch
  andere Plattformen verfügen über ähnliche Mechanismen, um Code in einem
  kritischen Abschnitt auszuführen. Dies entspricht im Grunde dem
  Deaktivieren von Interrupts, der Ausführung von Code und dem
  anschließenden erneuten Aktivieren der Interrupts.
] else { todo }

#if lang == "en" [
  Note we didn't need to put a critical section inside the timer
  interrupt, for two reasons:
  - Writing 0 to `COUNTER` can't be affected by a race since we don't read it
  - It will never be interrupted by the `main` thread anyway
] else if lang == "de" [
  Beachten Sie, dass wir innerhalb des Timer-Interrupts keinen kritischen
  Abschnitt benötigten; dies hat zwei Gründe:
  - Das Schreiben von 0 in `COUNTER` kann nicht von einer Race-Condition
    betroffen sein, da wir den Wert nicht lesen.
  - Es wird ohnehin niemals vom `main`-Thread unterbrochen werden.
] else { todo }

#if lang == "en" [
  If `COUNTER` was being shared by multiple interrupt handlers that might
  _preempt_ each other, then each one might require a critical
  section as well.
] else if lang == "de" [
  Wenn `COUNTER` von mehreren Interrupt-Handlern gemeinsam genutzt würde,
  die sich gegenseitig _unterbrechen_ könnten, müsste jeder von ihnen
  ebenfalls einen kritischen Abschnitt verwenden.
] else { todo }

#if lang == "en" [
  This solves our immediate problem, but we're still left writing a lot of
  unsafe code which we need to carefully reason about, and we might be
  using critical sections needlessly. Since each critical section
  temporarily pauses interrupt processing, there is an associated cost of
  some extra code size and higher interrupt latency and jitter (interrupts
  may take longer to be processed, and the time until they are processed
  will be more variable). Whether this is a problem depends on your
  system, but in general, we'd like to avoid it.
] else if lang == "de" [
  Dies löst zwar unser unmittelbares Problem, doch wir müssen weiterhin
  viel unsicheren Code schreiben, dessen Verhalten wir sorgfältig
  analysieren müssen; zudem setzen wir möglicherweise unnötigerweise
  kritische Abschnitte ein. Da jeder kritische Abschnitt die
  Interrupt-Verarbeitung vorübergehend aussetzt, entstehen Kosten in Form
  von zusätzlichem Codeumfang sowie höherer Interrupt-Latenz und stärkerem
  Jitter (die Verarbeitung von Interrupts kann länger dauern, und die Zeit
  bis zur Verarbeitung schwankt stärker). Ob dies ein Problem darstellt,
  hängt vom jeweiligen System ab, doch im Allgemeinen sollten wir dies
  vermeiden.
] else { todo }

#if lang == "en" [
  It's worth noting that while a critical section guarantees no interrupts
  will fire, it does not provide an exclusivity guarantee on multi-core
  systems! The other core could be happily accessing the same memory as
  your core, even without interrupts. You will need stronger
  synchronisation primitives if you are using multiple cores.
] else if lang == "de" [
  Es ist wichtig zu beachten: Auch wenn ein kritischer Abschnitt
  garantiert, dass keine Interrupts ausgelöst werden, bietet er auf
  Mehrkernsystemen keine Exklusivitätsgarantie! Der andere Rechenkern
  könnte -- selbst ohne Interrupts -- problemlos auf denselben Speicher
  zugreifen wie Ihr eigener Kern. Wenn Sie mehrere Rechenkerne nutzen,
  benötigen Sie daher leistungsfähigere Synchronisationsmechanismen.
] else { todo }

== #(if lang == "en" [Atomic Access]
  else if lang == "de" [Atomarer Zugriff]
  else { todo })

#if lang == "en" [
  On some platforms, special atomic instructions are available, which
  provide guarantees about read-modify-write operations. Specifically for
  Cortex-M: `thumbv6` (Cortex-M0, Cortex-M0+) only provide atomic load and
  store instructions, while `thumbv7` (Cortex-M3 and above) provide full
  Compare and Swap (CAS) instructions. These CAS instructions give an
  alternative to the heavy-handed disabling of all interrupts: we can
  attempt the increment, it will succeed most of the time, but if it was
  interrupted it will automatically retry the entire increment operation.
  These atomic operations are safe even across multiple cores.
] else if lang == "de" [
  Auf einigen Plattformen stehen spezielle atomare Befehle zur Verfügung,
  die Garantien für Lese-Modifizier-Schreib-Operationen
  (Read-Modify-Write) bieten. Speziell für Cortex-M gilt: `thumbv6`
  (Cortex-M0, Cortex-M0+) bietet lediglich atomare Lade- und
  Speicherbefehle, während `thumbv7` (Cortex-M3 und höher) vollständige
  „Compare-and-Swap"-Befehle (CAS) bereitstellt. Diese CAS-Befehle bieten
  eine Alternative zur drastischen Maßnahme, sämtliche Interrupts zu
  deaktivieren: Man kann versuchen, den Inkrementierungsvorgang
  durchzuführen -- was meistens gelingt --, doch sollte eine Unterbrechung
  auftreten, wird der gesamte Vorgang automatisch erneut versucht. Diese
  atomaren Operationen sind auch in Mehrkernsystemen sicher.
] else { todo }

#raw(block: true, lang: "rust",
"use core::sync::atomic::{AtomicUsize, Ordering};

static COUNTER: AtomicUsize = AtomicUsize::new(0);

#[entry]
fn main() -> ! {
    set_timer_1hz();
    let mut last_state = false;
    loop {
        let state = read_signal_level();
        if state && !last_state {
            // " + if lang == "en" {
                "Use `fetch_add` to atomically add 1 to COUNTER"
              } else if lang == "de" {
                "Verwenden Sie `fetch_add`, um 1 atomar zu COUNTER zu addieren."
              } else { todos } + "
            COUNTER.fetch_add(1, Ordering::Relaxed);
        }
        last_state = state;
    }
}

#[interrupt]
fn timer() {
    // " + if lang == "en" {
        "Use `store` to write 0 directly to COUNTER"
      } else if lang == "de" {
        "Verwenden Sie `store`, um 0 direkt in COUNTER zu schreiben."
      } else { todos } + "
    COUNTER.store(0, Ordering::Relaxed)
}
")

#if lang == "en" [
  This time `COUNTER` is a safe `static` variable. Thanks to the
  `AtomicUsize` type `COUNTER` can be safely modified from both the
  interrupt handler and the main thread without disabling interrupts. When
  possible, this is a better solution --- but it may not be supported on
  your platform.
] else if lang == "de" [
  Diesmal ist `COUNTER` eine sichere `static`-Variable. Dank des Typs
  `AtomicUsize` kann `COUNTER` sowohl vom Interrupt-Handler als auch vom
  Hauptthread aus sicher geändert werden, ohne Interrupts zu deaktivieren.
  Wenn möglich, ist dies die bessere Lösung -- wird aber möglicherweise
  von Ihrer Plattform nicht unterstützt.
] else { todo }

#let ln_ordering = link("https://doc.rust-lang.org/core/sync/atomic/enum.Ordering.html")[`Ordering`]
#if lang == "en" [
  A note on #ln_ordering:
  this affects how the compiler and hardware may reorder instructions, and
  also has consequences on cache visibility. Assuming that the target is a
  single core platform `Relaxed` is sufficient and the most efficient
  choice in this particular case. Stricter ordering will cause the
  compiler to emit memory barriers around the atomic operations; depending
  on what you're using atomics for you may or may not need this! The
  precise details of the atomic model are complicated and best described
  elsewhere.
] else if lang == "de" [
  Hinweis zur #ln_ordering:
  Diese beeinflusst, wie Compiler und Hardware Anweisungen neu anordnen,
  und hat auch Auswirkungen auf die Cache-Sichtbarkeit. Bei einer
  Einkernplattform ist die Option `Relaxed` ausreichend und in diesem Fall
  die effizienteste Wahl. Eine strengere Befehlsreihenfolge führt dazu,
  dass der Compiler Speicherbarrieren um die atomaren Operationen erzeugt.
  Je nachdem, wofür Sie atomare Operationen verwenden, benötigen Sie dies
  möglicherweise nicht. Die genauen Details des atomaren Modells sind
  komplex und werden am besten an anderer Stelle beschrieben.
] else { todo }

#let url_atomics = "https://doc.rust-lang.org/nomicon/atomics.html"
#if lang == "en" [
  For more details on atomics and ordering, see the
  #link(url_atomics)[nomicon].
] else if lang == "de" [
  Weitere Informationen zu atomaren Operationen und deren Reihenfolge
  finden Sie im #link(url_atomics)[nomicon].
] else { todo }

== #(if lang == "en" [Abstractions, Send, and Sync]
  else if lang == "de" [Abstraktionen, Send und Sync]
  else { todo })

#if lang == "en" [
  None of the above solutions are especially satisfactory. They require
  `unsafe` blocks which must be very carefully checked and are not
  ergonomic. Surely we can do better in Rust!
] else if lang == "de" [
  Keine der oben genannten Lösungen ist wirklich zufriedenstellend. Sie
  erfordern unsichere Blöcke, die sehr sorgfältig geprüft werden müssen
  und nicht ergonomisch sind. In Rust geht das doch bestimmt besser!
] else { todo }

#if lang == "en" [
  We can abstract our counter into a safe interface which can be safely
  used anywhere else in our code. For this example, we'll use the
  critical-section counter, but you could do something very similar with
  atomics.
] else if lang == "de" [
  Wir können unseren Zähler in eine sichere Schnittstelle abstrahieren,
  die überall im Code sicher verwendet werden kann. In diesem Beispiel
  verwenden wir den Zähler für kritische Abschnitte, aber mit atomaren
  Operationen ließe sich etwas sehr Ähnliches realisieren.
] else { todo }

#raw(block: true, lang: "rust",
"use core::cell::UnsafeCell;
use cortex_m::interrupt;

// " + if lang == "en" {
    "Our counter is just a wrapper around UnsafeCell<u32>, which is the heart
// of interior mutability in Rust. By using interior mutability, we can have
// COUNTER be `static` instead of `static mut`, but still able to mutate
// its counter value."
  } else if lang == "de" {
    "Unser Zaehler ist lediglich ein Wrapper um `UnsafeCell<u32>`, das Herzstueck 
// der „Interior Mutability“ in Rust. Dank dieses Konzepts können wir `COUNTER` 
// als `static` statt als `static mut` definieren und dennoch den Zaehlerwert 
// veraendern."
  } else { todos } + "
struct CSCounter(UnsafeCell<u32>);

const CS_COUNTER_INIT: CSCounter = CSCounter(UnsafeCell::new(0));

impl CSCounter {
    pub fn reset(&self, _cs: &interrupt::CriticalSection) {
        // " + if lang == "en" {
            "By requiring a CriticalSection be passed in, we know we must
        // be operating inside a CriticalSection, and so can confidently
        // use this unsafe block (required to call UnsafeCell::get)."
          } else if lang == "de" {
            "Indem wir die Uebergabe einer `CriticalSection` voraussetzen, wissen 
        // wir, dass wir uns innerhalb einer `CriticalSection` befinden; daher 
        // koennen wir bedenkenlos diesen `unsafe`-Block verwenden (der für den 
        // Aufruf von `UnsafeCell::get` erforderlich ist)."
          } else { todos } + "
        unsafe { *self.0.get() = 0 };
    }

    pub fn increment(&self, _cs: &interrupt::CriticalSection) {
        unsafe { *self.0.get() += 1 };
    }
}

// " + if lang == "en" {
    "Required to allow static CSCounter. See explanation below."
  } else if lang == "de" {
    "Erforderlich, um ein statisches CSCounter zu ermoeglichen. Siehe Erlaeuterung 
// unten."
  } else { todos } + "
unsafe impl Sync for CSCounter {}

// " + if lang == "en" {
    "COUNTER is no longer `mut` as it uses interior mutability;
// therefore it also no longer requires unsafe blocks to access."
  } else if lang == "de" {
    "COUNTER ist nicht mehr `mut`, da es „Interior Mutability“ verwendet; daher 
// sind fuer den Zugriff auch keine `unsafe`-Bloecke mehr erforderlich."
  } else { todos } + "
static COUNTER: CSCounter = CS_COUNTER_INIT;

#[entry]
fn main() -> ! {
    set_timer_1hz();
    let mut last_state = false;
    loop {
        let state = read_signal_level();
        if state && !last_state {
            // " + if lang in ("en", "de") {
                "No unsafe here!"
              } else { todos } + "
            interrupt::free(|cs| COUNTER.increment(cs));
        }
        last_state = state;
    }
}

#[interrupt]
fn timer() {
    // " + if lang == "en" {
        "We do need to enter a critical section here just to obtain a valid
    // cs token, even though we know no other interrupt could pre-empt
    // this one."
      } else if lang == "de" {
        "Wir muessen hier tatsaechlich einen kritischen Abschnitt betreten, nur um 
    // ein gueltiges CS-Token zu erhalten, auch wenn wir wissen, dass kein 
    // anderer Interrupt diesen unterbrechen koennte."
      } else { todos } + "
    interrupt::free(|cs| COUNTER.reset(cs));

    // " + if lang == "en" {
        "We could use unsafe code to generate a fake CriticalSection if we
    // really wanted to, avoiding the overhead:"
      } else if lang == "de" {
        "Wir koennten „unsicheren“ Code (unsafe code) verwenden, um eine 
    // gefaelschte CriticalSection zu erzeugen, falls wir das wirklich wollten, 
    // und so den Overhead vermeiden:"
      } else { todos } + "
    // let cs = unsafe { interrupt::CriticalSection::new() };
}
")

#if lang == "en" [
  We've moved our `unsafe` code to inside our carefully-planned
  abstraction, and now our application code does not contain any `unsafe`
  blocks.
] else if lang == "de" [
  Wir haben unseren `unsafe`-Code in unsere sorgfältig entworfene
  Abstraktion verlagert; nun enthält unser Anwendungscode keine
  `unsafe`-Blöcke mehr.
] else { todo }

#if lang == "en" [
  This design requires that the application pass a `CriticalSection` token
  in: these tokens are only safely generated by `interrupt::free`, so by
  requiring one be passed in, we ensure we are operating inside a critical
  section, without having to actually do the lock ourselves. This
  guarantee is provided statically by the compiler: there won't be any
  runtime overhead associated with `cs`. If we had multiple counters, they
  could all be given the same `cs`, without requiring multiple nested
  critical sections.
] else if lang == "de" [
  Dieser Entwurf setzt voraus, dass die Anwendung ein
  `CriticalSection`-Token übergibt: Da diese Tokens nur sicher durch
  `interrupt::free` erzeugt werden können, stellen wir durch die
  Anforderung eines solchen Tokens sicher, dass wir uns innerhalb eines
  kritischen Abschnitts befinden, ohne die Sperre selbst implementieren zu
  müssen. Diese Garantie wird statisch vom Compiler gewährleistet; es
  entsteht also kein Laufzeit-Overhead durch `cs`. Hätten wir mehrere
  Zähler, könnten diese alle dasselbe `cs` verwenden, ohne dass mehrere
  verschachtelte kritische Abschnitte erforderlich wären.
] else { todo }

#let url_sendsync = "https://doc.rust-lang.org/nomicon/send-and-sync.html"
#if lang == "en" [
  This also brings up an important topic for concurrency in Rust: the
  #link(url_sendsync)[`Send` and `Sync`]
  traits. To summarise the Rust book, a type is Send when it can safely be
  moved to another thread, while it is Sync when it can be safely shared
  between multiple threads. In an embedded context, we consider interrupts
  to be executing in a separate thread to the application code, so
  variables accessed by both an interrupt and the main code must be Sync.
] else if lang == "de" [
  Dies führt zu einem wichtigen Thema der Nebenläufigkeit in Rust: den
  Traits
  #link(url_sendsync)[`Send` und `Sync`].
  Um das „Rust Book" zusammenzufassen: Ein Typ ist `Send`, wenn er sicher
  in einen anderen Thread verschoben werden kann, während er `Sync` ist,
  wenn er sicher zwischen mehreren Threads geteilt werden kann. Im
  Embedded-Kontext betrachten wir Interrupts als Prozesse, die in einem
  vom Anwendungscode getrennten Thread ausgeführt werden; daher müssen
  Variablen, auf die sowohl ein Interrupt als auch der Hauptcode zugreift,
  `Sync` implementieren.
] else { todo }

#let ln_unsafecell = link("https://doc.rust-lang.org/core/cell/struct.UnsafeCell.html")[`UnsafeCell`]
#if lang == "en" [
  For most types in Rust, both of these traits are automatically derived
  for you by the compiler. However, because `CSCounter` contains an #ln_unsafecell,
  it is not Sync, and therefore we could not make a `static CSCounter`:
  `static` variables _must_ be Sync, since they can be accessed by
  multiple threads.
] else if lang == "de" [
  Für die meisten Typen in Rust werden diese beiden Traits automatisch vom
  Compiler für dich abgeleitet. Da `CSCounter` jedoch eine #ln_unsafecell
  enthält, ist der Typ nicht `Sync`\; folglich konnten wir keinen
  `static CSCounter` definieren, denn `static`-Variablen _müssen_
  `Sync` sein, da von mehreren Threads aus auf sie zugegriffen werden
  kann.
] else { todo }

#if lang == "en" [
  To tell the compiler we have taken care that the `CSCounter` is in fact
  safe to share between threads, we implement the Sync trait explicitly.
  As with the previous use of critical sections, this is only safe on
  single-core platforms: with multiple cores, you would need to go to
  greater lengths to ensure safety.
] else if lang == "de" [
  Um dem Compiler mitzuteilen, dass wir sichergestellt haben, dass der
  `CSCounter` tatsächlich gefahrlos zwischen Threads geteilt werden kann,
  implementieren wir das `Sync`-Trait explizit. Wie schon bei der früheren
  Verwendung kritischer Abschnitte ist dies nur auf
  Single-Core-Plattformen sicher; bei mehreren Kernen wäre ein deutlich
  höherer Aufwand erforderlich, um die Sicherheit zu gewährleisten.
] else { todo }

== #(if lang == "en" [Mutexes]
  else if lang == "de" [Mutexe]
  else { todo })

#if lang == "en" [
  We've created a useful abstraction specific to our counter problem, but
  there are many common abstractions used for concurrency.
] else if lang == "de" [
  Wir haben eine nützliche, speziell auf unser Zählerproblem
  zugeschnittene Abstraktion entwickelt; es gibt jedoch viele gängige
  Abstraktionen für Nebenläufigkeit.
] else { todo }

#let ln_drop = link("https://doc.rust-lang.org/core/ops/trait.Drop.html")[`Drop`]
#if lang == "en" [
  One such _synchronisation primitive_ is a mutex, short for mutual
  exclusion. These constructs ensure exclusive access to a variable, such
  as our counter. A thread can attempt to _lock_ (or _acquire_)
  the mutex, and either succeeds immediately, or blocks waiting for the
  lock to be acquired, or returns an error that the mutex could not be
  locked. While that thread holds the lock, it is granted access to the
  protected data. When the thread is done, it _unlocks_ (or
  _releases_) the mutex, allowing another thread to lock it. In Rust,
  we would usually implement the unlock using the #ln_drop
  trait to ensure it is always released when the mutex goes out of scope.
] else if lang == "de" [
  Ein solches _Synchronisationsprimitiv_ ist der Mutex (kurz für
  „mutual exclusion", also gegenseitiger Ausschluss). Diese Konstrukte
  gewährleisten den exklusiven Zugriff auf eine Variable, wie etwa unseren
  Zähler. Ein Thread kann versuchen, den Mutex zu _sperren_ (oder zu
  _erwerben_); dabei ist er entweder sofort erfolgreich, blockiert,
  bis die Sperre verfügbar ist, oder erhält eine Fehlermeldung, dass der
  Mutex nicht gesperrt werden konnte. Solange der Thread die Sperre hält,
  hat er Zugriff auf die geschützten Daten. Ist der Thread fertig,
  _entsperrt_ (oder _gibt_) er den Mutex _frei_, sodass ein
  anderer Thread ihn sperren kann. In Rust würden wir die Freigabe
  üblicherweise mithilfe des
  #ln_drop;-Traits
  implementieren; so ist sichergestellt, dass der Mutex immer freigegeben
  wird, sobald er den Gültigkeitsbereich (Scope) verlässt.
] else { todo }

#if lang == "en" [
  Using a mutex with interrupt handlers can be tricky: it is not normally
  acceptable for the interrupt handler to block, and it would be
  especially disastrous for it to block waiting for the main thread to
  release a lock, since we would then _deadlock_ (the main thread
  will never release the lock because execution stays in the interrupt
  handler). Deadlocking is not considered unsafe: it is possible even in
  safe Rust.
] else if lang == "de" [
  Die Verwendung eines Mutex in Interrupt-Handlern kann tückisch sein:
  Normalerweise darf ein Interrupt-Handler nicht blockieren. Besonders
  fatal wäre es, wenn er blockieren würde, während er darauf wartet, dass
  der Haupt-Thread eine Sperre (Lock) freigibt, da dies zu einem
  _Deadlock_ führen würde (der Haupt-Thread würde die Sperre niemals
  freigeben, da die Ausführung im Interrupt-Handler verbleibt). Ein
  Deadlock gilt nicht als „unsicher" (unsafe): Er ist selbst in sicherem
  Rust möglich.
] else { todo }

#if lang == "en" [
  To avoid this behaviour entirely, we could implement a mutex which
  requires a critical section to lock, just like our counter example. So
  long as the critical section must last as long as the lock, we can be
  sure we have exclusive access to the wrapped variable without even
  needing to track the lock/unlock state of the mutex.
] else if lang == "de" [
  Um dieses Verhalten vollständig zu vermeiden, könnten wir einen Mutex
  implementieren, der für das Sperren eine kritische Sektion erfordert --
  genau wie in unserem Zähler-Beispiel. Solange die Dauer der kritischen
  Sektion der Dauer der Sperre entspricht, ist sichergestellt, dass wir
  exklusiven Zugriff auf die gekapselte Variable haben, ohne den
  Sperrstatus des Mutex explizit nachverfolgen zu müssen.
] else { todo }

#if lang == "en" [
  This is in fact done for us in the `cortex_m` crate! We could have
  written our counter using it:
] else if lang == "de" [
  Genau dies wird uns bereits durch die `cortex_m`-Crate abgenommen! Wir
  hätten unseren Zähler auch unter Verwendung dieser Crate implementieren können:
] else { todo }

#raw(block: true, lang: "rust",
"use core::cell::Cell;
use cortex_m::interrupt::Mutex;

static COUNTER: Mutex<Cell<u32>> = Mutex::new(Cell::new(0));

#[entry]
fn main() -> ! {
    set_timer_1hz();
    let mut last_state = false;
    loop {
        let state = read_signal_level();
        if state && !last_state {
            interrupt::free(|cs|
                COUNTER.borrow(cs).set(COUNTER.borrow(cs).get() + 1));
        }
        last_state = state;
    }
}

#[interrupt]
fn timer() {
    // " + if lang == "en" {
        "We still need to enter a critical section here to satisfy the Mutex."
      } else if lang == "de" {
        "Wir muessen hier noch einen kritischen Abschnitt betreten, um die 
    // Mutex-Bedingung zu erfuellen."
      } else { todos } + "
    interrupt::free(|cs| COUNTER.borrow(cs).set(0));
}
")

#let ln_cell = link("https://doc.rust-lang.org/core/cell/struct.Cell.html")[`Cell`]
#if lang == "en" [
  We're now using #ln_cell,
  which along with its sibling `RefCell` is used to provide safe interior
  mutability. We've already seen `UnsafeCell` which is the bottom layer of
  interior mutability in Rust: it allows you to obtain multiple mutable
  references to its value, but only with unsafe code. A `Cell` is like an
  `UnsafeCell` but it provides a safe interface: it only permits taking a
  copy of the current value or replacing it, not taking a reference, and
  since it is not Sync, it cannot be shared between threads. These
  constraints mean it's safe to use, but we couldn't use it directly in a
  `static` variable as a `static` must be Sync.
] else if lang == "de" [
  Wir verwenden nun #ln_cell;;
  dieses bietet -- ebenso wie sein Pendant `RefCell` -- eine sichere Form
  der „Interior Mutability" (internen Veränderbarkeit). Wir haben bereits
  `UnsafeCell` kennengelernt, die unterste Ebene der internen
  Veränderbarkeit in Rust: Sie ermöglicht es, mehrere veränderbare
  Referenzen auf den enthaltenen Wert zu erhalten, allerdings nur mittels
  `unsafe`-Code. Eine `Cell` ähnelt einer `UnsafeCell`, stellt jedoch eine
  sichere Schnittstelle bereit: Sie erlaubt lediglich das Kopieren des
  aktuellen Werts oder dessen Austausch, nicht jedoch den Zugriff über
  eine Referenz; zudem ist sie nicht `Sync` und kann daher nicht zwischen
  Threads geteilt werden. Aufgrund dieser Einschränkungen ist ihre
  Verwendung sicher, allerdings lässt sie sich nicht direkt in einer
  `static`-Variablen einsetzen, da `static`-Elemente die Eigenschaft
  `Sync` erfüllen müssen.
] else { todo }

#if lang == "en" [
  So why does the example above work? The `Mutex<T>` implements Sync for
  any `T` which is Send --- such as a `Cell`. It can do this safely
  because it only gives access to its contents during a critical section.
  We're therefore able to get a safe counter with no unsafe code at all!
] else if lang == "de" [
  Warum funktioniert das obige Beispiel? Der `Mutex<T>` implementiert
  `Sync` für jedes `T`, das `Send` ist -- wie beispielsweise eine `Cell`.
  Dies ist sicher möglich, da der Zugriff auf den Inhalt nur während eines
  kritischen Abschnitts gewährt wird. Dadurch erhalten wir einen sicheren
  Zähler ohne jeglichen unsicheren Code!
] else { todo }

#if lang == "en" [
  This is great for simple types like the `u32` of our counter, but what
  about more complex types which are not Copy? An extremely common example
  in an embedded context is a peripheral struct, which generally is not
  Copy. For that, we can turn to `RefCell`.
] else if lang == "de" [
  Das ist ideal für einfache Typen wie den `u32` unseres Zählers. Was aber
  ist mit komplexeren Typen, die nicht `Copy` sind? Ein sehr häufiges
  Beispiel in eingebetteten Systemen ist eine Peripheriestruktur, die in
  der Regel nicht `Copy` ist. Für diesen Fall können wir `RefCell`
  verwenden.
] else { todo }

== #(if lang == "en" [Sharing Peripherals]
  else if lang == "de" [Gemeinsame Nutzung von Peripheriegeräten]
  else { todo })

#if lang == "en" [
  Device crates generated using `svd2rust` and similar abstractions
  provide safe access to peripherals by enforcing that only one instance
  of the peripheral struct can exist at a time. This ensures safety, but
  makes it difficult to access a peripheral from both the main thread and
  an interrupt handler.
] else if lang == "de" [
  Mit `svd2rust` und ähnlichen Abstraktionen erzeugte Device-Crates
  ermöglichen einen sicheren Zugriff auf Peripheriekomponenten, indem sie
  sicherstellen, dass zu jedem Zeitpunkt nur eine einzige Instanz der
  entsprechenden Peripherie-Struktur existiert. Dies gewährleistet zwar
  die Sicherheit, erschwert jedoch den gleichzeitigen Zugriff auf eine
  Peripheriekomponente sowohl aus dem Haupt-Thread als auch aus einem
  Interrupt-Handler heraus.
] else { todo }

#let ln_refcell = link("https://doc.rust-lang.org/core/cell/struct.RefCell.html")[`RefCell`]
#if lang == "en" [
  To safely share peripheral access, we can use the `Mutex` we saw before.
  We'll also need to use #ln_refcell,
  which uses a runtime check to ensure only one reference to a peripheral
  is given out at a time. This has more overhead than the plain `Cell`,
  but since we are giving out references rather than copies, we must be
  sure only one exists at a time.
] else if lang == "de" [
  Um den Zugriff auf Peripheriekomponenten sicher zu teilen, können wir
  den bereits bekannten `Mutex` verwenden. Zudem benötigen wir
  #link("https://doc.rust-lang.org/core/cell/struct.RefCell.html")[`RefCell`]\;
  dieses stellt mittels einer Laufzeitprüfung sicher, dass jeweils nur
  eine einzige Referenz auf eine Peripheriekomponente ausgegeben wird.
  Dies ist zwar mit einem höheren Overhead verbunden als bei einem
  einfachen `Cell`, doch da wir Referenzen anstatt Kopien weitergeben,
  müssen wir sicherstellen, dass zu jedem Zeitpunkt nur eine einzige
  Referenz existiert.
] else { todo }

#if lang == "en" [
  Finally, we'll also have to account for somehow moving the peripheral
  into the shared variable after it has been initialised in the main code.
  To do this we can use the `Option` type, initialised to `None` and later
  set to the instance of the peripheral.
] else if lang == "de" [
  Schließlich müssen wir auch berücksichtigen, wie die
  Peripheriekomponente in die gemeinsam genutzte Variable übertragen
  werden kann, nachdem sie im Hauptcode initialisiert wurde. Hierfür
  können wir den Typ `Option` verwenden, der zunächst mit `None`
  initialisiert und später auf die Instanz der Peripheriekomponente
  gesetzt wird.
] else { todo }

#raw(block: true, lang: "rust",
"use core::cell::RefCell;
use cortex_m::interrupt::{self, Mutex};
use stm32f4::stm32f405;

static MY_GPIO: Mutex<RefCell<Option<stm32f405::GPIOA>>> =
    Mutex::new(RefCell::new(None));

#[entry]
fn main() -> ! {
    // " + if lang == "en" {
        "Obtain the peripheral singletons and configure it.
    // This example is from an svd2rust-generated crate, but
    // most embedded device crates will be similar."
      } else if lang == "de" {
        "Die Peripherie-Singletons abrufen und konfigurieren.
    // Dieses Beispiel stammt aus einer mit svd2rust erstellten Crate, die 
    // meisten Crates für eingebettete Geräte sind jedoch ähnlich."
      } else { todos } + "
    let dp = stm32f405::Peripherals::take().unwrap();
    let gpioa = &dp.GPIOA;

    // " + if lang == "en" {
        "Some sort of configuration function.
    // Assume it sets PA0 to an input and PA1 to an output."
      } else if lang == "de" {
        "Eine Art Konfigurationsfunktion.
    // Gehen wir davon aus, dass es PA0 als Eingang und PA1 als Ausgang 
    // konfiguriert."
      } else { todos } + "
    configure_gpio(gpioa);

    // " + if lang == "en" {
        "Store the GPIOA in the mutex, moving it."
      } else if lang == "de" {
        "Speichere GPIOA im Mutex und verschiebe es dabei."
      } else { todos } + "
    interrupt::free(|cs| MY_GPIO.borrow(cs).replace(Some(dp.GPIOA)));
    // " + if lang == "en" {
        "We can no longer use `gpioa` or `dp.GPIOA`, and instead have to"
      } else if lang == "de" {
        "Wir koennen `gpioa` oder `dp.GPIOA` nicht mehr verwenden, sondern 
    // muessen stattdessen ueber den Mutex darauf zugreifen."
      } else { todos } + "
    // access it via the mutex.

    // " + if lang == "en" {
        "Be careful to enable the interrupt only after setting MY_GPIO:
    // otherwise the interrupt might fire while it still contains None,
    // and as-written (with `unwrap()`), it would panic."
      } else if lang == "de" {
        "Achten Sie darauf, den Interrupt erst nach dem Setzen von MY_GPIO zu 
    // aktivieren:
    // Andernfalls koennte der Interrupt ausgeloest werden, solange MY_GPIO 
    // noch None enthaelt, was – wie implementiert (mit `unwrap()`) – zu einer 
    // Panic fuehren wuerde."
      } else { todos } + "
    set_timer_1hz();
    let mut last_state = false;
    loop {
        // " + if lang == "en" {
            "We'll now read state as a digital input, via the mutex"
          } else if lang == "de" {
            "Wir lesen den Status nun als digitalen Eingang ueber den Mutex aus."
          } else { todos } + "
        let state = interrupt::free(|cs| {
            let gpioa = MY_GPIO.borrow(cs).borrow();
            gpioa.as_ref().unwrap().idr.read().idr0().bit_is_set()
        });

        if state && !last_state {
            // " + if lang == "en" {
                "Set PA1 high if we've seen a rising edge on PA0."
              } else if lang == "de" {
                "Setze PA1 auf High, wenn an PA0 eine steigende Flanke erkannt 
            // wurde."
              } else { todos } + "
            interrupt::free(|cs| {
                let gpioa = MY_GPIO.borrow(cs).borrow();
                gpioa.as_ref().unwrap().odr.modify(|_, w| w.odr1().set_bit());
            });
        }
        last_state = state;
    }
}

#[interrupt]
fn timer() {
    // " + if lang == "en" {
        "This time in the interrupt we'll just clear PA0."
      } else if lang == "de" {
        "Diesmal setzen wir im Interrupt lediglich PA0 zurueck."
      } else { todos } + "
    interrupt::free(|cs| {
        // " + if lang == "en" {
            "We can use `unwrap()` because we know the interrupt wasn't enabled
        // until after MY_GPIO was set; otherwise we should handle the potential
        // for a None value."
          } else if lang == "de" {
            "Wir koennen `unwrap()` verwenden, da wir wissen, dass der Interrupt 
        // erst aktiviert wurde, nachdem `MY_GPIO` gesetzt war; andernfalls 
        // muessten wir den moeglichen Fall eines `None`-Werts behandeln."
          } else { todos } + "
        let gpioa = MY_GPIO.borrow(cs).borrow();
        gpioa.as_ref().unwrap().odr.modify(|_, w| w.odr1().clear_bit());
    });
}
")

#if lang == "en" [
  That's quite a lot to take in, so let's break down the important lines.
] else if lang == "de" [
  Das ist eine ganze Menge, die man erst einmal verarbeiten muss --
  schauen wir uns also die wichtigen Zeilen genauer an.
] else { todo }

```rust
static MY_GPIO: Mutex<RefCell<Option<stm32f405::GPIOA>>> =
    Mutex::new(RefCell::new(None));
```

#if lang == "en" [
  Our shared variable is now a `Mutex` around a `RefCell` which contains
  an `Option`. The `Mutex` ensures we only have access during a critical
  section, and therefore makes the variable Sync, even though a plain
  `RefCell` would not be Sync. The `RefCell` gives us interior mutability
  with references, which we'll need to use our `GPIOA`. The `Option` lets
  us initialise this variable to something empty, and only later actually
  move the variable in. We cannot access the peripheral singleton
  statically, only at runtime, so this is required.
] else if lang == "de" [
  Unsere gemeinsam genutzte Variable ist nun ein `Mutex`, der einen
  `RefCell` umschließt, welcher wiederum ein `Option` enthält. Der `Mutex`
  stellt sicher, dass der Zugriff nur innerhalb eines kritischen
  Abschnitts erfolgt, und macht die Variable dadurch `Sync` -- auch wenn
  ein einfacher `RefCell` dies nicht wäre. Der `RefCell` ermöglicht uns
  „Interior Mutability" (interne Veränderbarkeit) bei Verwendung von
  Referenzen, was wir für unseren `GPIOA` benötigen. Das `Option` erlaubt
  es uns, die Variable zunächst leer zu initialisieren und den
  eigentlichen Wert erst später hineinzubewegen. Da wir nicht statisch,
  sondern nur zur Laufzeit auf das Peripherie-Singleton zugreifen können,
  ist dieses Vorgehen erforderlich.
] else { todo }

```rust
interrupt::free(|cs| MY_GPIO.borrow(cs).replace(Some(dp.GPIOA)));
```

#if lang == "en" [
  Inside a critical section we can call `borrow()` on the mutex, which
  gives us a reference to the `RefCell`. We then call `replace()` to move
  our new value into the `RefCell`.
] else if lang == "de" [
  Innerhalb eines kritischen Abschnitts können wir `borrow()` auf dem
  Mutex aufrufen, was uns eine Referenz auf die `RefCell` liefert.
  Anschließend rufen wir `replace()` auf, um unseren neuen Wert in die
  `RefCell` zu verschieben.
] else { todo }

```rust
interrupt::free(|cs| {
    let gpioa = MY_GPIO.borrow(cs).borrow();
    gpioa.as_ref().unwrap().odr.modify(|_, w| w.odr1().set_bit());
});
```

#if lang == "en" [
  Finally, we use `MY_GPIO` in a safe and concurrent fashion. The critical
  section prevents the interrupt firing as usual, and lets us borrow the
  mutex. The `RefCell` then gives us an `&Option<GPIOA>`, and tracks how
  long it remains borrowed - once that reference goes out of scope, the
  `RefCell` will be updated to indicate it is no longer borrowed.
] else if lang == "de" [
  Schließlich verwenden wir `MY_GPIO` auf sichere und nebenläufige Weise.
  Der kritische Abschnitt verhindert wie üblich das Auslösen von
  Interrupts und ermöglicht es uns, den Mutex auszuleihen. Die `RefCell`
  liefert uns dann ein `&Option<GPIOA>` und überwacht die Dauer der
  Ausleihe; sobald die Referenz ihren Gültigkeitsbereich verlässt, wird
  der Status der `RefCell` aktualisiert, um anzuzeigen, dass sie nicht
  mehr ausgeliehen ist.
] else { todo }

#if lang == "en" [
  Since we can't move the `GPIOA` out of the `&Option`, we need to convert
  it to an `&Option<&GPIOA>` with `as_ref()`, which we can finally
  `unwrap()` to obtain the `&GPIOA` which lets us modify the peripheral.
] else if lang == "de" [
  Da wir das `GPIOA`-Objekt nicht aus dem `&Option` herausverschieben
  können, müssen wir es mittels `as_ref()` in ein `&Option<&GPIOA>`
  umwandeln. Dieses können wir schließlich mit `unwrap()` auflösen, um das
  `&GPIOA` zu erhalten, das uns den Zugriff zur Modifikation der
  Peripherieeinheit ermöglicht.
] else { todo }

#if lang == "en" [
  If we need a mutable reference to a shared resource, then `borrow_mut`
  and `deref_mut` should be used instead. The following code shows an
  example using the TIM2 timer.
] else if lang == "de" [
  Wenn wir eine veränderbare Referenz auf eine gemeinsam genutzte
  Ressource benötigen, sollten stattdessen `borrow_mut` und `deref_mut`
  verwendet werden. Der folgende Code zeigt ein Beispiel unter Verwendung
  des TIM2-Timers.
] else { todo }

#raw(block: true, lang: "rust",
"use core::cell::RefCell;
use core::ops::DerefMut;
use cortex_m::interrupt::{self, Mutex};
use cortex_m::asm::wfi;
use stm32f4::stm32f405;

static G_TIM: Mutex<RefCell<Option<Timer<stm32::TIM2>>>> =
    Mutex::new(RefCell::new(None));

#[entry]
fn main() -> ! {
    let mut cp = cm::Peripherals::take().unwrap();
    let dp = stm32f405::Peripherals::take().unwrap();

    // " + if lang == "en" {
        "Some sort of timer configuration function.
    // Assume it configures the TIM2 timer, its NVIC interrupt,
    // and finally starts the timer."
      } else if lang == "de" {
        "Eine Art Timer-Konfigurationsfunktion. 
    // Angenommen, sie konfiguriert den TIM2-Timer sowie dessen NVIC-Interrupt 
    // und startet schließlich den Timer."
      } else { todos } + "
    let tim = configure_timer_interrupt(&mut cp, dp);

    interrupt::free(|cs| {
        G_TIM.borrow(cs).replace(Some(tim));
    });

    loop {
        wfi();
    }
}

#[interrupt]
fn timer() {
    interrupt::free(|cs| {
        if let Some(ref mut tim)) =  G_TIM.borrow(cs).borrow_mut().deref_mut() {
            tim.start(1.hz());
        }
    });
}
")

#if lang == "en" [
  Whew! This is safe, but it is also a little unwieldy. Is there anything
  else we can do?
] else if lang == "de" [
  Puh! Das ist zwar sicher, aber auch etwas unhandlich. Können wir sonst
  noch etwas tun?
] else { todo }

== RTIC

#let url_rtic = "https://rtic.rs"
#if lang == "en" [
  One alternative is the #link(url_rtic)[RTIC framework], short for Real Time
  Interrupt-driven Concurrency. It enforces static priorities and tracks
  accesses to `static mut` variables ("resources") to statically ensure
  that shared resources are always accessed safely, without requiring the
  overhead of always entering critical sections and using reference
  counting (as in `RefCell`). This has a number of advantages such as
  guaranteeing no deadlocks and giving extremely low time and memory
  overhead.
] else if lang == "de" [
  Eine Alternative ist das
  #link(url_rtic)[RTIC-Framework] (kurz für _Real
  Time Interrupt-driven Concurrency_). Es erzwingt statische Prioritäten
  und überwacht Zugriffe auf `static mut`-Variablen („Ressourcen"), um
  statisch sicherzustellen, dass auf gemeinsam genutzte Ressourcen stets
  sicher zugegriffen wird -- ohne den Overhead, der durch das ständige
  Betreten kritischer Abschnitte oder die Verwendung von Referenzzählung
  (wie bei `RefCell`) entstünde. Dies bietet eine Reihe von Vorteilen, wie
  etwa die Garantie von Deadlock-Freiheit sowie einen extrem geringen
  Zeit- und Speicheraufwand.
] else { todo }

#if lang == "en" [
  RTIC comes with as asynchronous executor, so your software tasks are
  `async` functions where you can use `async` APIs in addition to regular
  synchronous APIs.
] else if lang == "de" [
  RTIC bietet einen asynchronen Executor, sodass Ihre Software-Tasks als
  `async`-Funktionen implementiert sind; darin können Sie neben
  herkömmlichen synchronen APIs auch `async`-APIs nutzen.
] else { todo }

#if lang == "en" [
  The framework also includes other features like message passing, which
  reduces the need for explicit shared state, and the ability to schedule
  tasks to run at a given time, which can be used to implement periodic
  tasks. Check out #link(url_rtic)[the documentation] for more
  information!
] else if lang == "de" [
  Das Framework umfasst zudem Funktionen wie Message Passing -- was den
  Bedarf an explizit gemeinsam genutztem Zustand (Shared State) verringert
  -- sowie die Möglichkeit, Tasks für einen bestimmten Zeitpunkt zu
  planen, womit sich beispielsweise periodische Aufgaben realisieren
  lassen. Weitere Informationen finden Sie in
  #link(url_rtic)[der Dokumentation]!
] else { todo }

== Embassy

#let url_executor = "https://docs.rs/embassy-executor/latest/embassy_executor/"
#if lang == "en" [
  Embassy is an ecosystem of libraries which focus on using the `async` /
  `await` syntax included in Rust for concurrency. The core of embassy is
  its #link(url_executor)[asynchronous executor]
  which supports most common MCU architectures.
] else if lang == "de" [
  Embassy ist ein Ökosystem von Bibliotheken, die sich auf die Nutzung der
  in Rust enthaltenen `async`/`await`-Syntax für Nebenläufigkeit
  konzentrieren. Das Herzstück von Embassy ist sein
  #link(url_executor)[asynchroner Executor],
  der die gängigsten MCU-Architekturen unterstützt.
] else { todo }

#let url_em_time = "https://docs.rs/embassy-time/latest/embassy_time/"
#let ln_en_sync = link("https://docs.embassy.dev/embassy-sync/git/default/index.html")[embassy-sync]
#if lang == "en" [
  embassy also takes a battery-included approach and offers many other
  components, for example:
  - #link(url_em_time)[Time library]
  - Various HAL libraries which also provide the time library support.
  - #ln_en_sync for synchronization primitives
] else if lang == "de" [
  Embassy verfolgt zudem einen „Batteries-included"-Ansatz und bietet
  viele weitere Komponenten an, zum Beispiel:
  - #link(url_em_time)[Zeit-Bibliothek]
  - Verschiedene HAL-Bibliotheken, die auch Unterstützung für die
    Zeitbibliothek bieten.
  - #ln_en_sync für Synchronisationsprimitive
] else { todo }

#let url_em_site = "https://embassy.dev/"
#let url_em_book = "https://embassy.dev/book/"
#if lang == "en" [
  You can check the #link(url_em_site)[website] and the
  #link(url_em_book)[book] for more information.
] else if lang == "de" [
  Weitere Informationen finden Sie auf der
  #link(url_em_site)[Website] und im #link(url_em_book)[Buch].
] else { todo }

== #(if lang == "en" [Real Time Operating Systems]
  else if lang == "de" [Echtzeitbetriebssysteme]
  else { todo })

#let ln_freertos = link("https://freertos.org/")[FreeRTOS]
#let ln_chibi = link("http://chibios.org/")[ChibiOS]
#if lang == "en" [
  Another common model for embedded concurrency is the real-time operating
  system (RTOS). While currently less well explored in Rust, they are
  widely used in traditional embedded development. Open source examples
  include #ln_freertos and #ln_chibi. These RTOSs provide support for
  running multiple application threads which the CPU swaps between, either
  when the threads yield control (called cooperative multitasking) or
  based on a regular timer or interrupts (preemptive multitasking). The
  RTOS typically provide mutexes and other synchronisation primitives, and
  often interoperate with hardware features such as DMA engines.
] else if lang == "de" [
  Ein weiteres verbreitetes Modell für Nebenläufigkeit in eingebetteten
  Systemen ist das Echtzeitbetriebssystem (RTOS). Während diese in Rust
  bislang weniger stark erforscht sind, kommen sie in der klassischen
  Entwicklung eingebetteter Systeme häufig zum Einsatz. Zu den
  Open-Source-Beispielen zählen #ln_freertos und #ln_chibi.
  Solche Echtzeitbetriebssysteme unterstützen die Ausführung mehrerer
  Anwendungsthreads, zwischen denen die CPU wechselt -- entweder wenn die
  Threads die Kontrolle freiwillig abgeben (kooperatives Multitasking)
  oder gesteuert durch Timer bzw. Interrupts (präemptives Multitasking).
  Typischerweise stellen RTOS Mechanismen wie Mutexe und andere
  Synchronisationsprimitive bereit und interagieren häufig mit
  Hardwarefunktionen wie DMA-Controllern.
] else { todo }

#if lang == "en" [
  At the time of writing, there are not many Rust RTOS examples to point
  to, but it's an interesting area so watch this space!
] else if lang == "de" [
  Zum jetzigen Zeitpunkt gibt es noch nicht viele Beispiele für Rust-RTOS,
  auf die man verweisen könnte; es handelt sich jedoch um ein
  interessantes Gebiet -- bleiben Sie also dran!
] else { todo }

== #(if lang == "en" [Multiple Cores]
  else if lang == "de" [Mehrere Kerne]
  else { todo })

#if lang == "en" [
  It is becoming more common to have two or more cores in embedded
  processors, which adds an extra layer of complexity to concurrency. All
  the examples using a critical section (including the
  `cortex_m::interrupt::Mutex`) assume the only other execution thread is
  the interrupt thread, but on a multi-core system that's no longer true.
  Instead, we'll need synchronisation primitives designed for multiple
  cores (also called SMP, for symmetric multi-processing).
] else if lang == "de" [
  Es wird immer üblicher, eingebettete Prozessoren mit zwei oder mehr
  Kernen auszustatten, was die Parallelverarbeitung zusätzlich
  verkompliziert. Alle Beispiele mit kritischen Abschnitten
  (einschließlich `cortex_m::interrupt::Mutex`) gehen davon aus, dass der
  einzige weitere Ausführungsthread der Interrupt-Thread ist. Auf einem
  Mehrkernsystem trifft dies jedoch nicht mehr zu. Stattdessen benötigen
  wir Synchronisierungsprimitive, die speziell für Mehrkernsysteme (auch
  SMP, für symmetrisches Multiprocessing, genannt) entwickelt wurden.
] else { todo }

#if lang == "en" [
  These typically use the atomic instructions we saw earlier, since the
  processing system will ensure that atomicity is maintained over all cores.
] else if lang == "de" [
  Diese verwenden typischerweise die bereits erwähnten atomaren Befehle,
  da das Verarbeitungssystem die Atomarität über alle Kerne hinweg
  gewährleistet.
] else { todo }

#if lang == "en" [
  Covering these topics in detail is currently beyond the scope of this
  book, but the general patterns are the same as for the single-core case.
] else if lang == "de" [
  Eine detaillierte Behandlung dieser Themen würde den Rahmen dieses
  Buches sprengen, die allgemeinen Muster sind jedoch dieselben wie im
  Einzelkernfall.
] else { todo }
