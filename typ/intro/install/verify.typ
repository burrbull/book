#import "../../config.typ": *

#h1(offset: whole*2,
  if lang == "en" [Verify Installation]
  else if lang == "de" [Die Installation überprüfen]
  else { todo })
<verify-installation>

#if lang == "en" [
  In this section we check that some of the required tools / drivers have
  been correctly installed and configured.
] else if lang == "de" [
  In diesem Abschnitt überprüfen wir, ob einige der erforderlichen
  Werkzeuge bzw. Treiber korrekt installiert und konfiguriert wurden.
] else { todo }

#if lang == "en" [
  Connect your laptop / PC to the discovery board using a Mini-USB USB
  cable. The discovery board has two USB connectors; use the one labeled
  "USB ST-LINK" that sits on the center of the edge of the board.
] else if lang == "de" [
  Verbinden Sie Ihren Laptop oder PC über ein Mini-USB-Kabel mit dem
  Discovery-Board. Das Discovery-Board verfügt über zwei USB-Anschlüsse;
  verwenden Sie den mit „USB ST-LINK" beschrifteten Anschluss, der sich
  mittig an der Platinenkante befindet.
] else { todo }

#if lang == "en" [
  Also check that the ST-LINK header is populated. See the picture below;
  the ST-LINK header is highlighted.
] else if lang == "de" [
  Überprüfen Sie außerdem, ob die ST-LINK-Stiftleiste bestückt ist. Siehe
  dazu die Abbildung unten; die ST-LINK-Stiftleiste ist dort
  hervorgehoben.
] else { todo }

#if lang == "en" [
  Now run the following command:
] else if lang == "de" [
  Führen Sie nun den folgenden Befehl aus:
] else { todo }

```console
openocd -f interface/stlink.cfg -f target/stm32f3x.cfg
```

#quote(block: true)[
#if lang == "en" [
  *NOTE*: Old versions of openocd, including the 0.10.0 release
  from 2017, do not contain the new (and preferable)
  `interface/stlink.cfg` file; instead you may need to use
  `interface/stlink-v2.cfg` or `interface/stlink-v2-1.cfg`.
] else if lang == "de" [
  *HINWEIS*: Ältere Versionen von OpenOCD, einschließlich der
  Version 0.10.0 aus dem Jahr 2017, enthalten nicht die neue (und zu
  bevorzugende) Datei `interface/stlink.cfg`; stattdessen müssen Sie
  möglicherweise `interface/stlink-v2.cfg` oder
  `interface/stlink-v2-1.cfg` verwenden.
] else { todo }
]

#if lang == "en" [
  You should get the following output and the program should block the
  console:
] else if lang == "de" [
  Sie sollten die folgende Ausgabe erhalten und das Programm sollte die
  Konsole blockieren:
] else { todo }

```text
Open On-Chip Debugger 0.10.0
Licensed under GNU GPL v2
For bug reports, read
        http://openocd.org/doc/doxygen/bugs.html
Info : auto-selecting first available session transport "hla_swd". To override use 'transport select <transport>'.
adapter speed: 1000 kHz
adapter_nsrst_delay: 100
Info : The selected transport took over low-level target control. The results might differ compared to plain JTAG/SWD
none separate
Info : Unable to match requested speed 1000 kHz, using 950 kHz
Info : Unable to match requested speed 1000 kHz, using 950 kHz
Info : clock speed 950 kHz
Info : STLINK v2 JTAG v27 API v2 SWIM v15 VID 0x0483 PID 0x374B
Info : using stlink api v2
Info : Target voltage: 2.919881
Info : stm32f3x.cpu: hardware has 6 breakpoints, 4 watchpoints
```

#if lang == "en" [
  The contents may not match exactly but you should get the last line
  about breakpoints and watchpoints. If you got it then terminate the
  OpenOCD process and move to the #link(<getting-started>)[next section].
] else if lang == "de" [
  Der Inhalt stimmt möglicherweise nicht exakt überein, aber die letzte
  Zeile bezüglich Breakpoints und Watchpoints sollten Sie sehen. Wenn dies
  der Fall ist, beenden Sie den OpenOCD-Prozess und fahren Sie mit dem
  #link(<getting-started>)[nächsten Abschnitt] fort.
] else { todo }

#if lang == "en" [
  If you didn't get the "breakpoints" line then try one of the following
  commands.
] else if lang == "de" [
  Falls du die Zeile „breakpoints" nicht erhalten hast, versuche einen der
  folgenden Befehle.
] else { todo }

```console
openocd -f interface/stlink-v2.cfg -f target/stm32f3x.cfg
```

```console
openocd -f interface/stlink-v2-1.cfg -f target/stm32f3x.cfg
```

#if lang == "en" [
  If one of those commands works it means you got an old hardware revision
  of the discovery board. That won't be a problem but commit that fact to
  memory as you'll need to configure things a bit differently later on.
  You can move to the #link(<getting-started>)[next section].
] else if lang == "de" [
  Wenn einer dieser Befehle funktioniert, bedeutet das, dass Sie eine
  ältere Hardware-Revision des Discovery-Boards besitzen. Das stellt kein
  Problem dar, aber merken Sie sich diesen Umstand, da Sie die
  Konfiguration später etwas anders vornehmen müssen. Sie können zum
  #link(<getting-started>)[nächsten Abschnitt] übergehen.
] else { todo }

#if lang == "en" [
  If none of the commands work as a normal user then try to run them with
  root permission (e.g.~`sudo openocd ..`). If the commands do work with
  root permission then check that the
  #link(<linux-udev-rules>)[udev rules] have been correctly set.
] else if lang == "de" [
  Wenn keiner der Befehle als normaler Benutzer funktioniert, versuchen
  Sie, sie mit Root-Rechten auszuführen (z. B. `sudo openocd ..`). Sollten
  die Befehle mit Root-Rechten funktionieren, überprüfen Sie, ob die
  #link(<linux-udev-rules>)[udev-Regeln] korrekt eingerichtet wurden.
] else { todo }

#let url_issues = "https://github.com/rust-embedded/book/issues"
#if lang == "en" [
  If you have reached this point and OpenOCD is not working please open
  #link(url_issues)[an issue] and
  we'll help you out!
] else if lang == "de" [
  Wenn Sie an diesem Punkt angelangt sind und OpenOCD nicht funktioniert,
  eröffnen Sie bitte
  #link(url_issues)[eine Problemmeldung],
  und wir helfen Ihnen weiter!
] else { todo }
