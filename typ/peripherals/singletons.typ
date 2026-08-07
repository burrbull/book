#import "../config.typ": *

#h1(offset: whole,
  if lang in ("en", "de") [Singletons]
  else { todo })

#quote(block: true)[
#if lang == "en" [
  In software engineering, the singleton pattern is a software design
  pattern that restricts the instantiation of a class to one object.
] else if lang == "de" [
	In der Softwaretechnik ist das Singleton-Muster ein Entwurfsmuster, das
	die Instanziierung einer Klasse auf ein einziges Objekt beschränkt.
] else { todo }

#let url_singleton = "https://en.wikipedia.org/wiki/Singleton_pattern"
#if lang == "en" [
  _Wikipedia: #link(url_singleton)[Singleton Pattern]_
] else if lang == "de" [
	_Wikipedia: #link(url_singleton)[Singleton-Muster]_
] else { todo }
]

= #(if lang == "en" [But why can't we just use global variable(s)?]
  else if lang == "de" [Aber warum können wir nicht einfach globale Variable(n) verwenden?]
  else { todo })

#if lang == "en" [
  We could make everything a public static, like this
] else if lang == "de" [
	Wir könnten alles als „public static" definieren, etwa so:
] else { todo }

```rust
static mut THE_SERIAL_PORT: SerialPort = SerialPort;

fn main() {
    let _ = unsafe {
        THE_SERIAL_PORT.read_speed();
    };
}
```

#if lang == "en" [
  But this has a few problems. It is a mutable global variable, and in
  Rust, these are always unsafe to interact with. These variables are also
  visible across your whole program, which means the borrow checker is
  unable to help you track references and ownership of these variables.
] else if lang == "de" [
	Dies bringt jedoch einige Probleme mit sich. Es handelt sich um eine
	veränderbare globale Variable, und der Zugriff auf solche Variablen ist
	in Rust stets „unsafe". Zudem sind diese Variablen im gesamten Programm
	sichtbar, was bedeutet, dass der Borrow Checker nicht dabei helfen kann,
	die Referenzen und die Ownership dieser Variablen zu verfolgen.
] else { todo }

= #(if lang == "en" [How do we do this in Rust?]
  else if lang == "de" [Wie machen wir das in Rust?]
  else { todo })

#if lang == "en" [
  Instead of just making our peripheral a global variable, we might
  instead decide to make a structure, in this case called `PERIPHERALS`,
  which contains an `Option<T>` for each of our peripherals.
] else if lang == "de" [
	Anstatt unser Peripheriegerät einfach als globale Variable zu
	definieren, könnten wir uns stattdessen dazu entschließen, eine Struktur
	-- in diesem Fall mit dem Namen `PERIPHERALS` -- zu erstellen, die für
	jedes unserer Peripheriegeräte ein `Option<T>` enthält.
] else { todo }

```rust
struct Peripherals {
    serial: Option<SerialPort>,
}
impl Peripherals {
    fn take_serial(&mut self) -> SerialPort {
        let p = replace(&mut self.serial, None);
        p.unwrap()
    }
}
static mut PERIPHERALS: Peripherals = Peripherals {
    serial: Some(SerialPort),
};
```

#if lang == "en" [
  This structure allows us to obtain a single instance of our peripheral.
  If we try to call `take_serial()` more than once, our code will panic!
] else if lang == "de" [
	Diese Struktur ermöglicht es uns, eine einzelne Instanz unserer
	Peripheriekomponente zu erhalten. Wenn wir versuchen, `take_serial()`
	mehr als einmal aufzurufen, wird unser Code eine Panic auslösen!
] else { todo }

#raw(block: true, lang: "rust",
"fn main() {
    let serial_1 = unsafe { PERIPHERALS.take_serial() };
    // " + if lang == "en" {
        "This panics!"
      } else if lang == "de" {
        "Dies loest eine panic aus!"
      } else { todos } + "
    // let serial_2 = unsafe { PERIPHERALS.take_serial() };
}
")

#if lang == "en" [
  Although interacting with this structure is `unsafe`, once we have the
  `SerialPort` it contained, we no longer need to use `unsafe`, or the
  `PERIPHERALS` structure at all.
] else if lang == "de" [
	Obwohl die Interaktion mit dieser Struktur als `unsafe` gilt, benötigen
	wir -- sobald wir über die darin enthaltene `SerialPort`-Instanz
	verfügen -- weder `unsafe`-Code noch die `PERIPHERALS`-Struktur selbst.
] else { todo }

