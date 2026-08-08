#import "../config.typ": *

#h1(offset: whole,
  if lang in ("en", "de") [Hardware]
  else if lang == "ja" [ハードウェア]
  else if lang == "zh" [硬件]
  else { todo })
<getting-started-hardware>

#if lang == "en" [
  By now you should be somewhat familiar with the tooling and the
  development process. In this section we'll switch to real hardware; the
  process will remain largely the same. Let's dive in.
] else if lang == "de" [
  Mittlerweile sollten Sie mit den Werkzeugen und dem Entwicklungsprozess
  einigermaßen vertraut sein. In diesem Abschnitt wechseln wir zur echten
  Hardware; der Prozess bleibt im Großen und Ganzen gleich. Tauchen wir ein.
] else if lang == "ja" [
  ここまでで、ツールと開発プロセスにある程度慣れたはずです。このセクションでは、実際のハードウェアに切り替えます。
  開発プロセスは、ほとんど同じままです。飛び込みましょう。
] else if lang == "zh" [
  现在你应该有点熟悉工具和开发过程了。在这部分我们将切换到真正的硬件上；步骤非常相似。让我们深入下去。
] else { todo }

= #(if lang == "en" [Know your hardware]
  else if lang == "de" [Kennen Sie Ihre Hardware]
  else if lang == "ja" [ハードウェアを知る]
  else if lang == "zh" [认识你的硬件]
  else { todo })

#if lang == "en" [
  Before we begin you need to identify some characteristics of the target
  device as these will be used to configure the project:
  - The ARM core. e.g.~Cortex-M3.
  - Does the ARM core include an FPU? Cortex-M4#[*F*] and
    Cortex-M7#[*F*] cores do.
  - How much Flash memory and RAM does the target device have? e.g.~256
    KiB of Flash and 32 KiB of RAM.
  - Where are Flash memory and RAM mapped in the address space? e.g.~RAM
    is commonly located at address `0x2000_0000`.
] else if lang == "de" [
  Bevor wir beginnen, müssen Sie einige Eigenschaften des Zielgeräts
  identifizieren da diese zur Konfiguration des Projekts verwendet werden:
  - Der ARM-Kern, z.B. Cortex-M3.
  - Enthält der ARM-Kern eine FPU? Cortex-M4#[*F*] und
    Cortex-M7#[*F*]-Kerne tun dies.
  - Wie viel Flash-Speicher und RAM hat das Zielgerät? z.B. 256 KiB von
    Flash und 32 KiB RAM.
  - Wo werden Flash-Speicher und RAM im Adressraum abgebildet? zB RAM ist
    befindet sich üblicherweise an der Adresse `0x2000_0000`.
] else if lang == "ja" [
  始める前に、プロジェクトの設定に利用するターゲットデバイスのいくつかの特徴を確認する必要があります。
  - ARMコア、例えばCortex-M3です。
  - そのARMコアはFPUを搭載していますか？Cortex-M4#[*F*]とCortex-M7#[*F*]は、搭載しています。
  - ターゲットデバイスに搭載されているフラッシュメモリとRAMの容量はいくらですか？
    例えば、フラッシュは256KiBでRAMは32KiBです。
  - フラッシュメモリとRAMは、アドレス空間のどこにマッピングされていますか？
    例えば、RAMは、通常`0x2000_0000`番地に位置します。
] else if lang == "zh" [
  在我们开始之前，你需要了解下你的目标设备的一些特性，因为你将用它们来配置项目:
  - ARM 内核。比如 Cortex-M3 。
  - ARM 内核包括一个FPU吗?Cortex-M4#[*F*]和Cortex-M7#[*F*]有。
  - 目标设备有多少Flash和RAM？比如 256KiB的Flash和32KiB的RAM。
  - Flash和RAM映射在地址空间的什么位置?比如 RAM通常位于 `0x2000_0000` 地址处。
] else { todo }

#if lang == "en" [
  You can find this information in the data sheet or the reference manual
  of your device.
] else if lang == "de" [
  Diese Informationen finden Sie im Datenblatt oder im Referenzhandbuch
  Ihres/Ihrer Microcontrollers/Microcontrollerplatine.
] else if lang == "ja" [
  これらの情報は、デバイスのデータシートかリファレンスマニュアルに掲載されています。
] else if lang == "zh" [
  你可以在你的设备的数据手册和参考手册上找到这些信息。
] else { todo }

