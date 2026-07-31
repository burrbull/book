#import "../config.typ": *

#h1(if lang == "en" [Collections]
  else if lang == "de" [Sammlungen (Collections)]
  else { todo })
#set heading(offset: whole)

#let ln_vec = link("https://doc.rust-lang.org/std/vec/struct.Vec.html")[`Vec`]
#let ln_string = link("https://doc.rust-lang.org/std/string/struct.String.html")[`String`]
#let ln_map = link("https://doc.rust-lang.org/std/collections/struct.HashMap.html")[`HashMap`]
#if lang == "en" [
  Eventually you'll want to use dynamic data structures (AKA collections)
  in your program. `std` provides a set of common collections:
  #ln_vec, #ln_string, #ln_map, etc.
  All the collections implemented in `std` use a global dynamic
  memory allocator (AKA the heap).
] else if lang == "de" [
  Irgendwann wirst du in deinem Programm dynamische Datenstrukturen (auch
  bekannt als Collections) verwenden wollen. Die Standardbibliothek
  (`std`) stellt eine Reihe gängiger Collections bereit:
  #ln_vec, #ln_string, #ln_map usw.
  Alle in `std` implementierten Collections nutzen einen globalen
  dynamischen Speicherverwalter (den sogenannten Heap).
] else { todo }

#if lang == "en" [
  As `core` is, by definition, free of memory allocations these
  implementations are not available there, but they can be found in the
  `alloc` crate that's shipped with the compiler.
] else if lang == "de" [
  Da `core` definitionsgemäß frei von Speicherzuweisungen ist, stehen
  diese Implementierungen dort nicht zur Verfügung; sie sind jedoch im
  `alloc`-Crate zu finden, das mit dem Compiler ausgeliefert wird.
] else { todo }

#let ln_heapless = link("https://crates.io/crates/heapless")[`heapless`]
#if lang == "en" [
  If you need collections, a heap allocated implementation is not your
  only option. You can also use _fixed capacity_ collections; one
  such implementation can be found in the #ln_heapless crate.
] else if lang == "de" [
  Wenn Sie Sammlungen benötigen, ist eine auf dem Heap alloziierte
  Implementierung nicht Ihre einzige Option. Sie können auch Sammlungen
  mit _fester Kapazität_ verwenden; eine solche Implementierung
  findet sich im #ln_heapless;-Crate.
] else { todo }

#if lang == "en" [
  In this section, we'll explore and compare these two implementations.
] else if lang == "de" [
  In diesem Abschnitt werden wir diese beiden Implementierungen
  untersuchen und vergleichen.
] else { todo }

== #(if lang == "en" [Using `alloc`]
  else if lang == "de" [Verwendung von `alloc`]
  else { todo })

#if lang == "en" [
  The `alloc` crate is shipped with the standard Rust distribution. To
  import the crate you can directly `use` it _without_ declaring it
  as a dependency in your `Cargo.toml` file.
] else if lang == "de" [
  Die `alloc`-Crate ist in der Standard-Rust-Distribution enthalten. Um
  das Crate zu importieren, können Sie es direkt per `use` einbinden,
  _ohne_ es als Abhängigkeit in Ihrer `Cargo.toml`-Datei zu deklarieren.
] else { todo }

```rust
#![feature(alloc)]

extern crate alloc;

use alloc::vec::Vec;
```

#let ln_alloc = link("https://doc.rust-lang.org/core/alloc/trait.GlobalAlloc.html")[`GlobalAlloc`]
#if lang == "en" [
  To be able to use any collection you'll first need use the
  `global_allocator` attribute to declare the global allocator your
  program will use. It's required that the allocator you select implements
  the #ln_alloc trait.
] else if lang == "de" [
  Um eine beliebige Collection nutzen zu können, müssen Sie zunächst das
  Attribut `global_allocator` verwenden, um den globalen Allocator zu
  deklarieren, den Ihr Programm einsetzen soll. Der gewählte Allocator
  muss zwingend das Trait #ln_alloc implementieren.
] else { todo }

