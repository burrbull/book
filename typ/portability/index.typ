#import "../config.typ": *

#h1(if lang == "en" [Portability]
  else if lang == "de" [Portabilität]
  else { todo })
<portability>
#set heading(offset: whole)

#if lang == "en" [
  In embedded environments portability is a very important topic: Every
  vendor and even each family from a single manufacturer offers different
  peripherals and capabilities and similarly the ways to interact with the
  peripherals will vary.
] else if lang == "de" [
  In eingebetteten Systemen ist Portabilität ein sehr wichtiges Thema:
  Jeder Hersteller und sogar jede Produktfamilie eines einzelnen
  Herstellers bietet unterschiedliche Peripheriegeräte und Funktionen an,
  und dementsprechend variieren auch die Interaktionsmöglichkeiten mit den
  Peripheriegeräten.
] else { todo }

#if lang == "en" [
  A common way to equalize such differences is via a layer called Hardware
  Abstraction layer or *HAL*.
] else if lang == "de" [
  Eine gängige Methode, diese Unterschiede auszugleichen, ist die
  sogenannte Hardware-Abstraktionsschicht (HAL).
] else { todo }

#quote(block: true)[
#if lang == "en" [
  Hardware abstractions are sets of routines in software that emulate some
  platform-specific details, giving programs direct access to the hardware
  resources.
] else if lang == "de" [
  Hardware-Abstraktionen sind Sammlungen von Software-Routinen, die
  bestimmte plattformspezifische Details emulieren und Programmen so
  direkten Zugriff auf die Hardwareressourcen ermöglichen.
] else { todo }

#if lang == "en" [
  They often allow programmers to write device-independent, high
  performance applications by providing standard operating system (OS)
  calls to hardware.
] else if lang == "de" [
  Sie ermöglichen es Programmierern häufig, geräteunabhängige
  Hochleistungsanwendungen zu schreiben, indem sie standardisierte
  Betriebssystemaufrufe für den Hardwarezugriff bereitstellen.
] else { todo }

#let url_hal = "https://en.wikipedia.org/wiki/Hardware_abstraction"
#if lang == "en" [
  _Wikipedia: #link(url_hal)[Hardware Abstraction Layer]_
] else if lang == "de" [
  _Wikipedia: #link(url_hal)[Hardware Abstraction Layer]_
] else { todo }
]

#if lang == "en" [
  Embedded systems are a bit special in this regard since we typically do
  not have operating systems and user installable software but firmware
  images which are compiled as a whole as well as a number of other
  constraints. So while the traditional approach as defined by Wikipedia
  could potentially work it is likely not the most productive approach to
  ensure portability.
] else if lang == "de" [
  Eingebettete Systeme nehmen hier eine Sonderstellung ein, da wir es
  typischerweise nicht mit Betriebssystemen und vom Benutzer
  installierbarer Software zu tun haben, sondern mit Firmware-Images, die
  als Ganzes kompiliert werden -- und zudem mit einer Reihe weiterer
  Einschränkungen konfrontiert sind. Der klassische, auf Wikipedia
  beschriebene Ansatz könnte zwar theoretisch funktionieren, ist aber
  wahrscheinlich nicht der effizienteste Weg, um Portabilität zu
  gewährleisten.
] else { todo }

#let ln_hal = link("https://crates.io/crates/embedded-hal")[embedded-hal]
#if lang == "en" [
  How do we do this in Rust? Enter *#ln_hal*…
] else if lang == "de" [
  Wie gehen wir dabei in Rust vor? Hier kommt *#ln_hal* ins Spiel…
] else { todo }

== #(if lang == "en" [What is #ln_hal?]
  else if lang == "de" [Was ist #ln_hal?]
  else { todo })

#if lang == "en" [
  In a nutshell it is a set of traits which define implementation
  contracts between *HAL implementations*, *drivers* and
  *applications (or firmwares)*. Those contracts include both
  capabilities (i.e.~if a trait is implemented for a certain type, the
  *HAL implementation* provides a certain capability) and methods
  (i.e.~if you can construct a type implementing a trait it is guaranteed
  that you have the methods specified in the trait available).
] else if lang == "de" [
  Kurz gesagt handelt es sich um eine Reihe von Merkmalen, die
  Implementierungsverträge zwischen *HAL-Implementierungen*,
  *Treibern* und *Anwendungen (oder Firmware)* definieren.
  Diese Verträge umfassen sowohl Fähigkeiten (d.~h., wenn ein Merkmal für
  einen bestimmten Typ implementiert ist, stellt die
  *HAL-Implementierung* eine bestimmte Fähigkeit bereit) als auch
  Methoden (d.~h., wenn ein Typ, der ein Merkmal implementiert, erstellt
  werden kann, ist garantiert, dass die im Merkmal spezifizierten Methoden
  verfügbar sind).
] else { todo }

