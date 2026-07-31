#import "../config.typ": *

#h1(offset: whole,
  if lang == "en" [Memory Mapped Registers]
  else if lang == "de" [Im Speicher abgebildete Register]
  else { todo })
<memory-mapped-registers>
#set heading(offset: whole*2)

#if lang == "en" [
  Embedded systems can only get so far by executing normal Rust code and
  moving data around in RAM. If we want to get any information into or out
  of our system (be that blinking an LED, detecting a button press or
  communicating with an off-chip peripheral on some sort of bus) we're
  going to have to dip into the world of Peripherals and their 'memory
  mapped registers'.
] else if lang == "de" [
  Bei eingebetteten Systemen stößt man mit der reinen Ausführung von
  Standard-Rust-Code und dem Verschieben von Daten im Arbeitsspeicher
  (RAM) irgendwann an Grenzen. Wenn wir Informationen in das System
  einspeisen oder daraus ausgeben wollen -- sei es das Blinken einer LED,
  das Erkennen eines Tastendrucks oder die Kommunikation mit einer
  externen Peripheriekomponente über einen Bus --, müssen wir uns mit der
  Welt der Peripherieeinheiten und deren „im Speicher abgebildeten
  Registern" (memory-mapped registers) befassen.
] else { todo }

#let ln_cortex = link("https://crates.io/crates/cortex-m")[cortex-m]
#let ln_tm4c123x = link("https://crates.io/crates/tm4c123x")[tm4c123x]
#let ln_f30x = link("https://crates.io/crates/stm32f30x")[stm32f30x]
#let ln_hal = link("https://crates.io/crates/embedded-hal")[embedded-hal]
#let ln_f3 = link("https://crates.io/crates/stm32f3-discovery")[stm32f3-discovery]
#if lang == "en" [
  You may well find that the code you need to access the peripherals in
  your micro-controller has already been written, at one of the following
  levels:
  - Micro-architecture Crate - This sort of crate handles any useful
    routines common to the processor core your microcontroller is using,
    as well as any peripherals that are common to all micro-controllers
    that use that particular type of processor core. For example the
    #ln_cortex crate gives you
    functions to enable and disable interrupts, which are the same for all
    Cortex-M based micro-controllers. It also gives you access to the
    'SysTick' peripheral included with all Cortex-M based
    micro-controllers.
  - Peripheral Access Crate (PAC) - This sort of crate is a thin wrapper
    over the various memory-wrapper registers defined for your particular
    part-number of micro-controller you are using. For example,
    #ln_tm4c123x for the Texas Instruments Tiva-C TM4C123 series, or
    #ln_f30x for the ST-Micro STM32F30x series.
    Here, you'll be interacting with the
    registers directly, following each peripheral's operating instructions
    given in your micro-controller's Technical Reference Manual.
  - HAL Crate - These crates offer a more user-friendly API for your
    particular processor, often by implementing some common traits defined
    in #ln_hal. For
    example, this crate might offer a `Serial` struct, with a constructor
    that takes an appropriate set of GPIO pins and a baud rate, and offers
    some sort of `write_byte` function for sending data. See the chapter
    on #link(<portability>)[Portability] for more information
    on #ln_hal.
  - Board Crate - These crates go one step further than a HAL Crate by
    pre-configuring various peripherals and GPIO pins to suit the specific
    developer kit or board you are using, such as #ln_f3
    for the STM32F3DISCOVERY board.
] else if lang == "de" [
  Möglicherweise stellen Sie fest, dass der für den Zugriff auf die
  Peripherie Ihres Mikrocontrollers erforderliche Code bereits auf einer
  der folgenden Ebenen implementiert wurde:
  - Mikroarchitektur-Crate -- Diese Art von Crate verwaltet alle
    nützlichen Routinen, die dem Prozessorkern gemeinsam sind, den Ihr
    Mikrocontroller verwendet, sowie alle Peripheriegeräte, die allen
    Mikrocontrollern gemeinsam sind, die diesen bestimmten
    Prozessorkerntyp verwenden. Das #ln_cortex - Crate bietet
    Ihnen beispielsweise Funktionen zum Aktivieren und Deaktivieren von
    Interrupts, die für alle Cortex-M-basierten Mikrocontroller gleich
    sind. Außerdem erhalten Sie Zugriff auf die „SysTick"-Peripherie, die
    in allen Cortex-M-basierten Mikrocontrollern enthalten ist.
  - Peripheral Access Crate (PAC) -- Bei dieser Art von Crate handelt es
    sich um einen schlanken Adapter (Wrapper) für die verschiedenen
    Register, die für das spezifische Mikrocontroller-Modell definiert
    sind, das Sie verwenden. Zum Beispiel, #ln_tm4c123x für die
    Tiva-C-TM4C123-Serie von Texas Instruments oder #ln_f30x für die
    STM32F30x-Serie von STMicroelectronics. Hierbei greifen Sie direkt auf
    die Register zu und befolgen dabei die Betriebshinweise für die
    jeweilige Peripherieeinheit, wie sie im technischen Referenzhandbuch
    Ihres Mikrocontrollers beschrieben sind.
  - HAL-Crate -- Diese Crates bieten eine benutzerfreundlichere API für
    einen bestimmten Prozessor, häufig durch die Implementierung gängiger
    Traits, die in #ln_hal definiert
    sind. So könnte ein solches Crate beispielsweise eine
    `Serial`-Struktur bereitstellen, deren Konstruktor eine geeignete
    Kombination aus GPIO-Pins sowie eine Baudrate entgegennimmt und eine
    Funktion wie `write_byte` zum Senden von Daten anbietet. Weitere
    Informationen zu #ln_hal finden
    Sie im Kapitel über #link(<portability>)[Portabilität].
  - Board-Crate -- Diese Crates gehen noch einen Schritt weiter als
    HAL-Crates, indem sie verschiedene Peripheriekomponenten und GPIO-Pins
    passend für das jeweils verwendete Entwickler-Kit oder Board
    vorkonfigurieren -- wie zum Beispiel
    #ln_f3 für das STM32F3DISCOVERY-Board.
] else { todo }

