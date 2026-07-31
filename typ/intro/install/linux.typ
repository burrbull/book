#import "../../config.typ": *

#h1(offset: whole*2,
  [Linux])
#set heading(offset: whole*3)

#if lang == "en" [
  Here are the installation commands for a few Linux distributions.
] else if lang == "de" [
  Hier sind die Installationsbefehle für einige Linux-Distributionen.
] else { todo }

= #(if lang == "en" [Packages]
  else if lang == "de" [Pakete]
  else { todo })

#if lang == "en" [
  - Ubuntu 18.04 or newer / Debian stretch or newer
] else if lang == "de" [
  - Ubuntu 18.04 oder neuer / Debian Stretch oder neuer
] else { todo }

#quote(block: true)[
#if lang == "en" [
  *NOTE* `gdb-multiarch` is the GDB command you'll use to debug
  your ARM Cortex-M programs
] else if lang == "de" [
  *HINWEIS* `gdb-multiarch` ist der GDB-Befehl, den Sie zum
  Debuggen Ihrer ARM-Cortex-M-Programme verwenden werden.
] else { todo }
]

```console
sudo apt install gdb-multiarch openocd qemu-system-arm
```

#if lang == "en" [
  - Ubuntu 14.04 and 16.04
] else if lang == "de" [
  - Ubuntu 14.04 und 16.04
] else { todo }

#quote(block: true)[
#if lang == "en" [
  *NOTE* `arm-none-eabi-gdb` is the GDB command you'll use to debug
  your ARM Cortex-M programs
] else if lang == "de" [
  *HINWEIS* `arm-none-eabi-gdb` ist der GDB-Befehl, den Sie zum
  Debuggen Ihrer ARM-Cortex-M-Programme verwenden werden.
] else { todo }
]

```console
sudo apt install gdb-arm-none-eabi openocd qemu-system-arm
```

#if lang == "en" [
  - Fedora 27 or newer
] else if lang == "de" [
  - Fedora 27 oder neuer
] else { todo }

```console
sudo dnf install gdb openocd qemu-system-arm
```

- Arch Linux

#quote(block: true)[
#if lang == "en" [
  *NOTE* `arm-none-eabi-gdb` is the GDB command you'll use to debug
  ARM Cortex-M programs
] else if lang == "de" [
  *HINWEIS* `arm-none-eabi-gdb` ist der GDB-Befehl, den Sie zum
  Debuggen von ARM-Cortex-M-Programmen verwenden.
] else { todo }
]

```console
sudo pacman -S arm-none-eabi-gdb qemu-system-arm openocd
```

= #(if lang == "en" [udev rules]
  else if lang == "de" [udev-Regeln]
  else { todo }) <linux-udev-rules>

#if lang == "en" [
  This rule lets you use OpenOCD with the Discovery board without root privilege.
] else if lang == "de" [
  Diese Regel ermöglicht die Nutzung von OpenOCD mit dem Discovery Board ohne Root-Rechte.
] else { todo }

#{
let f = `/etc/udev/rules.d/70-st-link.rules`
if lang == "en" [
  Create the file #f with the contents shown below.
] else if lang == "de" [
  Erstellen Sie die Datei #f mit dem unten stehenden Inhalt.
] else { todo }
}

```text
# STM32F3DISCOVERY rev A/B - ST-LINK/V2
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", TAG+="uaccess"

# STM32F3DISCOVERY rev C+ - ST-LINK/V2-1
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", TAG+="uaccess"
```

#if lang == "en" [
  Then reload all the udev rules with:
] else if lang == "de" [
  Laden Sie anschließend alle udev-Regeln neu mit:
] else { todo }

```console
sudo udevadm control --reload-rules
```

#if lang == "en" [
  If you had the board plugged to your laptop, unplug it and then plug it again.
] else if lang == "de" [
  Wenn Sie die Platine an Ihren Laptop angeschlossen hatten, ziehen Sie
  den Stecker heraus und schließen Sie ihn dann erneut an.
] else { todo }

#if lang == "en" [
  You can check the permissions by running this command:
] else if lang == "de" [
  Sie können die Berechtigungen überprüfen, indem Sie diesen Befehl ausführen:
] else { todo }

```console
lsusb
```

#if lang == "en" [
  Which should show something like
] else if lang == "de" [
  Was so etwas wie
] else { todo }

```text
(..)
Bus 001 Device 018: ID 0483:374b STMicroelectronics ST-LINK/V2.1
(..)
```
#if lang == "de" [
  anzeigen sollte.
]

#if lang == "en" [
  Take note of the bus and device numbers. Use those numbers to create a
  path like `/dev/bus/usb/<bus>/<device>`. Then use this path like so:
] else if lang == "de" [
  Notieren Sie sich die Bus- und Gerätenummern. Verwenden Sie diese
  Nummern, um einen Pfad wie `/dev/bus/usb/<bus>/<device>` zu bilden.
  Verwenden Sie diesen Pfad anschließend wie folgt:
] else { todo }

```console
ls -l /dev/bus/usb/001/018
```

```text
crw-------+ 1 root root 189, 17 Sep 13 12:34 /dev/bus/usb/001/018
```

```console
getfacl /dev/bus/usb/001/018 | grep user
```

```text
user::rw-
user:you:rw-
```

#if lang == "en" [
  The `+` appended to permissions indicates the existence of an extended
  permission. The `getfacl` command tells the user `you` can make use of
  this device.
] else if lang == "de" [
  Das angehängte „+" bei den Berechtigungen weist auf eine erweiterte
  Berechtigung hin. Der Befehl „getfacl" teilt dem Benutzer mit, dass er
  dieses Gerät verwenden darf.
] else { todo }

#if lang == "en" [
  Now, go to the #link(<verify-installation>)[next section].
] else if lang == "de" [
  Fahren Sie nun mit dem #link(<verify-installation>)[nächsten Abschnitt] fort.
] else { todo }