#if lang == "en" [
  For completeness and to keep this section as self-contained as possible
  we'll implement a simple bump pointer allocator and use that as the
  global allocator. However, we _strongly_ suggest you use a battle
  tested allocator from crates.io in your program instead of this allocator.
] else if lang == "de" [
  Der Vollständigkeit halber und um diesen Abschnitt so in sich
  abgeschlossen wie möglich zu halten, implementieren wir einen einfachen
  Bump-Pointer-Allokator und verwenden diesen als globalen Allokator. Wir
  empfehlen Ihnen jedoch _dringend_, in Ihrem Programm stattdessen
  einen praxiserprobten Allokator von crates.io zu verwenden.
] else { todo }

#raw(block: true, lang: "rust",
"// " + if lang == "en" {
    "Bump pointer allocator implementation"
  } else if lang == "de" {
    "Implementierung eines Bump-Pointer-Allocators"
  } else { todos } + "

use core::alloc::{GlobalAlloc, Layout};
use core::cell::UnsafeCell;
use core::ptr;

use cortex_m::interrupt;

// " + if lang == "en" {
    "Bump pointer allocator for *single* core systems"
  } else if lang == "de" {
    "Bump-Pointer-Allocator fuer Systeme mit *einem* Rechenkern"
  } else { todos } + "
struct BumpPointerAlloc {
    head: UnsafeCell<usize>,
    end: usize,
}

unsafe impl Sync for BumpPointerAlloc {}

unsafe impl GlobalAlloc for BumpPointerAlloc {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        // " + if lang == "en" {
            "`interrupt::free` is a critical section that makes our allocator safe
        // to use from within interrupts"
          } else if lang == "de" {
            "`interrupt::free` ist ein kritischer Abschnitt, der die sichere 
        // Verwendung unseres Allocators aus Interrupts heraus ermoeglicht."
          } else { todos } + "
        interrupt::free(|_| {
            let head = self.head.get();
            let size = layout.size();
            let align = layout.align();
            let align_mask = !(align - 1);

            // " + if lang == "en" {
                "move start up to the next alignment boundary"
              } else if lang == "de" {
                "Verschiebe den Startpunkt zur naechsten Ausrichtungsgrenze."
              } else { todos } + "
            let start = (*head + align - 1) & align_mask;

            if start + size > self.end {
                // " + if lang == "en" {
                    "a null pointer signal an Out Of Memory condition"
                  } else if lang == "de" {
                    "ein Nullzeiger signalisiert einen „Out of Memory“-Zustand"
                  } else { todos } + "
                ptr::null_mut()
            } else {
                *head = start + size;
                start as *mut u8
            }
        })
    }

    unsafe fn dealloc(&self, _: *mut u8, _: Layout) {
        // " + if lang == "en" {
            "this allocator never deallocates memory"
          } else if lang == "de" {
            "Dieser Allokator gibt niemals Speicher frei."
          } else { todos } + "
    }
}

// " + if lang == "en" {
    "Declaration of the global memory allocator
// NOTE the user must ensure that the memory region `[0x2000_0100, 0x2000_0200]`
// is not used by other parts of the program"
  } else if lang == "de" {
    "Deklaration des globalen Speicher-Allocators
// HINWEIS: Der Benutzer muss sicherstellen, dass der Speicherbereich 
// `[0x2000_0100, 0x2000_0200]` nicht von anderen Teilen des Programms 
// verwendet wird."
  } else { todos } + "
#[global_allocator]
static HEAP: BumpPointerAlloc = BumpPointerAlloc {
    head: UnsafeCell::new(0x2000_0100),
    end: 0x2000_0200,
};
")

