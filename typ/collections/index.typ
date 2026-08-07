#import "../config.typ": *

#h1(if lang == "en" [Collections]
  else if lang == "de" [Sammlungen (Collections)]
  else if lang == "zh" [集合]
  else { todo })

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
] else if lang == "zh" [
  最后，还希望在程序里使用动态数据结构(也称为集合)。`std`
  提供了一组常见的集合:
  #ln_vec，#ln_string，#ln_map，等等。所有这些在`std`中被实现的集合都使用一个全局动态分配器(也称为堆)。
] else { todo }

#if lang == "en" [
  As `core` is, by definition, free of memory allocations these
  implementations are not available there, but they can be found in the
  `alloc` crate that's shipped with the compiler.
] else if lang == "de" [
  Da `core` definitionsgemäß frei von Speicherzuweisungen ist, stehen
  diese Implementierungen dort nicht zur Verfügung; sie sind jedoch im
  `alloc`-Crate zu finden, das mit dem Compiler ausgeliefert wird.
] else if lang == "zh" [
  因为`core`的定义中是没有内存分配的，所以这些实现在`core`中是没有的，但是我们可以在编译器附带的`alloc`
  crate中找到。
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
] else if lang == "zh" [
  如果需要集合，一个基于堆分配的实现不是唯一的选择。也可以使用 _fixed capacity_ 集合; 其实现可以在
  #ln_heapless crate中被找到。
] else { todo }

#if lang == "en" [
  In this section, we'll explore and compare these two implementations.
] else if lang == "de" [
  In diesem Abschnitt werden wir diese beiden Implementierungen
  untersuchen und vergleichen.
] else if lang == "zh" [
  在这部分，我们将研究和比较这两个实现。
] else { todo }

== #(if lang == "en" [Using `alloc`]
  else if lang == "de" [Verwendung von `alloc`]
  else if lang == "zh" [使用 `alloc`]
  else { todo })

#if lang == "en" [
  The `alloc` crate is shipped with the standard Rust distribution. To
  import the crate you can directly `use` it _without_ declaring it
  as a dependency in your `Cargo.toml` file.
] else if lang == "de" [
  Die `alloc`-Crate ist in der Standard-Rust-Distribution enthalten. Um
  das Crate zu importieren, können Sie es direkt per `use` einbinden,
  _ohne_ es als Abhängigkeit in Ihrer `Cargo.toml`-Datei zu deklarieren.
] else if lang == "zh" [
  `alloc` crate与标准的Rust发行版在一起。你可以直接 `use`
  导入这个crate，而不需要在`Cargo.toml`文件中把它声明为一个依赖。
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
] else if lang == "zh" [
  为了能使用集合，首先需要使用`global_allocator`属性去声明程序将使用的全局分配器。它要求选择的分配器实现了#link("https://doc.rust-lang.org/core/alloc/trait.GlobalAlloc.html")[`GlobalAlloc`]
  trait 。
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
] else if lang == "zh" [
  为了完整性和尽可能保持本节的自包含性，我们将实现一个简单线性指针分配器且用它作为全局分配器。然而，我们
  _强烈地_
  建议你在你的程序中使用一个来自crates.io的久经战斗测试的分配器而不是这个分配器。
] else { todo }

#raw(block: true, lang: "rust",
"// " + if lang == "en" {
    "Bump pointer allocator implementation"
  } else if lang == "de" {
    "Implementierung eines Bump-Pointer-Allocators"
  } else if lang == "zh" {
    "线性指针分配器实现"
  } else { todos } + "

use core::alloc::{GlobalAlloc, Layout};
use core::cell::UnsafeCell;
use core::ptr;

use cortex_m::interrupt;

// " + if lang == "en" {
    "Bump pointer allocator for *single* core systems"
  } else if lang == "de" {
    "Bump-Pointer-Allocator fuer Systeme mit *einem* Rechenkern"
  } else if lang == "zh" {
    "用于单核系统的线性指针分配器"
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
          } else if lang == "zh" {
            "`interrupt::free`是一个临界区，临界区让我们的分配器在中断中用起来安全"
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
              } else if lang == "zh" {
                "将start移至下一个对齐边界。"
              } else { todos } + "
            let start = (*head + align - 1) & align_mask;

            if start + size > self.end {
                // " + if lang == "en" {
                    "a null pointer signal an Out Of Memory condition"
                  } else if lang == "de" {
                    "ein Nullzeiger signalisiert einen „Out of Memory“-Zustand"
                  } else if lang == "zh" {
                    "一个空指针通知内存不足"
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
          } else if lang == "zh" {
            "这个分配器从不释放内存"
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
  } else if lang == "zh" {
    "全局内存分配器的声明
// 注意 用户必须确保`[0x2000_0100, 0x2000_0200]`内存区域
// 没有被程序的其它部分使用"
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
] else if lang == "zh" [
  除了选择一个全局分配器，用户也必须要定义如何使用_不稳定的_`alloc_error_handler`属性来处理内存溢出错误。
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
] else if lang == "zh" [
  一旦一切都完成了，用户最后就可以在`alloc`中使用集合。
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
] else if lang == "zh" [
  如果你已经使用了`std`
  crate中的集合，那么这些对你来说将非常熟悉，因为他们的实现一样。
] else { todo }

