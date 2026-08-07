#import "../config.typ": *

#h1(if lang == "en" [Tips for embedded C developers]
  else if lang == "de" [Tipps für Embedded-C-Entwickler]
  else { todo })

#if lang == "en" [
  This chapter collects a variety of tips that might be useful to
  experienced embedded C developers looking to start writing Rust. It will
  especially highlight how things you might already be used to in C are
  different in Rust.
] else if lang == "de" [
  Dieses Kapitel versammelt eine Reihe von Tipps, die für erfahrene
  Embedded-C-Entwickler nützlich sein können, die mit der Programmierung
  in Rust beginnen möchten. Dabei wird insbesondere hervorgehoben, wie
  sich Dinge, die man aus C bereits kennt, in Rust unterscheiden.
] else { todo }

== #(if lang == "en" [Preprocessor]
  else if lang == "de" [Präprozessor]
  else { todo })

#if lang == "en" [
  In embedded C it is very common to use the preprocessor for a variety of
  purposes, such as:
  - Compile-time selection of code blocks with `#ifdef`
  - Compile-time array sizes and computations
  - Macros to simplify common patterns (to avoid function call overhead)
] else if lang == "de" [
  In der Embedded-C-Programmierung ist es sehr üblich, den Präprozessor
  für eine Vielzahl von Zwecken zu nutzen, wie zum Beispiel:
  - Auswahl von Codeblöcken zur Kompilierzeit mittels `#ifdef`
  - Zur Kompilierzeit festgelegte Array-Größen und Berechnungen
  - Makros zur Vereinfachung häufiger Muster (um den Overhead von
    Funktionsaufrufen zu vermeiden)
] else { todo }

#if lang == "en" [
  In Rust there is no preprocessor, and so many of these use cases are
  addressed differently. In the rest of this section we cover various
  alternatives to using the preprocessor.
] else if lang == "de" [
  In Rust gibt es keinen Präprozessor, weshalb viele dieser
  Anwendungsfälle anders gelöst werden. Im weiteren Verlauf dieses
  Abschnitts behandeln wir verschiedene Alternativen zur Verwendung des
  Präprozessors.
] else { todo }

=== #(if lang == "en" [Compile-Time Code Selection]
  else if lang == "de" [Code-Auswahl zur Kompilierzeit]
  else { todo })

#let url_features = "https://doc.rust-lang.org/cargo/reference/manifest.html#the-features-section"
#if lang == "en" [
  The closest match to `#ifdef ... #endif` in Rust are
  #link(url_features)[Cargo features].
  These are a little more formal than the C preprocessor: all possible
  features are explicitly listed per crate, and can only be either on or
  off. Features are turned on when you list a crate as a dependency, and
  are additive: if any crate in your dependency tree enables a feature for
  another crate, that feature will be enabled for all users of that crate.
] else if lang == "de" [
  Das Äquivalent zu `#ifdef ... #endif` in Rust sind
  #link(url_features)[Cargo-Features].
  Diese sind etwas formaler als der C-Präprozessor: Alle möglichen
  Features werden pro Crate explizit aufgelistet und können entweder
  aktiviert oder deaktiviert sein. Features werden eingeschaltet, sobald
  man ein Crate als Abhängigkeit angibt; sie sind zudem additiv: Wenn
  irgendein Crate im Abhängigkeitsbaum ein Feature für ein anderes Crate
  aktiviert, ist dieses Feature für alle Nutzer jenes Crates aktiviert.
] else { todo }

#if lang == "en" [
  For example, you might have a crate which provides a library of signal
  processing primitives. Each one might take some extra time to compile or
  declare some large table of constants which you'd like to avoid. You
  could declare a Cargo feature for each component in your `Cargo.toml`:
] else if lang == "de" [
  Angenommen, du hast ein Crate, das eine Bibliothek von Grundbausteinen
  für die Signalverarbeitung bereitstellt. Jeder dieser Bausteine ​​könnte
  zusätzliche Kompilierzeit beanspruchen oder eine umfangreiche Tabelle
  von Konstanten definieren, die du gerne vermeiden möchtest. Du könntest
  für jede Komponente in deiner `Cargo.toml` ein Cargo-Feature definieren:
] else { todo }

```toml
[features]
FIR = []
IIR = []
```

#if lang == "en" [
  Then, in your code, use `#[cfg(feature="FIR")]` to control what is
  included.
] else if lang == "de" [
  Verwenden Sie dann in Ihrem Code `#[cfg(feature="FIR")]`, um zu steuern,
  was einbezogen wird.
] else { todo }

#raw(block: true, lang: "rust",
"/// " + if lang == "en" {
    "In your top-level lib.rs"
  } else if lang == "de" {
    "In deiner lib.rs auf oberster Ebene"
  } else { todos } + "

#[cfg(feature=\"FIR\")]
pub mod fir;

#[cfg(feature=\"IIR\")]
pub mod iir;
")

