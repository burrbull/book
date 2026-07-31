#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [A little Rust with your C]
  else if lang == "de" [Ein bisschen Rust zu Ihrem C]
  else { todo })
<rust-with-c>
#set heading(offset: whole*2)

#if lang == "en" [
  Using Rust code inside a C or C++ project mostly consists of two parts.
  - Creating a C-friendly API in Rust
  - Embedding your Rust project into an external build system
] else if lang == "de" [
  Die Verwendung von Rust-Code in einem C- oder C++-Projekt besteht
  größtenteils aus zwei Teilen.
  - Erstellung einer C-kompatiblen API in Rust
  - Einbindung Ihres Rust-Projekts in ein externes Build-System
] else { todo }

#if lang == "en" [
  Apart from `cargo` and `meson`, most build systems don't have native
  Rust support. So you're most likely best off just using `cargo` for
  compiling your crate and any dependencies.
] else if lang == "de" [
  Abgesehen von `cargo` und `meson` bieten die meisten Build-Systeme keine
  native Rust-Unterstützung. Daher fährst du höchstwahrscheinlich am
  besten damit, einfach `cargo` für die Kompilierung deines Crates und
  aller Abhängigkeiten zu verwenden.
] else { todo }

= #(if lang == "en" [Setting up a project]
  else if lang == "de" [Ein Projekt einrichten]
  else { todo })

#if lang == "en" [
  Create a new `cargo` project as usual.
] else if lang == "de" [
  Erstellen Sie wie gewohnt ein neues `cargo`-Projekt.
] else { todo }

#if lang == "en" [
  There are flags to tell `cargo` to emit a systems library, instead of
  its regular rust target. This also allows you to set a different output
  name for your library, if you want it to differ from the rest of your crate.
] else if lang == "de" [
  Es gibt Flags, mit denen man `cargo` anweisen kann, eine
  Systembibliothek anstelle des üblichen Rust-Ziels zu erstellen. Auf
  diese Weise können Sie auch einen abweichenden Namen für die Bibliothek
  festlegen, falls dieser sich von dem des restlichen Crates unterscheiden soll.
] else { todo }
 
#raw(block: true, lang: "toml",
"[lib]
name = \"your_crate\"
crate-type = [\"cdylib\"]      # " + if lang == "en" {
                                "Creates dynamic lib"
                              } else if lang == "de" {
                                "Erstellt eine dynamische Bibliothek"
                              } else { todos } + "
# crate-type = [\"staticlib\"] # " + if lang == "en" {
                                "Creates static lib"
                              } else if lang == "de" {
                                "Erstellt eine statische Bibliothek"
                              } else { todos } + "
")

= #(if lang == "en" [Building a `C` API]
  else if lang == "de" [Erstellung einer C-API]
  else { todo })

#if lang == "en" [
  Because C++ has no stable ABI for the Rust compiler to target, we use
  `C` for any interoperability between different languages. This is no
  exception when using Rust inside of C and C++ code.
] else if lang == "de" [
  Da C++ über keine stabile ABI verfügt, auf die der Rust-Compiler
  abzielen könnte, nutzen wir C für die Interoperabilität zwischen
  verschiedenen Sprachen. Dies gilt auch für die Verwendung von Rust
  innerhalb von C- und C++-Code.
] else { todo }

== `#[no_mangle]`

#if lang == "en" [
  The Rust compiler mangles symbol names differently than native code
  linkers expect. As such, any function that Rust exports to be used
  outside of Rust needs to be told not to be mangled by the compiler.
] else if lang == "de" [
  Der Rust-Compiler verarbeitet Symbolnamen anders als Linker für nativen
  Code erwarten. Daher muss jeder Funktion, die Rust zur Verwendung
  außerhalb von Rust exportiert, mitgeteilt werden, dass der Compiler sie
  nicht verändern soll.
] else { todo }

== `extern "C"`

#if lang == "en" [
  By default, any function you write in Rust will use the Rust ABI (which
  is also not stabilized). Instead, when building outwards facing FFI APIs
  we need to tell the compiler to use the system ABI.
] else if lang == "de" [
  Standardmäßig verwendet jede in Rust geschriebene Funktion die Rust-ABI
  (die ebenfalls nicht stabilisiert ist). Beim Erstellen von nach außen
  gerichteten FFI-APIs muss der Compiler daher angewiesen werden, die
  System-ABI zu verwenden.
] else { todo }