#if lang == "en" [
  This has a small runtime overhead because we must wrap the `SerialPort`
  structure in an option, and we'll need to call `take_serial()` once,
  however this small up-front cost allows us to leverage the borrow
  checker throughout the rest of our program.
] else if lang == "de" [
	Dies bringt einen geringen Laufzeit-Overhead mit sich, da wir die
	`SerialPort`-Struktur in eine `Option` einbetten und einmalig
	`take_serial()` aufrufen müssen; dieser geringe anfängliche Aufwand
	ermöglicht es uns jedoch, den Borrow-Checker im weiteren Verlauf des
	Programms voll zu nutzen.
] else { todo }

= #(if lang == "en" [Existing library support]
  else if lang == "de" [Vorhandene Bibliotheksunterstützung]
  else { todo })

#if lang == "en" [
  Although we created our own `Peripherals` structure above, it is not
  necessary to do this for your code. the `cortex_m` crate contains a
  macro called `singleton!()` that will perform this action for you.
] else if lang == "de" [
	Obwohl wir oben unsere eigene `Peripherals`-Struktur erstellt haben, ist
	dies für Ihren Code nicht erforderlich; das `cortex_m`-Crate enthält ein
	Makro namens `singleton!()`, das diese Aufgabe für Sie übernimmt.
] else { todo }

#raw(block: true, lang: "rust",
"use cortex_m::singleton;

fn main() {
    // " + if lang == "en" {
        "OK if `main` is executed only once"
      } else if lang == "de" {
        "In Ordnung, wenn `main` nur einmal ausgefuehrt wird."
      } else { todos } + "
    let x: &'static mut bool =
        singleton!(: bool = false).unwrap();
}
")

#let url_sinmacro = "https://docs.rs/cortex-m/latest/cortex_m/macro.singleton.html"
#if lang == "en" [
  #link(url_sinmacro)[cortex_m docs]
] else if lang == "de" [
	#link(url_sinmacro)[cortex_m Dokumente]
] else { todo }

#let ln_rtic = link("https://github.com/rtic-rs/cortex-m-rtic")[`cortex-m-rtic`]
#if lang == "en" [
  Additionally, if you use #ln_rtic, the
  entire process of defining and obtaining these peripherals are
  abstracted for you, and you are instead handed a `Peripherals` structure
  that contains a non-`Option<T>` version of all of the items you define.
] else if lang == "de" [
	Wenn Sie zudem #ln_rtic
	verwenden, wird der gesamte Prozess der Definition und Bereitstellung
	dieser Peripheriekomponenten für Sie abstrahiert; stattdessen erhalten
	Sie eine `Peripherals`-Struktur, die eine Version aller von Ihnen
	definierten Elemente enthält, die nicht als `Option<T>` vorliegen.
] else { todo }


#raw(block: true, lang: "rust",
"// cortex-m-rtic v0.5.x
#[rtic::app(device = lm3s6965, peripherals = true)]
const APP: () = {
    #[init]
    fn init(cx: init::Context) {
        static mut X: u32 = 0;
         
        // " + if lang == "en" {
            "Cortex-M peripherals"
          } else if lang == "de" {
            "Cortex-M-Peripherie"
          } else { todos } + "
        let core: cortex_m::Peripherals = cx.core;
        
        // " + if lang == "en" {
            "Device specific peripherals"
          } else if lang == "de" {
            "Geraetespezifische Peripheriegeraete"
          } else { todos } + "
        let device: lm3s6965::Peripherals = cx.device;
    }
}
")

= #(if lang == "en" [But why?]
  else if lang == "de" [Aber warum?]
  else { todo })

#if lang == "en" [
  But how do these Singletons make a noticeable difference in how our Rust
  code works?
] else if lang == "de" [
	Aber wie bewirken diese Singletons einen spürbaren Unterschied in der
	Funktionsweise unseres Rust-Codes?
] else { todo }