#if lang == "en" [
  In this section we'll be using our reference hardware, the
  STM32F3DISCOVERY. This board contains an STM32F303VCT6 microcontroller.
  This microcontroller has:
  - A Cortex-M4F core that includes a single precision FPU
  - 256 KiB of Flash located at address 0x0800_0000.
  - 40 KiB of RAM located at address 0x2000_0000. (There's another RAM
    region but for simplicity we'll ignore it).
] else if lang == "de" [
  In diesem Abschnitt verwenden wir unsere Referenzhardware, die
  STM32F3DISCOVERY. Diese Platine enthält einen Mikrocontroller
  STM32F303VCT6. Dieser Mikrocontroller verfügt über:
  - Ein Cortex-M4F-Kern, der eine einzelne Präzisions-FPU enthält
  - 256 KiB Flash befinden sich an der Adresse 0x0800_0000.
  - 440 KiB RAM an der Adresse 0x2000_0000. (Es gibt noch eine weitere
    RAM-Region, aber der Einfachheit halber ignorieren wir das).
] else if lang == "ja" [
  このセクションでは、私たちのリファレンスハードウェアであるSTM32F3DISCOVERYを使用します。
  このボードは、STM32F303VCT6マイクロコントローラを1つ搭載しています。このマイクロコントローラは以下のものを持っています。
  - 単精度FPUを含むCortex-M4Fコアが1つ
  - 0x0800_0000番地に配置された256KiBのフラッシュメモリ
  - 0x2000_0000番地に配置された40KiBのRAM。（別のRAM領域もありますが、説明の簡単化のため、取り扱いません）
] else if lang == "zh" [
  这部分，要使用我们的参考硬件，STM32F3DISCOVERY。这个板子包含一个STM32F303VCT6微控制器。这个微控制器拥有:
  - 一个Cortex-M4F核心，它包含一个单精度FPU。
  - 位于 0x0800_0000 地址的256KiB的Flash。
  - 位于 0x2000_0000 地址的40KiB的RAM。(这里还有其它的RAM区域，但是为了方便起见，我们将忽略它)。
] else { todo }

= #(if lang == "en" [Configuring]
  else if lang == "de" [Konfigurieren]
  else if lang == "ja" [設定]
  else if lang == "zh" [配置]
  else { todo })

#if lang == "en" [
  We'll start from scratch with a fresh template instance. Refer to the
  #link( <getting-started-qemu>)[previous section on QEMU] for a refresher on how to do this without `cargo-generate`.
] else if lang == "de" [
  Wir beginnen bei Null mit einer neuen Vorlageninstanz. Zur Auffrischung
  siehe #link(<getting-started-qemu>)[vorheriger Abschnitt zu QEMU], wie man das ohne `cargo-generate` macht.
] else if lang == "ja" [
  テンプレートの新しいインスタンスを使って、スクラッチから書いていきましょう。
  `cargo-generate`を使用しない方法については、#link(<getting-started-qemu>)[前セクションのQEMU]を参照して下さい。
] else if lang == "zh" [
  我们将使用一个新的模板实例从零开始。对于新手，请参考#link(<getting-started-qemu>)[先前的QEMU]章节，了解如何在没有`cargo-generate`的情况下完成配置。
] else { todo }

```text
$ cargo generate --git https://github.com/rust-embedded/cortex-m-quickstart
 Project Name: app
 Creating project called `app`...
 Done! New project created /tmp/app

$ cd app
```

#if lang == "en" [
  Step number one is to set a default compilation target in `.cargo/config.toml`.
] else if lang == "de" [
  Schritt Nummer eins besteht darin, ein Standardkompilierungsziel in
  `.cargo/config.toml` festzulegen.
] else if lang == "ja" [
  第一ステップは、`.cargo/config`にデフォルトコンパイルターゲットを設定することです。
] else if lang == "zh" [
  第一步是在`.cargo/config.toml`中设置一个默认编译目标。
] else { todo }

```console
tail -n5 .cargo/config.toml
```

#if lang in ("en", "zh") [
  ```toml
  # Pick ONE of these compilation targets
  # target = "thumbv6m-none-eabi"    # Cortex-M0 and Cortex-M0+
  # target = "thumbv7m-none-eabi"    # Cortex-M3
  # target = "thumbv7em-none-eabi"   # Cortex-M4 and Cortex-M7 (no FPU)
  target = "thumbv7em-none-eabihf" # Cortex-M4F and Cortex-M7F (with FPU)
  ```
] else if lang == "de" [
  ```toml
  # Waehlen Sie EINES von diesen Kompilierungszielen aus
  # target = "thumbv6m-none-eabi"    # Cortex-M0 and Cortex-M0+
  # target = "thumbv7m-none-eabi"    # Cortex-M3
  # target = "thumbv7em-none-eabi"   # Cortex-M4 and Cortex-M7 (no FPU)
  target = "thumbv7em-none-eabihf" # Cortex-M4F and Cortex-M7F (with FPU)
  ```
] else if lang == "ja" [
  ```toml
  [build]
  # 以下のコンパイルターゲットから1つを選びます
  # target = "thumbv6m-none-eabi"    # Cortex-M0およびCortex-M0+
  # target = "thumbv7m-none-eabi"    # Cortex-M3
  # target = "thumbv7em-none-eabi"   # Cortex-M4およびCortex-M7 (no FPU)
  target = "thumbv7em-none-eabihf" # Cortex-M4FおよびCortex-M7F (with FPU)
  ```
] else { todo }

