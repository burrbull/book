#import "../../config.typ": *

#h1(offset: whole*2,
  [macOS])
#set heading(offset: whole*3)

#let brew_ln = link("http://brew.sh/")[Homebrew]
#let ports_ln = link("https://www.macports.org/")[MacPorts]

#if lang == "en" [
  All the tools can be installed using #brew_ln or #ports_ln:
] else if lang == "de" [
  Alle Werkzeuge können mit #brew_ln oder #ports_ln installiert werden:
] else { todo }

= #(if lang == "en" [Install tools with #brew_ln]
  else if lang == "de" [Werkzeuge mit #brew_ln installieren]
  else { todo })

```text
$ # GDB
$ brew install arm-none-eabi-gdb

$ # OpenOCD
$ brew install openocd

$ # QEMU
$ brew install qemu
```

#quote(block: true)[
#if lang == "en" [
  *NOTE* If OpenOCD crashes you may need to install the latest
  version using:
] else if lang == "de" [
  *HINWEIS* Falls OpenOCD abstürzt, müssen Sie möglicherweise die
  neueste Version installieren; verwenden Sie dazu:
] else { todo }
]

```text
$ brew install --HEAD openocd
```

= #(if lang == "en" [Install tools with #ports_ln]
  else if lang == "de" [Werkzeuge mit #ports_ln installieren]
  else { todo })

```text
$ # GDB
$ sudo port install arm-none-eabi-gcc

$ # OpenOCD
$ sudo port install openocd

$ # QEMU
$ sudo port install qemu
```

#if lang == "en" [
  That's all! Go to the #link(<verify-installation>)[next section].
] else if lang == "de" [
  Das war's! Gehen Sie zum #link(<verify-installation>)[nächsten Abschnitt].
] else { todo }