#if lang == "en" [
  You can similarly include code blocks only if a feature is _not_
  enabled, or if any combination of features are or are not enabled.
] else if lang == "de" [
  Sie können Codeblöcke analog dazu nur dann einfügen, wenn eine Funktion
  _nicht_ aktiviert ist oder wenn eine beliebige Kombination von
  Funktionen aktiviert oder deaktiviert ist.
] else { todo }

#let url_conditional = "https://doc.rust-lang.org/reference/conditional-compilation.html"
#if lang == "en" [
  Additionally, Rust provides a number of automatically-set conditions you
  can use, such as `target_arch` to select different code based on
  architecture. For full details of the conditional compilation support,
  refer to the #link(url_conditional)[conditional compilation]
  chapter of the Rust reference.
] else if lang == "de" [
  Darüber hinaus bietet Rust eine Reihe automatisch gesetzter Bedingungen,
  die Sie verwenden können, beispielsweise `target_arch`, um je nach
  Architektur unterschiedlichen Code auszuwählen. Ausführliche
  Informationen zur bedingten Kompilierung finden Sie im Kapitel
  #link(url_conditional)[Bedingte Kompilierung]
  der Rust-Referenz.
] else { todo }

#if lang == "en" [
  The conditional compilation will only apply to the next statement or
  block. If a block can not be used in the current scope then the `cfg`
  attribute will need to be used multiple times. It's worth noting that
  most of the time it is better to simply include all the code and allow
  the compiler to remove dead code when optimising: it's simpler for you
  and your users, and in general the compiler will do a good job of
  removing unused code.
] else if lang == "de" [
  Die bedingte Kompilierung bezieht sich nur auf die unmittelbar folgende
  Anweisung oder den folgenden Block. Kann im aktuellen Gültigkeitsbereich
  kein Block verwendet werden, muss das `cfg`-Attribut mehrfach eingesetzt
  werden. Es sei darauf hingewiesen, dass es meist besser ist, den
  gesamten Code einzubeziehen und den Compiler bei der Optimierung nicht
  mehr benötigten Code („Dead Code") entfernen zu lassen: Dies ist für Sie
  und Ihre Nutzer einfacher, und der Compiler leistet im Allgemeinen gute
  Arbeit beim Entfernen von ungenutztem Code.
] else { todo }

=== #(if lang == "en" [Compile-Time Sizes and Computation]
  else if lang == "de" [Größen und Berechnungen zur Kompilierzeit]
  else { todo })

#if lang == "en" [
  Rust supports `const fn`, functions which are guaranteed to be evaluable
  at compile-time and can therefore be used where constants are required,
  such as in the size of arrays. This can be used alongside features
  mentioned above, for example:
] else if lang == "de" [
  Rust unterstützt `const fn` -- Funktionen, die garantiert zur
  Kompilierzeit ausgewertet werden können und sich daher überall dort
  einsetzen lassen, wo Konstanten erforderlich sind, etwa bei der Größe
  von Arrays. Dies lässt sich mit den zuvor genannten Funktionen
  kombinieren, zum Beispiel:
] else { todo }

```rust
const fn array_size() -> usize {
    #[cfg(feature="use_more_ram")]
    { 1024 }
    #[cfg(not(feature="use_more_ram"))]
    { 128 }
}

static BUF: [u32; array_size()] = [0u32; array_size()];
```

#if lang == "en" [
  These are new to stable Rust as of 1.31, so documentation is still
  sparse. The functionality available to `const fn` is also very limited
  at the time of writing; in future Rust releases it is expected to expand
  on what is permitted in a `const fn`.
] else if lang == "de" [
  Diese Funktionen sind seit Version 1.31 in Stable Rust verfügbar,
  weshalb die Dokumentation noch spärlich ist. Auch der für `const fn`
  verfügbare Funktionsumfang ist zum Zeitpunkt der Erstellung dieses
  Textes stark eingeschränkt; es ist jedoch zu erwarten, dass die in einer
  `const fn` zulässigen Operationen in künftigen Rust-Versionen erweitert werden.
] else { todo }

=== #(if lang == "en" [Macros]
  else if lang == "de" [Makros]
  else { todo })

#let url_macros = "https://doc.rust-lang.org/book/ch19-06-macros.html"
#if lang == "en" [
  Rust provides an extremely powerful #link(url_macros)[macro system].
  While the C preprocessor operates almost directly on the text of your
  source code, the Rust macro system operates at a higher level. There are
  two varieties of Rust macro: _macros by example_ and
  _procedural macros_. The former are simpler and most common; they
  look like function calls and can expand to a complete expression,
  statement, item, or pattern. Procedural macros are more complex but
  permit extremely powerful additions to the Rust language: they can
  transform arbitrary Rust syntax into new Rust syntax.
] else if lang == "de" [
  Rust bietet ein äußerst leistungsfähiges #link(url_macros)[Makrosystem].
  Während der C-Präprozessor fast direkt auf dem Text des Quellcodes
  arbeitet, operiert das Rust-Makrosystem auf einer höheren Ebene. Es gibt
  zwei Arten von Rust-Makros: _Macros by Example_ (Makros nach
  Muster) und _prozedurale Makros_. Erstere sind einfacher und weiter
  verbreitet; sie sehen wie Funktionsaufrufe aus und können zu einem
  vollständigen Ausdruck, einer Anweisung, einem Element oder einem Muster
  expandiert werden. Prozedurale Makros sind komplexer, ermöglichen jedoch
  äußerst leistungsfähige Erweiterungen der Sprache Rust: Sie können
  beliebige Rust-Syntax in neue Rust-Syntax umwandeln.
] else { todo }