#if lang == "en" [
  We'll use `thumbv7em-none-eabihf` as that covers the Cortex-M4F core.
] else if lang == "de" [
  Wir verwenden `thumbv7em-none-eabihf`, da es den Cortex-M4F-Kern abdeckt.
] else if lang == "ja" [
  Cortex-M4Fコアを対象とするものとして、`thumbv7em-none-eabihf`を使います。
] else if lang == "zh" [
  我们将使用 `thumbv7em-none-eabihf`，因为它包括了Cortex-M4F内核． 
] else { todo }

#quote(block: true)[
#if lang == "en" [
  *NOTE*: As you may remember from the previous chapter, we have to
  install all targets and this is a new one. So don't forget to run the
  installation process `rustup target add thumbv7em-none-eabihf` for
  this target.
] else if lang == "de" [
  *HINWEIS*: Wie Sie sich vielleicht aus dem vorherigen
  Kapitel erinnern, müssen wir alle Ziele installieren, dies ist ein
  neues Ziel. Vergessen Sie also nicht, die Installationsprozess
  `rustup target add thumbv7em-none-eabihf` für dieses Ziel auszuführen.
] else if lang == "zh" [
  *注意*：你可能还记得先前的章节，我们必须要安装所有的目标平台，这个平台是一个新的．
  所以，不要忘了为这个平台运行安装步骤
  `rustup target add thumbv7em-none-eabihf` ．
] else { todo }
]

#if lang == "en" [
  The second step is to enter the memory region information into the `memory.x` file.
] else if lang == "de" [
  Der zweite Schritt besteht darin, die Speicherbereichsinformationen in die Datei `memory.x` einzugeben
] else if lang == "ja" [
  第二ステップは、`memory.x`ファイルにメモリ領域の情報を入力することです。
] else if lang == "zh" [
  第二步是将存储区域信息(memory region information)输入`memory.x`。
] else { todo }

```text
$ cat memory.x
/* Linker script for the STM32F303VCT6 */
MEMORY
{
  /* NOTE 1 K = 1 KiBi = 1024 bytes */
  FLASH : ORIGIN = 0x08000000, LENGTH = 256K
  RAM : ORIGIN = 0x20000000, LENGTH = 40K
}
```

#quote(block: true)[
#if lang == "en" [
  *NOTE*: If you for some reason changed the `memory.x` file after
  you had made the first build of a specific build target, then do
  `cargo clean` before `cargo build`, because `cargo build` may not track
  updates of `memory.x`.
] else if lang == "de" [
  *NOTE*: Wenn Sie aus irgendeinem Grund die Datei `memory.x`
  geändert haben, nachdem Sie den ersten Build für ein bestimmtes
  Build-Ziel erstellt haben, dann führen Sie `cargo clean` vor
  `cargo build` aus, da `cargo build` keine Änderungen von `memory.x` verfolgt.
] else if lang == "zh" [
  *注意*：如果你因为某些理由，在对某个编译目标首次编译后，改变了`memory.x`文件，需要在`cargo build`之前执行`cargo clean`。因为`cargo build`可能不会跟踪`memory.x`的更新。
] else { todo }
]

#if lang == "en" [
  We'll start with the hello example again, but first we have to make a
  small change.
] else if lang == "de" [
  Wir beginnen noch einmal mit dem Hallo-Beispiel, aber zuerst müssen wir
  eine kleine Änderung vornehmen.
] else if lang == "zh" [
  我们将再次使用hello示例作为开始，但是首先我们必须做一个小改变。
] else { todo }

#if lang == "en" [
  In `examples/hello.rs`, make sure the `debug::exit()` call is commented
  out or removed. It is used only for running in QEMU.
] else if lang == "de" [
  Stellen Sie in `examples/hello.rs`sicher, daß `debug::exit()` auskommentiert
  oder entfernt wurde. Es wird nur zum Ausführen in QEMU verwendet.
] else if lang == "ja" [
  `debug::exit()`の呼び出しが、コメントアウトされているか削除されていることを確認して下さい。
  これは、QEMUで実行する時のみ、使用します。
] else if lang == "zh" [
  在`examples/hello.rs`中，确保`debug::exit()`调用被注释掉了或者移除掉了。它只能用于在QEMU中运行的情况。
] else { todo }