#if lang == "en" [
  A typical layering might look like this:
] else if lang == "de" [
  Ein typischer Schichtaufbau könnte wie folgt aussehen:
] else { todo }

#box(image("../assets/rust_layers.svg"))

#if lang == "en" [
  Some of the defined traits in *#ln_hal* are:
  - GPIO (input and output pins)
  - Serial communication
  - I2C
  - SPI
  - Timers/Countdowns
  - Analog Digital Conversion
] else if lang == "de" [
  Einige der in *#ln_hal* definierten Traits sind:
  - GPIO (Eingangs- und Ausgangspins)
  - Serielle Kommunikation
  - I2C
  - SPI
  - Timers/Countdowns
  - Analog-Digital-Umsetzung
] else { todo }

#if lang == "en" [
  The main reason for having the *embedded-hal* traits and crates
  implementing and using them is to keep complexity in check. If you
  consider that an application might have to implement the use of the
  peripheral in the hardware as well as the application and potentially
  drivers for additional hardware components, then it should be easy to
  see that the re-usability is very limited. Expressed mathematically, if
  *M* is the number of peripheral HAL implementations and
  *N* the number of drivers then if we were to reinvent the wheel
  for every application then we would end up with *M\*N*
  implementations while by using the _API_ provided by the *#ln_hal*
  traits will make the implementation complexity approach *M+N*. Of
  course there're additional benefits to be had, such as less
  trial-and-error due to a well-defined and ready-to-use APIs.
] else if lang == "de" [
  Der Hauptgrund für die Existenz der *embedded-hal*-Traits und der
  sie implementierenden sowie nutzenden Crates liegt darin, die
  Komplexität beherrschbar zu halten. Bedenkt man, dass eine Anwendung
  sowohl die Nutzung der Hardware-Peripherie als auch die eigentliche
  Anwendungslogik sowie möglicherweise Treiber für zusätzliche
  Hardwarekomponenten implementieren muss, wird schnell klar, dass die
  Wiederverwendbarkeit stark eingeschränkt ist. Mathematisch ausgedrückt:
  Wenn *M* die Anzahl der HAL-Implementierungen für
  Peripheriegeräte und *N* die Anzahl der Treiber ist, würde man --
  müsste man für jede Anwendung das Rad neu erfinden -- bei *M × N*
  Implementierungen landen; durch die Verwendung der von den *#ln_hal*-Traits
  bereitgestellten API nähert sich die Implementierungskomplexität
  hingegen *M + N* an. Natürlich ergeben sich daraus weitere
  Vorteile, wie etwa ein geringerer Aufwand durch „Trial-and-Error" dank
  wohldefinierter und sofort einsatzbereiter APIs.
] else { todo }

== #(if lang == "en" [Users of the #ln_hal]
  else if lang == "de" [Nutzer von #ln_hal]
  else { todo })

#if lang == "en" [
  As said above there are three main users of the HAL:
] else if lang == "de" [
  Wie bereits erwähnt, gibt es drei Hauptnutzer einer HAL:
] else { todo }

=== #(if lang == "en" [HAL implementation]
  else if lang == "de" [HAL-Implementierung]
  else { todo })

#if lang == "en" [
  A HAL implementation provides the interfacing between the hardware and
  the users of the HAL traits. Typical implementations consist of three
  parts:
  - One or more hardware specific types
  - Functions to create and initialize such a type,
    often providing various configuration options
    (speed, operation mode, use pins, etc.)
  - one or more `trait` `impl` of *#ln_hal* traits for that type
] else if lang == "de" [
  Eine HAL-Implementierung stellt die Schnittstelle zwischen der Hardware
  und den Nutzern der HAL-Traits bereit. Typische Implementierungen
  bestehen aus drei Teilen:
  - Ein oder mehrere hardwarespezifische Typen
  - Funktionen zum Erstellen und Initialisieren eines solchen Typs, die
    häufig verschiedene Konfigurationsoptionen (Geschwindigkeit,
    Betriebsmodus, verwendete Pins usw.) bereitstellen.
  - eine oder mehrere `trait`-Implementierungen (`impl`) von
    *#ln_hal*-Traits für diesen Typ
] else { todo }