= #(if lang == "en" [Board Crate]
  else if lang == "de" [Board Crate]
  else { todo })

#if lang == "en" [
  A board crate is the perfect starting point, if you're new to embedded
  Rust. They nicely abstract the HW details that might be overwhelming
  when starting studying this subject, and makes standard tasks easy, like
  turning a LED on or off. The functionality it exposes varies a lot
  between boards. Since this book aims at staying hardware agnostic, the
  board crates won't be covered by this book.
] else if lang == "de" [
  Eine Board-Crate ist der ideale Ausgangspunkt für den Einstieg in
  Embedded Rust. Sie abstrahiert auf angenehme Weise die Hardware-Details,
  die Anfänger in diesem Bereich oft überfordern können, und erleichtert
  Standardaufgaben wie das Ein- oder Ausschalten einer LED. Der
  bereitgestellte Funktionsumfang variiert jedoch stark von Board zu
  Board. Da dieses Buch hardwareunabhängig bleiben soll, werden
  Board-Crates hier nicht behandelt.
] else { todo }

#let url_disco = "https://rust-embedded.github.io/discovery/"
#if lang == "en" [
  If you want to experiment with the STM32F3DISCOVERY board, it is highly
  recommended to take a look at the #ln_f3
  board crate, which provides functionality to blink the board LEDs,
  access its compass, bluetooth and more. The
  #link(url_disco)[Discovery] book
  offers a great introduction to the use of a board crate.
] else if lang == "de" [
  Wenn Sie mit dem STM32F3DISCOVERY-Board experimentieren möchten, ist es
  sehr empfehlenswert, sich das #ln_f3;-Board-Crate
  anzusehen; dieses bietet Funktionen, um die LEDs des Boards blinken zu
  lassen sowie auf den Kompass, Bluetooth und mehr zuzugreifen. Das
  #link(url_disco)[Discovery]-Buch bietet eine hervorragende
  Einführung in die Verwendung eines Board-Crates.
] else { todo }