#raw(block: true, lang: "rust",
"#[entry]
fn main() -> ! {
    hprintln!(\"Hello, world!\").unwrap();

    // " + if lang == "en" {
        "exit QEMU
    // NOTE do not run this on hardware; it can corrupt OpenOCD state
    // debug::exit(debug::EXIT_SUCCESS);"
      } else if lang == "de" {
        "exit QEMU
    // HINWEIS: Fuehren Sie dies nicht auf der Hardware aus; es kann den 
    //          OpenOCD-Zustand beschaedigen.
    // debug::exit(debug::EXIT_SUCCESS);"
      } else if lang == "ja" {
        "QEMUを終了する
    // 注記、ハードウェア上で実行しないで下さい。OpenOCDの状態を破壊する可能性があります。
    // debug::exit(debug::EXIT_SUCCESS);"
      } else if lang == "zh" {
        "退出 QEMU
    // 注意 不要在硬件上运行这个；它会打破OpenOCD的状态"
      } else { todos } + "

    loop {}
}
")

#if lang == "en" [
  You can now cross compile programs using `cargo build` and inspect the
  binaries using `cargo-binutils` as you did before. The `cortex-m-rt`
  crate handles all the magic required to get your chip running, as
  helpfully, pretty much all Cortex-M CPUs boot in the same fashion.
] else if lang == "de" [
  Sie können nun Programme mittels `cargo build` cross-kompilieren und die
  Binärdateien mit `cargo-binutils` untersuchen, genau wie zuvor. Das
  `cortex-m-rt`-Crate übernimmt die gesamte für den Betrieb des Chips
  erforderliche „Magie", da erfreulicherweise so gut wie alle
  Cortex-M-CPUs auf die gleiche Weise booten.
] else if lang == "ja" [
  これまでやってきた通り、`cargo build`でプログラムをクロスコンパイルし、
  `cargo-binutils`でバイナリを調べることができます。
  `cortex-m-rt`クレートは、チップを動作させるために必要な、全てのおまじないを処理します。
  便利なことに、ほとんど全てのCortex-M CPUが同じ方法で起動します。
] else if lang == "zh" [
  你可以像你之前做的一样，使用`cargo build`检查编译程序，使用`cargo-binutils`观察二进制项。`cortex-m-rt`库可以处理所有让芯片运行起来所需的魔法，几乎所有的Cortex-M
  CPUs都按同样的方式启动。
] else { todo }

```console
cargo build --example hello
```

= #(if lang == "en" [Debugging]
  else if lang == "de" [Fehlerbehebung (Debugging)]
  else if lang == "ja" [デバッグ]
  else if lang == "zh" [调试]
  else { todo })

#let url_dn = "https://github.com/rust-embedded/debugonomicon"
#if lang == "en" [
  Debugging will look a bit different. In fact, the first steps can look
  different depending on the target device. In this section we'll show the
  steps required to debug a program running on the STM32F3DISCOVERY. This
  is meant to serve as a reference; for device specific information about
  debugging check out #link(url_dn)[the Debugonomicon].
] else if lang == "de" [
  Das Debugging gestaltet sich etwas anders. Tatsächlich können sich
  bereits die ersten Schritte je nach Zielgerät unterscheiden. In diesem
  Abschnitt zeigen wir die Schritte, die zum Debuggen eines auf dem
  STM32F3DISCOVERY laufenden Programms erforderlich sind. Dies soll als
  Referenz dienen; für gerätespezifische Informationen zum Debugging
  konsultieren Sie bitte #link(url_dn)[das Debugonomicon].
] else if lang == "ja" [
  デバッグ方法は少し違います。実際、最初のステップは、ターゲットデバイスによって異なります。
  このセクションでは、STM32F3DISCOVERY上で実行しているプログラムをデバッグするために必要となる手順を説明します。
  これは、参考の役目を果たします。デバイス固有のデバッグ情報は、
  #link(url_dn)[the Debugonomicon]を参照して下さい。
] else if lang == "zh" [
  调试会看起来有点不一样。事实上，取决于不同的目标设备，第一步可能看起来不一样。在这个章节里，我们将展示，调试一个在STM32F3DISCOVERY上运行的程序，所需要的步骤。这作为一个参考。关于调试有关的设备特定的信息，可以看#link(url_dn)[the Debugonomicon]。
] else { todo }

#if lang == "en" [
  As before we'll do remote debugging and the client will be a GDB
  process. This time, however, the server will be OpenOCD.
] else if lang == "de" [
  Wie zuvor führen wir Remote-Debugging durch, wobei der Client ein
  GDB-Prozess ist. Diesmal ist der Server jedoch OpenOCD.
] else if lang == "ja" [
  以前と同様に、リモートデバッグを行います。クライアントがGDBプロセスであることも同様です。
  しかし、今回、サーバはOpenOCDになります。
] else if lang == "zh" [
  像之前一样，我们将进行远程调试，客户端将是一个GDB进程。不同的是，OpenOCD将是服务器。
] else { todo }

