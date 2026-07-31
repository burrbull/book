#import "../config.typ": *

#figure(
  kind: table,
  table(
    columns: (auto, auto, auto, auto, 1fr),
    align: (x, y) => {
      if x == 4 and y > 0 {
        left + horizon
      } else {
        center + horizon
      }
    },
    table.header(
      if lang in ("en", "de") [Name]
      else { todo },
      if lang == "en" [Bit Number(s)]
      else if lang == "de" [Bit-Nummer]
      else { todo },
      if lang == "en" [Value]
      else if lang == "de" [Wert]
      else { todo },
      if lang == "en" [Meaning]
      else if lang == "de" [Bedeutung]
      else { todo },
      if lang == "en" [Notes]
      else if lang == "de" [Hinweise]
      else { todo },
    ),
    table.cell(rowspan: 2)[enable], table.cell(rowspan: 2)[0],
    [0], [disabled],
    if lang == "en" [Disables the GPIO]
    else if lang == "de" [Deaktiviert den GPIO]
    else { todo },

    [1], [enabled],
    if lang == "en" [Enables the GPIO]
    else if lang == "de" [Aktiviert den GPIO]
    else { todo },

    table.cell(rowspan: 2)[direction], table.cell(rowspan: 2)[1],
    [0], [input],
    if lang == "en" [Sets the direction to Input]
    else if lang == "de" [Legt die Richtung auf „Eingang" fest.]
    else { todo },

    [1], [output],
    if lang == "en" [Sets the direction to Output]
    else if lang == "de" [Legt die Richtung auf „Ausgang" fest.]
    else { todo },

    table.cell(rowspan: 4)[input_mode], table.cell(rowspan: 4)[2..3],
    [00], [hi-z],
    if lang == "en" [Sets the input as high resistance]
    else if lang == "de" [Setzt den Eingang auf hochohmig.]
    else { todo },

    [01], [pull-low],
    if lang == "en" [Input pin is pulled low]
    else if lang == "de" [Der Eingangspin wird auf Low-Pegel gezogen.]
    else { todo },

    [10], [pull-high],
    if lang == "en" [Input pin is pulled high]
    else if lang == "de" [Der Eingangspin wird auf High-Pegel gezogen]
    else { todo },

    [11], [n/a],
    if lang == "en" [Invalid state. Do not set]
    else if lang == "de" [Ungültiger Zustand. Nicht setzen.]
    else { todo },

    table.cell(rowspan: 2)[output_mode], table.cell(rowspan: 2)[4],
    [0], [set-low],
    if lang == "en" [Output pin is driven low]
    else if lang == "de" [Der Ausgangspin wird auf Low-Pegel gesteuert.]
    else { todo },

    [1], [set-high],
    if lang == "en" [Output pin is driven high]
    else if lang == "de" [Der Ausgangspin wird auf High-Pegel gesteuert.]
    else { todo },

    [input_status], [5], [x], [in-val],
    if lang == "en" [0 if input is < 1.5v, 1 if input >= 1.5v]
    else if lang == "de" [0, wenn der Eingang < 1,5 V ist; 1, wenn der Eingang ≥ 1,5 V ist.]
    else { todo },
  )
)