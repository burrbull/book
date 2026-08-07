#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [Installing the tools]
  else if lang == "de" [Werkzeuge installieren]
  else if lang == "zh" [安装工具]
  else { todo })

#if lang == "en" [
  This page contains OS-agnostic installation instructions for a few of
  the tools:
] else if lang == "de" [
  Diese Seite enthält betriebssystemunabhängige Installationsanleitungen für
  einige der Werkzeuge:
] else if lang == "zh" [
  这一页包含的工具安装指令与操作系统无关：
] else { todo }

== #(if lang == "en" [Rust Toolchain]
  else if lang == "de" [Rust-Werkzeuge]
  else if lang == "zh" [Rust 工具链]
  else { todo })

#let ln_rustup = link("https://rustup.rs")
#if lang == "en" [
  Install rustup by following the instructions at #ln_rustup.
] else if lang == "de" [
  Installieren Sie rustup, indem Sie die Anweisungen unter #ln_rustup.
] else { todo }

#if lang == "en" [
  *NOTE* Make sure you have a compiler version equal to or newer than `1.31`.
  `rustc -V` should return a date newer than the one shown below.
] else if lang == "de" [
  *HINWEIS* Stellen Sie sicher, dass Sie eine Compiler-Version verwenden, die mindestens `1.31` entspricht. Der Befehl `rustc -V`
  sollte ein Datum ausgeben, das neuer ist als das unten angegebene.
] else if lang == "zh" [
  *注意*
  确保你的编译器版本等于或者大于`1.31`版本。`rustc -V`应该返回一个比下列日期更新的日期。
] else { todo }

```text
$ rustc -V
rustc 1.31.1 (b6c32da9b 2018-12-18)
```

#let url_find = "https://developer.arm.com/ip-products/processors/cortex-m#c-7d3b69ce-5b17-4c9e-8f06-59b605713133"
#if lang == "en" [
  For bandwidth and disk usage concerns the default installation only
  supports native compilation. To add cross compilation support for the
  ARM Cortex-M architectures choose one of the following compilation
  targets. For the STM32F3DISCOVERY board used for the examples in this
  book, use the `thumbv7em-none-eabihf` target.
  #link(url_find)[Find the best Cortex-M for you.]
] else if lang == "de" [
  Aus Gründen der Bandbreite und der Festplattenauslastung
  unterstützt die Standardinstallation nur die native Kompilierung. Um die
  Unterstützung für die Cross-Kompilierung für die ARM-Cortex-M-Architekturen
  hinzuzufügen, wählen Sie eines der folgenden Kompilierungsziele aus. Für das
  STM32F3DISCOVERY-Board, das für die Beispiele in diesem Buch verwendet wird,
  verwenden Sie das Ziel `thumbv7em-none-eabihf`.
  #link(url_find)[Finden Sie den für Sie am besten geeigneten Cortex-M.]
] else if lang == "zh" [
  #todoupd("zh")
  考虑到带宽和磁盘的使用量，默认的安装只支持主机环境的编译。为了添加对ARM
  Cortex-M架构交叉编译的支持，从下列编译目标中选择一个。对于这本书里使用的STM32F3DISCOVERY板子，使用`thumbv7em-none-eabihf`作为目标。
] else { todo }

#if lang == "en" [
  Cortex-M0, M0+, and M1 (ARMv6-M architecture):
] else if lang == "de" [
  Cortex-M0, M0+, and M1 (ARMv6-M-Architektur):
] else if lang == "zh" [
  Cortex-M0, M0+, 和 M1 (ARMv6-M 架构):
] else { todo }

```console
rustup target add thumbv6m-none-eabi
```

#if lang == "en" [
  Cortex-M3 (ARMv7-M architecture):
] else if lang == "de" [
  Cortex-M3 (ARMv7-M-Architektur):
] else if lang == "zh" [
  Cortex-M3 (ARMv7-M 架构):
] else { todo }

```console
rustup target add thumbv7m-none-eabi
```

