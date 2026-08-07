#import "../../config.typ": *

#h1(offset: whole*2,
  if lang == "en" [Predictability]
  else if lang == "de" [Vorhersehbarkeit]
  else { todo })
<hal-predictability>

= #(if lang == "en" [Constructors are used instead of extension traits]
  else if lang == "de" [Anstelle von Extension Traits werden Konstruktoren verwendet]
  else { todo }) (C-CTOR)
<c-ctor>

#if lang == "en" [
  All peripherals to which the HAL adds functionality should be wrapped in
  a new type, even if no additional fields are required for that
  functionality.
] else if lang == "de" [
  Alle Peripheriegeräte, denen die HAL Funktionalität hinzufügt, sollten
  in einen neuen Typ gekapselt werden -- selbst dann, wenn für diese
  Funktionalität keine zusätzlichen Felder erforderlich sind.
] else { todo }

#if lang == "en" [
  Extension traits implemented for the raw peripheral should be avoided.
] else if lang == "de" [
  Die Implementierung von Extension Traits für das rohe Peripheriegerät
  (Raw Peripheral) sollte vermieden werden.
] else { todo }

= #(if lang == "en" [Methods are decorated with `#[inline]` where appropriate]
  else if lang == "de" [Methoden werden dort, wo es angebracht ist, mit `#[inline]`
  versehen]
  else { todo }) (C-INLINE)
<c-inline>

#if lang == "en" [
  The Rust compiler does not by default perform full inlining across crate
  boundaries. As embedded applications are sensitive to unexpected code
  size increases, `#[inline]` should be used to guide the compiler as
  follows:
  - All "small" functions should be marked `#[inline]`. What qualifies as
    "small" is subjective, but generally all functions that are expected
    to compile down to single-digit instruction sequences qualify as
    small.
  - Functions that are very likely to take constant values as parameters
    should be marked as `#[inline]`. This enables the compiler to compute
    even complicated initialization logic at compile time, provided the
    function inputs are known.
] else if lang == "de" [
  Der Rust-Compiler führt standardmäßig kein vollständiges Inlining über
  Crate-Grenzen hinweg durch. Da eingebettete Anwendungen empfindlich auf
  unerwartete Vergrößerungen des Codes reagieren, sollte `#[inline]`
  verwendet werden, um den Compiler wie folgt zu steuern:
  - Alle „kleinen" Funktionen sollten mit `#[inline]` gekennzeichnet
    werden. Was als „klein" gilt, ist subjektiv; im Allgemeinen zählen
    jedoch alle Funktionen dazu, die voraussichtlich zu einer Sequenz von
    nur wenigen Maschinenbefehlen kompiliert werden.
  - Funktionen, die sehr wahrscheinlich konstante Werte als Parameter
    erhalten, sollten mit `#[inline]` gekennzeichnet werden. Dies
    ermöglicht es dem Compiler, selbst komplexe Initialisierungslogik zur
    Kompilierzeit zu berechnen, sofern die Eingabewerte der Funktion
    bekannt sind.
] else { todo }