#if lang == "en" [
  As done during the #link(<verify-installation>)[verify] section
  connect the discovery board to your laptop / PC and check that the
  ST-LINK header is populated.
] else if lang == "de" [
  Verbinden Sie, wie im Abschnitt
  "#link(<verify-installation>)[Die Installation überprüfen]"
  beschrieben, das Discovery Board mit Ihrem Laptop/PC und prüfen Sie, ob
  der ST-LINK-Header ausgefüllt ist.
] else if lang == "ja" [
  #link(<verify-installation>)[インストールの確認]セクションでやったように、ノートPCまたはPCをdiscoveryボードに接続し、
  ST-LINKヘッダが設定されていることを確認して下さい。
] else if lang == "zh" [
  像是在#link(<verify-installation>)[安装验证]中做的那样，把你的笔记本/个人电脑和discovery开发板连接起来，检查ST-LINK的短路帽是否被安装了。
] else { todo }

#if lang == "en" [
  On a terminal run `openocd` to connect to the ST-LINK on the discovery
  board. Run this command from the root of the template; `openocd` will
  pick up the `openocd.cfg` file which indicates which interface file and
  target file to use.
] else if lang == "de" [
  Führen Sie in einem Terminal `openocd` aus, um eine Verbindung zum
  ST-LINK auf dem Discovery-Board herzustellen. Führen Sie diesen Befehl
  im Stammverzeichnis der Vorlage aus; `openocd` greift dabei auf die
  Datei `openocd.cfg` zu, in der festgelegt ist, welche Schnittstellen-
  und Zieldateien verwendet werden sollen.
] else if lang == "ja" [
  discoveryボードのST-LINKに接続するために、端末で`openocd`を実行して下さい。
  このコマンドは、テンプレートプロジェクトのルートディレクトリから実行して下さい。
  `openocd`は、どのインタフェースファイルとターゲットファイルを使うか、が記述されている`openocd.cfg`ファイルを見つけます。
] else if lang == "zh" [
  在一个终端上运行 `openocd` 连接到你的开发板上的 ST-LINK
  。从模板的根目录运行这个命令；`openocd` 将会选择 `openocd.cfg`
  文件，它指出了所使用的接口文件(interface file)和目标文件(target file)。
] else { todo }

```console
cat openocd.cfg
```

#if lang in ("en", "zh") [
  ```text
  # Sample OpenOCD configuration for the STM32F3DISCOVERY development board

  # Depending on the hardware revision you got you'll have to pick ONE of these
  # interfaces. At any time only one interface should be commented out.

  # Revision C (newer revision)
  source [find interface/stlink.cfg]

  # Revision A and B (older revisions)
  # source [find interface/stlink-v2.cfg]

  source [find target/stm32f3x.cfg]
  ```
] else if lang == "de" [
  ```text
  # Beispiel-OpenOCD-Konfiguration für das STM32F3DISCOVERY-Entwicklungsboard

  # Je nach der vorliegenden Hardware-Revision muessen Sie eine dieser 
  # Schnittstellen auswaehlen. Es sollte jeweils nur eine Schnittstelle 
  # auskommentiert sein.

  # Revision C (neuere Revision)
  source [find interface/stlink.cfg]

  # Revision A and B (aeltere Revisionen)
  # source [find interface/stlink-v2.cfg]

  source [find target/stm32f3x.cfg]
  ```
] else if lang == "ja" [
  ```text
  # STM32F3DISCOVERY開発ボード用のOpenOCD設定サンプル

  # 持っているハードウェアのリビジョンに応じて、これらのインタフェースのうち、1つを選んで下さい。
  # 常に、1つのインタフェースがコメントアウトされているべきです。

  # リビジョンC （新しいリビジョン）
  source [find interface/stlink-v2-1.cfg]

  # リビジョンAとB（古いリビジョン）
  # source [find interface/stlink-v2.cfg]

  source [find target/stm32f3x.cfg]
  ```
] else { todo }

#quote(block: true)[
#if lang == "en" [
  *NOTE*: If you found out that you have an older revision of the
  discovery board during the #link(<verify-installation>)[verify]
  section then you should modify the `openocd.cfg` file at this point to
  use `interface/stlink-v2.cfg`.
] else if lang == "de" [
  *HINWEIS* Falls Sie im Abschnitt
  "#link(<verify-installation>)[Die Installation überprüfen]"
  feststellen, dass Sie eine ältere Revision des Discovery-Boards
  besitzen, sollten Sie an dieser Stelle die Datei `openocd.cfg` so
  anpassen, dass `interface/stlink-v2.cfg` verwendet wird.
] else if lang == "ja" [
  *注記*
  #link(<verify-installation>)[インストールの確認]セクションで、古いバージョンのdiscoveryボードを持っていることが判明している場合、
  `interface/stlink-v2.cfg`を使うように`openocd.cfg`ファイルを修正する必要があります。
] else if lang == "zh" [
  *注意*
  如果你在#link(<verify-installation>)[安装验证]章节中，发现你的discovery开发板是一个更旧的版本，那么你应该修改你的
  `openocd.cfg` 文件，注释掉 `interface/stlink.cfg`，让它去使用
  `interface/stlink-v2.cfg` 。
] else { todo }
]