#if lang == "en" [
  Apart from selecting a global allocator the user will also have to
  define how Out Of Memory (OOM) errors are handled using the
  _unstable_ `alloc_error_handler` attribute.
] else if lang == "de" [
  Neben der Auswahl eines globalen Allocators muss der Benutzer auch
  festlegen, wie mit „Out of Memory" (OOM)-Fehlern umgegangen wird;
  hierfür wird das _instabile_ Attribut `alloc_error_handler`
  verwendet.
] else { todo }

```rust
#![feature(alloc_error_handler)]

use cortex_m::asm;

#[alloc_error_handler]
fn on_oom(_layout: Layout) -> ! {
    asm::bkpt();

    loop {}
}
```

#if lang == "en" [
 Once all that is in place, the user can finally use the collections in `alloc`.
] else if lang == "de" [
  Sobald alles vorhanden ist, kann der Benutzer endlich die Sammlungen in
  „alloc" verwenden.
] else { todo }

```rust
#[entry]
fn main() -> ! {
    let mut xs = Vec::new();

    xs.push(42);
    assert!(xs.pop(), Some(42));

    loop {
        // ..
    }
}
```

#if lang == "en" [
  If you have used the collections in the `std` crate then these will be
  familiar as they are exact same implementation.
] else if lang == "de" [
  Wenn Sie die Sammlungen aus dem `std`-Crate bereits verwendet haben,
  werden Ihnen diese vertraut vorkommen, da es sich um exakt dieselbe
  Implementierung handelt.
] else { todo }

== #(if lang == "en" [Using `heapless`]
  else if lang == "de" [Verwendung von `heapless`]
  else { todo })

#if lang == "en" [
  `heapless` requires no setup as its collections don't depend on a global
  memory allocator. Just `use` its collections and proceed to instantiate them:
] else if lang == "de" [
  `heapless` erfordert keine Einrichtung, da seine Datenstrukturen nicht
  von einem globalen Speicher-Allocator abhängen. Binde die
  Datenstrukturen einfach per `use` ein und instanziiere sie:
] else { todo }

```rust
// heapless version: v0.4.x
use heapless::Vec;
use heapless::consts::*;

#[entry]
fn main() -> ! {
    let mut xs: Vec<_, U8> = Vec::new();

    xs.push(42).unwrap();
    assert_eq!(xs.pop(), Some(42));
    loop {}
}
```

#if lang == "en" [
  You'll note two differences between these collections and the ones in `alloc`.
] else if lang == "de" [
  Sie werden zwei Unterschiede zwischen diesen Sammlungen und denen in
  `alloc` feststellen.
] else { todo }

#let ln_typenum = link("https://crates.io/crates/typenum")[`typenum`]
#if lang == "en" [
  First, you have to declare upfront the capacity of the collection.
  `heapless` collections never reallocate and have fixed capacities; this
  capacity is part of the type signature of the collection. In this case
  we have declared that `xs` has a capacity of 8 elements that is the
  vector can, at most, hold 8 elements. This is indicated by the `U8`
  (see #ln_typenum) in the type signature.
] else if lang == "de" [
  Erstens muss die Kapazität der Sammlung im Voraus deklariert werden.
  `heapless`-Sammlungen werden nie neu allokiert und haben eine feste
  Kapazität; diese Kapazität ist Teil der Typsignatur der Sammlung. In
  diesem Fall haben wir deklariert, dass `xs` eine Kapazität von 8
  Elementen hat, d.~h. der Vektor kann maximal 8 Elemente aufnehmen. Dies
  wird durch das `u8` (siehe #ln_typenum) in der Typsignatur
  angezeigt.
] else { todo }

#if lang == "en" [
  Second, the `push` method, and many other methods, return a `Result`.
  Since the `heapless` collections have fixed capacity all operations that
  insert elements into the collection can potentially fail. The API
  reflects this problem by returning a `Result` indicating whether the
  operation succeeded or not. In contrast, `alloc` collections will
  reallocate themselves on the heap to increase their capacity.
] else if lang == "de" [
  Zweitens geben die Methode `push` sowie viele weitere Methoden ein
  `Result` zurück. Da `heapless`-Datenstrukturen über eine feste Kapazität
  verfügen, können alle Operationen, die Elemente in die Struktur
  einfügen, potenziell fehlschlagen. Die API trägt diesem Umstand
  Rechnung, indem sie ein `Result` liefert, das anzeigt, ob die Operation
  erfolgreich war oder nicht. Im Gegensatz dazu passen
  `alloc`-Datenstrukturen ihre Kapazität durch eine erneute
  Speicherzuweisung auf dem Heap an.
] else { todo }