#raw(block: true, lang: "rust",
"impl SerialPort {
    const SER_PORT_SPEED_REG: *mut u32 = 0x4000_1000 as _;

    fn read_speed(
        &self // " + if lang == "en" {
                  "<------ This is really, really important"
                } else if lang == "de" {
                  "<------ Das ist wirklich, wirklich wichtig."
                } else { todos } + "
    ) -> u32 {
        unsafe {
            ptr::read_volatile(Self::SER_PORT_SPEED_REG)
        }
    }
}
")

#if lang == "en" [
  There are two important factors in play here:
  - Because we are using a singleton, there is only one way or place to
    obtain a `SerialPort` structure
  - To call the `read_speed()` method, we must have ownership or a
    reference to a `SerialPort` structure
] else if lang == "de" [
	Hier spielen zwei wichtige Faktoren eine Rolle:
	- Da wir ein Singleton verwenden, gibt es nur eine Möglichkeit bzw.
	einen Ort, um eine `SerialPort`-Struktur zu erhalten.
	- Um die Methode `read_speed()` aufzurufen, benötigen wir den Besitz
	einer `SerialPort`-Struktur oder eine Referenz darauf.
] else { todo }

#if lang == "en" [
  These two factors put together means that it is only possible to access
  the hardware if we have appropriately satisfied the borrow checker,
  meaning that at no point do we have multiple mutable references to the
  same hardware!
] else if lang == "de" [
	Zusammengenommen bedeuten diese beiden Faktoren, dass ein Zugriff auf
	die Hardware nur möglich ist, wenn wir die Anforderungen des
	Borrow-Checkers ordnungsgemäß erfüllt haben -- das heißt, dass zu keinem
	Zeitpunkt mehrere veränderbare Referenzen auf dieselbe Hardware
	existieren!
] else { todo }

#raw(block: true, lang: "rust",
"fn main() {
    // " + if lang == "en" {
        "missing reference to `self`! Won't work."
      } else if lang == "de" {
        "Verweis auf `self` fehlt! Das wird nicht funktionieren."
      } else { todos } + "
    // SerialPort::read_speed();

    let serial_1 = unsafe { PERIPHERALS.take_serial() };

    // " + if lang == "en" {
        "you can only read what you have access to"
      } else if lang == "de" {
        "Sie koennen nur lesen, worauf Sie Zugriff haben"
      } else { todos } + "
    let _ = serial_1.read_speed();
}
")

= #(if lang == "en" [Treat your hardware like data]
  else if lang == "de" [Behandle deine Hardware wie Daten]
  else { todo })

#if lang == "en" [
  Additionally, because some references are mutable, and some are
  immutable, it becomes possible to see whether a function or method could
  potentially modify the state of the hardware. For example,
] else if lang == "de" [
	Da es zudem sowohl veränderbare als auch unveränderbare Referenzen gibt,
	lässt sich erkennen, ob eine Funktion oder Methode potenziell den
	Zustand der Hardware ändern könnte. Zum Beispiel:
] else { todo }

#if lang == "en" [
  This is allowed to change hardware settings:
] else if lang == "de" [
	Dies darf Hardware-Einstellungen ändern:
] else { todo }

```rust
fn setup_spi_port(
    spi: &mut SpiPort,
    cs_pin: &mut GpioPin
) -> Result<()> {
    // ...
}
```

#if lang == "en" [
  This isn't:
] else if lang == "de" [
	Das nicht:
] else { todo }

```rust
fn read_button(gpio: &GpioPin) -> bool {
    // ...
}
```

#if lang == "en" [
  This allows us to enforce whether code should or should not make changes
  to hardware at *compile time*, rather than at runtime. As a note,
  this generally only works across one application, but for bare metal
  systems, our software will be compiled into a single application, so
  this is not usually a restriction.
] else if lang == "de" [
	Dies ermöglicht es uns, bereits zur *Kompilierzeit* -- und nicht
	erst zur Laufzeit -- festzulegen, ob Code Änderungen an der Hardware
	vornehmen darf oder nicht. Zu beachten ist, dass dies im Allgemeinen nur
	innerhalb einer einzelnen Anwendung funktioniert; da unsere Software für
	Bare-Metal-Systeme jedoch als eine einzige Anwendung kompiliert wird,
	stellt dies üblicherweise keine Einschränkung dar.
] else { todo }