```text
$ openocd
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
Info : Target voltage: 2.913879
Info : stm32f3x.cpu: hardware has 6 breakpoints, 4 watchpoints
```

#if lang == "en" [
  On another terminal run GDB, also from the root of the template.
] else if lang == "de" [
  Starten Sie in einem weiteren Terminal GDB, ebenfalls vom
  Stammverzeichnis des Templates aus.
] else if lang == "ja" [
  別の端末で、GDBを実行します。こちらも、テンプレートプロジェクトのルートディレクトから実行して下さい。
] else { todo }

```text
gdb-multiarch -q target/thumbv7em-none-eabihf/debug/examples/hello
```

#if lang == "en" [
  *NOTE*: like before you might need another version of gdb instead
  of `gdb-multiarch` depending on which one you installed in the
  installation chapter. This could also be `arm-none-eabi-gdb` or just `gdb`.
] else if lang == "de" [
  *HINWEIS*: Wie bereits erwähnt, benötigen Sie möglicherweise
  anstelle von `gdb-multiarch` eine andere Version von gdb, je nachdem,
  welche Version Sie im Installationskapitel installiert haben. Dies
  könnte beispielsweise `arm-none-eabi-gdb` oder einfach `gdb` sein.
] else if lang == "zh" [
  *注意*:
  像之前一样，你可能需要另一个版本的gdb而不是`gdb-multiarch`，取决于你在之前的章节安装了什么工具。这也可能使用的是`arm-none-eabi-gdb`或者只是`gdb`
] else { todo }

#if lang == "en" [
  Next connect GDB to OpenOCD, which is waiting for a TCP connection on port 3333.
] else if lang == "de" [
  Verbinden Sie nun GDB mit OpenOCD, das auf eine TCP-Verbindung an Port 3333 wartet.
] else if lang == "ja" [
  次に、TCP 3333ポートで接続待ちしているOpenOCDに、GDBを接続します。
] else if lang == "zh" [
  接下来把GDB连接到OpenOCD，它正在等待一个在端口3333上的TCP链接。
] else { todo }

```console
(gdb) target remote :3333
Remote debugging using :3333
0x00000000 in ?? ()
```

#if lang == "en" [
  Now proceed to _flash_ (load) the program onto the microcontroller
  using the `load` command.
] else if lang == "de" [
  Fahren Sie nun damit fort, das Programm mithilfe des Befehls `load` auf
  den Mikrocontroller zu _flashen_ (zu laden).
] else if lang == "ja" [
  それでは、`load`コマンドを使って、マイクロコントローラにプログラムを_書き込んで_下さい。
] else if lang == "zh" [
  接下来使用`load`命令，继续 _flash_(加载) 程序到微控制器上。
] else { todo }

```console
(gdb) load
Loading section .vector_table, size 0x400 lma 0x8000000
Loading section .text, size 0x1518 lma 0x8000400
Loading section .rodata, size 0x414 lma 0x8001918
Start address 0x08000400, load size 7468
Transfer rate: 13 KB/sec, 2489 bytes/write.
```

#if lang == "en" [
  The program is now loaded. This program uses semihosting so before we do
  any semihosting call we have to tell OpenOCD to enable semihosting. You
  can send commands to OpenOCD using the `monitor` command.
] else if lang == "de" [
  Das Programm ist nun geladen. Da dieses Programm Semihosting verwendet,
  müssen wir OpenOCD anweisen, Semihosting zu aktivieren, bevor wir einen
  entsprechenden Aufruf tätigen. Befehle können mithilfe des Befehls
  `monitor` an OpenOCD gesendet werden.
] else if lang == "ja" [
  プログラムがロードされました。このプログラムはセミホスティングを使用します。そこで、
  セミホスティングを呼び出して何かを行う前に、OpenOCDにセミホスティングを有効にするように、
  指示する必要があります。
] else if lang == "zh" [
  程序现在被加载了。这个程序使用半主机模式，因此在我们调用半主机模式之前，我们必须告诉OpenOCD使能半主机。你可以使用
  `monitor` 命令，发送命令给OpenOCD 。
] else { todo }

```console
(gdb) monitor arm semihosting enable
semihosting is enabled
```

#quote(block: true)[
#if lang == "en" [
  You can see all the OpenOCD commands by invoking the `monitor help` command.
] else if lang == "de" [
  Sie können sich alle OpenOCD-Befehle anzeigen lassen, indem Sie den
  Befehl `monitor help` aufrufen.
] else if lang == "ja" [
  `monitor help`コマンドを実行することで、全てのOpenOCDコマンドを見ることができます。
] else if lang == "zh" [
  通过调用 `monitor help` 命令，你能看到所有的OpenOCD命令。
] else { todo }
]