#if lang == "en" [
  As of version v0.4.x all `heapless` collections store all their elements
  inline. This means that an operation like
  `let x = heapless::Vec::new();` will allocate the collection on the
  stack, but it's also possible to allocate the collection on a `static`
  variable, or even on the heap (`Box<Vec<_, _>>`).
] else if lang == "de" [
  Seit Version v0.4.x speichern alle `heapless`-Datenstrukturen ihre
  Elemente direkt „inline". Das bedeutet, dass eine Operation wie
  `let x = heapless::Vec::new();` die Datenstruktur auf dem Stack anlegt;
  es ist jedoch auch möglich, sie in einer `static`-Variablen oder sogar
  auf dem Heap (`Box<Vec<_, _>>`) zu speichern.
] else { todo }

== #(if lang == "en" [Trade-offs]
  else if lang == "de" [Abwägungen]
  else { todo })

#if lang == "en" [
  Keep these in mind when choosing between heap allocated, relocatable
  collections and fixed capacity collections.
] else if lang == "de" [
  Berücksichtigen Sie diese Punkte, wenn Sie zwischen auf dem Heap
  alloziierten, verschiebbaren Sammlungen und Sammlungen mit fester
  Kapazität wählen.
] else { todo }

=== #(if lang == "en" [Out Of Memory and error handling]
  else if lang == "de" [„Out of Memory" und Fehlerbehandlung]
  else { todo })

#if lang == "en" [
  With heap allocations Out Of Memory is always a possibility and can
  occur in any place where a collection may need to grow: for example, all
  `alloc::Vec.push` invocations can potentially generate an OOM condition.
  Thus some operations can _implicitly_ fail. Some `alloc`
  collections expose `try_reserve` methods that let you check for
  potential OOM conditions when growing the collection but you need be
  proactive about using them.
] else if lang == "de" [
  Bei Heap-Allokationen ist ein „Out of Memory" (OOM) -- also ein
  Speichermangel -- immer möglich; er kann überall dort auftreten, wo eine
  Collection wachsen muss: So können beispielsweise alle Aufrufe von
  `alloc::Vec.push` potenziell zu einer OOM-Situation führen. Folglich
  können manche Operationen _implizit_ fehlschlagen. Einige
  `alloc`-Collections bieten `try_reserve`-Methoden an, mit denen sich
  potenzielle OOM-Situationen beim Vergrößern der Collection überprüfen
  lassen; man muss diese Methoden jedoch aktiv einsetzen.
] else { todo }

#if lang == "en" [
  If you exclusively use `heapless` collections and you don't use a memory
  allocator for anything else then an OOM condition is impossible.
  Instead, you'll have to deal with collections running out of capacity on
  a case by case basis. That is you'll have deal with _all_ the
  `Result`s returned by methods like `Vec.push`.
] else if lang == "de" [
  Wenn man ausschließlich `heapless`-Collections verwendet und keinen
  Speicher-Allocator für andere Zwecke nutzt, ist eine OOM-Situation
  ausgeschlossen. Stattdessen muss man im Einzelfall damit umgehen, wenn
  die Kapazität einer Collection erschöpft ist. Das bedeutet, man muss
  _alle_ `Result`-Werte behandeln, die von Methoden wie `Vec.push`
  zurückgegeben werden.
] else { todo }

