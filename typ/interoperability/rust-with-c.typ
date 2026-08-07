#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [A little Rust with your C]
  else if lang == "de" [Ein bisschen Rust zu Ihrem C]
  else if lang == "zh" [使用Rust的C]
  else { todo })
<rust-with-c>

#if lang == "en" [
  Using Rust code inside a C or C++ project mostly consists of two parts.
  - Creating a C-friendly API in Rust
  - Embedding your Rust project into an external build system
] else if lang == "de" [
  Die Verwendung von Rust-Code in einem C- oder C++-Projekt besteht
  größtenteils aus zwei Teilen.
  - Erstellung einer C-kompatiblen API in Rust
  - Einbindung Ihres Rust-Projekts in ein externes Build-System
] else if lang == "zh" [
  在C或者C++中使用Rust代码通常由两部分组成。
  - 用Rust生成一个C友好的API
  - 将你的Rust项目嵌入一个外部的编译系统
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
] else if lang == "zh" [
  除了`cargo`和`meson`，大多数编译系统没有原生Rust支持。因此你最好只用`cargo`编译你的crate和依赖。
] else { todo }

= #(if lang == "en" [Setting up a project]
  else if lang == "de" [Ein Projekt einrichten]
  else if lang == "zh" [设置一个项目]
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
] else if lang == "zh" [
  像往常一样创建一个新的`cargo`项目。有一些标志可以告诉`cargo`去生成一个系统库，而不是常规的rust目标文件。如果你想要它与crate的其它部分不一样，你也可以为你的库设置一个不同的输出名。
] else { todo }
 
#raw(block: true, lang: "toml",
"[lib]
name = \"your_crate\"
crate-type = [\"cdylib\"]      # " + if lang == "en" {
                                "Creates dynamic lib"
                              } else if lang == "de" {
                                "Erstellt eine dynamische Bibliothek"
                              } else if lang == "zh" {
                                "生成动态链接库"
                              } else { todos } + "
# crate-type = [\"staticlib\"] # " + if lang == "en" {
                                "Creates static lib"
                              } else if lang == "de" {
                                "Erstellt eine statische Bibliothek"
                            } else if lang == "zh" {
                              "生成静态链接库"
                              } else { todos } + "
")

= #(if lang == "en" [Building a `C` API]
  else if lang == "de" [Erstellung einer C-API]
  else if lang == "zh" [构建一个`C` API]
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
] else if lang == "zh" [
  因为对于Rust编译器来说，C++没有稳定的ABI，因此对于不同语言间的互操性我们使用`C`。在C和C++代码的内部使用Rust时也不例外。
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
] else if lang == "zh" [
  Rust对符号名的修饰与主机的代码链接器所期望的不同。因此，需要告知任何被Rust导出到Rust外部去使用的函数不要被编译器修饰。
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
] else if lang == "zh" [
  默认，任何用Rust写的函数将使用Rust ABI(这也不稳定)。当编译面向外部的FFI
  APIs时，我们需要告诉编译器去使用系统ABI 。
] else { todo }

#let url_external = "https://doc.rust-lang.org/reference/items/external-blocks.html"
#if lang == "en" [
  Depending on your platform, you might want to target a specific ABI
  version, which are documented #link(url_external)[here].
] else if lang == "de" [
  Je nach Plattform möchten Sie möglicherweise eine bestimmte ABI-Version
  anvisieren; diese sind #link(url_external)[hier] dokumentiert.
] else if lang == "zh" [
  取决于你的平台，你可能想要针对一个特定的ABI版本，其记录在#link(url_external)[这里]。
] else { todo }

#divider()

#if lang == "en" [
  Putting these parts together, you get a function that looks roughly like this.
] else if lang == "de" [
  Wenn man diese Teile zusammensetzt, erhält man eine Funktion, die
  ungefähr so ​​aussieht.
] else if lang == "zh" [
  把这些部分放在一起，你得到一个函数，其粗略看起来像是这个。
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
] else if lang == "zh" [
  就像在Rust项目中使用`C`代码时那样，现在需要把数据转换为应用中其它部分可以理解的形式。
] else { todo }

