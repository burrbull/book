#import "../config.typ": *

#h1((en: [Installing the tools],
  de: [Werkzeuge installieren],
  ja: [ツールのインストール],
  ru: [Установка инструментов],
  zh: [安装工具],
), offset: whole)

#tr((
en: [
  This page contains OS-agnostic installation instructions for a few of
  the tools:
],
de: [
  Diese Seite enthält betriebssystemunabhängige Installationsanleitungen für
  einige der Werkzeuge:
],
ja: [
  このページには、いくつかのツールのOSに依存しないインストール手順を掲載します。
],
ru: [
  На этой странице приведены не зависящие от ОС инструкции по установке
  некоторых инструментов:
],
zh: [
  这一页包含的工具安装指令与操作系统无关：
]))

== #tr((
  en: [Rust Toolchain],
  de: [Rust-Werkzeuge],
  ja: [Rustツールチェイン],
  ru: [Тулчейн Rust],
  zh: [Rust 工具链],
))

#let ln_rustup = link("https://rustup.rs")
#tr((
en: [
  Install rustup by following the instructions at #ln_rustup.
],
de: [
  Installieren Sie rustup, indem Sie die Anweisungen unter #ln_rustup.
],
ru: [
  Установите rustup, следуя инструкциям на #ln_rustup.
],
ja: [
  #ln_rustup;の手順に従って、rustupをインストールします。
]))

#tr((
en: [
  *NOTE* Make sure you have a compiler version equal to or newer than `1.31`.
  `rustc -V` should return a date newer than the one shown below.
],
de: [
  *HINWEIS* Stellen Sie sicher, dass Sie eine Compiler-Version verwenden, die mindestens `1.31` entspricht. Der Befehl `rustc -V`
  sollte ein Datum ausgeben, das neuer ist als das unten angegebene.
],
ja: [
  *注意*
  コンパイラのバージョンが`1.31`以上であることを確認して下さい。`rustc -v`は下記に示す日付より新しい日付を返すべきです。
],
ru: [
  *ПРИМЕЧАНИЕ* Убедитесь, что версия компилятора не ниже `1.31`.
  Команда `rustc -V` должна выводить дату новее указанной ниже.
],
zh: [
  *注意*
  确保你的编译器版本等于或者大于`1.31`版本。`rustc -V`应该返回一个比下列日期更新的日期。
]))

```text
$ rustc -V
rustc 1.31.1 (b6c32da9b 2018-12-18)
```

#let url_find = "https://developer.arm.com/ip-products/processors/cortex-m#c-7d3b69ce-5b17-4c9e-8f06-59b605713133"
#tr((
en: [
  For bandwidth and disk usage concerns the default installation only
  supports native compilation. To add cross compilation support for the
  ARM Cortex-M architectures choose one of the following compilation
  targets. For the STM32F3DISCOVERY board used for the examples in this
  book, use the `thumbv7em-none-eabihf` target.
  #link(url_find)[Find the best Cortex-M for you.]
],
de: [
  Aus Gründen der Bandbreite und der Festplattenauslastung
  unterstützt die Standardinstallation nur die native Kompilierung. Um die
  Unterstützung für die Cross-Kompilierung für die ARM-Cortex-M-Architekturen
  hinzuzufügen, wählen Sie eines der folgenden Kompilierungsziele aus. Für das
  STM32F3DISCOVERY-Board, das für die Beispiele in diesem Buch verwendet wird,
  verwenden Sie das Ziel `thumbv7em-none-eabihf`.
  #link(url_find)[Finden Sie den für Sie am besten geeigneten Cortex-M.]
],
ja: [
  #todoupd("ja")
  バンド幅とディスク使用量に関する懸念から、デフォルトインストールではネイティブコンパイルのみをサポートします。
  ARM
  Cortex-Mアーキテクチャのクロスコンパイラを追加するために、下記のコンパイルターゲットをインストールします。
],
ru: [
  Для экономии трафика и места на диске стандартная установка поддерживает
  только нативную компиляцию. Чтобы добавить поддержку кросс-компиляции
  для архитектур ARM Cortex-M, выберите одну из следующих целевых платформ
  (compilation targets). Для платы STM32F3DISCOVERY, которую мы используем
  в примерах этой книги, нужна платформа `thumbv7em-none-eabihf`.
  #link(url_find)[Выберите подходящий для вас Cortex-M.]
],
zh: [
  #todoupd("zh")
  考虑到带宽和磁盘的使用量，默认的安装只支持主机环境的编译。为了添加对ARM
  Cortex-M架构交叉编译的支持，从下列编译目标中选择一个。对于这本书里使用的STM32F3DISCOVERY板子，使用`thumbv7em-none-eabihf`作为目标。
]))

#tr((
en: [
  Cortex-M0, M0+, and M1 (ARMv6-M architecture):
],
de: [
  Cortex-M0, M0+, and M1 (ARMv6-M-Architektur):
],
ru: [
  Cortex-M0, M0+ и M1 (архитектура ARMv6-M):
],
zh: [
  Cortex-M0, M0+, 和 M1 (ARMv6-M 架构):
]))

```console
rustup target add thumbv6m-none-eabi
```

#tr((
en: [
  Cortex-M3 (ARMv7-M architecture):
],
de: [
  Cortex-M3 (ARMv7-M-Architektur):
],
ru: [
  Cortex-M3 (архитектура ARMv7-M):
],
zh: [
  Cortex-M3 (ARMv7-M 架构):
]))

