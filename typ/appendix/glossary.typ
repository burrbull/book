#import "../config.typ": *

#h1(if lang == "en" [Appendix A: Glossary]
  else if lang == "de" [Anhang A: Glossar]
  else if lang == "zh" [附录A: 词汇表]
  else { todo })

#if lang == "en" [
  The embedded ecosystem is full of different protocols, hardware
  components and vendor-specific things that use their own terms and
  abbreviations. This Glossary attempts to list them with pointers for
  understanding them better.
] else if lang == "de" [
  Das Embedded-Ökosystem ist geprägt von einer Vielzahl unterschiedlicher
  Protokolle, Hardwarekomponenten und herstellerspezifischer Elemente, für
  die jeweils eigene Begriffe und Abkürzungen verwendet werden. Dieses
  Glossar soll diese auflisten und Hinweise zum besseren Verständnis geben.
] else if lang == "zh" [
  嵌入式生态系统中充满了不同的协议，硬件组件，还有许多与生产商相关的东西，它们都使用自己的缩写和项目名。这个词汇表尝试列出它们以便更好理解它们。
] else { todo }

*BSP*

#let url_bspvideo = "https://youtu.be/vLYit_HHPaY"
#if lang == "en" [
  A Board Support Crate provides a high level interface configured for a
  specific board. It usually depends on a #link(<glossary-hal>)[HAL] crate. There
  is a more detailed description on the
  #link(<memory-mapped-registers>)[memory-mapped registers page] or for a
  broader overview see #link(url_bspvideo)[this video].
] else if lang == "de" [
  Ein „Board Support Crate" stellt eine auf eine bestimmte Platine
  zugeschnittene Schnittstelle auf hoher Ebene bereit. Es hängt in der
  Regel von einem #link(<glossary-hal>)[HAL]-Crate ab. Eine ausführlichere
  Beschreibung finden Sie auf der
  #link(<memory-mapped-registers>)[Seite zu den im Speicher abgebildeten Registern]
  oder für einen umfassenderen Überblick sehen Sie sich
  #link(url_bspvideo)[dieses Video] an.
] else if lang == "zh" [
  板级支持的Crate(Board Support
  Crate)提供为某个特定板子配置的高级接口。它通常依赖一个#link(<glossary-hal>)[HAL]
  crate 。在#link(<memory-mapped-registers>)[存储映射的寄存器那页]有更多细节的描述或者看#link(url_bspvideo)[这个视频]来获取一个更广泛的概述。
] else { todo }

*FPU*

#if lang == "en" [
  Floating-point Unit. A 'math processor' running only operations on
  floating-point numbers.
] else if lang == "de" [
  Gleitkommaeinheit. Ein „Mathematikprozessor", der ausschließlich
  Operationen mit Gleitkommazahlen ausführt.
] else if lang == "zh" [
  浮点单元(Floating-Point Unit)。一个只运行在浮点数上的'数学处理器'。
] else { todo }

*HAL* <glossary-hal>

#let ln_hal = link("https://crates.io/crates/embedded-hal")[`embedded-hal`]
#let url_hal_video = "https://youtu.be/vLYit_HHPaY"
#if lang == "en" [
  A Hardware Abstraction Layer crate provides a developer friendly
  interface to a microcontroller's features and peripherals. It is usually
  implemented on top of a #link(<glossary-pac>)[Peripheral Access Crate (PAC)]. It
  may also implement traits from the #ln_hal crate.
  There is a more detailed description on the
  #link(<memory-mapped-registers>)[memory-mapped registers page] or for a
  broader overview see #link(url_hal_video)[this video].
] else if lang == "de" [
  Ein „Hardware Abstraction Layer"-Crate bietet eine entwicklerfreundliche
  Schnittstelle zu den Funktionen und Peripheriegeräten eines
  Mikrocontrollers. Es wird in der Regel auf Basis eines
  #link(<glossary-pac>)[Peripheral Access Crate (PAC)] implementiert.
  Möglicherweise implementiert es auch Traits aus dem #ln_hal;-Crate.
  Eine ausführlichere Beschreibung finden Sie auf der
  #link(<memory-mapped-registers>)[Seite zu den im Speicher abgebildeten Registern]
  oder für einen umfassenderen Überblick in #link(url_hal_video)[diesem Video].
] else if lang == "zh" [
  硬件抽象层(Hardware Abstraction Layer)
  crate为微控制器的功能和外设提供一个开发者友好的接口。它通常在#link(<glossary-pac>)[Peripheral Access Crate (PAC)]之上被实现。它可能也会实现来自#ln_hal
  crate的traits
  。在#link(<memory-mapped-registers>)[存储映射的寄存器那页]上有更多的细节或者看#link(url_hal_video)[这个视频]获取一个更广泛的概述。
] else { todo }

*I2C*