#if lang == "en" [
  Cortex-M4 and M7 without hardware floating point (ARMv7E-M architecture):
] else if lang == "de" [
  Cortex-M4 und M7 ohne Hardware-Gleitkommafunktion
  (ARMv7E-M-Architektur):
] else if lang == "zh" [
  没有硬件浮点单元的Cortex-M4和M7 (ARMv7E-M架构)
] else { todo }

```console
rustup target add thumbv7em-none-eabi
```

#if lang == "en" [
  Cortex-M4F and M7F with hardware floating point (ARMv7E-M architecture):
] else if lang == "de" [
  Cortex-M4F und M7F mit Hardware-Gleitkomma (ARMv7E-M-Architektur):
] else if lang == "zh" [
  具有硬件浮点单元的Cortex-M4F和M7F (ARMv7E-M架构)
] else { todo }

```console
rustup target add thumbv7em-none-eabihf
```

#if lang == "en" [
  Cortex-M23 (ARMv8-M architecture):
] else if lang == "de" [
  Cortex-M23 (ARMv8-M-Architektur):
] else if lang == "zh" [
  Cortex-M23 (ARMv8-M架构):
] else { todo }

```console
rustup target add thumbv8m.base-none-eabi
```

#if lang == "en" [
  Cortex-M33 and M35P (ARMv8-M architecture):
] else if lang == "de" [
  Cortex-M33 und M35P (ARMv8-M-Architektur):
] else if lang == "zh" [
  Cortex-M33和M35P (ARMv8-M架构):
] else { todo }

```console
rustup target add thumbv8m.main-none-eabi
```

#if lang == "en" [
  Cortex-M33F and M35PF with hardware floating point (ARMv8-M architecture):
] else if lang == "de" [
  Cortex-M33F und M35PF mit Hardware-Gleitkomma (ARMv8-M-Architektur):
] else if lang == "zh" [
  具有硬件浮点单元的Cortex-M33F和M35PF (ARMv8-M架构):
] else { todo }

```console
rustup target add thumbv8m.main-none-eabihf
```

== `cargo-binutils`

```text
cargo install cargo-binutils

rustup component add llvm-tools
```

#let ln_vs = link("https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=16")
#if lang == "en" [
  WINDOWS: prerequisite C++ Build Tools for Visual Studio 2019 is installed. #ln_vs
] else if lang == "de" [
  WINDOWS: Voraussetzung ist, dass die C++-Build-Tools für Visual Studio 2019
  installiert sind. #ln_vs
] else if lang == "zh" [
  WINDOWS: 需要预先安装 C++ Build Tools for Visual Studio 2019。#ln_vs
] else { todo }

== `cargo-generate`

#if lang == "en" [
  We'll use this later to generate a project from a template.
] else if lang == "de" [
  Wir werden dies später verwenden, um ein Projekt aus einer Vorlage zu generieren.
] else if lang == "zh" [
  我们随后将使用这个来从模板生成一个项目。
] else { todo }

```console
cargo install cargo-generate
```

#if lang == "en" [
  Note: on some Linux distros (e.g.~Ubuntu) you may need to install the
  packages `libssl-dev` and `pkg-config` prior to installing cargo-generate.
] else if lang == "de" [
  Hinweis: Bei einigen Linux-Distributionen (z. B. Ubuntu) müssen Sie
  möglicherweise vor der Installation von `cargo-generate` die Pakete `libssl-dev`
  und `pkg-config` installieren.
] else if lang == "zh" [
  注意:在某些Linux发行版上(e.g.~Ubuntu)
  在安装cargo-generate之前，你可能需要安装`libssl-dev`和`pkg-config`
] else { todo }

== #(if lang == "en" [OS-Specific Instructions]
  else if lang == "de" [Betriebssystemspezifische Anweisungen]
  else if lang == "zh" [特定于操作系统的指令]
  else { todo })

#if lang == "en" [
  Now follow the instructions specific to the OS you are using:
] else if lang == "de" [
  Befolgen Sie nun die Anweisungen für das von Ihnen verwendete Betriebssystem:
] else if lang == "zh" [
  现在根据你使用的操作系统，来执行对应的指令:
] else { todo }
- #link("install/linux.html")[Linux]
- #link("install/windows.html")[Windows]
- #link("install/macos.html")[macOS]
