#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [Optimizations: the speed size tradeoff]
  else if lang == "de" [Optimierungen: Der Kompromiss zwischen Geschwindigkeit und Größe]
  else { todo })

#if lang == "en" [
  Everyone wants their program to be super fast and super small but it's
  usually not possible to have both characteristics. This section
  discusses the different optimization levels that `rustc` provides and
  how they affect the execution time and binary size of a program.
] else if lang == "de" [
  Jeder möchte, dass sein Programm extrem schnell und extrem klein ist,
  doch meist lassen sich nicht beide Eigenschaften zugleich verwirklichen.
  Dieser Abschnitt behandelt die verschiedenen Optimierungsstufen von
  `rustc` und deren Auswirkungen auf die Ausführungszeit sowie die Größe
  der Binärdatei eines Programms.
] else { todo }

= #(if lang == "en" [No optimizations]
  else if lang == "de" [Keine Optimierungen]
  else { todo })

#if lang == "en" [
  This is the default. When you call `cargo build` you use the development
  (AKA `dev`) profile. This profile is optimized for debugging so it
  enables debug information and does _not_ enable any optimizations,
  i.e.~it uses `-C opt-level = 0`.
] else if lang == "de" [
  Dies ist die Standardeinstellung. Wenn Sie `cargo build` aufrufen, wird
  das Entwicklungs-Profil (auch bekannt als `dev`-Profil) verwendet. Da
  dieses Profil für das Debugging optimiert ist, werden
  Debug-Informationen aktiviert, jedoch _keinerlei_ Optimierungen
  vorgenommen; es wird also `-C opt-level=0` verwendet.
] else { todo }

#if lang == "en" [
  At least for bare metal development, debuginfo is zero cost in the sense
  that it won't occupy space in Flash / ROM so we actually recommend that
  you enable debuginfo in the release profile -- it is disabled by
  default. That will let you use breakpoints when debugging release builds.
] else if lang == "de" [
  Zumindest bei der Bare-Metal-Entwicklung verursachen Debug-Informationen
  keine Kosten im Sinne von Speicherplatzbedarf im Flash- oder
  ROM-Speicher. Daher empfehlen wir, Debug-Informationen auch im
  Release-Profil zu aktivieren -- standardmäßig sind sie dort deaktiviert.
  Dies ermöglicht Ihnen die Verwendung von Breakpoints beim Debuggen von
  Release-Builds.
] else { todo }

#raw(block: true, lang: "toml",
"[profile.release]
# " + if lang == "en" {
    "symbols are nice and they don't increase the size on Flash"
  } else if lang == "de" {
    "Symbole sind praktisch und vergroessern die Dateigroesse im Flash nicht"
  } else { todos } + "
debug = true
")

#if lang == "en" [
  No optimizations is great for debugging because stepping through the
  code feels like you are executing the program statement by statement,
  plus you can `print` stack variables and function arguments in GDB. When
  the code is optimized, trying to print variables results in
  `$0 = <value optimized out>` being printed.
] else if lang == "de" [
  Der Verzicht auf Optimierungen ist ideal für das Debugging, da sich das
  schrittweise Durchlaufen des Codes anfühlt, als würde man das Programm
  Anweisung für Anweisung ausführen; zudem lassen sich Stack-Variablen und
  Funktionsargumente in GDB per `print` ausgeben. Bei optimiertem Code
  führt der Versuch, Variablen auszugeben, hingegen zur Meldung
  `$0 = <value optimized out>`.
] else { todo }

#if lang == "en" [
  The biggest downside of the `dev` profile is that the resulting binary
  will be huge and slow. The size is usually more of a problem because
  unoptimized binaries can occupy dozens of KiB of Flash, which your
  target device may not have -- the result: your unoptimized binary
  doesn't fit in your device!
] else if lang == "de" [
  Der größte Nachteil des `dev`-Profils besteht darin, dass die
  resultierende Binärdatei sehr groß und langsam ist. Meist wiegt vor
  allem die Größe schwer, da nicht optimierte Binärdateien Dutzende KiB an
  Flash-Speicher belegen können -- Speicherplatz, über den das Zielgerät
  womöglich gar nicht verfügt. Die Folge: Die nicht optimierte Binärdatei
  passt nicht auf das Gerät!
] else { todo }

