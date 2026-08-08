#import "../../config.typ": *

#h1(offset: whole*2,
  if lang == "en" [Verify Installation]
  else if lang == "de" [Die Installation überprüfen]
  else if lang == "ja" [インストールの確認]
  else if lang == "zh" [安装验证]
  else { todo })
<verify-installation>

#if lang == "en" [
  In this section we check that some of the required tools / drivers have
  been correctly installed and configured.
] else if lang == "de" [
  In diesem Abschnitt überprüfen wir, ob einige der erforderlichen
  Werkzeuge bzw. Treiber korrekt installiert und konfiguriert wurden.
] else if lang == "ja" [
  このセクションでは、必要となるツールとドライバが正しくインストールされ、設定されていることを確認します。
] else if lang == "zh" [
  在这个章节中我们将检查工具和驱动是否已经被正确地安装和配置了。
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
] else if lang == "ja" [
  マイクロUSBケーブルを使って、ノートPC /
  PCをdiscoveryボードに接続して下さい。
  discoveryボードは2つのUSBコネクタを搭載しています。
  ボード端の中央にある"USB ST-LINK"とラベルが付いたものを使用して下さい。
] else if lang == "zh" [
  使用一个micro USB线缆将你的笔记本/个人电脑连接到discovery开发板上。discovery开发板有两个USB连接器；使用标记着"USB ST-LINK"的那个，它位于开发板边缘的中间位置。
] else { todo }

#if lang == "en" [
  Also check that the ST-LINK header is populated. See the picture below;
  the ST-LINK header is highlighted.
] else if lang == "de" [
  Überprüfen Sie außerdem, ob die ST-LINK-Stiftleiste bestückt ist. Siehe
  dazu die Abbildung unten; die ST-LINK-Stiftleiste ist dort hervorgehoben.
] else if lang == "ja" [
  ST-LINKヘッダが装着されていることも確認します。下の写真の赤丸で囲った部分がST-LINKヘッダです。
] else if lang == "zh" [
  也要检查下ST-LINK的短路帽是否被安装了。看下面的图；ST-LINK短路帽用红色圈起来了。
] else { todo }

#if lang == "en" [
  Now run the following command:
] else if lang == "de" [
  Führen Sie nun den folgenden Befehl aus:
] else if lang == "ja" [
  それでは、次のコマンドを実行して下さい。
] else if lang == "zh" [
  现在运行下面的命令:
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
] else if lang == "zh" [
  *注意*: 旧版的openocd, 包括从2017发布的0.10.0,
  不包含新的(且更适合的)`interface/stlink.cfg`文件；
  你需要使用`interface/stlink-v2.cfg` 或者 `interface/stlink-v2-1.cfg`。
] else { todo }
]

#if lang == "en" [
  You should get the following output and the program should block the
  console:
] else if lang == "de" [
  Sie sollten die folgende Ausgabe erhalten und das Programm sollte die
  Konsole blockieren:
] else if lang == "ja" [
  次の出力が得られ、プログラムはコンソールをブロックするはずです。
] else if lang == "zh" [
  你应该看到了下面的输出，且程序应该阻塞住了控制台:
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
] else if lang == "ja" [
  確認作業とは直接関係しませんが、ブレイクポイントとウォッチポイントに関する最後の行を取得したはずです。
  取得できた場合、OpenOCDプロセスを停止し、#link(<getting-started>)[次のセクション]へ進んで下さい。
] else if lang == "zh" [
  内容可能并不是一模一样，但是在最后一行，你应该看到了breakpoints和watchpoints，如果你看到了，那就终止OpenOCD进程然后进入#link(<getting-started>)[下个章节]
] else { todo }

#if lang == "en" [
  If you didn't get the "breakpoints" line then try one of the following
  commands.
] else if lang == "de" [
  Falls du die Zeile „breakpoints" nicht erhalten hast, versuche einen der
  folgenden Befehle.
] else if lang == "ja" [
  "breakpoints"の行が取得できなかった場合、次のコマンドを試してく下さい。
] else if lang == "zh" [
  如果你没看到"breakpoints"这行，尝试下下列命令中的某一个命令。
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
] else if lang == "ja" [
  このコマンドが機能した場合、古いハードウェアリビジョンのdiscoveryボードを入手したことを意味します。
  これは問題になりませんが、後で少し設定を変える必要があるので、そのことを覚えておいて下さい。
  #link(<getting-started>)[次のセクション]に進むことができます。
] else if lang == "zh" [
  如果这些命令的某条起作用了，那意味着你使用的discovery开发板是一个旧的版本。那也不成问题，但是你要记住这件事，因为随后你的配置可能有点不同。你可以移到#link(<getting-started>)[下个章节]了。
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
] else if lang == "ja" [
  どちらのコマンドも通常ユーザとしてうまく動かなかった場合、rootパーミッションで実行してみて下さい(例えば、`sudo openocd ..`)。
  コマンドがrootパーミッションで機能した場合、#link(<linux-udev-rules>)[udevルール]が正しく設定されているか確認して下さい。
] else if lang == "zh" [
  如果这些命令在普通用户模式下都没用，尝试下使用root模式运行它们(e.g.~`sudo openocd ..`)。如果命令在root模式下起作用，需要检查下#link(<linux-udev-rules>)[udev rules]是否被正确地设置了。
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
] else if lang == "ja" [
  ここまで到着していまい、OpenOCDが動いていないならば、#link(url_issues)[issue]を作って下さい。私たちがあなたを支援します。
] else if lang == "zh" [
  如果这些都试了，OpenOCD还不工作，请打开一个#link(url_issues)[issue]，我们将帮助你！
] else { todo }