#if lang == "en" [
  But if you're working on a system that doesn't yet have dedicated board
  crate, or you need functionality not provided by existing crates, read
  on as we start from the bottom, with the micro-architecture crates.
] else if lang == "de" [
  Wenn Sie jedoch an einem System arbeiten, für das es noch kein
  dediziertes Board-Crate gibt, oder wenn Sie Funktionen benötigen, die
  von vorhandenen Crates nicht abgedeckt werden, lesen Sie weiter: Wir
  beginnen ganz unten, bei den Mikroarchitektur-Crates.
] else { todo }

= #(if lang == "en" [Micro-architecture crate]
  else if lang == "de" [Mikroarchitektur-Crate]
  else { todo })

#if lang == "en" [
  Let's look at the SysTick peripheral that's common to all Cortex-M based
  micro-controllers. We can find a pretty low-level API in the
  #ln_cortex crate, and we can use it like this:
] else if lang == "de" [
  Betrachten wir die SysTick-Peripherie, die allen Mikrocontrollern auf
  Cortex-M-Basis gemeinsam ist. Im #ln_cortex;-Crate finden wir
  eine recht hardwarenahe API, die sich folgendermaßen verwenden lässt:
] else { todo }

```rust
#![no_std]
#![no_main]
use cortex_m::peripheral::{syst, Peripherals};
use cortex_m_rt::entry;
use panic_halt as _;

#[entry]
fn main() -> ! {
    let peripherals = Peripherals::take().unwrap();
    let mut systick = peripherals.SYST;
    systick.set_clock_source(syst::SystClkSource::Core);
    systick.set_reload(1_000);
    systick.clear_current();
    systick.enable_counter();
    while !systick.has_wrapped() {
        // Loop
    }

    loop {}
}
```

#if lang == "en" [
  The functions on the `SYST` struct map pretty closely to the
  functionality defined by the ARM Technical Reference Manual for this
  peripheral. There's nothing in this API about 'delaying for X
  milliseconds' - we have to crudely implement that ourselves using a
  `while` loop. Note that we can't access our `SYST` struct until we have
  called `Peripherals::take()` - this is a special routine that guarantees
  that there is only one `SYST` structure in our entire program. For more
  on that, see the #link(<peripherals>)[Peripherals] section.
] else if lang == "de" [
  Die Funktionen der `SYST`-Struktur entsprechen weitgehend der
  Funktionalität, die im ARM Technical Reference Manual für diese
  Peripherieeinheit definiert ist. Diese API bietet keine Möglichkeit,
  eine Verzögerung von „X Millisekunden" direkt umzusetzen; wir müssen
  dies stattdessen selbst auf einfache Weise mittels einer
  `while`-Schleife implementieren. Beachten Sie, dass wir erst auf die
  `SYST`-Struktur zugreifen können, nachdem wir `Peripherals::take()`
  aufgerufen haben. Dabei handelt es sich um eine spezielle Routine, die
  sicherstellt, dass im gesamten Programm nur eine einzige `SYST`-Instanz
  existiert. Weitere Informationen dazu finden Sie im Abschnitt
  "#link(<peripherals>)[Peripherien]".
] else { todo }

= #(if lang == "en" [Using a Peripheral Access Crate (PAC)]
  else if lang == "de" [Verwendung eines Peripheral Access Crate (PAC)]
  else { todo })

