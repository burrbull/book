#import "../../config.typ": *

#h1(offset: whole*2,
  if lang == "en" [HAL Design Patterns Checklist]
  else if lang == "de" [Checkliste HAL-Design-Muster]
  else { todo })
<hal-checklist>
#set heading(offset: whole*3)

#if lang == "en" [
  *Naming* (_crate aligns with Rust naming conventions_)
    - ☐ The crate is named appropriately (#link(<c-crate-name>)[C-CRATE-NAME])
  - *Interoperability* (_crate interacts nicely with other library functionality_)
    - ☐ Wrapper types provide a destructor method (#link(<c-free>)[C-FREE])
    - ☐ HALs reexport their register access crate (#link(<c-reexport-pac>)[C-REEXPORT-PAC])
    - ☐ Types implement the `embedded-hal` traits (#link(<c-hal-traits>)[C-HAL-TRAITS])
  - *Predictability* (_crate enables legible code that acts how it looks_)
    - ☐ Constructors are used instead of extension traits (#link(<c-ctor>)[C-CTOR])
  - *GPIO Interfaces* (_GPIO Interfaces follow a common pattern_)
    - ☐ Pin types are zero-sized by default (#link(<c-zst-pin>)[C-ZST-PIN])
    - ☐ Pin types provide methods to erase pin and port (#link(<c-erased-pin>)[C-ERASED-PIN])
    - ☐ Pin state should be encoded as type parameters (#link(<c-pin-state>)[C-PIN-STATE])
] else if lang == "de" [
  - *Benennung* (_Crate richtet sich nach den Namenskonventionen von Rust_)
    - ☐ Das Crate trägt einen passenden Namen. (#link(<c-crate-name>)[C-CRATE-NAME])
  - *Interoperabilität* (_das Crate harmoniert gut mit der Funktionalität anderer Bibliotheken_)
    - ☐ Wrapper-Typen stellen eine Destruktor-Methode bereit. (#link(<c-free>)[C-FREE])
    - ☐ HALs exportieren ihr Registerzugriffs-Crate erneut. (#link(<c-reexport-pac>)[C-REEXPORT-PAC])
    - ☐ Typen implementieren die `embedded-hal`-Traits. (#link(<c-hal-traits>)[C-HAL-TRAITS])
  - *Vorhersehbarkeit* (_Das Crate ermöglicht gut lesbaren Code, der sich so verhält, wie er aussieht_)
    - ☐ Anstelle von Extension Traits werden Konstruktoren verwendet. (#link(<c-ctor>)[C-CTOR])
  - *GPIO-Schnittstellen* (_GPIO-Schnittstellen folgen einem einheitlichen Muster_)
    - ☐ Pin-Typen haben standardmäßig die Größe Null. (#link(<c-zst-pin>)[C-ZST-PIN])
    - ☐ Pin-Typen stellen Methoden zum Löschen von Pins und Ports bereit. (#link(<c-erased-pin>)[C-ERASED-PIN])
    - ☐ Der Pin-Zustand sollte als Typparameter kodiert werden. (#link(<c-pin-state>)[C-PIN-STATE])
] else { todo }
