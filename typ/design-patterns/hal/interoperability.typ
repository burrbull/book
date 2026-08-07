#import "../../config.typ": *

#h1(offset: whole*2,
  if lang == "en" [Interoperability]
  else if lang == "de" [Interoperabilität]
  else { todo })
<hal-interoperability>

= #(if lang == "en" [Wrapper types provide a destructor method]
  else if lang == "de" [Wrapper-Typen stellen eine Destruktor-Methode bereit]
  else { todo }) (C-FREE)
<c-free>

#if lang == "en" [
  Any non-`Copy` wrapper type provided by the HAL should provide a `free`
  method that consumes the wrapper and returns back the raw peripheral
  (and possibly other objects) it was created from.
] else if lang == "de" [
  Jeder vom HAL bereitgestellte Wrapper-Typ, der nicht `Copy`
  implementiert, sollte eine `free`-Methode anbieten; diese verbraucht den
  Wrapper und gibt das rohe Peripheriegerät (sowie gegebenenfalls weitere
  Objekte), aus dem er erstellt wurde, wieder frei.
] else { todo }

#if lang == "en" [
  The method should shut down and reset the peripheral if necessary.
  Calling `new` with the raw peripheral returned by `free` should not fail
  due to an unexpected state of the peripheral.
] else if lang == "de" [
  Die Methode sollte das Peripheriegerät bei Bedarf deaktivieren und
  zurücksetzen. Ein Aufruf von `new` mit dem durch `free` zurückgegebenen
  rohen Peripheriegerät darf nicht aufgrund eines unerwarteten Zustands
  des Geräts fehlschlagen.
] else { todo }

#if lang == "en" [
  If the HAL type requires other non-`Copy` objects to be constructed (for
  example I/O pins), any such object should be released and returned by
  `free` as well. `free` should return a tuple in that case.
] else if lang == "de" [
  Falls für die Konstruktion des HAL-Typs weitere Objekte erforderlich
  sind, die nicht `Copy` implementieren (zum Beispiel I/O-Pins), sollten
  auch diese Objekte durch `free` freigegeben und zurückgegeben werden. In
  diesem Fall sollte `free` ein Tupel zurückgeben.
] else { todo }

#if lang == "en" [
  For example:
] else if lang == "de" [
  Zum Beispiel:
] else { todo }

```rust
# pub struct TIMER0;
pub struct Timer(TIMER0);

impl Timer {
    pub fn new(periph: TIMER0) -> Self {
        Self(periph)
    }

    pub fn free(self) -> TIMER0 {
        self.0
    }
}
```

= #(if lang == "en" [HALs reexport their register access crate]
  else if lang == "de" [HALs exportieren ihr Registerzugriffs-Crate erneut]
  else { todo }) (C-REEXPORT-PAC)
<c-reexport-pac>

#let ln_svd2rust = link("https://github.com/rust-embedded/svd2rust")[svd2rust]
#if lang == "en" [
  HALs can be written on top of #ln_svd2rust;-generated
  PACs, or on top of other crates that provide raw register access. HALs
  should always reexport the register access crate they are based on in
  their crate root.
] else if lang == "de" [
  HALs können auf der Basis von mit
  #link("https://github.com/rust-embedded/svd2rust")[svd2rust] generierten
  PACs oder anderen Crates implementiert werden, die einen direkten
  Registerzugriff ermöglichen. HALs sollten das Crate für den
  Registerzugriff, auf dem sie aufbauen, stets an der Wurzel ihres eigenen
  Crates erneut exportieren (re-exportieren).
] else { todo }

#if lang == "en" [
  A PAC should be reexported under the name `pac`, regardless of the
  actual name of the crate, as the name of the HAL should already make it
  clear what PAC is being accessed.
] else if lang == "de" [
  Ein PAC sollte unter dem Namen `pac` re-exportiert werden -- unabhängig
  vom eigentlichen Namen des Crates --, da bereits der Name der HAL
  verdeutlichen sollte, auf welches PAC zugegriffen wird.
] else { todo }

= #(if lang == "en" [Types implement the `embedded-hal` traits (C-HAL-TRAITS)]
  else if lang == "de" [Typen implementieren die `embedded-hal`-Traits]
  else { todo }) <c-hal-traits>

#let ln_hal = link("https://github.com/rust-embedded/embedded-hal")[`embedded-hal`]
#if lang == "en" [
  Types provided by the HAL should implement all applicable traits
  provided by the #ln_hal crate.
] else if lang == "de" [
  Vom HAL bereitgestellte Typen sollten alle anwendbaren Traits
  implementieren, die vom #ln_hal;-Crate bereitgestellt werden.
] else { todo }

#if lang == "en" [
  Multiple traits may be implemented for the same type.
] else if lang == "de" [
  Für denselben Typ können mehrere Traits implementiert werden.
] else { todo }