#if lang == "en" [
  OOM failures can be harder to debug than say `unwrap`-ing on all
  `Result`s returned by `heapless::Vec.push` because the observed location
  of failure may _not_ match with the location of the cause of the
  problem. For example, even `vec.reserve(1)` can trigger an OOM if the
  allocator is nearly exhausted because some other collection was leaking
  memory (memory leaks are possible in safe Rust).
] else if lang == "de" [
  Fehler durch Speichermangel (OOM) können schwieriger zu debuggen sein
  als etwa das Aufrufen von `unwrap` auf allen `Result`-Werten von
  `heapless::Vec.push`, da die Stelle, an der der Fehler sichtbar wird,
  nicht unbedingt mit der Ursache des Problems übereinstimmen muss. So
  kann beispielsweise selbst `vec.reserve(1)` ein OOM auslösen, wenn der
  Allocator nahezu erschöpft ist, weil eine andere Collection Speicher
  verloren hat (Speicherlecks sind auch in „Safe Rust" möglich).
] else { todo }

=== #(if lang == "en" [Memory usage]
  else if lang == "de" [Speichernutzung]
  else { todo })

#if lang == "en" [
  Reasoning about memory usage of heap allocated collections is hard
  because the capacity of long lived collections can change at runtime.
  Some operations may implicitly reallocate the collection increasing its
  memory usage, and some collections expose methods like `shrink_to_fit`
  that can potentially reduce the memory used by the collection --
  ultimately, it's up to the allocator to decide whether to actually
  shrink the memory allocation or not. Additionally, the allocator may
  have to deal with memory fragmentation which can increase the
  _apparent_ memory usage.
] else if lang == "de" [
  Die Einschätzung des Speicherverbrauchs von auf dem Heap allozierten
  Collections ist schwierig, da sich die Kapazität langlebiger Collections
  zur Laufzeit ändern kann. Manche Operationen führen möglicherweise zu
  einer impliziten Neuzuweisung des Speichers, wodurch der Speicherbedarf
  steigt; andere Collections bieten Methoden wie `shrink_to_fit` an, die
  den genutzten Speicher potenziell verringern können -- wobei letztlich
  der Allocator entscheidet, ob die Speicherzuweisung tatsächlich
  reduziert wird. Zudem muss der Allocator unter Umständen mit
  Speicherfragmentierung umgehen, was den _scheinbaren_
  Speicherverbrauch erhöhen kann.
] else { todo }

#if lang == "en" [
  On the other hand if you exclusively use fixed capacity collections,
  store most of them in `static` variables and set a maximum size for the
  call stack then the linker will detect if you try to use more memory
  than what's physically available.
] else if lang == "de" [
  Verwendet man hingegen ausschließlich Collections mit fester Kapazität,
  legt die meisten davon in `static`-Variablen ab und legt eine maximale
  Größe für den Aufruf-Stack (Call Stack) fest, so erkennt der Linker,
  wenn mehr Speicher beansprucht wird, als physisch verfügbar ist.
] else { todo }

#let ln_z_emit = link("https://doc.rust-lang.org/beta/unstable-book/compiler-flags/emit-stack-sizes.html")[`-Z emit-stack-sizes`]
#let ln_stack_sizes = link("https://crates.io/crates/stack-sizes")[`stack-sizes`]
#if lang == "en" [
  Furthermore, fixed capacity collections allocated on the stack will be
  reported by #ln_z_emit
  flag which means that tools that analyze stack usage
  (like #ln_stack_sizes) will include them in their analysis.
] else if lang == "de" [
  Darüber hinaus werden auf dem Stack alloziierte Collections mit fester
  Kapazität durch das Flag #ln_z_emit
  erfasst; das bedeutet, dass Werkzeuge zur Analyse der Stack-Nutzung
  (wie #ln_stack_sizes) diese in ihre Auswertung einbeziehen.
] else { todo }

#if lang == "en" [
  However, fixed capacity collections can _not_ be shrunk which can
  result in lower load factors (the ratio between the size of the
  collection and its capacity) than what relocatable collections can achieve.
] else if lang == "de" [
  Sammlungen mit fester Kapazität können jedoch _nicht_ verkleinert
  werden, was zu niedrigeren Auslastungsgraden (dem Verhältnis zwischen
  der Größe der Sammlung und ihrer Kapazität) führen kann, als sie bei
  Sammlungen mit veränderbarer Kapazität möglich sind.
] else { todo }

