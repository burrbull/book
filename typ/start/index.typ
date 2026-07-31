#import "../config.typ": *

#h1(if lang == "en" [Getting Started]
  else if lang == "de" [Erste Schritte]
  else { todo })
<getting-started>
#set heading(offset: whole)

#let ln_f3 = link("http://www.st.com/en/evaluation-tools/stm32f3discovery.html")[STM32F3DISCOVERY]
#if lang == "en" [
  In this section we'll walk you through the process of writing, building,
  flashing and debugging embedded programs. You will be able to try most
  of the examples without any special hardware as we will show you the
  basics using QEMU, a popular open-source hardware emulator. The only
  section where hardware is required is, naturally enough, the
  #link(<getting-started-hardware>)[Hardware] section, where we use OpenOCD to
  program an #ln_f3.
] else if lang == "de" [
  In diesem Abschnitt führen wir Sie Schritt für Schritt durch den Prozess
  des Schreibens, Kompilierens, Flashen und Debuggens von
  Embedded-Programmen. Sie können die meisten der Beispiele ohne spezielle
  Hardware ausprobieren, da wir Ihnen die Grundlagen mithilfe von QEMU,
  einem beliebten Open-Source-Hardware-Emulator, vermitteln. Der einzige
  Abschnitt, in dem Hardware erforderlich ist, ist natürlich der Abschnitt
  #link(<getting-started-hardware>)[Hardware], wo wir OpenOCD verwenden, um ein
  #ln_f3 zu programmieren.
] else { todo }