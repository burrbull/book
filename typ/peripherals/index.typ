#import "../config.typ": *

#h1(if lang == "en" [Peripherals]
  else if lang == "de" [Peripheriegeräte]
  else if lang == "zh" [外设]
  else { todo })
<peripherals>

= #(if lang == "en" [What are Peripherals?]
  else if lang == "de" [Was sind Peripheriegeräte?]
  else if lang == "zh" [什么是外设?]
  else { todo })

#if lang == "en" [
  Most Microcontrollers have more than just a CPU, RAM, or Flash Memory -
  they contain sections of silicon which are used for interacting with
  systems outside of the microcontroller, as well as directly and
  indirectly interacting with their surroundings in the world via sensors,
  motor controllers, or human interfaces such as a display or keyboard.
  These components are collectively known as Peripherals.
] else if lang == "de" [
  Die meisten Mikrocontroller verfügen über mehr als nur eine CPU, einen
  RAM oder einen Flash-Speicher -- sie enthalten Siliziumabschnitte, die
  für die Interaktion mit Systemen außerhalb des Mikrocontrollers sowie
  für die direkte und indirekte Interaktion mit ihrer Umgebung in der Welt
  über Sensoren, Motorsteuerungen oder menschliche Schnittstellen wie ein
  Display oder eine Tastatur verwendet werden. Diese Komponenten werden
  zusammenfassend als Peripheriegeräte bezeichnet.
] else if lang == "zh" [
  大多数微处理器不仅仅有一个CPU，RAM，或者Flash存储器 -
  它们还包含被用来与微处理器的外部系统进行交互的硅片部分，通过传感器，电机控制器，或者人机接口比如一个显示器或者键盘直接和间接地与周遭世界交互。这些组件统称为外设。
] else { todo }

#if lang == "en" [
  These peripherals are useful because they allow a developer to offload
  processing to them, avoiding having to handle everything in software.
  Similar to how a desktop developer would offload graphics processing to
  a video card, embedded developers can offload some tasks to peripherals
  allowing the CPU to spend its time doing something else important, or
  doing nothing in order to save power.
] else if lang == "de" [
  Diese Peripheriegeräte sind nützlich, weil sie es einem Entwickler
  ermöglichen, die Verarbeitung auf sie auszulagern, sodass er sich nicht
  um alles in der Software kümmern muss. Ähnlich wie ein
  Desktop-Entwickler die Grafikverarbeitung auf eine Grafikkarte verlagern
  würde, können Embedded-Entwickler einige Aufgaben auf Peripheriegeräte
  verlagern, sodass die CPU ihre Zeit mit anderen wichtigen Dingen
  verbringen oder gar nichts tun kann, um Strom zu sparen.
] else if lang == "zh" [
  这些外设很有用，因为它们允许一个开发者将处理工作交给它们来做，避免了必须在软件中处理每件事。就像一个桌面开发者如何将图形处理工作让给一个显卡那样，嵌入式开发者能将一些任务让给外设去做，让CPU可以把时间放在做其它更重要的事上，或者为了省电啥事也不做。
] else { todo }

#if lang == "en" [
  If you look at the main circuit board in an old-fashioned home computer
  from the 1970s or 1980s (and actually, the desktop PCs of yesterday are
  not so far removed from the embedded systems of today) you would expect
  to see:
  - A processor
  - A RAM chip
  - A ROM chip
  - An I/O controller
] else if lang == "de" [
  Wenn Sie sich die Hauptplatine eines altmodischen Heimcomputers aus den
  1970er oder 1980er Jahren ansehen (und tatsächlich sind die Desktop-PCs
  von gestern nicht so weit von den eingebetteten Systemen von heute
  entfernt), würden Sie Folgendes erwarten:
  - Einen Prozessor
  - Einen RAM-Chip
  - Einen ROM-Chip
  - Einen Ein-/Ausgabe-Controller
] else if lang == "zh" [
  如果你看向来自1970s或者1980s的旧型号的家庭电脑的主板(其实，昨日的桌面PCs与今日的嵌入式系统没太大区别)，你将看到:
  - 一个处理器
  - 一个RAM芯片
  - 一个ROM芯片
  - 一个I/O控制器
] else { todo }