#if lang == "en" [
  Can we have smaller, debugger friendly binaries? Yes, there's a trick.
] else if lang == "de" [
  Gibt es eine Möglichkeit, kleinere und dennoch für das Debugging
  geeignete Binärdateien zu erhalten? Ja, es gibt einen Trick.
] else { todo }

== #(if lang == "en" [Optimizing dependencies]
  else if lang == "de" [Optimierung der Abhängigkeiten]
  else { todo })

#let url_overrides = "https://doc.rust-lang.org/cargo/reference/profiles.html#overrides"
#if lang == "en" [
  There's a Cargo feature named #link(url_overrides)[`profile-overrides`]
  that lets you override the optimization level of dependencies. You can
  use that feature to optimize all dependencies for size while keeping the
  top crate unoptimized and debugger friendly.
] else if lang == "de" [
  Cargo bietet mit #link(url_overrides)[`Profil-Überschreibung`]
  eine Funktion, mit der Sie den Optimierungsgrad von Abhängigkeiten
  überschreiben können. So lassen sich alle Abhängigkeiten hinsichtlich
  ihrer Größe optimieren, während die oberste Crate unoptimiert und
  debuggfreundlich bleibt.
] else { todo }

#if lang == "en" [
  Beware that generic code can sometimes be optimized alongside the crate
  where it is instantiated, rather than the crate where it is defined. If
  you create an instance of a generic struct in your application and find
  that it pulls in code with a large footprint, it may be that increasing
  the optimisation level of the relevant dependencies has no effect.
] else if lang == "de" [
  Beachten Sie, dass generischer Code manchmal zusammen mit der Crate
  optimiert werden kann, in der er instanziiert wird, anstatt mit der
  Crate, in der er definiert ist. Wenn Sie in Ihrer Anwendung eine Instanz
  einer generischen Struktur erstellen und feststellen, dass diese Code
  mit großem Speicherbedarf einbindet, kann es sein, dass eine Erhöhung
  des Optimierungsgrads der relevanten Abhängigkeiten keine Wirkung zeigt.
] else { todo }

#if lang == "en" [
  Here's an example:
] else if lang == "de" [
  Hier ist ein Beispiel:
] else { todo }

```toml
# Cargo.toml
[package]
name = "app"
# ..

[profile.dev.package."*"] # +
opt-level = "z" # +
```

#if lang == "en" [
  Without the override:
] else if lang == "de" [
  Ohne die Überschreibung:
] else { todo }

```text
$ cargo size --bin app -- -A
app  :
section               size        addr
.vector_table         1024   0x8000000
.text                 9060   0x8000400
.rodata               1708   0x8002780
.data                    0  0x20000000
.bss                     4  0x20000000
```

#if lang == "en" [
  With the override:
] else if lang == "de" [
  Mit der Überschreibung
] else { todo }

```text
$ cargo size --bin app -- -A
app  :
section               size        addr
.vector_table         1024   0x8000000
.text                 3490   0x8000400
.rodata               1100   0x80011c0
.data                    0  0x20000000
.bss                     4  0x20000000
```

#if lang == "en" [
  That's a 6 KiB reduction in Flash usage without any loss in the
  debuggability of the top crate. If you step into a dependency then
  you'll start seeing those `<value optimized out>` messages again but
  it's usually the case that you want to debug the top crate and not the
  dependencies. And if you _do_ need to debug a dependency then you
  can use the `profile-overrides` feature to exclude a particular
  dependency from being optimized. See example below:
] else if lang == "de" [
  Das bedeutet eine Verringerung des Flash-Speicherverbrauchs um 6 KiB,
  ohne die Debug-Fähigkeit des Haupt-Crates zu beeinträchtigen. Wenn man
  in eine Abhängigkeit hineinspringt, erscheinen zwar wieder die Meldungen
  `<value optimized out>`, doch in der Regel möchte man das Haupt-Crate
  debuggen und nicht die Abhängigkeiten. Sollte es dennoch erforderlich
  sein, eine Abhängigkeit zu debuggen, lässt sich die Funktion
  `profile-overrides` nutzen, um diese spezifische Abhängigkeit von der
  Optimierung auszunehmen. Siehe dazu das folgende Beispiel:
] else { todo }

#raw(block: true, lang: "toml",
"# ..

# " + if lang == "en" {
    "don't optimize the `cortex-m-rt` crate"
  } else if lang == "de" {
    "Optimiere das `cortex-m-rt`-Crate nicht"
  } else { todos } + "