#if lang == "en" [
  In general, where you might have used a C preprocessor macro, you
  probably want to see if a macro-by-example can do the job instead. They
  can be defined in your crate and easily used by your own crate or
  exported for other users. Be aware that since they must expand to
  complete expressions, statements, items, or patterns, some use cases of
  C preprocessor macros will not work, for example a macro that expands to
  part of a variable name or an incomplete set of items in a list.
] else if lang == "de" [
  Wenn Sie normalerweise ein C-Präprozessor-Makro verwenden würden,
  sollten Sie im Allgemeinen prüfen, ob stattdessen ein „Macro-by-Example"
  (Makro-durch-Beispiel) die Aufgabe erfüllen kann. Solche Makros lassen
  sich in Ihrem Crate definieren und sowohl intern verwenden als auch für
  andere Nutzer exportieren. Beachten Sie jedoch, dass sie zu
  vollständigen Ausdrücken, Anweisungen, Elementen (Items) oder Mustern
  expandieren müssen; bestimmte Anwendungsfälle von C-Präprozessor-Makros
  funktionieren daher nicht -- etwa Makros, die nur einen Teil eines
  Variablennamens oder unvollständige Listenelemente erzeugen.
] else { todo }

#let url_inline = "https://doc.rust-lang.org/reference/attributes.html#inline-attribute"
#if lang == "en" [
  As with Cargo features, it is worth considering if you even need the
  macro. In many cases a regular function is easier to understand and will
  be inlined to the same code as a macro. The `#[inline]` and
  `#[inline(always)]` #link(url_inline)[attributes]
  give you further control over this process, although care should be
  taken here as well --- the compiler will automatically inline functions
  from the same crate where appropriate, so forcing it to do so
  inappropriately might actually lead to decreased performance.
] else if lang == "de" [
  Wie bei Cargo-Features lohnt es sich auch hier zu überlegen, ob das
  Makro überhaupt erforderlich ist. Oftmals ist eine gewöhnliche Funktion
  leichter verständlich und wird vom Compiler zu demselben Maschinencode
  expandiert (geinlined) wie ein Makro. Die Attribute `#[inline]` und
  `#[inline(always)]`-#link(url_inline)[Attribute]
  bieten Ihnen zusätzliche Kontrolle über diesen Vorgang, wobei jedoch
  Vorsicht geboten ist: Der Compiler inlined Funktionen aus demselben
  Crate ohnehin automatisch, wenn dies sinnvoll ist; ein erzwungenes
  Inlining in ungeeigneten Fällen kann die Leistung sogar verschlechtern.
] else { todo }

#if lang == "en" [
  Explaining the entire Rust macro system is out of scope for this tips
  page, so you are encouraged to consult the Rust documentation for full
  details.
] else if lang == "de" [
  Eine Erläuterung des gesamten Rust-Makrosystems würde den Rahmen dieser
  Tipps-Seite sprengen; für alle Einzelheiten sei daher auf die
  Rust-Dokumentation verwiesen.
] else { todo }

== #(if lang in ("en", "de") [Build System]
  else { todo })

#let url_build_scripts = "https://doc.rust-lang.org/cargo/reference/build-scripts.html"
#if lang == "en" [
  Most Rust crates are built using Cargo (although it is not required).
  This takes care of many difficult problems with traditional build
  systems. However, you may wish to customise the build process. Cargo
  provides
  #link(url_build_scripts)[`build.rs` scripts]
  for this purpose. They are Rust scripts which can interact with the
  Cargo build system as required.
] else if lang == "de" [
  Die meisten Rust-Crates werden mit Cargo erstellt (auch wenn dies nicht
  zwingend erforderlich ist). Cargo löst dabei viele der schwierigen
  Probleme, die mit herkömmlichen Build-Systemen verbunden sind. Dennoch
  kann es sinnvoll sein, den Build-Prozess individuell anzupassen. Hierfür
  stellt Cargo #link(url_build_scripts)[`build.rs`-Skripte]
  bereit. Dabei handelt es sich um Rust-Skripte, die bei Bedarf mit dem
  Cargo-Build-System interagieren können.
] else { todo }

