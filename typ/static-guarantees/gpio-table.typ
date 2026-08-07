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
      else if lang == "zh" [名字]
      else { todo },
      if lang == "en" [Bit Number(s)]
      else if lang == "de" [Bit-Nummer]
      else if lang == "zh" [位数(s)]
      else { todo },
      if lang == "en" [Value]
      else if lang == "de" [Wert]
      else if lang == "zh" [值]
      else { todo },
      if lang == "en" [Meaning]
      else if lang == "de" [Bedeutung]
      else if lang == "zh" [含义]
      else { todo },
      if lang == "en" [Notes]
      else if lang == "de" [Hinweise]
      else if lang == "zh" [注释]
      else { todo },
    ),
    table.cell(rowspan: 2)[enable], table.cell(rowspan: 2)[0],
    [0], [disabled],
    if lang == "en" [Disables the GPIO]
    else if lang == "de" [Deaktiviert den GPIO]
    else if lang == "zh" [关闭GPIO]
    else { todo },

    [1], [enabled],
    if lang == "en" [Enables the GPIO]
    else if lang == "de" [Aktiviert den GPIO]
    else if lang == "zh" [使能GPIO]
    else { todo },

    table.cell(rowspan: 2)[direction], table.cell(rowspan: 2)[1],
    [0], [input],
    if lang == "en" [Sets the direction to Input]
    else if lang == "de" [Legt die Richtung auf „Eingang" fest.]
    else if lang == "zh" [方向设置成输入]
    else { todo },

    [1], [output],
    if lang == "en" [Sets the direction to Output]
    else if lang == "de" [Legt die Richtung auf „Ausgang" fest.]
    else if lang == "zh" [方向设置成输出]
    else { todo },

    table.cell(rowspan: 4)[input_mode], table.cell(rowspan: 4)[2..3],
    [00], [hi-z],
    if lang == "en" [Sets the input as high resistance]
    else if lang == "de" [Setzt den Eingang auf hochohmig.]
    else if lang == "zh" [输入设置为高阻态]
    else { todo },

    [01], [pull-low],
    if lang == "en" [Input pin is pulled low]
    else if lang == "de" [Der Eingangspin wird auf Low-Pegel gezogen.]
    else if lang == "zh" [下拉输入管脚]
    else { todo },

    [10], [pull-high],
    if lang == "en" [Input pin is pulled high]
    else if lang == "de" [Der Eingangspin wird auf High-Pegel gezogen]
    else if lang == "zh" [上拉输入管脚]
    else { todo },

    [11], [n/a],
    if lang == "en" [Invalid state. Do not set]
    else if lang == "de" [Ungültiger Zustand. Nicht setzen.]
    else if lang == "zh" [无效状态。不要设置]
    else { todo },

    table.cell(rowspan: 2)[output_mode], table.cell(rowspan: 2)[4],
    [0], [set-low],
    if lang == "en" [Output pin is driven low]
    else if lang == "de" [Der Ausgangspin wird auf Low-Pegel gesteuert.]
    else if lang == "zh" [把管脚设置成低电平]
    else { todo },

    [1], [set-high],
    if lang == "en" [Output pin is driven high]
    else if lang == "de" [Der Ausgangspin wird auf High-Pegel gesteuert.]
    else if lang == "zh" [把管脚设置成高电平]
    else { todo },

    [input_status], [5], [x], [in-val],
    if lang == "en" [0 if input is < 1.5v, 1 if input >= 1.5v]
    else if lang == "de" [0, wenn der Eingang < 1,5 V ist; 1, wenn der Eingang ≥ 1,5 V ist.]
    else if lang == "zh" [如果输入 < 1.5v 为0，如果输入
    >= 1.5v 为1]
    else { todo },
  )
)