#if lang == "en" [
  The RAM chip, ROM chip and I/O controller (the peripheral in this
  system) would be joined to the processor through a series of parallel
  traces known as a 'bus'. This bus carries address information, which
  selects which device on the bus the processor wishes to communicate
  with, and a data bus which carries the actual data. In our embedded
  microcontrollers, the same principles apply - it's just that everything
  is packed on to a single piece of silicon.
] else if lang == "de" [
  Der RAM-Chip, der ROM-Chip und der I/O-Controller (das Peripheriegerät
  in diesem System) wären über eine Reihe paralleler Leiterbahnen, die als
  „Bus" bekannt sind, mit dem Prozessor verbunden. Dieser Bus trägt
  Adressinformationen, die auswählen, mit welchem ​​Gerät auf dem Bus der
  Prozessor kommunizieren möchte, und einen Datenbus, der die eigentlichen
  Daten überträgt. In unseren eingebetteten Mikrocontrollern gelten die
  gleichen Prinzipien -- nur dass alles auf einem einzigen Stück Silizium
  untergebracht ist.
] else if lang == "zh" [
  RAM芯片，ROM芯片和I/O控制器(这个系统中的外设)会通过一系列并行的迹(traces)又被称为一个"总线"被加进处理器中。地址总线搬运地址信息，其用来选择处理器希望跟总线上哪个设备通信，还有一个用来搬运实际数据的数据总线。在我们的嵌入式微控制器中，应用了相同的概念
  \- 只是所有的东西被打包到一片硅片上。
] else { todo }

#if lang == "en" [
  However, unlike graphics cards, which typically have a Software API like
  Vulkan, Metal, or OpenGL, peripherals are exposed to our Microcontroller
  with a hardware interface, which is mapped to a chunk of the memory.
] else if lang == "de" [
  Im Gegensatz zu Grafikkarten, die normalerweise über eine Software-API
  wie Vulkan, Metal oder OpenGL verfügen, werden Peripheriegeräte unserem
  Mikrocontroller über eine Hardwareschnittstelle zugänglich gemacht, die
  einem Teil des Speichers zugeordnet ist.
] else if lang == "zh" [
  然而，不像显卡，显卡通常有像是Vulkan，Metal，或者OpenGL这样的一个软件API。外设暴露给微控制器的是一个硬件接口，其被映射到一块存储区域。
] else { todo }

= #(if lang == "en" [Linear and Real Memory Space]
  else if lang == "de" [Linearer und realer Speicherraum]
  else if lang == "zh" [线性的物理存储空间]
  else { todo })

#if lang == "en" [
  On a microcontroller, writing some data to some other arbitrary address,
  such as `0x4000_0000` or `0x0000_0000`, may also be a completely valid
  action.
] else if lang == "de" [
  Bei einem Mikrocontroller kann auch das Schreiben von Daten an eine
  beliebige andere Adresse -- etwa `0x4000_0000` oder `0x0000_0000` -- ein
  völlig zulässiger Vorgang sein.
] else if lang == "zh" [
  在一个微控制器上，随便往一些地址写一些数据，比如 `0x4000_0000` 或者
  `0x0000_0000`，可能也是一个完全有效的动作。
] else { todo }

#if lang == "en" [
  On a desktop system, access to memory is tightly controlled by the MMU,
  or Memory Management Unit. This component has two major
  responsibilities: enforcing access permission to sections of memory
  (preventing one process from reading or modifying the memory of another
  process); and re-mapping segments of the physical memory to virtual
  memory ranges used in software. Microcontrollers do not typically have
  an MMU, and instead only use real physical addresses in software.
] else if lang == "de" [
  Auf einem Desktop-System wird der Speicherzugriff streng von der MMU
  (Memory Management Unit, Speicherverwaltungseinheit) kontrolliert. Diese
  Komponente hat zwei Hauptaufgaben: die Durchsetzung von
  Zugriffsberechtigungen für Speicherbereiche (um zu verhindern, dass ein
  Prozess den Speicher eines anderen Prozesses liest oder verändert) sowie
  die Abbildung von Segmenten des physischen Speichers auf virtuelle
  Speicherbereiche, die von der Software genutzt werden. Mikrocontroller
  verfügen in der Regel nicht über eine MMU; stattdessen verwendet die
  Software dort ausschließlich reale physische Adressen.
] else if lang == "zh" [
  在一个桌面系统上，访问内存被MMU，或者内存管理单元紧紧地控制着。这个组件有两个主要责任:
  对部分内存加入访问权限(防止一个进程读取或者修改另一个进程的内存)；重映射物理内存的段到软件中使用的虚拟内存范围上。微控制器通常没有一个MMU，反而在软件中只使用真实的物理地址。
] else { todo }