#if lang == "en" [
  Common use cases for build scripts include:
  - provide build-time information, for example statically embedding the
    build date or Git commit hash into your executable
  - generate linker scripts at build time depending on selected features
    or other logic
  - change the Cargo build configuration
  - add extra static libraries to link against
] else if lang == "de" [
  Zu den häufigen Anwendungsfällen für Build-Skripte gehören:
  - Informationen zum Build-Zeitpunkt bereitstellen, zum Beispiel durch
    das statische Einbetten des Build-Datums oder des Git-Commit-Hashs in
    die ausführbare Datei.
  - Linker-Skripte zur Build-Zeit generieren, abhängig von ausgewählten
    Funktionen oder anderer Logik.
  - die Cargo-Build-Konfiguration ändern
  - Zusätzliche statische Bibliotheken für den Linkvorgang hinzufügen
] else { todo }

#if lang == "en" [
  At present there is no support for post-build scripts, which you might
  traditionally have used for tasks like automatic generation of binaries
  from the build objects or printing build information.
] else if lang == "de" [
  Derzeit gibt es keine Unterstützung für Post-Build-Skripte, wie man sie
  üblicherweise für Aufgaben wie die automatische Erstellung von
  Binärdateien aus den Build-Objekten oder die Ausgabe von
  Build-Informationen verwendet hat.
] else { todo }

=== #(if lang == "en" [Cross-Compiling]
  else if lang == "de" [Cross-Kompilierung]
  else { todo })

#if lang == "en" [
  Using Cargo for your build system also simplifies cross-compiling. In
  most cases it suffices to tell Cargo `--target thumbv6m-none-eabi` and
  find a suitable executable in `target/thumbv6m-none-eabi/debug/myapp`.
] else if lang == "de" [
  Die Verwendung von Cargo als Build-System vereinfacht auch die
  Cross-Kompilierung. In den meisten Fällen genügt es, Cargo die Option
  `--target thumbv6m-none-eabi` mitzugeben und die entsprechende
  ausführbare Datei unter `target/thumbv6m-none-eabi/debug/myapp` zu finden.
] else { todo }

#if lang == "en" [
  For platforms not natively supported by Rust, you will need to build
  `libcore` for that target yourself. On such platforms,
  #link("https://github.com/japaric/xargo")[Xargo] can be used as a
  stand-in for Cargo which automatically builds `libcore` for you.
] else if lang == "de" [
  Für Plattformen, die nicht nativ von Rust unterstützt werden, müssen Sie
  `libcore` für das jeweilige Zielsystem selbst kompilieren. Auf solchen
  Plattformen lässt sich #link("https://github.com/japaric/xargo")[Xargo]
  als Ersatz für Cargo verwenden, da es `libcore` automatisch für Sie
  erstellt.
] else { todo }

== #(if lang == "en" [Iterators vs Array Access]
  else if lang == "de" [Iteratoren vs.~Array-Zugriff]
  else { todo })

#if lang == "en" [
  In C you are probably used to accessing arrays directly by their index:
] else if lang == "de" [
  In C sind Sie es wahrscheinlich gewohnt, direkt über den Index auf
  Arrays zuzugreifen:
] else { todo }

```c
int16_t arr[16];
int i;
for(i=0; i<sizeof(arr)/sizeof(arr[0]); i++) {
    process(arr[i]);
}
```

#if lang == "en" [
  In Rust this is an anti-pattern: indexed access can be slower (as it
  needs to be bounds checked) and may prevent various compiler
  optimisations. This is an important distinction and worth repeating:
  Rust will check for out-of-bounds access on manual array indexing to
  guarantee memory safety, while C will happily index outside the array.
] else if lang == "de" [
  In Rust ist dies ein Anti-Muster: Indexzugriffe können langsamer sein
  (da eine Bereichsprüfung erforderlich ist) und verschiedene
  Compiler-Optimierungen verhindern. Dieser Unterschied ist wichtig und
  sollte wiederholt werden: Rust prüft bei manueller Array-Indizierung auf
  Zugriffe außerhalb der Grenzen, um Speichersicherheit zu gewährleisten,
  während C problemlos auf Bereiche außerhalb des Arrays zugreift.
] else { todo }

#if lang == "en" [
  Instead, use iterators:
] else if lang == "de" [
  Verwenden Sie stattdessen Iteratoren.
] else { todo }

```rust
let arr = [0u16; 16];
for element in arr.iter() {
    process(*element);
}
```

#if lang == "en" [
  Iterators provide a powerful array of functionality you would have to
  implement manually in C, such as chaining, zipping, enumerating, finding
  the min or max, summing, and more. Iterator methods can also be chained,
  giving very readable data processing code.
] else if lang == "de" [
  Iteratoren bieten eine Vielzahl leistungsstarker Funktionen, die Sie in
  C manuell implementieren müssten, wie z. B. Verkettung, Zipping,
  Aufzählung, Minimum- und Maximumsuche, Summierung und vieles mehr.
  Iteratormethoden lassen sich ebenfalls verketten, was zu sehr lesbarem
  Code für die Datenverarbeitung führt.
] else { todo }

