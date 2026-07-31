#import "../../config.typ": *

#h1(offset: whole*2,
  [Windows])
#set heading(offset: whole*3)

= `arm-none-eabi-gdb`

#let url_arm_gnu = "https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads"
#if lang == "en" [
  ARM provides `.exe` installers for Windows. Grab one from #link(url_arm_gnu)[here],
  and follow the instructions. Just before the installation process
  finishes tick/select the "Add path to environment variable" option. Then
  verify that the tools are in your `%PATH%`:
] else if lang == "de" [
  ARM stellt `.exe`-Installationsprogramme für Windows bereit.
  Laden Sie eines von #link(url_arm_gnu)[hier]
  herunter und befolgen Sie die Anweisungen. Aktivieren Sie kurz vor
  Abschluss des Installationsvorgangs die Option „Add path to environment
  variable". Überprüfen Sie anschließend, ob die Werkzeuge in Ihrem
  `%PATH%` enthalten sind:
] else { todo }

```text
$ arm-none-eabi-gdb -v
GNU gdb (GNU Tools for Arm Embedded Processors 7-2018-q2-update) 8.1.0.20180315-git
(..)
```

= OpenOCD

#let url_openocd = "https://xpack.github.io/openocd/"
#let bin_path = `C:\Users\USERNAME\AppData\Roaming\xPacks\@xpack-dev-tools\openocd\0.10.0-13.1\.content\bin\`
#if lang == "en" [
  There's no official binary release of OpenOCD for Windows but if you're
  not in the mood to compile it yourself, the xPack project provides a
  binary distribution, #link(url_openocd)[here].
  Follow the provided installation instructions. Then update your `%PATH%`
  environment variable to include the path where the binaries were
  installed. (#bin_path, if you've been using the easy install)
] else if lang == "de" [
  Es gibt kein offizielles Binär-Release von OpenOCD für Windows, aber
  wenn Sie es nicht selbst kompilieren möchten, stellt das xPack-Projekt
  eine Binärdistribution bereit -- zu finden
  #link(url_openocd)[hier]. Befolgen Sie die dort
  aufgeführten Installationsanweisungen. Aktualisieren Sie anschließend
  Ihre Umgebungsvariable `%PATH%`, indem Sie den Pfad hinzufügen, unter
  dem die Binärdateien installiert wurden (z. B. #bin_path,
  falls Sie die einfache Installation verwendet haben).
] else { todo }

#if lang == "en" [
  Verify that OpenOCD is in your `%PATH%` with:
] else if lang == "de" [
  Überprüfen Sie mit folgendem Befehl, ob OpenOCD in Ihrem `%PATH%` enthalten ist:
] else { todo }

```text
$ openocd -v
Open On-Chip Debugger 0.10.0
(..)
```

= QEMU

#let url_qemu = "https://www.qemu.org/download/#windows"
#if lang == "en" [
  Grab QEMU from #link(url_qemu)[the official website].
] else if lang == "de" [
  Lade QEMU von #link(url_qemu)[der offiziellen Website] herunter.
] else { todo }

= ST-LINK USB driver

#let url_stlink = "http://www.st.com/en/embedded-software/stsw-link009.html"
#if lang == "en" [
  You'll also need to install #link(url_stlink)[this USB driver]
  or OpenOCD won't work. Follow the installer instructions and make sure
  you install the right version (32-bit or 64-bit) of the driver.
] else if lang == "de" [
  Sie müssen außerdem #link(url_stlink)[diesen USB-Treiber]
  installieren, da OpenOCD sonst nicht funktioniert. Befolgen Sie die
  Anweisungen des Installationsprogramms und stellen Sie sicher, dass Sie
  die richtige Version des Treibers (32-Bit oder 64-Bit) installieren.
] else { todo }

#if lang == "en" [
  That's all! Go to the #link(<verify-installation>)[next section].
] else if lang == "de" [
  Das war's! Gehen Sie zum #link(<verify-installation>)[nächsten Abschnitt].
] else { todo }