[profile.dev.package.cortex-m-rt] # +
opt-level = 0 # +

# " + if lang == "en" {
    "but do optimize all the other dependencies"
  } else if lang == "de" {
    "optimieren Sie jedoch alle anderen Abhaengigkeiten"
  } else { todos } + "
[profile.dev.package.\"*\"]
codegen-units = 1 # " + if lang in ("en", "de") {
                    "better optimizations"
                  } else { todos } + "
opt-level = \"z\"
")

#if lang == "en" [
  Now the top crate and `cortex-m-rt` are debugger friendly!
] else if lang == "de" [
  Jetzt sind das Top-Level-Crate und `cortex-m-rt` debuggerfreundlich!
] else { todo }

= #(if lang == "en" [Optimize for speed]
  else if lang == "de" [Auf Geschwindigkeit optimieren]
  else { todo })

#if lang == "en" [
  As of 2018-09-18 `rustc` supports three "optimize for speed" levels:
  `opt-level = 1`, `2` and `3`. When you run `cargo build --release` you
  are using the release profile which defaults to `opt-level = 3`.
] else if lang == "de" [
  Seit dem 18.09.2018 unterstützt `rustc` drei Stufen der
  Geschwindigkeitsoptimierung: `opt-level = 1`, `2` und `3`. Beim
  Ausführen von `cargo build --release` wird das Release-Profil verwendet,
  das standardmäßig auf `opt-level = 3` eingestellt ist.
] else { todo }

#if lang == "en" [
  Both `opt-level = 2` and `3` optimize for speed at the expense of binary
  size, but level `3` does more vectorization and inlining than level `2`.
  In particular, you'll see that at `opt-level` equal to or greater than
  `2` LLVM will unroll loops. Loop unrolling has a rather high cost in
  terms of Flash / ROM (e.g.~from 26 bytes to 194 for a zero this array
  loop) but can also halve the execution time given the right conditions
  (e.g.~number of iterations is big enough).
] else if lang == "de" [
  Sowohl `opt-level = 2` als auch `3` optimieren auf Geschwindigkeit
  zulasten der Binärgröße; allerdings führt Stufe `3` mehr Vektorisierung
  und Inlining durch als Stufe `2`. Insbesondere ist zu beobachten, dass
  LLVM bei einem `opt-level` von 2 oder höher Schleifen entrollt („Loop
  Unrolling"). Das Entrollen von Schleifen ist recht kostspielig im
  Hinblick auf den Flash-/ROM-Speicherbedarf (z. B. Anstieg von 26 auf 194
  Bytes für eine Schleife zum Nullsetzen eines Arrays), kann aber unter
  geeigneten Bedingungen (etwa bei einer ausreichend hohen Anzahl von
  Iterationen) die Ausführungszeit halbieren.
] else { todo }

#if lang == "en" [
  Currently there's no way to disable loop unrolling in `opt-level = 2`
  and `3` so if you can't afford its cost you should optimize your program
  for size.
] else if lang == "de" [
  Derzeit gibt es keine Möglichkeit, das Entrollen von Schleifen bei
  `opt-level = 2` und `3` zu deaktivieren; wenn Sie sich diesen
  Speicheraufwand also nicht leisten können, sollten Sie Ihr Programm
  stattdessen auf eine geringe Größe hin optimieren.
] else { todo }

= #(if lang == "en" [Optimize for size]
  else if lang == "de" [Nach Größe optimieren]
  else { todo })

#if lang == "en" [
  As of 2018-09-18 `rustc` supports two "optimize for size" levels:
  `opt-level = "s"` and `"z"`. These names were inherited from clang /
  LLVM and are not too descriptive but `"z"` is meant to give the idea
  that it produces smaller binaries than `"s"`.
] else if lang == "de" [
  Seit dem 18.09.2018 unterstützt `rustc` zwei Stufen zur
  Größenoptimierung: `opt-level = "s"` und `"z"`. Diese Bezeichnungen
  wurden von Clang/LLVM übernommen und sind nicht besonders
  aussagekräftig; allerdings soll das `"z"` signalisieren, dass damit
  kleinere Binärdateien erzeugt werden als mit `"s"`.
] else { todo }