#let url_iter_book = "https://doc.rust-lang.org/book/ch13-02-iterators.html"
#let url_iter_doc = "https://doc.rust-lang.org/core/iter/trait.Iterator.html"
#if lang == "en" [
  See the #link(url_iter_book)[Iterators in the Book] and
  #link(url_iter_doc)[Iterator documentation] for more details.
] else if lang == "de" [
  Weitere Informationen finden Sie unter
  #link(url_iter_book)[Iteratoren im Buch]
  und #link(url_iter_doc)[Iterator-Dokumentation].
] else { todo }

== #(if lang == "en" [References vs Pointers]
  else if lang == "de" [Referenzen vs.~Zeiger]
  else { todo })

#let url_derefraw = "https://doc.rust-lang.org/book/ch19-01-unsafe-rust.html#dereferencing-a-raw-pointer"
#if lang == "en" [
  In Rust, pointers (called #link(url_derefraw)[_raw pointers_])
  exist but are only used in specific circumstances, as dereferencing them
  is always considered `unsafe` -- Rust cannot provide its usual
  guarantees about what might be behind the pointer.
] else if lang == "de" [
  In Rust gibt es zwar Zeiger (sogenannte
  #link(url_derefraw)[_Raw Pointer_]),
  diese werden jedoch nur unter bestimmten Umständen verwendet, da ihre
  Dereferenzierung stets als `unsafe` gilt -- Rust kann nämlich nicht die
  üblichen Garantien darüber geben, was sich hinter dem Zeiger befindet.
] else { todo }

#if lang == "en" [
  In most cases, we instead use _references_, indicated by the `&`
  symbol, or _mutable references_, indicated by `&mut`. References
  behave similarly to pointers, in that they can be dereferenced to access
  the underlying values, but they are a key part of Rust's ownership
  system: Rust will strictly enforce that you may only have one mutable
  reference _or_ multiple non-mutable references to the same value at
  any given time.
] else if lang == "de" [
  Meistens verwenden wir stattdessen _Referenzen_ (gekennzeichnet
  durch das Symbol `&`) oder _veränderbare Referenzen_
  (gekennzeichnet durch `&mut`). Referenzen verhalten sich ähnlich wie
  Zeiger, da sie dereferenziert werden können, um auf die
  zugrundeliegenden Werte zuzugreifen; sie sind jedoch ein wesentlicher
  Bestandteil des Ownership-Systems von Rust: Rust stellt strikt sicher,
  dass zu jedem Zeitpunkt entweder nur eine veränderbare Referenz
  _oder_ mehrere unveränderbare Referenzen auf denselben Wert
  existieren dürfen.
] else { todo }

#if lang == "en" [
  In practice this means you have to be more careful about whether you
  need mutable access to data: where in C the default is mutable and you
  must be explicit about `const`, in Rust the opposite is true.
] else if lang == "de" [
  In der Praxis bedeutet dies, dass man genauer abwägen muss, ob man
  veränderbaren Zugriff auf Daten benötigt: Während in C Veränderbarkeit
  der Standard ist und `const` explizit angegeben werden muss, verhält es
  sich in Rust genau umgekehrt.
] else { todo }

#if lang == "en" [
  One situation where you might still use raw pointers is interacting
  directly with hardware (for example, writing a pointer to a buffer into
  a DMA peripheral register), and they are also used under the hood for
  all peripheral access crates to allow you to read and write
  memory-mapped registers.
] else if lang == "de" [
  Eine Situation, in der man dennoch „Raw Pointer" (rohe Zeiger) verwenden
  könnte, ist die direkte Interaktion mit Hardware (zum Beispiel beim
  Schreiben eines Zeigers auf einen Puffer in ein DMA-Peripherieregister);
  zudem kommen sie im Hintergrund bei allen Crates für den
  Peripheriezugriff zum Einsatz, um das Lesen und Schreiben
  speicherabgebildeter Register (memory-mapped registers) zu ermöglichen.
] else { todo }

== #(if lang == "en" [Volatile Access]
  else if lang == "de" [Volatiler (unsicherer) Zugriff]
  else { todo })

#if lang == "en" [
  In C, individual variables may be marked `volatile`, indicating to the
  compiler that the value in the variable may change between accesses.
  Volatile variables are commonly used in an embedded context for
  memory-mapped registers.
] else if lang == "de" [
  In C können einzelne Variablen mit `volatile` gekennzeichnet werden, um
  dem Compiler mitzuteilen, dass sich ihr Wert zwischen den Zugriffen
  ändern kann. Volatile Variablen werden häufig in eingebetteten Systemen
  für im Speicher abgebildete Register verwendet.
] else { todo }

