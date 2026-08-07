#import "../config.typ": *

#h1(if lang == "en" [Peripherals]
  else if lang == "de" [Peripheriegeräte]
  else { todo })
<peripherals>

= #(if lang == "en" [What are Peripherals?]
  else if lang == "de" [Was sind Peripheriegeräte?]
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
] else { todo }

= #(if lang == "en" [Linear and Real Memory Space]
  else if lang == "de" [Linearer und realer Speicherraum]
  else { todo })

#if lang == "en" [
  On a microcontroller, writing some data to some other arbitrary address,
  such as `0x4000_0000` or `0x0000_0000`, may also be a completely valid
  action.
] else if lang == "de" [
  Bei einem Mikrocontroller kann auch das Schreiben von Daten an eine
  beliebige andere Adresse -- etwa `0x4000_0000` oder `0x0000_0000` -- ein
  völlig zulässiger Vorgang sein.
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
] else { todo }

#box(image("../assets/nrf52-memory-map.png"))

#link("http://infocenter.nordicsemi.com/pdf/nRF52832_PS_v1.1.pdf")[Nordic nRF52832 Datasheet (pdf)]

= #(if lang == "en" [Memory Mapped Peripherals]
  else if lang == "de" [Im Speicher abgebildete Peripheriegeräte]
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
  Schreiben Sie „0x8000\_0000" in ein SPI-Frequenzkonfigurationsregister,
  und der SPI-Port sendet Daten mit 8 Megabit pro Sekunde. Schreiben Sie
  „0x0200\_0000" an dieselbe Adresse und der SPI-Port sendet Daten mit 125
  Kilobit pro Sekunde. Diese Konfigurationsregister sehen in etwa so aus:
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
] else { todo }