#if lang == "en" [
  If you want your release binaries to be optimized for size then change
  the `profile.release.opt-level` setting in `Cargo.toml` as shown below.
] else if lang == "de" [
  Wenn Ihre Release-Binärdateien hinsichtlich der Größe optimiert werden
  sollen, ändern Sie die Einstellung `profile.release.opt-level` in der
  Datei `Cargo.toml` wie unten dargestellt.
] else { todo }

#raw(block: true, lang: "toml",
"[profile.release]
# " + if lang == "en" { "or \"z\"" }
  else if lang == "de" { "oder \"z\"" }
  else { todos } + "
opt-level = \"s\"
")

#if lang == "en" [
  These two optimization levels greatly reduce LLVM's inline threshold, a
  metric used to decide whether to inline a function or not. One of Rust
  principles are zero cost abstractions; these abstractions tend to use a
  lot of newtypes and small functions to hold invariants (e.g.~functions
  that borrow an inner value like `deref`, `as_ref`) so a low inline
  threshold can make LLVM miss optimization opportunities (e.g.~eliminate
  dead branches, inline calls to closures).
] else if lang == "de" [
  Diese beiden Optimierungsstufen senken den Inline-Schwellenwert von LLVM
  erheblich -- einen Kennwert, der darüber entscheidet, ob eine Funktion
  „geinlined" (direkt an der Aufrufstelle eingebettet) wird oder nicht.
  Eines der Prinzipien von Rust sind „Zero-Cost-Abstractions"
  (Abstraktionen ohne Laufzeitkosten); diese nutzen häufig sogenannte
  „Newtypes" und kleine Funktionen zur Wahrung von Invarianten (z. B.
  Funktionen wie `deref` oder `as_ref`, die einen inneren Wert ausleihen).
  Ein niedriger Inline-Schwellenwert kann daher dazu führen, dass LLVM
  Optimierungsmöglichkeiten verpasst (etwa das Entfernen von nicht
  erreichbaren Programmzweigen oder das Inlinen von Closure-Aufrufen).
] else { todo }

#if lang == "en" [
When optimizing for size you may want to try increasing the inline
threshold to see if that has any effect on the binary size. The
recommended way to change the inline threshold is to append the
`-C inline-threshold` flag to the other rustflags in
`.cargo/config.toml`.
] else if lang == "de" [
  Bei der Optimierung auf eine geringe Binärgröße kann es sinnvoll sein,
  den Inline-Schwellenwert zu erhöhen und zu prüfen, ob sich dies auf die
  Größe der Binärdatei auswirkt. Die empfohlene Methode zur Änderung
  dieses Schwellenwerts besteht darin, das Flag `-C inline-threshold` zu
  den übrigen `rustflags` in der Datei `.cargo/config.toml` hinzuzufügen.
] else { todo }

#raw(block: true, lang: "toml",
"# .cargo/config.toml
# " + if lang == "en" {
    "this assumes that you are using the cortex-m-quickstart template"
  } else if lang == "de" {
    "Dies setzt voraus, dass Sie die cortex-m-quickstart-Vorlage verwenden"
  } else { todos } + "
[target.'cfg(all(target_arch = \"arm\", target_os = \"none\"))']
rustflags = [
  # ..
  \"-C\", \"inline-threshold=123\", # +
]
")

#let url_opt_lvls = "https://github.com/rust-lang/rust/blob/1.29.0/src/librustc_codegen_llvm/back/write.rs#L2105-L2122"
#if lang == "en" [
  What value to use?
  #link(url_opt_lvls)[As of 1.29.0 these are the inline thresholds that the different optimization levels use]:
  - `opt-level = 3` uses 275
  - `opt-level = 2` uses 225
  - `opt-level = "s"` uses 75
  - `opt-level = "z"` uses 25
] else if lang == "de" [
  Welchen Wert verwenden?
  #link(url_opt_lvls)[Ab Version 1.29.0 gelten für die verschiedenen Optimierungsstufen folgende Inline-Schwellenwerte]:
  - `opt-level = 3` verwendet 275
  - `opt-level = 2` verwendet 225
  - `opt-level = "s"` verwendet 75
  - `opt-level = "z"` verwendet 25
] else { todo }

#if lang == "en" [
  You should try `225` and `275` when optimizing for size.
] else if lang == "de" [
  Du solltest `225` und `275` ausprobieren, wenn du auf die Größe
  optimierst.
] else { todo }
