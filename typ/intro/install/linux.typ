#import "../../config.typ": *

#h1(offset: whole*2,
  [Linux])
#set heading(offset: whole*3)

#if lang == "en" [
  Here are the installation commands for a few Linux distributions.
] else if lang == "de" [
  Hier sind die Installationsbefehle für einige Linux-Distributionen.
] else if lang == "zh" [
  这部分是在某些Linux发行版下的安装指令。
] else { todo }

= #(if lang == "en" [Packages]
  else if lang == "de" [Pakete]
  else if lang == "zh" [依赖包]
  else { todo })

#if lang == "en" [
  - Ubuntu 18.04 or newer / Debian stretch or newer
] else if lang == "de" [
  - Ubuntu 18.04 oder neuer / Debian Stretch oder neuer
] else if lang == "zh" [
  - Ubuntu 18.04 或者更新的版本 / Debian stretch 或者更新的版本
] else { todo }

#quote(block: true)[
#if lang == "en" [
  *NOTE* `gdb-multiarch` is the GDB command you'll use to debug
  your ARM Cortex-M programs
] else if lang == "de" [
  *HINWEIS* `gdb-multiarch` ist der GDB-Befehl, den Sie zum
  Debuggen Ihrer ARM-Cortex-M-Programme verwenden werden.
] else if lang == "zh" [
  * 注意* `gdb-multiarch` 是你将用来调试你的ARM
] else { todo }
]

```console
sudo apt install gdb-multiarch openocd qemu-system-arm
```

#if lang in ("en", "zh") [
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
] else if lang == "zh" [
  *注意* `arm-none-eabi-gdb` 是你将用来调试你的ARM
  Cortex-M程序的GDB命令
] else { todo }
]

```console
sudo apt install gdb-arm-none-eabi openocd qemu-system-arm
```

#if lang == "en" [
  - Fedora 27 or newer
] else if lang == "de" [
  - Fedora 27 oder neuer
] else if lang == "zh" [
  - Fedora 27 或者更新的版本
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
] else if lang == "zh" [
  *注意* `arm-none-eabi-gdb` 是你将用来调试你的ARM Cortex-M程序的GDB命令
] else { todo }
]

```console
sudo pacman -S arm-none-eabi-gdb qemu-system-arm openocd
```

= #(if lang == "en" [udev rules]
  else if lang == "de" [udev-Regeln]
  else if lang == "zh" [udev 规则]
  else { todo }) <linux-udev-rules>

#if lang == "en" [
  This rule lets you use OpenOCD with the Discovery board without root privilege.
] else if lang == "de" [
  Diese Regel ermöglicht die Nutzung von OpenOCD mit dem Discovery Board ohne Root-Rechte.
] else if lang == "zh" [
  这个规则可以让你在不使用超级用户权限的情况下，使用OpenOCD和Discovery开发板。
] else { todo }

#{
let f = `/etc/udev/rules.d/70-st-link.rules`
if lang == "en" [
  Create the file #f with the contents shown below.
] else if lang == "de" [
  Erstellen Sie die Datei #f mit dem unten stehenden Inhalt.
] else if lang == "zh" [
  生成包含下列内容的 `/etc/udev/rules.d/70-st-link.rules` 文件
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
] else if lang == "zh" [
  然后重新加载所有的udev规则
] else { todo }

```console
sudo udevadm control --reload-rules
```

#if lang == "en" [
  If you had the board plugged to your laptop, unplug it and then plug it again.
] else if lang == "de" [
  Wenn Sie die Platine an Ihren Laptop angeschlossen hatten, ziehen Sie
  den Stecker heraus und schließen Sie ihn dann erneut an.
] else if lang == "zh" [
  如果你已经把开发板插入到笔记本中了，请拔下它然后再插上它。
] else { todo }

#if lang == "en" [
  You can check the permissions by running this command:
] else if lang == "de" [
  Sie können die Berechtigungen überprüfen, indem Sie diesen Befehl ausführen:
] else if lang == "zh" [
  你可以通过运行这个命令检查权限:
] else { todo }

```console
lsusb
```

#if lang == "en" [
  Which should show something like
] else if lang == "de" [
  Was so etwas wie
] else if lang == "zh" [
  终端可能有如下显示
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
] else if lang == "zh" [
  记住bus和device号，使用这些数字组合成一个像是
  `/dev/bus/usb/<bus>/<device>` 这样的路径。然后像这样使用这个路径:
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
] else if lang == "zh" [
  权限后的 `+` 指出存在一个扩展权限。`getfacl`
  命令显示，`user`也就是`你`，可以使用这个设备。
] else { todo }

#if lang == "en" [
  Now, go to the #link(<verify-installation>)[next section].
] else if lang == "de" [
  Fahren Sie nun mit dem #link(<verify-installation>)[nächsten Abschnitt] fort.
] else if lang == "zh" [
  现在，去往#link(<verify-installation>)[下个章节].
] else { todo }
