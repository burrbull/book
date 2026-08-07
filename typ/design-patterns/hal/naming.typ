#import "../../config.typ": *

#h1(offset: whole*2,
  if lang == "en" [Naming]
  else if lang == "de" [Benennung]
  else { todo })
<hal-naming>

= #(if lang == "en" [The crate is named appropriately]
  else if lang == "de" [Das Crate trägt einen passenden Namen]
  else { todo }) (C-CRATE-NAME)
<c-crate-name>

#if lang == "en" [
  HAL crates should be named after the chip or family of chips they aim to
  support. Their name should end with `-hal` to distinguish them from
  register access crates. The name should not contain underscores (use
  dashes instead).
] else if lang == "de" [
  HAL-Crates sollten nach dem Chip oder der Chip-Familie benannt werden,
  die sie unterstützen sollen. Ihr Name sollte auf `-hal` enden, um sie
  von Registerzugriffs-Crates zu unterscheiden. Der Name sollte keine
  Unterstriche enthalten (stattdessen sind Bindestriche zu verwenden).
] else { todo }
