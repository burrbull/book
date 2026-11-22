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
      tr((
        en: [Name],
        de: [Name],
        ja: [名前],
        ru: [Имя],
        zh: [名字],
      )),
      tr((
        en: [Bit Number(s)],
        de: [Bit-Nummer],
        ja: [ビットフィールド],
        ru: [Номер бита(ов)],
        zh: [位数(s)],
      )),
      tr((
        en: [Value],
        de: [Wert],
        ja: [値],
        ru: [Значение],
        zh: [值],
      )),
      tr((
        en: [Meaning],
        de: [Bedeutung],
        ja: [意味],
        ru: [Смысл],
        zh: [含义],
      )),
      tr((
        en: [Notes],
        de: [Hinweise],
        ja: [説明],
        ru: [Примечания],
        zh: [注释],
      )),
    ),
    table.cell(rowspan: 2)[enable], table.cell(rowspan: 2)[0],
    [0], [disabled],
    tr((
      en: [Disables the GPIO],
      de: [Deaktiviert den GPIO],
      ja: [GPIOを無効にする],
      ru: [Отключает GPIO],
      zh: [关闭GPIO],
    )),

    [1], [enabled],
    tr((
      en: [Enables the GPIO],
      de: [Aktiviert den GPIO],
      ja: [GPIOを有効にする],
      ru: [Включает GPIO],
      zh: [使能GPIO],
    )),

    table.cell(rowspan: 2)[direction], table.cell(rowspan: 2)[1],
    [0], [input],
    tr((
      en: [Sets the direction to Input],
      de: [Legt die Richtung auf „Eingang" fest.],
      ja: [方向を入力に設定する],
      ru: [Задаёт направление: вход],
      zh: [方向设置成输入],
    )),

    [1], [output],
    tr((
      en: [Sets the direction to Output],
      de: [Legt die Richtung auf „Ausgang" fest.],
      ja: [方向を出力に設定する],
      ru: [Задаёт направление: выход],
      zh: [方向设置成输出],
    )),

    table.cell(rowspan: 4)[input_mode], table.cell(rowspan: 4)[2..3],
    [00], [hi-z],
    tr((
      en: [Sets the input as high resistance],
      de: [Setzt den Eingang auf hochohmig.],
      ja: [入力を高抵抗に設定する],
      ru: [Задаёт вход с высоким сопротивлением],
      zh: [输入设置为高阻态],
    )),

    [01], [pull-low],
    tr((
      en: [Input pin is pulled low],
      de: [Der Eingangspin wird auf Low-Pegel gezogen.],
      ja: [入力ピンはプルダウンになる],
      ru: [Входной вывод подтянут к земле],
      zh: [下拉输入管脚],
    )),

    [10], [pull-high],
    tr((
      en: [Input pin is pulled high],
      de: [Der Eingangspin wird auf High-Pegel gezogen],
      ja: [入力ピンはプルアップになる],
      ru: [Входной вывод подтянут к питанию],
      zh: [上拉输入管脚],
    )),

    [11], [n/a],
    tr((
      en: [Invalid state. Do not set],
      de: [Ungültiger Zustand. Nicht setzen.],
      ja: [無効な状態。設定しないこと。],
      ru: [Недопустимое состояние. Не устанавливать],
      zh: [无效状态。不要设置],
    )),

    table.cell(rowspan: 2)[output_mode], table.cell(rowspan: 2)[4],
    [0], [set-low],
    tr((
      en: [Output pin is driven low],
      de: [Der Ausgangspin wird auf Low-Pegel gesteuert.],
      ja: [出力ピンをローにする],
      ru: [Выходной вывод управляется низким уровнем],
      zh: [把管脚设置成低电平],
    )),

    [1], [set-high],
    tr((
      en: [Output pin is driven high],
      de: [Der Ausgangspin wird auf High-Pegel gesteuert.],
      ja: [出力ピンをハイにする],
      ru: [Выходной вывод управляется высоким уровнем],
      zh: [把管脚设置成高电平],
    )),

    [input_status], [5], [x], [in-val],
    tr((
      en: [0 if input is < 1.5v, 1 if input >= 1.5v],
      de: [0, wenn der Eingang < 1,5 V ist; 1, wenn der Eingang ≥ 1,5 V ist.],
      ja: [入力が1.5Vより低ければ0、1.5V以上であれば1],
      ru: [0, если вход < 1,5 В; 1, если вход >= 1,5 В],
      zh: [如果输入 < 1.5v 为0，如果输入 >= 1.5v 为1],
    )),
  )
)