#let ln_read = link("https://doc.rust-lang.org/core/ptr/fn.read_volatile.html")[`core::ptr::read_volatile`]
#let ln_write = link("https://doc.rust-lang.org/core/ptr/fn.write_volatile.html")[`core::ptr::write_volatile`]
#if lang == "en" [
  In Rust, instead of marking a variable as `volatile`, we use specific
  methods to perform volatile access: #ln_read and #ln_write.
  These methods take a `*const T` or a `*mut T` (_raw pointers_, as
  discussed above) and perform a volatile read or write.
] else if lang == "de" [
  In Rust verwenden wir anstelle der Kennzeichnung einer Variable als
  `volatile` spezielle Methoden für den Zugriff auf unsichere Daten:
  #ln_read und #ln_write.
  Diese Methoden akzeptieren einen `*const T` oder einen `*mut T`
  (Rohzeiger, wie oben beschrieben) und führen einen flüchtigen Lese- bzw.
  Schreibvorgang durch.
] else { todo }

#if lang == "en" [
  For example, in C you might write:
] else if lang == "de" [
  In C könnten Sie zum Beispiel schreiben:
] else { todo }
 
#raw(block: true, lang: "c",
"volatile bool signalled = false;

void ISR() {
    // " + if lang == "en" {
        "Signal that the interrupt has occurred"
      } else if lang == "de" {
        "Signalisieren, dass der Interrupt aufgetreten ist"
      } else { todos } + "
    signalled = true;
}

void driver() {
    while(true) {
        // " + if lang == "en" {
            "Sleep until signalled"
          } else if lang == "de" {
            "Schlafen bis zum Signal"
          } else { todos } + "
        while(!signalled) { WFI(); }
        // " + if lang == "en" {
            "Reset signalled indicator"
          } else if lang == "de" {
            "Signalisierten Indikator zuruecksetzen"
          } else { todos } + "
        signalled = false;
        // " + if lang == "en" {
            "Perform some task that was waiting for the interrupt"
          } else if lang == "de" {
            "Fuehren Sie eine Aufgabe aus, die auf den Interrupt gewartet hat"
          } else { todos } + "
        run_task();
    }
}
")

#if lang == "en" [
  The equivalent in Rust would use volatile methods on each access:
] else if lang == "de" [
  Das Äquivalent in Rust würde bei jedem Zugriff volatile Methoden
  verwenden:
] else { todo }

#raw(block: true, lang: "rust",
"static mut SIGNALLED: bool = false;

#[interrupt]
fn ISR() {
    // " + if lang == "en" {
        "Signal that the interrupt has occurred
    // (In real code, you should consider a higher level primitive,
    //  such as an atomic type)."
      } else if lang == "de" {
        "Signalisieren, dass eine Unterbrechung aufgetreten ist
    // (Im realen Code sollten Sie eine hoeherwertige primitive Datenstruktur, 
    // wie z. B. einen atomaren Datentyp, in Betracht ziehen)."
      } else { todos } + "
    unsafe { core::ptr::write_volatile(&mut SIGNALLED, true) };
}

fn driver() {
    loop {
        // " + if lang == "en" {
            "Sleep until signalled"
          } else if lang == "de" {
            "Schlafen bis zum Signal"
          } else { todos } + "
        while unsafe { !core::ptr::read_volatile(&SIGNALLED) } {}
        // " + if lang == "en" {
            "Reset signalled indicator"
          } else if lang == "de" {
            "Signalisierten Indikator zuruecksetzen"
          } else { todos } + "
        unsafe { core::ptr::write_volatile(&mut SIGNALLED, false) };
        // " + if lang == "en" {
            "Perform some task that was waiting for the interrupt"
          } else if lang == "de" {
            "Fuehren Sie eine Aufgabe aus, die auf den Interrupt gewartet hat"
          } else { todos } + "
        run_task();
    }
}
")

#if lang == "en" [
  A few things are worth noting in the code sample:
  - We can pass `&mut SIGNALLED` into the function requiring `*mut T`, since `&mut T`
    automatically converts to a `*mut T` (and the same for `*const T`)
  - We need `unsafe` blocks for the `read_volatile`/`write_volatile` methods,
    since they are `unsafe` functions. It is the programmer's responsibility
    to ensure safe use: see the methods' documentation for further details.
] else if lang == "de" [
  Am Codebeispiel sind einige Dinge erwähnenswert:
  - Wir können `&mut SIGNALLED` an die Funktion übergeben, die `*mut T`
    erwartet, da `&mut T` automatisch in `*mut T` umgewandelt wird (und
    das Gleiche gilt für `*const T`).
  - Für die Methoden `read_volatile` und `write_volatile` benötigen wir
    `unsafe`-Blöcke, da es sich um `unsafe`-Funktionen handelt. Es liegt
    in der Verantwortung des Programmierers, für eine sichere Verwendung
    zu sorgen; weitere Einzelheiten sind der Dokumentation der jeweiligen
    Methoden zu entnehmen.
] else { todo }