#if lang == "en" [
  Like before we can skip all the way to `main` using a breakpoint and the
  `continue` command.
] else if lang == "de" [
  Wie zuvor können wir mithilfe eines Breakpoints und des Befehls
  `continue` direkt zu `main` springen.
] else if lang == "ja" [
  以前のように、ブレイクポイントと`continue`コマンドを使用することで、`main`までスキップすることができます。
] else if lang == "zh" [
  像我们之前一样，使用一个断点和 `continue` 命令我们可以跳过所有的步骤到
  `main` 。
] else { todo }

```console
(gdb) break main
Breakpoint 1 at 0x8000490: file examples/hello.rs, line 11.
Note: automatically using hardware breakpoints for read-only addresses.

(gdb) continue
Continuing.

Breakpoint 1, hello::__cortex_m_rt_main_trampoline () at examples/hello.rs:11
11      #[entry]
```

#quote(block: true)[
#if lang == "en" [
  *NOTE* If GDB blocks the terminal instead of hitting the
  breakpoint after you issue the `continue` command above, you might want
  to double check that the memory region information in the `memory.x`
  file is correctly set up for your device (both the starts _and_ lengths).
] else if lang == "de" [
  *HINWEIS* Falls GDB das Terminal blockiert, anstatt am Haltepunkt
  (Breakpoint) anzuhalten, nachdem Sie den oben genannten Befehl
  `continue` eingegeben haben, sollten Sie überprüfen, ob die Angaben zum
  Speicherbereich in der Datei `memory.x` für Ihr Gerät korrekt
  konfiguriert sind (sowohl die Startadressen _als auch_ die Längen).
] else if lang == "zh" [
  *注意*
  如果在你使用了上面的`continue`命令后，GDB阻塞住了终端而不是停在了断点处，你可能需要检查下`memory.x`文件中的存储分区的信息，对于你的设备来说是否被正确的设置了起始位置*和*大小
。
] else { todo }
]

#if lang == "en" [
  Step into the main function with `step`.
] else if lang == "de" [
  Springen Sie mit `step` in die main-Funktion.
] else if lang == "zh" [
  使用`step`步进main函数里。
] else { todo }

```console
(gdb) step
halted: PC: 0x08000496
hello::__cortex_m_rt_main () at examples/hello.rs:13
13          hprintln!("Hello, world!").unwrap();
```

#if lang == "en" [
  After advancing the program with `next` you should see "Hello, world!"
  printed on the OpenOCD console, among other stuff.
] else if lang == "de" [
  Nachdem Sie das Programm mit `next` weitergeführt haben, sollten Sie
  unter anderem „Hello, world!" auf der OpenOCD-Konsole ausgegeben sehen.
] else if lang == "ja" [
  #todoupd("ja")
  この時点で、OpenOCDコンソールに、他のものと入り混じって「Hello,
  world!」と表示されるはずです。
] else if lang == "zh" [
  在使用了`next`让函数继续执行之后，你应该看到 "Hello, world!"
  被打印到了OpenOCD控制台上。
] else { todo }

```console
$ openocd
(..)
Info : halted: PC: 0x08000502
Hello, world!
Info : halted: PC: 0x080004ac
Info : halted: PC: 0x080004ae
Info : halted: PC: 0x080004b0
Info : halted: PC: 0x080004b4
Info : halted: PC: 0x080004b8
Info : halted: PC: 0x080004bc
```

#if lang == "en" [
  The message is only displayed once as the program is about to enter the
  infinite loop defined in line 19: `loop {}`
] else if lang == "de" [
  Die Meldung wird nur einmal angezeigt, kurz bevor das Programm in die in
  Zeile 19 definierte Endlosschleife eintritt: `loop {}`
] else if lang == "zh" [
  消息只打印一次，然后进入定义在19行的无限循环中: `loop {}`
] else { todo }

#if lang == "en" [
  You can now exit GDB using the `quit` command.
] else if lang == "de" [
  Sie können GDB nun mit dem Befehl `quit` beenden.
] else if lang == "zh" [
  使用 `quit` 命令，你现在可以退出 GDB 了。
] else { todo }

```console
(gdb) quit
A debugging session is active.

        Inferior 1 [Remote target] will be detached.

Quit anyway? (y or n)
```