#let url_external = "https://doc.rust-lang.org/reference/items/external-blocks.html"
#if lang == "en" [
  Depending on your platform, you might want to target a specific ABI
  version, which are documented #link(url_external)[here].
] else if lang == "de" [
  Je nach Plattform möchten Sie möglicherweise eine bestimmte ABI-Version
  anvisieren; diese sind #link(url_external)[hier] dokumentiert.
] else { todo }

#divider()

#if lang == "en" [
  Putting these parts together, you get a function that looks roughly like this.
] else if lang == "de" [
  Wenn man diese Teile zusammensetzt, erhält man eine Funktion, die
  ungefähr so ​​aussieht.
] else { todo }

```rust
#[no_mangle]
pub extern "C" fn rust_function() {

}
```

#if lang == "en" [
  Just as when using `C` code in your Rust project you now need to
  transform data from and to a form that the rest of the application will
  understand.
] else if lang == "de" [
  Genau wie bei der Verwendung von C-Code in Ihrem Rust-Projekt müssen Sie
  nun Daten in eine Form umwandeln -- und aus dieser zurück --, die der
  Rest der Anwendung versteht.
] else { todo }

= #(if lang == "en" [Linking and greater project context]
  else if lang == "de" [Verknüpfung und übergeordneter Projektkontext]
  else { todo })

#if lang == "en" [
  So then, that's one half of the problem solved. How do you use this now?
] else if lang == "de" [
  Damit ist die eine Hälfte des Problems gelöst. Wie verwendet man das nun?
] else { todo }

#if lang == "en" [
  *This very much depends on your project and/or build system*
] else if lang == "de" [
  *Das hängt stark von Ihrem Projekt bzw. Ihrem Build-System ab.*
] else { todo }

#if lang == "en" [
  `cargo` will create a `my_lib.so`/`my_lib.dll` or `my_lib.a` file,
  depending on your platform and settings. This library can simply be
  linked by your build system.
] else if lang == "de" [
  `cargo` erstellt -- je nach Plattform und Einstellungen -- eine Datei
  namens `my_lib.so`, `my_lib.dll` oder `my_lib.a`. Diese Bibliothek kann
  einfach von Ihrem Build-System eingebunden (gelinkt) werden.
] else { todo }

#if lang == "en" [
  However, calling a Rust function from C requires a header file to
  declare the function signatures.
] else if lang == "de" [
  Um jedoch eine Rust-Funktion aus C heraus aufzurufen, ist eine
  Header-Datei erforderlich, in der die Funktionssignaturen deklariert werden.
] else { todo }

#if lang == "en" [
  Every function in your Rust-ffi API needs to have a corresponding header function.
] else if lang == "de" [
  Für jede Funktion in Ihrer Rust-FFI-API muss eine entsprechende
  Deklaration im Header vorhanden sein.
] else { todo }

```rust
#[no_mangle]
pub extern "C" fn rust_function() {}
```

#if lang == "en" [
  would then become
] else if lang == "de" [
  würde dann werden
] else { todo }

```c
void rust_function();
```

#if lang == "en" [
  etc.
] else if lang == "de" [
  usw.
] else { todo }

#if lang == "en" [
  There is a tool to automate this process, called
  #link("https://github.com/eqrion/cbindgen")[cbindgen] which analyses
  your Rust code and then generates headers for your C and C++ projects
  from it.
] else if lang == "de" [
  Es gibt ein Werkzeug zur Automatisierung dieses Prozesses namens
  #link("https://github.com/eqrion/cbindgen")[cbindgen], das Ihren
  Rust-Code analysiert und daraus Header-Dateien für Ihre C- und
  C++-Projekte generiert.
] else { todo }

#if lang == "en" [
  At this point, using the Rust functions from C is as simple as including
  the header and calling them!
] else if lang == "de" [
  An diesem Punkt ist die Verwendung der Rust-Funktionen aus C heraus so
  einfach, wie den Header einzubinden und die Funktionen aufzurufen!
] else { todo }

```c
#include "my-rust-project.h"
rust_function();
```