#if lang == "en" [
  We won't get very far with our embedded software development if we
  restrict ourselves to only the basic peripherals included with every
  Cortex-M. At some point, we're going to need to write some code that's
  specific to the particular micro-controller we're using. In this
  example, let's assume we have an Texas Instruments TM4C123 - a middling
  80MHz Cortex-M4 with 256 KiB of Flash. We're going to pull in the
  #ln_tm4c123x crate to make use of this chip.
] else if lang == "de" [
  Bei der Entwicklung von Embedded-Software kommen wir nicht weit, wenn
  wir uns auf die grundlegenden Peripheriekomponenten beschränken, die in
  jedem Cortex-M enthalten sind. Irgendwann müssen wir Code schreiben, der
  speziell auf den verwendeten Mikrocontroller zugeschnitten ist. Gehen
  wir in diesem Beispiel davon aus, dass wir einen Texas Instruments
  TM4C123 verwenden -- einen soliden 80-MHz-Cortex-M4 mit 256 KiB
  Flash-Speicher. Um diesen Chip nutzen zu können, binden wir das
  #ln_tm4c123x;-Crate ein.
] else { todo }

```rust
#![no_std]
#![no_main]

use panic_halt as _; // panic handler

use cortex_m_rt::entry;
use tm4c123x;

#[entry]
pub fn init() -> (Delay, Leds) {
    let cp = cortex_m::Peripherals::take().unwrap();
    let p = tm4c123x::Peripherals::take().unwrap();

    let pwm = p.PWM0;
    pwm.ctl.write(|w| w.globalsync0().clear_bit());
    // Mode = 1 => Count up/down mode
    pwm._2_ctl.write(|w| w.enable().set_bit().mode().set_bit());
    pwm._2_gena.write(|w| w.actcmpau().zero().actcmpad().one());
    // 528 cycles (264 up and down) = 4 loops per video line (2112 cycles)
    pwm._2_load.write(|w| unsafe { w.load().bits(263) });
    pwm._2_cmpa.write(|w| unsafe { w.compa().bits(64) });
    pwm.enable.write(|w| w.pwm4en().set_bit());
}
```

#let ln_svd2rust = link("https://crates.io/crates/svd2rust")[svd2rust]
#if lang == "en" [
  We've accessed the `PWM0` peripheral in exactly the same way as we
  accessed the `SYST` peripheral earlier, except we called
  `tm4c123x::Peripherals::take()`. As this crate was auto-generated using
  #ln_svd2rust, the access
  functions for our register fields take a closure, rather than a numeric
  argument. While this looks like a lot of code, the Rust compiler can use
  it to perform a bunch of checks for us, but then generate machine-code
  which is pretty close to hand-written assembler! Where the
  auto-generated code isn't able to determine that all possible arguments
  to a particular accessor function are valid (for example, if the SVD
  defines the register as 32-bit but doesn't say if some of those 32-bit
  values have a special meaning), then the function is marked as `unsafe`.
  We can see this in the example above when setting the `load` and `compa`
  sub-fields using the `bits()` function.
] else if lang == "de" [
  Wir haben auf die `PWM0`-Peripherie auf genau dieselbe Weise zugegriffen
  wie zuvor auf die `SYST`-Peripherie, mit dem Unterschied, dass wir
  `tm4c123x::Peripherals::take()` aufgerufen haben. Da dieses Crate
  mithilfe von #link("https://crates.io/crates/svd2rust")[svd2rust]
  automatisch generiert wurde, erwarten die Zugriffsfunktionen für unsere
  Registerfelder einen Closure anstelle eines numerischen Arguments. Auch
  wenn dies nach viel Code aussieht, kann der Rust-Compiler ihn nutzen, um
  eine Reihe von Prüfungen für uns durchzuführen und anschließend
  Maschinencode zu erzeugen, der handgeschriebenem Assemblercode sehr
  nahekommt! Wenn der automatisch generierte Code nicht feststellen kann,
  ob alle möglichen Argumente für eine bestimmte Zugriffsfunktion gültig
  sind (zum Beispiel, wenn die SVD das Register als 32-Bit-Register
  definiert, aber nicht angibt, ob bestimmte dieser 32-Bit-Werte eine
  besondere Bedeutung haben), wird die Funktion als `unsafe` markiert.
  Dies lässt sich im obigen Beispiel beim Setzen der Unterfelder `load`
  und `compa` mittels der Funktion `bits()` beobachten.
] else { todo }

== #(if lang == "en" [Reading]
  else if lang == "de" [Lesen]
  else { todo })