#if lang == "en" [
  Although 32 bit microcontrollers have a real and linear address space
  from `0x0000_0000`, and `0xFFFF_FFFF`, they generally only use a few
  hundred kilobytes of that range for actual memory. This leaves a
  significant amount of address space remaining. In earlier chapters, we
  were talking about RAM being located at address `0x2000_0000`. If our
  RAM was 64 KiB long (i.e.~with a maximum address of 0xFFFF) then
  addresses `0x2000_0000` to `0x2000_FFFF` would correspond to our RAM.
  When we write to a variable which lives at address `0x2000_1234`, what
  happens internally is that some logic detects the upper portion of the
  address (0x2000 in this example) and then activates the RAM so that it
  can act upon the lower portion of the address (0x1234 in this case). On
  a Cortex-M we also have our Flash ROM mapped in at address `0x0000_0000`
  up to, say, address `0x0007_FFFF` (if we have a 512 KiB Flash ROM).
  Rather than ignore all remaining space between these two regions,
  Microcontroller designers instead mapped the interface for peripherals
  in certain memory locations. This ends up looking something like this:
] else if lang == "de" [
  Obwohl 32-Bit-Mikrocontroller über einen echten, linearen Adressraum von
  `0x0000_0000` bis `0xFFFF_FFFF` verfügen, nutzen sie für den
  eigentlichen Speicher meist nur einige hundert Kilobyte dieses Bereichs.
  Dadurch bleibt ein beträchtlicher Teil des Adressraums ungenutzt. In
  früheren Kapiteln war die Rede davon, dass sich der RAM an der Adresse
  `0x2000_0000` befindet. Wäre unser RAM 64 KiB groß (d.~h. mit einer
  maximalen Adresse von 0xFFFF), so entsprächen die Adressen `0x2000_0000`
  bis `0x2000_FFFF` diesem Speicherbereich. Wenn wir in eine Variable
  schreiben, die an der Adresse `0x2000_1234` liegt, geschieht intern
  Folgendes: Eine Logikeinheit erkennt den oberen Teil der Adresse (in
  diesem Beispiel `0x2000`) und aktiviert den RAM, sodass dieser auf den
  unteren Teil der Adresse (in diesem Fall `0x1234`) reagieren kann. Bei
  einem Cortex-M-System ist zudem das Flash-ROM eingeblendet -- etwa im
  Bereich von `0x0000_0000` bis `0x0007_FFFF` (bei einem
  512-KiB-Flash-ROM). Anstatt den gesamten verbleibenden Raum zwischen
  diesen beiden Bereichen ungenutzt zu lassen, haben die Entwickler der
  Mikrocontroller die Schnittstellen für Peripheriegeräte bestimmten
  Speicheradressen zugeordnet. Das Ergebnis sieht dann ungefähr so ​​aus:
] else if lang == "zh" [
  虽然32位微控制器有一个从`0x0000_0000`到`0xFFFF_FFFF`的线性的物理地址空间，但是它们通常只使用几百KiB的实际内存。有相当大部分的地址空间保留着。在早期的章节中，我们说到RAM被放置在地址`0x2000_0000`处。如果我们的RAM是64KiB大小(i.e.~最大地址为0xFFFF),那么地址
  `0x2000_0000`到`0x2000_FFFF`与我们的RAM有关。当我们写入一个位于地址`0x2000_1234`的变量时，内部发生的是，一些逻辑发现了地址的上部(这个例子里是0x2000)，然后激活RAM，以便能操作地址的下部(这个例子里是0x1234)。在一个Cortex-M上，我们也也会把Flash
  ROM映射进地址 `0x000_0000` 到地址 `0x0007_FFFF` 上 (如果我们有一个512KiB
  Flash
  ROM)。微控制器设计者没有忽略这两个区域间的所有剩余空间，反而将外设的接口映射到这些地址上。最后看起来像这样:
] else { todo }