#if lang == "en" [
  Debugging now requires a few more steps so we have packed all those
  steps into a single GDB script named `openocd.gdb`. The file was created
  during the `cargo generate` step, and should work without any
  modifications. Let's have a peek:
] else if lang == "de" [
  Das Debugging erfordert nun einige zusätzliche Schritte; daher haben wir
  all diese Schritte in einem einzigen GDB-Skript namens `openocd.gdb`
  zusammengefasst. Die Datei wurde während des Schritts `cargo generate`
  erstellt und sollte ohne Änderungen funktionieren. Werfen wir einen Blick darauf:
] else if lang == "zh" [
  现在调试比之前多了点步骤，因此我们要把所有步骤打包进一个名为
  `openocd.gdb` 的GDB脚本中。这个文件在 `cargo generate`
  步骤中被生成，因此不需要任何修改了。让我们看一下:
] else { todo }

```console
cat openocd.gdb
```

```text
target extended-remote :3333

# print demangled symbols
set print asm-demangle on

# detect unhandled exceptions, hard faults and panics
break DefaultHandler
break HardFault
break rust_begin_unwind

monitor arm semihosting enable

load

# start the process but immediately halt the processor
stepi
```
#let cmd_gdb_hello = `<gdb> -x openocd.gdb target/thumbv7em-none-eabihf/debug/examples/hello`
#if lang == "en" [
  Now running #cmd_gdb_hello
  will immediately connect GDB to OpenOCD, enable semihosting, load the
  program and start the process.
] else if lang == "de" [
  Wenn Sie nun den Befehl #cmd_gdb_hello
  ausführen, verbindet sich GDB sofort mit OpenOCD, aktiviert Semihosting,
  lädt das Programm und startet den Prozess.
] else if lang == "ja" [
  #cmd_gdb_hello;を実行することで、GDBはすぐにOpenOCDに接続し、
  セミホスティングを有効化し、プログラムをロードした上で、プロセスを開始します。
] else if lang == "zh" [
  现在运行 #cmd_gdb_hello
  将会立即把GDB和OpenOCD连接起来，使能半主机，加载程序和启动进程。
] else { todo }

#if lang == "en" [
  Alternatively, you can turn `<gdb> -x openocd.gdb` into a custom runner
  to make `cargo run` build a program _and_ start a GDB session. This
  runner is included in `.cargo/config.toml` but it's commented out.
] else if lang == "de" [
  Alternativ können Sie `<gdb> -x openocd.gdb` als benutzerdefinierten
  Runner einrichten, sodass `cargo run` das Programm baut _und_ eine
  GDB-Sitzung startet. Dieser Runner ist bereits in der Datei
  `.cargo/config.toml` enthalten, jedoch auskommentiert.
] else if lang == "ja" [
  別の方法として、`<gdb> -x openocd.gdb`をカスタムランナーにして、`cargo run`でプログラムをビルドし、
  _さらに_GDBセッションを開始することもできます。このランナーは、`.cargo/config`に含まれていますが、
  コメントアウトされています。
] else if lang == "zh" [
  另外，你能将 `<gdb> -x openocd.gdb` 放进一个自定义的 runner 中，使
  `cargo run` 能编译程序并启动一个GDB会话。这个 runner 在
  `.cargo/config.toml` 中，但是它被注释掉了。
] else { todo }

```console
head -n10 .cargo/config.toml
```

#raw(block: true, lang: "toml",
"[target.thumbv7m-none-eabi]
# " + if lang in ("en", "zh") {
    "uncomment this to make `cargo run` execute programs on QEMU"
  } else if lang == "de" {
    "Dies auskommentieren, damit `cargo run` Programme auf QEMU ausfuehrt."
  } else if lang == "ja" {
    "ここのコメントアウトを外すと、`cargo run`はQEMUでプログラムを実行します"
  } else { todos } + "
# runner = \"qemu-system-arm -cpu cortex-m3 -machine lm3s6965evb -nographic -semihosting-config enable=on,target=native -kernel\"

[target.'cfg(all(target_arch = \"arm\", target_os = \"none\"))']
# " + if lang in ("en", "zh") {
    "uncomment ONE of these three option to make `cargo run` start a GDB session
# which option to pick depends on your system"
  } else if lang == "de" {
    "Heben Sie die Auskommentierung einer dieser drei Optionen auf, damit 
  # `cargo run` eine GDB-Sitzung startet.
# Welche Option Sie waehlen sollten, haengt von Ihrem System ab."
  } else if lang == "ja" {
    "3つの選択肢のうち、1つのコメントアウトを外すと、`cargo run`はGDBセッションを開始します。
# どの選択肢を使うか、は対象システムによって異なります。"
  } else { todos } + "
runner = \"arm-none-eabi-gdb -x openocd.gdb\"
# runner = \"gdb-multiarch -x openocd.gdb\"
# runner = \"gdb -x openocd.gdb\"
")

```text
$ cargo run --example hello
(..)
Loading section .vector_table, size 0x400 lma 0x8000000
Loading section .text, size 0x1e70 lma 0x8000400
Loading section .rodata, size 0x61c lma 0x8002270
Start address 0x800144e, load size 10380
Transfer rate: 17 KB/sec, 3460 bytes/write.
(gdb)
```