#let url_struct_r = "https://docs.rs/tm4c123x/0.7.0/tm4c123x/pwm0/ctl/struct.R.html"
#if lang == "en" [
  The `read()` function returns an object which gives read-only access to
  the various sub-fields within this register, as defined by the
  manufacturer's SVD file for this chip. You can find all the functions
  available on special `R` return type for this particular register, in
  this particular peripheral, on this particular chip, in the
  #link(url_struct_r)[tm4c123x documentation].
] else if lang == "de" [
  Die Funktion `read()` gibt ein Objekt zurück, das schreibgeschützten
  Zugriff auf die verschiedenen Teilfelder dieses Registers gewährt --
  entsprechend der vom Hersteller für diesen Chip bereitgestellten
  SVD-Datei. Alle für den speziellen Rückgabetyp `R` dieses spezifischen
  Registers (innerhalb der jeweiligen Peripherieeinheit auf diesem Chip)
  verfügbaren Funktionen finden Sie in der
  #link(url_struct_r)[tm4c123x-Dokumentation].
] else { todo }

#raw(block: true, lang: "rust",
"if pwm.ctl.read().globalsync0().is_set() {
    // " + if lang == "en" {
        "Do a thing"
      } else if lang == "de" {
        "Tu etwas"
      } else { todos } + "
}
")

== #(if lang == "en" [Writing]
  else if lang == "de" [Schreiben]
  else { todo })

#let url_struct_w = "https://docs.rs/tm4c123x/0.7.0/tm4c123x/pwm0/ctl/struct.W.html"
#if lang == "en" [
  The `write()` function takes a closure with a single argument. Typically
  we call this `w`. This argument then gives read-write access to the
  various sub-fields within this register, as defined by the
  manufacturer's SVD file for this chip. Again, you can find all the
  functions available on the 'w' for this particular register, in this
  particular peripheral, on this particular chip, in the
  #link(url_struct_w)[tm4c123x documentation].
  Note that all of the sub-fields that we do not set will be set to a
  default value for us - any existing content in the register will be lost.
] else if lang == "de" [
  Die Funktion `write()` erwartet einen Closure mit einem einzelnen
  Argument. Üblicherweise bezeichnen wir dieses als `w`. Dieses Argument
  gewährt Lese- und Schreibzugriff auf die verschiedenen Teilfelder
  innerhalb des Registers, wie sie in der SVD-Datei des Herstellers für
  diesen Chip definiert sind. Auch hier gilt: Alle für `w` verfügbaren
  Funktionen -- spezifisch für dieses Register, diese Peripherieeinheit
  und diesen Chip -- finden Sie in der
  #link(url_struct_w)[tm4c123x-Dokumentation].
  Beachten Sie, dass alle Teilfelder, die wir nicht explizit setzen,
  automatisch auf einen Standardwert gesetzt werden; bereits vorhandene
  Inhalte des Registers gehen dabei verloren.
] else { todo }

```rust
pwm.ctl.write(|w| w.globalsync0().clear_bit());
```

== #(if lang == "en" [Modifying]
  else if lang == "de" [Ändern]
  else { todo })

#if lang == "en" [
  If we wish to change only one particular sub-field in this register and
  leave the other sub-fields unchanged, we can use the `modify` function.
  This function takes a closure with two arguments - one for reading and
  one for writing. Typically we call these `r` and `w` respectively. The
  `r` argument can be used to inspect the current contents of the
  register, and the `w` argument can be used to modify the register contents.
] else if lang == "de" [
  Wenn wir in diesem Register nur ein bestimmtes Teilfeld ändern und die
  übrigen Teilfelder unverändert lassen möchten, können wir die Funktion
  `modify` verwenden. Diese Funktion nimmt eine Closure mit zwei
  Argumenten entgegen -- eines zum Lesen und eines zum Schreiben.
  Üblicherweise bezeichnen wir diese als `r` beziehungsweise `w`. Das
  Argument `r` dient dazu, den aktuellen Inhalt des Registers zu
  betrachten, während das Argument `w` genutzt werden kann, um den
  Registerinhalt zu ändern.
] else { todo }