== #(if lang == "en" [Using `heapless`]
  else if lang == "de" [Verwendung von `heapless`]
  else if lang == "zh" [使用 `heapless`]
  else { todo })

#if lang == "en" [
  `heapless` requires no setup as its collections don't depend on a global
  memory allocator. Just `use` its collections and proceed to instantiate them:
] else if lang == "de" [
  `heapless` erfordert keine Einrichtung, da seine Datenstrukturen nicht
  von einem globalen Speicher-Allocator abhängen. Binde die
  Datenstrukturen einfach per `use` ein und instanziiere sie:
] else if lang == "zh" [
  `heapless`无需设置，因为它的集合不依赖一个全局内存分配器。只是`use`它的集合然后实例化它们:
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
] else if lang == "zh" [
  你会注意到这些集合与`alloc`中的集合有两个不一样的地方。
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
] else if lang == "zh" [
  第一，你必须预先声明集合的容量。`heapless`集合从来不会发生重分配且具有固定的容量;这个容量是集合的类型签名的一部分。在这个例子里，我们已经声明了`xs`的容量为8个元素，也就是说，这个vector最多只能有八个元素。这是通过类型签名中的`U8`
  (看#ln_typenum)来指定的。
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
] else if lang == "zh" [
  第二，`push`方法和另外一些方法返回的是一个`Result`。因为`heapless`集合有一个固定的容量，所以所有插入的操作都可能会失败。通过返回一个`Result`，API反应了这个问题，指出操作是否成功还是失败。相反，`alloc`集合自己将会在堆上重新分配去增加它的容量。
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
] else if lang == "zh" [
  自v0.4.x版本起，所有的`heapless`集合将所有的元素内联地存储起来了。这意味着像是`let x = heapless::Vec::new()`这样的一个操作将会在栈上分配集合，但是它也能够在一个`static`变量上分配集合，或者甚至在堆上(`Box<Vec<_, _>>`)。
] else { todo }

== #(if lang == "en" [Trade-offs]
  else if lang == "de" [Abwägungen]
  else if lang == "zh" [取舍]
  else { todo })

#if lang == "en" [
  Keep these in mind when choosing between heap allocated, relocatable
  collections and fixed capacity collections.
] else if lang == "de" [
  Berücksichtigen Sie diese Punkte, wenn Sie zwischen auf dem Heap
  alloziierten, verschiebbaren Sammlungen und Sammlungen mit fester
  Kapazität wählen.
] else if lang == "zh" [
  当在堆分配的可重定位的集合和固定容量的集合间进行选择的时候，记住这些内容。
] else { todo }

=== #(if lang == "en" [Out Of Memory and error handling]
  else if lang == "de" [„Out of Memory" und Fehlerbehandlung]
  else if lang == "zh" [内存溢出和错误处理]
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
] else if lang == "zh" [
  使用堆分配，内存溢出总是有可能出现的且会发生在任何一个集合需要增长的地方:
  比如，所有的 `alloc::Vec.push` 调用会潜在地产生一个OOM(Out of
  Memory)条件。因此一些操作可能会_隐式地_失败。一些`alloc`集合暴露了`try_reserve`方法，可以当增加集合时让你检查潜在的OOM条件，但是你需要主动地使用它们。
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
] else if lang == "zh" [
  如果你只使用`heapless`集合，而不使用内存分配器，那么一个OOM条件不可能出现。反而，你必须逐个处理容量不足的集合。也就是必须处理_所有_的`Result`，`Result`由像是`Vec.push`这样的方法返回的。
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
] else if lang == "zh" [
  与在所有由`heapless::Vec.push`返回的`Result`上调用`unwrap`相比，OOM错误更难调试，因为错误被发现的位置可能与导致问题的位置_不_一致。比如，甚至如果分配器接近消耗完`vec.reserve(1)`都能触发一个OOM，因为一些其它的集合正在泄露内存(内存泄露在安全的Rust是会发生的)。
] else { todo }

