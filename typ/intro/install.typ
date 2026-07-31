#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [Installing the tools]
  else { todo })
#set heading(offset: whole*2)

#if lang == "en" [
  This page contains OS-agnostic installation instructions for a few of
  the tools:
] else { todo }

== Rust Toolchain

#let ln_rustup = link("https://rustup.rs")
#if lang == "en" [
  Install rustup by following the instructions at #ln_rustup.
] else { todo }

#if lang == "en" [
  *NOTE* Make sure you have a compiler version equal to or newer than `1.31`.
  `rustc -V` should return a date newer than the one shown below.
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
] else { todo }

#if lang == "en" [
  Cortex-M0, M0+, and M1 (ARMv6-M architecture):
] else { todo }

```console
rustup target add thumbv6m-none-eabi
```

#if lang == "en" [
  Cortex-M3 (ARMv7-M architecture):
] else { todo }

```console
rustup target add thumbv7m-none-eabi
```

#if lang == "en" [
  Cortex-M4 and M7 without hardware floating point (ARMv7E-M architecture):
] else { todo }

```console
rustup target add thumbv7em-none-eabi
```

#if lang == "en" [
  Cortex-M4F and M7F with hardware floating point (ARMv7E-M architecture):
] else { todo }

```console
rustup target add thumbv7em-none-eabihf
```

#if lang == "en" [
  Cortex-M23 (ARMv8-M architecture):
] else { todo }

```console
rustup target add thumbv8m.base-none-eabi
```

#if lang == "en" [
  Cortex-M33 and M35P (ARMv8-M architecture):
] else { todo }

```console
rustup target add thumbv8m.main-none-eabi
```

#if lang == "en" [
Cortex-M33F and M35PF with hardware floating point (ARMv8-M architecture):
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
  WINDOWS: prerequisite C++ Build Tools for Visual Studio 2019 is
  installed. #ln_vs
] else { todo }

== `cargo-generate`

#if lang == "en" [
  We'll use this later to generate a project from a template.
] else { todo }

```console
cargo install cargo-generate
```

#if lang == "en" [
  Note: on some Linux distros (e.g.~Ubuntu) you may need to install the
  packages `libssl-dev` and `pkg-config` prior to installing
  cargo-generate.
] else { todo }

== #(if lang == "en" [OS-Specific Instructions]
  else { todo })

#if lang == "en" [
  Now follow the instructions specific to the OS you are using:
] else { todo }
- #link("install/linux.html")[Linux]
- #link("install/windows.html")[Windows]
- #link("install/macos.html")[macOS]