```rust
pwm.ctl.modify(|r, w| w.globalsync0().clear_bit());
```

#if lang == "en" [
  The `modify` function really shows the power of closures here. In C,
  we'd have to read into some temporary value, modify the correct bits and
  then write the value back. This means there's considerable scope for error:
] else if lang == "de" [
  Die Funktion `modify` veranschaulicht hier eindrucksvoll die
  Leistungsfähigkeit von Closures. In C müssten wir den Wert zunächst in
  eine temporäre Variable einlesen, die entsprechenden Bits ändern und den
  Wert anschließend wieder zurückschreiben. Dies birgt ein erhebliches
  Fehlerpotenzial:
] else { todo }

```c
uint32_t temp = pwm0.ctl.read();
temp |= PWM0_CTL_GLOBALSYNC0;
pwm0.ctl.write(temp);
uint32_t temp2 = pwm0.enable.read();
temp2 |= PWM0_ENABLE_PWM4EN;
pwm0.enable.write(temp); // Uh oh! Wrong variable!
```

= #(if lang == "en" [Using a HAL crate]
  else if lang == "de" [Verwendung eines HAL-Crates]
  else { todo })

#if lang == "en" [
  The HAL crate for a chip typically works by implementing a custom Trait
  for the raw structures exposed by the PAC. Often this trait will define
  a function called `constrain()` for single peripherals or `split()` for
  things like GPIO ports with multiple pins. This function will consume
  the underlying raw peripheral structure and return a new object with a
  higher-level API. This API may also do things like have the Serial port
  `new` function require a borrow on some `Clock` structure, which can
  only be generated by calling the function which configures the PLLs and
  sets up all the clock frequencies. In this way, it is statically
  impossible to create a Serial port object without first having
  configured the clock rates, or for the Serial port object to misconvert
  the baud rate into clock ticks. Some crates even define special traits
  for the states each GPIO pin can be in, requiring the user to put a pin
  into the correct state (say, by selecting the appropriate Alternate
  Function Mode) before passing the pin into Peripheral. All with no
  run-time cost!
] else if lang == "de" [
  Ein HAL-Crate für einen Chip funktioniert typischerweise, indem es ein
  spezifisches Trait für die vom PAC bereitgestellten Rohstrukturen
  implementiert. Oft definiert dieses Trait eine Funktion namens
  `constrain()` für einzelne Peripherieeinheiten oder `split()` für
  Komponenten wie GPIO-Ports mit mehreren Pins. Diese Funktion übernimmt
  die zugrundeliegende Rohstruktur der Peripherie und gibt ein neues
  Objekt mit einer höherwertigen API zurück. Diese API kann zudem
  sicherstellen, dass beispielsweise die `new`-Funktion für die serielle
  Schnittstelle eine Referenz auf eine `Clock`-Struktur verlangt; eine
  solche Struktur lässt sich nur durch den Aufruf der Funktion erzeugen,
  welche die PLLs konfiguriert und sämtliche Taktfrequenzen einstellt. Auf
  diese Weise ist es zur Kompilierzeit ausgeschlossen, ein Objekt für die
  serielle Schnittstelle zu erzeugen, ohne zuvor die Taktraten
  konfiguriert zu haben, oder dass das Objekt die Baudrate fehlerhaft in
  Taktzyklen umrechnet. Manche Crates definieren sogar spezielle Traits
  für die Zustände, die ein GPIO-Pin einnehmen kann; der Nutzer muss den
  Pin dann in den korrekten Zustand versetzen (etwa durch Auswahl des
  passenden Modus für alternative Funktionen), bevor er ihn an die
  Peripherieeinheit übergibt. Und das alles ohne Laufzeitkosten!
] else { todo }

#if lang == "en" [
  Let's see an example:
] else if lang == "de" [
  Schauen wir uns ein Beispiel an:
] else { todo }

#raw(block: true, lang: "rust",
"#![no_std]
#![no_main]