= #(if lang == "en" [Linking and greater project context]
  else if lang == "de" [Verknüpfung und übergeordneter Projektkontext]
  else if lang == "zh" [链接和更大的项目上下文]
  else { todo })

#if lang == "en" [
  So then, that's one half of the problem solved. How do you use this now?
] else if lang == "de" [
  Damit ist die eine Hälfte des Problems gelöst. Wie verwendet man das nun?
] else if lang == "zh" [
  问题只解决了一半。

  你现在要如何使用它?
] else { todo }

#if lang == "en" [
  *This very much depends on your project and/or build system*
] else if lang == "de" [
  *Das hängt stark von Ihrem Projekt bzw. Ihrem Build-System ab.*
] else if lang == "zh" [
  *这很大程度上取决于你的项目或者编译系统*
] else { todo }

#if lang == "en" [
  `cargo` will create a `my_lib.so`/`my_lib.dll` or `my_lib.a` file,
  depending on your platform and settings. This library can simply be
  linked by your build system.
] else if lang == "de" [
  `cargo` erstellt -- je nach Plattform und Einstellungen -- eine Datei
  namens `my_lib.so`, `my_lib.dll` oder `my_lib.a`. Diese Bibliothek kann
  einfach von Ihrem Build-System eingebunden (gelinkt) werden.
] else if lang == "zh" [
  `cargo`将生成一个`my_lib.so`/`my_lib.dll`或者`my_lib.a`文件，取决于你的平台和配置。可以通过编译系统简单地链接这个库。
] else { todo }

#if lang == "en" [
  However, calling a Rust function from C requires a header file to
  declare the function signatures.
] else if lang == "de" [
  Um jedoch eine Rust-Funktion aus C heraus aufzurufen, ist eine
  Header-Datei erforderlich, in der die Funktionssignaturen deklariert werden.
] else if lang == "zh" [
  然而，从C调用一个Rust函数要求一个头文件去声明函数的签名。
] else { todo }

#if lang == "en" [
  Every function in your Rust-ffi API needs to have a corresponding header function.
] else if lang == "de" [
  Für jede Funktion in Ihrer Rust-FFI-API muss eine entsprechende
  Deklaration im Header vorhanden sein.
] else if lang == "zh" [
  在Rust-ffi API中的每个函数需要有一个相关的头文件函数。
] else { todo }

```rust
#[no_mangle]
pub extern "C" fn rust_function() {}
```

#if lang == "en" [
  would then become
] else if lang == "de" [
  würde dann werden
] else if lang == "zh" [
  将会变成
] else { todo }

```c
void rust_function();
```

#if lang == "en" [
  etc.
] else if lang == "de" [
  usw.
] else if lang == "zh" [
  等等。
] else { todo }

#let ln_cbindgen = link("https://github.com/eqrion/cbindgen")[cbindgen]
#if lang == "en" [
  There is a tool to automate this process, called
  #ln_cbindgen which analyses
  your Rust code and then generates headers for your C and C++ projects
  from it.
] else if lang == "de" [
  Es gibt ein Werkzeug zur Automatisierung dieses Prozesses namens
  #ln_cbindgen, das Ihren
  Rust-Code analysiert und daraus Header-Dateien für Ihre C- und
  C++-Projekte generiert.
] else if lang == "zh" [
  这里有个工具可以自动化这个过程，叫做#ln_cbindgen，其会分析你的Rust代码然后为C和C++项目生成头文件。
] else { todo }

#if lang == "en" [
  At this point, using the Rust functions from C is as simple as including
  the header and calling them!
] else if lang == "de" [
  An diesem Punkt ist die Verwendung der Rust-Funktionen aus C heraus so
  einfach, wie den Header einzubinden und die Funktionen aufzurufen!
] else if lang == "zh" [
  此时从C中使用Rust函数非常简单，只需包含头文件和调用它们！
] else { todo }

```c
#include "my-rust-project.h"
rust_function();
```