=== #(if lang == "en" [Worst Case Execution Time (WCET)]
  else if lang == "de" [Maximale Ausführungszeit (WCET)]
  else { todo })

#if lang == "en" [
  If you are building time sensitive applications or hard real time
  applications then you care, maybe a lot, about the worst case execution
  time of the different parts of your program.
] else if lang == "de" [
  Wenn Sie zeitkritische oder Echtzeitanwendungen entwickeln, ist Ihnen
  die Worst-Case-Ausführungszeit (WCET) der verschiedenen Programmteile
  wahrscheinlich sehr wichtig.
] else { todo }

#if lang == "en" [
  The `alloc` collections can reallocate so the WCET of operations that
  may grow the collection will also include the time it takes to
  reallocate the collection, which itself depends on the _runtime_
  capacity of the collection. This makes it hard to determine the WCET of,
  for example, the `alloc::Vec.push` operation as it depends on both the
  allocator being used and its runtime capacity.
] else if lang == "de" [
  Da `alloc`-Collections Speicher neu allokieren können, umfasst die WCET
  von Operationen, die die Collection vergrößern, auch die Zeit für die
  Neuallokation. Diese hängt wiederum von der _Laufzeitkapazität_ der
  Collection ab. Daher ist es schwierig, die WCET beispielsweise der
  Operation `alloc::Vec.push` zu bestimmen, da sie sowohl vom verwendeten
  Allokator als auch von dessen Laufzeitkapazität abhängt.
] else { todo }

#if lang == "en" [
  On the other hand fixed capacity collections never reallocate so all
  operations have a predictable execution time. For example,
  `heapless::Vec.push` executes in constant time.
] else if lang == "de" [
  Collections mit fester Kapazität hingegen allokieren nie Speicher neu,
  sodass alle Operationen eine vorhersehbare Ausführungszeit haben.
  Beispielsweise wird `heapless::Vec.push` in konstanter Zeit ausgeführt.
] else { todo }

=== #(if lang == "en" [Ease of use]
  else if lang == "de" [Benutzerfreundlichkeit]
  else { todo })

#if lang == "en" [
  `alloc` requires setting up a global allocator whereas `heapless` does
  not. However, `heapless` requires you to pick the capacity of each
  collection that you instantiate.
] else if lang == "de" [
  Für `alloc` muss ein globaler Allocator eingerichtet werden, für
  `heapless` hingegen nicht. Allerdings erfordert `heapless`, dass man bei
  der Instanziierung jeder Collection deren Kapazität festlegt.
] else { todo }

#if lang == "en" [
  The `alloc` API will be familiar to virtually every Rust developer. The
  `heapless` API tries to closely mimic the `alloc` API but it will never
  be exactly the same due to its explicit error handling -- some developers
  may feel the explicit error handling is excessive or too cumbersome.
] else if lang == "de" [
  Die `alloc`-API dürfte so gut wie jedem Rust-Entwickler vertraut sein.
  Die `heapless`-API orientiert sich zwar eng an der `alloc`-API,
  unterscheidet sich jedoch aufgrund der expliziten Fehlerbehandlung --
  manche Entwickler empfinden diese explizite Fehlerbehandlung womöglich
  als übertrieben oder zu umständlich.
] else { todo }