#box(image("../assets/nrf52-memory-map.png"))

#link("http://infocenter.nordicsemi.com/pdf/nRF52832_PS_v1.1.pdf")[Nordic nRF52832 Datasheet (pdf)]

= #(if lang == "en" [Memory Mapped Peripherals]
  else if lang == "de" [Im Speicher abgebildete Peripheriegeräte]
  else if lang == "zh" [存储映射的外设]
  else { todo })

#if lang == "en" [
  Interaction with these peripherals is simple at a first glance - write
  the right data to the correct address. For example, sending a 32 bit
  word over a serial port could be as direct as writing that 32 bit word
  to a certain memory address. The Serial Port Peripheral would then take
  over and send out the data automatically.
] else if lang == "de" [
  Die Interaktion mit diesen Peripheriegeräten ist auf den ersten Blick
  einfach: Schreiben Sie die richtigen Daten an die richtige Adresse.
  Beispielsweise könnte das Senden eines 32-Bit-Worts über eine serielle
  Schnittstelle genauso direkt sein wie das Schreiben dieses 32-Bit-Worts
  an eine bestimmte Speicheradresse. Das Serial-Port-Peripheriegerät würde
  dann übernehmen und die Daten automatisch versenden.
] else if lang == "zh" [
  乍一看，与这些外设交互很简单 -
  将正确的数据写入正确的地址。比如，在一个串行端口上发送一个32位字，可以直接把那个32位字写入某个存储地址。串行端口外设然后能自动获取和发出数据。
] else { todo }

#if lang == "en" [
  Configuration of these peripherals works similarly. Instead of calling a
  function to configure a peripheral, a chunk of memory is exposed which
  serves as the hardware API. Write `0x8000_0000` to a SPI Frequency
  Configuration Register, and the SPI port will send data at 8 Megabits
  per second. Write `0x0200_0000` to the same address, and the SPI port
  will send data at 125 Kilobits per second. These configuration registers
  look a little bit like this:
] else if lang == "de" [
  Die Konfiguration dieser Peripheriegeräte funktioniert ähnlich. Anstatt
  eine Funktion zum Konfigurieren eines Peripheriegeräts aufzurufen, wird
  ein Teil des Speichers verfügbar gemacht, der als Hardware-API dient.
  Schreiben Sie „0x8000_0000" in ein SPI-Frequenzkonfigurationsregister,
  und der SPI-Port sendet Daten mit 8 Megabit pro Sekunde. Schreiben Sie
  „0x0200_0000" an dieselbe Adresse und der SPI-Port sendet Daten mit 125
  Kilobit pro Sekunde. Diese Konfigurationsregister sehen in etwa so aus:
] else if lang == "zh" [
  这些外设的配置工作相似。不是调用一个函数去配置一个外设，而是暴露一块地址空间作为硬件API。向一个SPI频率控制寄存器写入
  `0x8000_0000`，SPI端口将会按照每秒8MB的速度发送数据。向同个地址写入
  `0x0200_0000`，SPI端口将会按照每秒125KiB的速度发送数据。这些配置寄存器看起来有点像这个:
] else { todo }

#box(image("../assets/nrf52-spi-frequency-register.png"))

#link("http://infocenter.nordicsemi.com/pdf/nRF52832_PS_v1.1.pdf")[Nordic nRF52832 Datasheet (pdf)]

#if lang == "en" [
  This interface is how interactions with the hardware are made, no matter
  what language is used, whether that language is Assembly, C, or Rust.
] else if lang == "de" [
  Über diese Schnittstelle erfolgen die Interaktionen mit der Hardware,
  unabhängig davon, welche Sprache verwendet wird -- sei es Assembler, C
  oder Rust.
] else if lang == "zh" [
  这个接口是关于如何与硬件交互的，其与被使用的语言无关，无论这个语言是汇编，C，或者Rust。
] else { todo }