=== #(if lang == "en" [Memory usage]
  else if lang == "de" [Speichernutzung]
  else if lang == "zh" [内存使用]
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
] else if lang == "zh" [
  推理堆分配集合的内存使用是很难的因为长期使用的集合的大小会在运行时改变。一些操作可能隐式地重分配集合，增加了它的内存使用，一些集合暴露的方法，像是`shrink_to_fit`，会潜在地减少集合使用的内存 --
  最终，它由分配器去决定是否确定减小内存的分配或者不。另外，分配器可能不得不处理内存碎片，它会_明显_增加内存的使用。
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
] else if lang == "zh" [
  另一方面，如果你只使用固定容量的集合，请把大多数的数据保存在`static`变量中，并为调用栈设置一个最大尺寸，随后如果你尝试使用大于可用的物理内存的内存大小时，链接器会发现它。
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
] else if lang == "zh" [
  另外，在栈上分配的固定容量的集合可以通过#ln_z_emit;标识来报告，其意味着用来分析栈使用的工具(像是#ln_stack_sizes)将会把在栈上分配的集合包含进它们的分析中。
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
] else if lang == "zh" [
  然而，固定容量的集合_不_能被减少，与可重定位集合所能达到的负载系数(集合的大小和它的容量之间的比值)相比，它能产生更低的负载系数。
] else { todo }

=== #(if lang == "en" [Worst Case Execution Time (WCET)]
  else if lang == "de" [Maximale Ausführungszeit (WCET)]
  else if lang == "zh" [最坏执行时间 (WCET)]
  else { todo })

#if lang == "en" [
  If you are building time sensitive applications or hard real time
  applications then you care, maybe a lot, about the worst case execution
  time of the different parts of your program.
] else if lang == "de" [
  Wenn Sie zeitkritische oder Echtzeitanwendungen entwickeln, ist Ihnen
  die Worst-Case-Ausführungszeit (WCET) der verschiedenen Programmteile
  wahrscheinlich sehr wichtig.
] else if lang == "zh" [
  如果你正在搭建时间敏感型应用或者硬实时应用，那么你可能更关心你程序的不同部分的最坏执行时间。
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
] else if lang == "zh" [
  `alloc`集合能重分配，所以操作的WCET可能会增加，集合也将包括它用来重分配集合所需的时间，它取决于集合的_运行时_容量。这使得它更难去决定操作，比如`alloc::Vec.push`，的WCET，因为它依赖被使用的分配器和它的运行时容量。
] else { todo }

#if lang == "en" [
  On the other hand fixed capacity collections never reallocate so all
  operations have a predictable execution time. For example,
  `heapless::Vec.push` executes in constant time.
] else if lang == "de" [
  Collections mit fester Kapazität hingegen allokieren nie Speicher neu,
  sodass alle Operationen eine vorhersehbare Ausführungszeit haben.
  Beispielsweise wird `heapless::Vec.push` in konstanter Zeit ausgeführt.
] else if lang == "zh" [
  另一方面固定容量的集合不会重分配，因此所有的操作有个可预期的执行时间。比如，`heapless::Vec.push`以固定时间执行。
] else { todo }

=== #(if lang == "en" [Ease of use]
  else if lang == "de" [Benutzerfreundlichkeit]
  else if lang == "zh" [易用性]
  else { todo })

#if lang == "en" [
  `alloc` requires setting up a global allocator whereas `heapless` does
  not. However, `heapless` requires you to pick the capacity of each
  collection that you instantiate.
] else if lang == "de" [
  Für `alloc` muss ein globaler Allocator eingerichtet werden, für
  `heapless` hingegen nicht. Allerdings erfordert `heapless`, dass man bei
  der Instanziierung jeder Collection deren Kapazität festlegt.
] else if lang == "zh" [
  `alloc`要求配置一个全局分配器而`heapless`不需要。然而，`heapless`要求你去选择你要实例化的每一个集合的容量。
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
] else if lang == "zh" [
  `alloc` API几乎为每一个Rust开发者所熟知。`heapless` API尝试模仿`alloc`
  API，但是因为`heapless`的显式错误处理，它们不可能会一模一样 --
  一些开发者可能会觉得显式的错误处理过多或太麻烦。
] else { todo }