#let wiki_i2c = "https://en.wikipedia.org/wiki/I2c"
#if lang == "en" [
  Sometimes referred to as `I²C` or Inter-IC. It is a protocol meant for
  hardware communication within a single integrated circuit.
  See #link(wiki_i2c)[here] for more details
] else if lang == "de" [
  Wird manchmal auch als „I²C" oder „Inter-IC" bezeichnet. Es handelt sich
  um ein Protokoll für die Hardware-Kommunikation innerhalb eines
  einzelnen integrierten Schaltkreises. Weitere Informationen finden Sie
  #link(wiki_i2c)[hier].
] else if lang == "zh" [
  有时又被称为 `I²C` 或者 Intere-IC
  。它是一种用于在单个集成电路中进行硬件通信的协议。看#link(wiki_i2c)[这里]来获取更多细节。
] else { todo }

*PAC* <glossary-pac>

#let ln_svd2rust = link("https://github.com/rust-embedded/svd2rust/")[svd2rust]
#let url_pacvideo = "https://youtu.be/vLYit_HHPaY"
#if lang == "en" [
  A Peripheral Access Crate provides access to a microcontroller's
  peripherals. It is one of the lower level crates and is usually
  generated directly from the provided #link(<glossary-svd>)[SVD],
  often using #ln_svd2rust.
  The #link(<glossary-hal>)[Hardware Abstraction Layer] would usually
  depend on this crate. There is a more detailed description on the
  #link(<memory-mapped-registers>)[memory-mapped registers page] or for a
  broader overview see #link(url_pacvideo)[this video].
] else if lang == "de" [
  Ein „Peripheral Access Crate" ermöglicht den Zugriff auf die
  Peripheriegeräte eines Mikrocontrollers. Es handelt sich um eines der
  Crates auf niedrigerer Ebene, das in der Regel direkt aus der
  bereitgestellten #link(<glossary-svd>)[SVD] generiert wird, häufig unter
  Verwendung von
  #ln_svd2rust. Die
  #link(<glossary-hal>)[Hardware-Abstraktionsschicht] hängt in der Regel von diesem
  Crate ab. Eine ausführlichere Beschreibung finden Sie auf der
  #link(<memory-mapped-registers>)[Seite zu den im Speicher abgebildeten Registern]
  oder für einen umfassenderen Überblick in
  #link(url_pacvideo)[diesem Video].
] else if lang == "zh" [
  一个外设访问 Crate (Peripheral Access
  Crate)提供了对一个微控制器的外设的访问。它是一个底层的crates且通常从提供的#link(<glossary-svd>)[SVD]被直接生成，经常使用#ln_svd2rust。#link(<glossary-hal>)[硬件抽象层]应该依赖这个crate。在#link(<memory-mapped-registers>)[存储映射的寄存器那页]有更细节的描述或者看#link(url_pacvideo)[这个视频]获取一个更广泛的概述。
] else { todo }

*SPI*

#let wiki_spi = "https://en.wikipedia.org/wiki/Serial_peripheral_interface"
#if lang == "en" [
  Serial Peripheral Interface.
  See #link(wiki_spi)[here] for more information.
] else if lang == "de" [
  Serial Peripheral Interface.
  Weitere Informationen finden Sie #link(wiki_spi)[hier].
] else if lang == "zh" [
  串行外设接口。看#link(wiki_spi)[这里]获取更多信息。
] else { todo }

*SVD* <glossary-svd>

#let url_svd = "https://www.keil.com/pack/doc/CMSIS/SVD/html/index.html"
#if lang == "en" [
  System View Description is an XML file format used to describe the
  programmers view of a microcontroller device. You can read more about it
  on #link(url_svd)[the ARM CMSIS documentation site].
] else if lang == "de" [
  „System View Description" ist ein XML-Dateiformat, das dazu dient, die
  Programmierersicht eines Mikrocontrollers zu beschreiben. Weitere
  Informationen hierzu finden Sie auf
  #link(url_svd)[der ARM CMSIS-Dokumentationsseite].
] else if lang == "zh" [
  系统视图描述文件(System View
  Description)是一个XML文件格式，以程序员视角来描述一个微控制器设备。你能在#link(url_svd)[the ARM CMSIS documentation site]上获取更多信息。
] else { todo }

*UART*

#let wiki_uart = "https://en.wikipedia.org/wiki/Universal_asynchronous_receiver-transmitter"
#if lang == "en" [
  Universal asynchronous receiver-transmitter.
  See #link(wiki_uart)[here] for more information.
] else if lang == "de" [
  Universeller asynchroner Empfänger-Sender.
  Weitere Informationen finden Sie #link(wiki_uart)[hier].
] else if lang == "zh" [
  通用异步收发器。看#link(wiki_uart)[这里]获取更多信息。
] else { todo }

*USART*

#let wiki_usart = "https://en.wikipedia.org/wiki/Universal_synchronous_and_asynchronous_receiver-transmitter"
#if lang == "en" [
  Universal synchronous and asynchronous receiver-transmitter.
  See #link(wiki_usart)[here] for more information.
] else if lang == "de" [
  Universeller synchroner und asynchroner Empfänger-Sender.
  Weitere Informationen finden Sie #link(wiki_usart)[hier].
] else if lang == "zh" [
  通用同步异步收发器。看#link(wiki_usart)[这里]获取更多信息。
] else { todo }
