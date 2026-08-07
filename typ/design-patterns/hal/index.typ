#import "../../config.typ": *

#h1(offset: whole,
  if lang == "en" [HAL Design Patterns]
  else if lang == "de" [HAL-Design-Muster]
  else { todo })

#let url_quide = "https://rust-lang.github.io/api-guidelines/"
#if lang == "en" [
  This is a set of common and recommended patterns for writing hardware
  abstraction layers (HALs) for microcontrollers in Rust. These patterns
  are intended to be used in addition to the existing
  #link(url_quide)[Rust API Guidelines]
  when writing HALs for microcontrollers.
  - #link(<hal-checklist>)[Checklist]
  - #link(<hal-naming>)[Naming]
  - #link(<hal-interoperability>)[Interoperability]
  - #link(<hal-predictability>)[Predictability]
  - #link(<hal-gpio>)[GPIO]
] else if lang == "de" [
  Hierbei handelt es sich um eine Sammlung bewährter und empfohlener
  Muster für die Implementierung von Hardware-Abstraktionsschichten (HALs)
  für Mikrocontroller in Rust. Diese Muster sind als Ergänzung zu den
  bestehenden #link(url_quide)[Rust-API-Richtlinien]
  für die Entwicklung von HALs für Mikrocontroller gedacht.
  #link(<hal-checklist>)[Checkliste]
  - #link(<hal-naming>)[Benennung]
  - #link(<hal-interoperability>)[Interoperabilität]
  - #link(<hal-predictability>)[Vorhersehbarkeit]
  - #link(<hal-gpio>)[GPIO]
] else { todo }