#if lang == "en" [
  It is rare to require these functions directly in your code, as they
  will usually be taken care of for you by higher-level libraries. For
  memory mapped peripherals, the peripheral access crates will implement
  volatile access automatically, while for concurrency primitives there
  are better abstractions available (see the
  #link(<concurrency>)[Concurrency chapter]).
] else if lang == "de" [
  Es ist selten erforderlich, diese Funktionen direkt im eigenen Code zu
  verwenden, da sie üblicherweise von höherwertigen Bibliotheken für Sie
  übernommen werden. Bei speicherabgebildeten Peripheriekomponenten
  implementieren die entsprechenden „Peripheral Access Crates" den
  volatilen Zugriff automatisch, während für Nebenläufigkeits-Primitive
  bessere Abstraktionen zur Verfügung stehen (siehe das Kapitel
  #link(<concurrency>)[Nebenläufigkeit]).
] else { todo }

== #(if lang == "en" [Packed and Aligned Types]
  else if lang == "de" [Gepackte und ausgerichtete Datentypen]
  else { todo })

#if lang == "en" [
  In embedded C it is common to tell the compiler a variable must have a
  certain alignment or a struct must be packed rather than aligned,
  usually to meet specific hardware or protocol requirements.
] else if lang == "de" [
  In der Embedded-Programmierung mit C ist es üblich, dem Compiler
  vorzugeben, dass eine Variable eine bestimmte Ausrichtung (Alignment)
  aufweisen oder eine Struktur „gepackt" (packed) statt ausgerichtet sein
  muss -- meist, um spezifische Hardware- oder Protokollanforderungen zu
  erfüllen.
] else { todo }

#if lang == "en" [
  In Rust this is controlled by the `repr` attribute on a struct or union.
  The default representation provides no guarantees of layout, so should
  not be used for code that interoperates with hardware or C. The compiler
  may re-order struct members or insert padding and the behaviour may
  change with future versions of Rust.
] else if lang == "de" [
  In Rust wird dies über das `repr`-Attribut an einer `struct` oder
  `union` gesteuert. Die Standarddarstellung macht keine Zusagen über das
  Speicherlayout und sollte daher nicht für Code verwendet werden, der mit
  Hardware oder C interagiert. Der Compiler kann die Reihenfolge der
  Strukturmitglieder ändern oder Füllbytes (Padding) einfügen, und das
  Verhalten kann sich in zukünftigen Rust-Versionen ändern.
] else { todo }

#raw(block: true, lang: "rust",
"struct Foo {
    x: u16,
    y: u8,
    z: u16,
}

fn main() {
    let v = Foo { x: 0, y: 0, z: 0 };
    println!(\"{:p} {:p} {:p}\", &v.x, &v.y, &v.z);
}

// 0x7ffecb3511d0 0x7ffecb3511d4 0x7ffecb3511d2
// " + if lang == "en" {
    "Note ordering has been changed to x, z, y to improve packing."
  } else if lang == "de" {
    "Die Reihenfolge der Noten wurde auf x, z, y geaendert, um die Packdichte zu 
// verbessern."
  } else { todos } + "
")

#if lang == "en" [
  To ensure layouts that are interoperable with C, use `repr(C)`:
] else if lang == "de" [
  Um Layouts zu gewährleisten, die mit C interoperabel sind, verwenden Sie `repr(C)`:
] else { todo }

#raw(block: true, lang: "rust",
"#[repr(C)]
struct Foo {
    x: u16,
    y: u8,
    z: u16,
}

fn main() {
    let v = Foo { x: 0, y: 0, z: 0 };
    println!(\"{:p} {:p} {:p}\", &v.x, &v.y, &v.z);
}

// 0x7fffd0d84c60 0x7fffd0d84c62 0x7fffd0d84c64
// " + if lang == "en" {
    "Ordering is preserved and the layout will not change over time.
// `z` is two-byte aligned so a byte of padding exists between `y` and `z`."
  } else if lang == "de" {
    "Die Reihenfolge bleibt erhalten und das Layout veraendert sich im Laufe der 
// Zeit nicht.
// `z` ist auf Zwei-Byte-Grenzen ausgerichtet, sodass sich zwischen `y` und `z` 
// ein Padding-Byte befindet."
  } else { todos } + "
")

#if lang == "en" [
  To ensure a packed representation, use `repr(packed)`:
] else if lang == "de" [
  Um eine kompakte Darstellung zu gewährleisten, verwenden Sie `repr(packed)`:
] else { todo }

#raw(block: true, lang: "rust",
"#[repr(packed)]
struct Foo {
    x: u16,
    y: u8,
    z: u16,
}

fn main() {
    let v = Foo { x: 0, y: 0, z: 0 };
    // " + if lang == "en" {
        "References must always be aligned, so to check the addresses of the
    // struct's fields, we use `std::ptr::addr_of!()` to get a raw pointer
    // instead of just printing `&v.x`."
      } else if lang == "de" {
        "Referenzen muessen stets korrekt ausgerichtet sein; um also die 
    // Adressen der Struct-Felder zu ueberpruefen, verwenden wir 
    // `std::ptr::addr_of!()`, um einen Rohzeiger (Raw Pointer) zu erhalten, 
    // anstatt einfach `&v.x` auszugeben."
      } else { todos } + "
    let px = std::ptr::addr_of!(v.x);
    let py = std::ptr::addr_of!(v.y);
    let pz = std::ptr::addr_of!(v.z);
    println!(\"{:p} {:p} {:p}\", px, py, pz);
}