```console
rustup target add thumbv7m-none-eabi
```

#tr((
en: [
  Cortex-M4 and M7 without hardware floating point (ARMv7E-M architecture):
],
de: [
  Cortex-M4 und M7 ohne Hardware-Gleitkommafunktion
  (ARMv7E-M-Architektur):
],
ru: [
  Cortex-M4 и M7 без аппаратной поддержки операций с плавающей точкой
  (архитектура ARMv7E-M):
],
zh: [
  没有硬件浮点单元的Cortex-M4和M7 (ARMv7E-M架构)
]))

```console
rustup target add thumbv7em-none-eabi
```

#tr((
en: [
  Cortex-M4F and M7F with hardware floating point (ARMv7E-M architecture):
],
de: [
  Cortex-M4F und M7F mit Hardware-Gleitkomma (ARMv7E-M-Architektur):
],
ru: [
  Cortex-M4F и M7F с аппаратной поддержкой операций с плавающей точкой
  (архитектура ARMv7E-M):
],
zh: [
  具有硬件浮点单元的Cortex-M4F和M7F (ARMv7E-M架构)
]))

```console
rustup target add thumbv7em-none-eabihf
```

#tr((
en: [
  Cortex-M23 (ARMv8-M architecture):
],
de: [
  Cortex-M23 (ARMv8-M-Architektur):
],
ru: [
  Cortex-M23 (архитектура ARMv8-M):
],
zh: [
  Cortex-M23 (ARMv8-M架构):
]))

```console
rustup target add thumbv8m.base-none-eabi
```

#tr((
en: [
  Cortex-M33 and M35P (ARMv8-M architecture):
],
de: [
  Cortex-M33 und M35P (ARMv8-M-Architektur):
],
ru: [
  Cortex-M33 и M35P (архитектура ARMv8-M):
],
zh: [
  Cortex-M33和M35P (ARMv8-M架构):
]))

```console
rustup target add thumbv8m.main-none-eabi
```

#tr((
en: [
  Cortex-M33F and M35PF with hardware floating point (ARMv8-M architecture):
],
de: [
  Cortex-M33F und M35PF mit Hardware-Gleitkomma (ARMv8-M-Architektur):
],
ru: [
  Cortex-M33F и M35PF с аппаратной поддержкой операций с плавающей точкой
  (архитектура ARMv8-M):
],
zh: [
  具有硬件浮点单元的Cortex-M33F和M35PF (ARMv8-M架构):
]))

```console
rustup target add thumbv8m.main-none-eabihf
```

== `cargo-binutils`

```console
cargo install cargo-binutils

rustup component add llvm-tools
```

#let ln_vs = link("https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=16")
#tr((
en: [
  WINDOWS: prerequisite C++ Build Tools for Visual Studio 2019 is installed. #ln_vs
],
de: [
  WINDOWS: Voraussetzung ist, dass die C++-Build-Tools für Visual Studio 2019
  installiert sind. #ln_vs
],
ru: [
  WINDOWS: предполагается, что установлены C++ Build Tools для Visual
  Studio 2019. #ln_vs
],
zh: [
  WINDOWS: 需要预先安装 C++ Build Tools for Visual Studio 2019。#ln_vs
]))

== `cargo-generate`

#tr((
en: [
  We'll use this later to generate a project from a template.
],
de: [
  Wir werden dies später verwenden, um ein Projekt aus einer Vorlage zu generieren.
],
ru: [
  Мы воспользуемся этим инструментом позже, чтобы создать проект из шаблона.
],
zh: [
  我们随后将使用这个来从模板生成一个项目。
]))

```console
cargo install cargo-generate
```

#tr((
en: [
  Note: on some Linux distros (e.g.~Ubuntu) you may need to install the
  packages `libssl-dev` and `pkg-config` prior to installing cargo-generate.
],
de: [
  Hinweis: Bei einigen Linux-Distributionen (z. B. Ubuntu) müssen Sie
  möglicherweise vor der Installation von `cargo-generate` die Pakete `libssl-dev`
  und `pkg-config` installieren.
],
ru: [
  Примечание: в некоторых дистрибутивах Linux (например, Ubuntu) перед
  установкой cargo-generate может понадобиться установить пакеты
  `libssl-dev` и `pkg-config`.
],
zh: [
  注意:在某些Linux发行版上(e.g.~Ubuntu)
  在安装cargo-generate之前，你可能需要安装`libssl-dev`和`pkg-config`
]))

== #tr((
  en: [OS-Specific Instructions],
  de: [Betriebssystemspezifische Anweisungen],
  ru: [Инструкции для конкретной ОС],
  zh: [特定于操作系统的指令],
))

#tr((
en: [
  Now follow the instructions specific to the OS you are using:
],
de: [
  Befolgen Sie nun die Anweisungen für das von Ihnen verwendete Betriebssystem:
],
ja: [
  使用しているOSに特有の手順に従って下さい。
],
ru: [
  Теперь следуйте инструкциям для вашей операционной системы:
],
zh: [
  现在根据你使用的操作系统，来执行对应的指令:
]))
- #link(<install-linux>)[Linux]
- #link(<install-windows>)[Windows]
- #link(<install-macos>)[macOS]