#if lang == "en" [
  Such a *HAL implementation* can come in various flavours:
  - Via low-level hardware access, e.g.~via registers
  - Via operating system, e.g.~by using the `sysfs` under Linux
  - Via adapter, e.g.~a mock of types for unit testing
  - Via driver for hardware adapters, e.g.~I2C multiplexer or GPIO expander
] else if lang == "de" [
  Eine solche *HAL-Implementierung* kann in verschiedenen
  Ausprägungen vorliegen:
  - Über hardwarenahen Zugriff, z. B. über Register
  - Über das Betriebssystem, z. B. durch Verwendung von `sysfs` unter Linux
  - Über einen Adapter, z. B. ein Mock von Typen für Unit-Tests
  - Via-Treiber für Hardware-Adapter, z. B. I2C-Multiplexer oder GPIO-Expander
] else { todo }

=== #(if lang == "en" [Driver]
  else if lang == "de" [Treiber]
  else { todo })

#if lang == "en" [
  A driver implements a set of custom functionality for an internal or
  external component, connected to a peripheral implementing the
  #ln_hal traits.
  Typical examples for such drivers include various sensors (temperature,
  magnetometer, accelerometer, light), display devices (LED arrays, LCD
  displays) and actuators (motors, transmitters).
] else if lang == "de" [
  Ein Treiber implementiert eine Reihe benutzerdefinierter Funktionen für
  eine interne oder externe Komponente, die mit einem Peripheriegerät
  verbunden ist, das die #ln_hal;-Traits
  implementiert. Typische Beispiele für solche Treiber sind verschiedene
  Sensoren (Temperatur-, Magnetometer-, Beschleunigungs- und
  Lichtsensoren), Anzeigegeräte (LED-Arrays, LCD-Displays) und Aktoren
  (Motoren, Sender).
] else { todo }

#if lang == "en" [
  A driver has to be initialized with an instance of type that implements
  a certain `trait` of the #ln_hal which is
  ensured via trait bound and provides its own type instance with a custom
  set of methods allowing to interact with the driven device.
] else if lang == "de" [
  Ein Treiber muss mit einer Instanz eines Typs initialisiert werden, der
  ein bestimmtes `Trait` von
  #ln_hal
  implementiert. Dies wird durch Trait-Bound sichergestellt. Der Treiber
  stellt eine eigene Typinstanz mit einem benutzerdefinierten Satz von
  Methoden bereit, die die Interaktion mit dem angesteuerten Gerät
] else { todo }

=== #(if lang == "en" [Application]
  else if lang == "de" [Anwendung]
  else { todo })

#if lang == "en" [
  The application binds the various parts together and ensures that the
  desired functionality is achieved. When porting between different
  systems, this is the part which requires the most adaptation efforts,
  since the application needs to correctly initialize the real hardware
  via the HAL implementation and the initialisation of different hardware
  differs, sometimes drastically so. Also the user choice often plays a
  big role, since components can be physically connected to different
  terminals, hardware buses sometimes need external hardware to match the
  configuration or there are different trade-offs to be made in the use of
  internal peripherals (e.g.~multiple timers with different capabilities
  are available or peripherals conflict with others).
] else if lang == "de" [
  Die Anwendung verknüpft die verschiedenen Komponenten miteinander und
  stellt sicher, dass die gewünschte Funktionalität erreicht wird. Bei der
  Portierung zwischen verschiedenen Systemen ist dies der Teil, der den
  größten Anpassungsaufwand erfordert, da die Anwendung die eigentliche
  Hardware über die HAL-Implementierung korrekt initialisieren muss -- und
  die Initialisierung unterschiedlicher Hardware variiert, bisweilen sogar
  drastisch. Zudem spielen oft anwenderspezifische Entscheidungen eine
  wichtige Rolle: Komponenten können physisch an unterschiedliche
  Anschlüsse angebunden sein, Hardware-Busse erfordern mitunter externe
  Hardware zur Konfigurationsanpassung, oder es müssen Abwägungen bei der
  Nutzung interner Peripherie getroffen werden (etwa wenn mehrere Timer
  mit unterschiedlichen Fähigkeiten zur Verfügung stehen oder Konflikte
  zwischen verschiedenen Peripherieeinheiten auftreten).
] else { todo }