// 0x7ffd33598490 0x7ffd33598492 0x7ffd33598493
// " + if lang == "en" {
    "No padding has been inserted between `y` and `z`, so now `z` is unaligned."
  } else if lang == "de" {
    "Zwischen `y` und `z` wurde kein Padding eingefuegt, daher ist `z` nun 
// nicht ausgerichtet."
  } else { todos } + "
")

#if lang == "en" [
  Note that using `repr(packed)` also sets the alignment of the type to `1`.
] else if lang == "de" [
  Beachten Sie, dass die Verwendung von `repr(packed)` die Ausrichtung des
  Typs ebenfalls auf `1` setzt.
] else { todo }

#if lang == "en" [
  Finally, to specify a specific alignment, use `repr(align(n))`, where
  `n` is the number of bytes to align to (and must be a power of two):
] else if lang == "de" [
  Um eine bestimmte Ausrichtung festzulegen, verwenden Sie schließlich
  `repr(align(n))`, wobei `n` die Anzahl der auszurichtenden Bytes ist
  (und eine Zweierpotenz sein muss).
] else { todo }

#raw(block: true, lang: "rust",
"#[repr(C)]
#[repr(align(4096))]
struct Foo {
    x: u16,
    y: u8,
    z: u16,
}

fn main() {
    let v = Foo { x: 0, y: 0, z: 0 };
    let u = Foo { x: 0, y: 0, z: 0 };
    println!(\"{:p} {:p} {:p}\", &v.x, &v.y, &v.z);
    println!(\"{:p} {:p} {:p}\", &u.x, &u.y, &u.z);
}

// 0x7ffec909a000 0x7ffec909a002 0x7ffec909a004
// 0x7ffec909b000 0x7ffec909b002 0x7ffec909b004
// " + if lang == "en" {
    "The two instances `u` and `v` have been placed on 4096-byte alignments,
// evidenced by the `000` at the end of their addresses."
  } else if lang == "de" {
    "Die beiden Instanzen `u` und `v` wurden an 4096-Byte-Grenzen ausgerichtet, 
// was an den `000` am Ende ihrer Adressen erkennbar ist."
  } else { todos } + "
")

#if lang == "en" [
  Note we can combine `repr(C)` with `repr(align(n))` to obtain an aligned
  and C-compatible layout. It is not permissible to combine
  `repr(align(n))` with `repr(packed)`, since `repr(packed)` sets the
  alignment to `1`. It is also not permissible for a `repr(packed)` type
  to contain a `repr(align(n))` type.
] else if lang == "de" [
  Beachten Sie, dass wir `repr(C)` mit `repr(align(n))` kombinieren
  können, um ein ausgerichtetes und C-kompatibles Layout zu erhalten. Die
  Kombination von `repr(align(n))` mit `repr(packed)` ist nicht zulässig,
  da `repr(packed)` die Ausrichtung auf `1` setzt. Ebenso ist es nicht
  zulässig, dass ein `repr(packed)`-Typ einen `repr(align(n))`-Typ
  enthält.
] else { todo }

#let url_layout = "https://doc.rust-lang.org/reference/type-layout.html"
#if lang == "en" [
  For further details on type layouts, refer to the #link(url_layout)[type layout]
  chapter of the Rust Reference.
] else if lang == "de" [
  Weitere Details zu Typ-Layouts finden Sie im Kapitel
  #link(url_layout)[Typ-Layout]
  der Rust-Referenz.
] else { todo }

== #(if lang == "en" [Other Resources]
  else if lang == "de" [Weitere Ressourcen]
  else { todo })

#let url_faq = "https://docs.rust-embedded.org/faq.html"
#let url_for_c = "http://blahg.josefsipek.net/?p=580"
#let url_pointers = "https://github.com/diwic/reffers-rs/blob/master/docs/Pointers.html"
#if lang == "en" [
  - In this book:
    - #link(<c-with-rust>)[A little C with your Rust]
    - #link(<rust-with-c>)[A little Rust with your C]
  - #link(url_faq)[The Rust Embedded FAQs]
  - #link(url_for_c)[Rust Pointers for C Programmers]
  - #link(url_pointers)[I used to use pointers - now what?]
] else if lang == "de" [
  - In diesem Buch:
    - #link(<c-with-rust>)[Ein bisschen C zu Ihrem Rust]
    - #link(<rust-with-c>)[Ein bisschen Rust zu Ihrem C]
  - #link(url_faq)[Die Rust-Embedded-FAQs]
  - #link(url_for_c)[Rust-Pointer für C-Programmierer]
  - #link(url_pointers)[Früher habe ich Pointer verwendet -- und jetzt?]
] else { todo }