use panic_halt as _; // panic handler

use cortex_m_rt::entry;
use tm4c123x_hal as hal;
use tm4c123x_hal::prelude::*;
use tm4c123x_hal::serial::{NewlineMode, Serial};
use tm4c123x_hal::sysctl;

#[entry]
fn main() -> ! {
    let p = hal::Peripherals::take().unwrap();
    let cp = hal::CorePeripherals::take().unwrap();

    // " + if lang == "en" {
        "Wrap up the SYSCTL struct into an object with a higher-layer API"
      } else if lang == "de" {
        "Kapseln Sie die SYSCTL-Struktur in einem Objekt mit einer API auf 
    // hoeherer Ebene."
      } else { todos } + "
    let mut sc = p.SYSCTL.constrain();
    // " + if lang == "en" {
        "Pick our oscillation settings"
      } else if lang == "de" {
        "Waehlen Sie unsere Oszillationseinstellungen aus."
      } else { todos } + "
    sc.clock_setup.oscillator = sysctl::Oscillator::Main(
        sysctl::CrystalFrequency::_16mhz,
        sysctl::SystemClock::UsePll(sysctl::PllOutputFrequency::_80_00mhz),
    );
    // " + if lang == "en" {
        "Configure the PLL with those settings"
      } else if lang == "de" {
        "Konfigurieren Sie die PLL mit diesen Einstellungen."
      } else { todos } + "
    let clocks = sc.clock_setup.freeze();

    // " + if lang == "en" {
        "Wrap up the GPIO_PORTA struct into an object with a higher-layer API.
    // Note it needs to borrow `sc.power_control` so it can power up the GPIO
    // peripheral automatically."
      } else if lang == "de" {
        "Kapseln Sie die `GPIO_PORTA`-Struktur in einem Objekt mit einer API der 
    // hoeheren Ebene.
    // Beachten Sie, dass es `sc.power_control` nutzen muss, um die 
    // Stromversorgung der GPIO-Peripherie automatisch zu aktivieren."
      } else { todos } + "
    let mut porta = p.GPIO_PORTA.split(&sc.power_control);

    // " + if lang == "en" {
        "Activate the UART."
      } else if lang == "de" {
        "Aktivieren Sie den UART."
      } else { todos } + "
    let uart = Serial::uart0(
        p.UART0,
        // " + if lang == "en" {
            "The transmit pin"
          } else if lang == "de" {
            "Der Sende-Pin"
          } else { todos } + "
        porta
            .pa1
            .into_af_push_pull::<hal::gpio::AF1>(&mut porta.control),
        // " + if lang == "en" {
            "The receive pin"
          } else if lang == "de" {
            "Der Empfangs-Pin"
          } else { todos } + "
        porta
            .pa0
            .into_af_push_pull::<hal::gpio::AF1>(&mut porta.control),
        // " + if lang == "en" {
            "No RTS or CTS required"
          } else if lang == "de" {
            "Kein RTS oder CTS erforderlich"
          } else { todos } + "
        (),
        (),
        // " + if lang == "en" {
            "The baud rate"
          } else if lang == "de" {
            "Die Baudrate"
          } else { todos } + "
        115200_u32.bps(),
        // " + if lang == "en" {
            "Output handling"
          } else if lang == "de" {
            "Ausgabeverarbeitung"
          } else { todos } + "
        NewlineMode::SwapLFtoCRLF,
        // " + if lang == "en" {
            "We need the clock rates to calculate the baud rate divisors"
          } else if lang == "de" {
            "Wir benoetigen die Taktfrequenzen, um die Baudraten-Teiler zu 
        // berechnen."
          } else { todos } + "
        &clocks,
        // " + if lang == "en" {
            "We need this to power up the UART peripheral"
          } else if lang == "de" {
            "Wir benoetigen dies, um die UART-Peripherie zu aktivieren."
          } else { todos } + "
        &sc.power_control,
    );

    loop {
        writeln!(uart, \"Hello, World!\\r\\n\").unwrap();
    }
}
")
