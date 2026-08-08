#import "../config.typ": *

#h1(if lang == "en" [Introduction]
  else if lang == "de" [Einleitung]
  else if lang == "ja" [導入]
  else if lang == "uk" [Вступ]
  else if lang == "zh" [引言]
  else { todo })
#set heading(offset: whole*2)

#if lang == "en" [
  Welcome to The Embedded Rust Book: An introductory book about using
  the Rust Programming Language on "Bare Metal" embedded systems, such as Microcontrollers.
] else if lang == "de" [
  Willkommen bei „Das Embedded-Rust Buch“ – einem Einführungswerk zur Verwendung
  der Programmiersprache Rust auf „Bare-Metal“-Embedded-Systemen, wie etwa Mikrocontrollern.
] else if lang == "ja" [
  _The Embedded Rust
  Book_へようこそ。Rustをマイクロコントローラのような、「ベアメタル」の組込みシステムで使うための入門書です。
] else if lang == "uk" [
  Ласкаво просимо до The Embedded Rust Book: ознайомчої книги про використання
  мови програмування Rust у вбудованих "Bare Metal" системах, таких як мікроконтролери.
] else if lang == "zh" [
  欢迎阅读嵌入式Rust:一本关于如何在裸机(比如，微处理器)上使用Rust编程语言的入门书籍。
] else { todo }

= #(if lang == "en" [Who Embedded Rust is For]
  else if lang == "de" [Für wen Embedded-Rust geeignet ist]
  else if lang == "ja" [組込みRustは誰のためのもの]
  else if lang == "uk" [Для кого Вбудований Rust]
  else if lang == "zh" [嵌入式Rust是为谁准备的]
  else { todo })

#let url_rustbook = "https://doc.rust-lang.org/book/ch00-00-introduction.html"
#if lang == "en" [
  Embedded Rust is for everyone who wants to do embedded programming while
  taking advantage of the higher-level concepts and safety guarantees the
  Rust language provides. (See also
  #link(url_rustbook)[Who Rust Is For])
] else if lang == "de" [
  Embedded-Rust ist für alle, die eingebettete Systeme programmieren und
  dabei die Vorteile der fortgeschrittenen Konzepte und
  Sicherheitsgarantien der Rust-Sprache nutzen möchten.

  (Siehe auch
  #link(url_rustbook)[Für wen ist Rust geeignet?])
] else if lang == "ja" [
  組込みRustは、Rustの高い抽象度と安全性のもと、組込みプログラミングをしたい人のためのものです。
  (#url_rustbook)[Rustは誰のためのもの]も合わせて見て下さい)
] else if lang == "uk" [
  Вбудований Rust для кожного, хто бажає програмувати вбудовані системи використовуючи
  переваги концепцій вищого рівня та гарантій безпеки, які надає мова Rust.
  (Дивіться також #link(url_rustbook)[Для кого Rust])
] else if lang == "zh" [
  嵌入式Rust是为了那些既想要进行嵌入式编程，又想要使用Rust语言所提供的高级概念和安全保障的人们而准备的(参见#link(url_rustbook)[Who Rust Is For])
] else { todo }

= #(if lang == "en" [Scope]
  else if lang == "de" [Umfang]
  else if lang == "ja" [スコープ]
  else if lang == "uk" [Область застосування]
  else if lang == "zh" [本书范围]
  else { todo })

#if lang == "en" [
  The goals of this book are:
  - Get developers up to speed with embedded Rust development.
    i.e.~How to et up a development environment.
  - Share _current_ best practices about using Rust for embedded
    development. i.e. How to best use Rust language features to write more
    correct embedded software.
  - Serve as a cookbook in some cases. e.g.~How do I mix C and Rust in a
    single project?
] else if lang == "de" [
  Die Ziele dieses Buches sind:
  - Machen Sie Entwickler mit der Embedded-Rust-Entwicklung vertraut --
    zum Beispiel damit, wie man eine Entwicklungsumgebung einrichtet.
  - Teilen Sie _aktuelle_ Best Practices für den Einsatz von Rust in
    der Embedded-Entwicklung -- zum Beispiel: Wie man Sprachfunktionen von
    Rust optimal nutzt, um korrektere Embedded-Software zu schreiben.
  - Dient in einigen Fällen als Kochbuch -- zum Beispiel: Wie kombiniere
    ich C und Rust in einem einzigen Projekt?
] else if lang == "ja" [
  この本の目的は、以下の通りです。
  - 組込みRustをできる限り速く開始できるようにします。すなわち、開発環境のセットアップ方法です。
  - 組込み開発におけるRustの_現在_のベストプラクティスを共有します。つまり、より正しい組込みソフトウェアを書くための、Rustの最善な利用方法です。
  - いくつかのケースに対するマニュアルを提供します。例えば、1つのプロジェクト内で、C言語とRustとを混在する方法です。
] else if lang == "uk" [
  Цілі цієї книги:
  - Надати розробникам швидкий доступ до розробки вбудованих систем на Rust.
    Тобто як налаштувати середовище розробки.
  - Поділіться найкращими _сучасними_ практиками використання Rust
    для розробки вбудованих систем. Тобто як найкраще використовувати можливості мови Rust
    для написання більш коректних вбудованих програм.
  - Cлугувати кулінарною книгою у деяких випадках. Наприклад як поєднати C та Rust в одному проекті?
] else if lang == "zh" [
  这本书的目的是：
  - 让开发者快速上手Rust嵌入式开发，比如，如何设置一个开发环境。
  - 分享那些关于使用Rust进行嵌入式开发的，现存的，最好的实践经验，比如，如何最大程度上地利用好Rust语言的特性去写更正确的嵌入式软件
  - 某种程度下作为工具书，比如，如何在一个项目里将C和Rust混合在一起使用
] else { todo }

#if lang == "en" [
  This book tries to be as general as possible but to make things easier
  for both the readers and the writers it uses the ARM Cortex-M
  architecture in all its examples. However, the book doesn't assume that
  the reader is familiar with this particular architecture and explains
  details particular to this architecture where required.
] else if lang == "de" [
  Dieses Buch ist bestrebt, so allgemein wie möglich zu bleiben; um jedoch
  sowohl den Lesern als auch den Autoren die Arbeit zu erleichtern,
  verwendet es in allen Beispielen die ARM-Cortex-M-Architektur. Dennoch
  setzt das Buch keine Vorkenntnisse zu dieser speziellen Architektur
  voraus und erläutert die entsprechenden Besonderheiten, wo immer dies
  erforderlich ist.
] else if lang == "ja" [
  本書は出来る限り一般的な事項を取り扱います。ただし、説明を簡単にするために、全ての例で、ARM
  Cortex-Mアーキテクチャを利用します。
  読者は、このアーキテクチャに詳しい必要はありません。本書では、アーキテクチャ固有の詳細について、必要に応じて説明をします。
] else if lang == "uk" [
  Ця книга намагається бути якомога більш загальною, але щоб полегшити роботу
  як читачам, так і авторам, у ній використовується архітектура ARM Cortex-M у всіх її прикладах.
  Однак книга не передбачає, що читач знайомий із цією конкретною архітектурою,
  і пояснює деталі, пов’язані з цією архітектурою, де потрібно.
] else if lang == "zh" [
  虽然尽可能地尝试让这本书可以用于大多数场景，但是为了使读者和作者更容易理解，在所有的示例中，这本书都使用了ARM
  Cortex-M架构。然而，这本书并不需要读者熟悉这个架构，书中会在需要时对这个架构的特定细节进行解释。
] else { todo }

= #(if lang == "en" [Who This Book is For]
  else if lang == "de" [Für wen dieses Buch gedacht ist]
  else if lang == "ja" [この本は誰のためのもの]
  else if lang == "uk" [Для кого Ця Книга]
  else if lang == "zh" [这本书是为谁准备的]
  else { todo })

#if lang == "en" [
  This book caters towards people with either some embedded background or
  some Rust background, however we believe everybody curious about
  embedded Rust programming can get something out of this book. For those
  without any prior knowledge we suggest you read the "Assumptions and
  Prerequisites" section and catch up on missing knowledge to get more out
  of the book and improve your reading experience. You can check out the
  "Other Resources" section to find resources on topics you might want to
  catch up on.
] else if lang == "de" [
  Dieses Buch richtet sich an Personen mit Vorkenntnissen im Bereich
  Embedded-Systeme oder Rust; wir sind jedoch der Meinung, dass jeder, der
  sich für die Embedded-Programmierung mit Rust interessiert, von diesem
  Buch profitieren kann. Wer keine Vorkenntnisse mitbringt, dem empfehlen
  wir, den Abschnitt „Annahmen und Voraussetzungen" zu lesen und sich
  entsprechendes Wissen anzueignen, um den größtmöglichen Nutzen aus dem
  Buch zu ziehen und das Leseerlebnis zu verbessern. Im Abschnitt „Weitere
  Ressourcen" finden Sie Hinweise zu Themen, in die Sie sich bei Bedarf
  einarbeiten können.
] else if lang == "ja" [
  本書は、組込み開発か、Rustかのバックグラウンドを持つ人々に向けたものです。しかし、組込みRustに興味がある人なら、誰でも、この本から何かを得られると思います。本書による学習効果を高めるために、事前知識が不足している読者は、「仮定と前提条件」のセクションを読み、不足している知識を補うことをお勧めします。不足知識を補うリソースを見つけるために、「その他のリソース」セクションをチェックすることができます。
] else if lang == "uk" [
  Ця книга розрахована на людей, які мають досвід роботи з вбудованими програмами або з Rust,
  але ми віримо, що всі, хто цікавиться програмуванням у вбудованому Rust, можуть щось отримати з цієї книги.
  Для тих, хто не має попередніх знань, ми пропонуємо прочитати розділ «Припущення та передумови»
  та надолужити пропущені знання, щоб отримати більше від книги та покращити свій досвід читання.
  Ви можете переглянути розділ «Інші ресурси», щоб знайти ресурси на теми, які, можливо, захочете надолужити.
] else if lang == "zh" [
  这本书适合那些有一些嵌入式背景或者有Rust背景的人，然而我相信每一个对Rust嵌入式编程好奇的人都能从这本书中获得某些收获。对于那些先前没有任何经验的人，我们建议你读一下"要求和预备知识"部分。从其它资料中获取、补充缺失的知识，这样能提高你的阅读体验。你可以看看"其它资源"部分，以找到你感兴趣的那些主题的资源。
] else { todo }

== #(if lang == "en" [Assumptions and Prerequisites]
  else if lang == "de" [Annahmen und Voraussetzungen]
  else if lang == "ja" [仮定と前提条件]
  else if lang == "uk" [Припущення та передумови]
  else if lang == "zh" [要求和预备知识]
  else { todo })

#let url_ediion = "https://doc.rust-lang.org/edition-guide/"
#if lang == "en" [
  - You are comfortable using the Rust Programming Language, and have
    written, run, and debugged Rust applications on a desktop environment.
    You should also be familiar with the idioms of the
    #link(url_ediion)[2018 edition] as
    this book targets Rust 2018.

  - You are comfortable developing and debugging embedded systems in
    another language such as C, C++, or Ada, and are familiar with
    concepts such as:
    - Cross Compilation
    - Memory Mapped Peripherals
    - Interrupts
    - Common interfaces such as I2C, SPI, Serial, etc.
] else if lang == "de" [
  - Sie sind sicher im Umgang mit der Programmiersprache Rust und haben
    bereits Rust-Anwendungen in einer Desktop-Umgebung geschrieben,
    ausgeführt und deren Fehler behoben. Zudem sollten Sie mit den Idiomen
    der #link(url_ediion)[2018 Edition]
    vertraut sein, da sich dieses Buch auf Rust 2018 konzentriert.

  - Sie sind sicher in der Entwicklung und Fehlersuche bei
    Embedded-Systemen in einer anderen Sprache wie C, C++ oder Ada und mit
    Konzepten vertraut wie:
    - Cross-Kompilierung
    - Im Speicher abgebildete Peripheriegeräte
    - Interrupts
    - Gängige Schnittstellen wie I2C, SPI, seriell usw.
] else if lang == "ja" [
  - Rustでのプログラミングを楽しんでおり、デスクトップ環境でRustアプリケーションを書いたり、実行したり、デバッグしたりしたことがあることを前提とします。また、本書ではRust
    2018を対象とするため、2018
    editionのイディオムに慣れ親しんでいる必要があります。
  - C, C++,
    Adaといった言語で組込みシステムを開発、デバッグすることに慣れており、次の概念になじみがあることを想定します。
    - クロスコンパイル
    - メモリマップ方式のペリフェラル
    - 割り込み
    - I2C、SPI、シリアルといった一般的なインタフェース
] else if lang == "uk" [
  - Вам зручно користуватися мовою програмування Rust і ви вже писали,
    запускали та налагоджували програми Rust у середовищі робочого столу.
    Ви також повинні бути знайомі з ідіомами #link(url_ediion)[2018 Edition], оскільки ця книга спрямована на Rust 2018.
  - Вам зручно розробляти та налагоджувати вбудовані системи іншою
    мовою, наприклад C, C++ або Ada, і ви знайомі з такими поняттями, як:
    - Крос-компіляція
    - Периферійні пристрої з відображенням у пам'яті
    - Переривання
    - Загальні інтерфейси, такі як I2C, SPI, Serial тощо.
] else if lang == "zh" [
  - 你可以轻松地使用Rust编程语言，且在一个桌面环境上写过，运行过，调试过Rust应用。你应该也要熟悉#link(url_ediion)[2018 edition]的术语，因为这本书是面向Rust
  2018的。

  - 你可以轻松地使用其它语言，比如C，C++或者Ada，开发和调试嵌入式系统，且熟悉如下的概念：
    - 交叉编译
    - 存储映射的外设（Memory Mapped Peripherals）
    - 中断
    - I2C，SPI，串口等等常见的接口
] else { todo }

== #(if lang == "en" [Other Resources]
  else if lang == "de" [Weitere Ressourcen]
  else if lang == "ja" [その他のリソース]
  else if lang == "uk" [Інші ресурси]
  else if lang == "zh" [其它资源]
  else { todo })

#if lang == "en" [
  If you are unfamiliar with anything mentioned above or if you want more
  information about a specific topic mentioned in this book you might find
  some of these resources helpful.
] else if lang == "de" [
  Falls Ihnen einer der oben genannten Punkte nicht vertraut ist oder Sie
  mehr über ein bestimmtes, in diesem Buch erwähntes Thema erfahren
  möchten, könnten einige dieser Ressourcen hilfreich für Sie sein.
] else if lang == "ja" [
  もしあなたが上述した何らかの事項をよく知らない場合、もしくは、本書内の特定トピックに関して、より詳細な情報を知りたい場合、これらのリソースが役に立つでしょう。
] else if lang == "uk" [
  Якщо ви не знайомі з чимось із згаданого вище або вам потрібна додаткова інформація про конкретну тему, згадану в цій книзі, деякі з цих ресурсів можуть стати в нагоді.
] else if lang == "zh" [
  如果你还不熟悉上面提到的东西或者你对这本书中提到的某个特定主题感兴趣，你也许能从这些资源中找到有用的信息。
] else { todo }

#figure(
  kind: table,
  table(
    columns: (37.84%, 27.03%, 35.14%),
    align: (center,left,left,),
    table.header(
      if lang == "en" [Topic]
      else if lang == "de" [Thema]
      else if lang == "ja" [トピック]
      else if lang == "zh" [主题]
      else { todo },
      if lang == "en" [Resource]
      else if lang == "de" [Ressource]
      else if lang == "ja" [リソース]
      else if lang == "zh" [资源]
      else { todo },
      if lang == "en" [Description]
      else if lang == "de" [Beschreibung]
      else if lang == "ja" [説明]
      else if lang == "zh" [描述]
      else { todo }
    ),
    [Rust],
    link("https://doc.rust-lang.org/book/")[Rust Book],
    if lang == "en" [
      If you are not yet comfortable with Rust, we highly suggest reading this book.
    ] else if lang == "de" [
      Wenn Sie sich mit Rust noch nicht sicher fühlen,
      empfehlen wir Ihnen dringend, dieses Buch zu lesen.
    ] else if lang == "ja" [
      もしRustに親しんでいない場合、この本を読むことを強くお勧めします。
    ] else if lang == "zh" [
      如果你还不熟悉Rust，我们强烈建议你读这本书．
    ] else { todo },

    [Rust, Embedded],
    link("https://docs.rust-embedded.org/discovery/")[Discovery Book],
    if lang == "en" [
      If you have never done any embedded programming, this book might be a better start
    ] else if lang == "de" [
      Wenn Sie sich noch nie mit eingebetteter Programmierung beschäftigt haben,
      ist dieses Buch möglicherweise der bessere Einstieg
    ] else if lang == "zh" [
      如果你从没做过嵌入式编程，这本书可能是个更好的开端．
    ] else { todo },

    [Rust, Embedded], link("https://docs.rust-embedded.org")[Embedded Rust Bookshelf],
    if lang == "en" [
      Here you can find several other resources provided by Rust's Embedded Working Group.
    ] else if lang == "de" [
      Hier finden Sie weitere Ressourcen, die von der Embedded Working Group
      von Rust bereitgestellt werden.
    ] else if lang == "ja" [
      Rust組込みワーキンググループによるいくらかのリソースがあります。
    ] else if lang == "zh" [
      在这里，你可以找到由Rust的嵌入式工作组提供的许多其它资源．
    ] else { todo },

    [Rust, Embedded],
    link("https://docs.rust-embedded.org/embedonomicon/")[Embedonomicon],
    if lang == "en" [
      The nitty gritty details when doing embedded programming in Rust.
    ] else if lang == "de" [
      Die Feinheiten der Embedded-Programmierung mit Rust.
    ] else if lang == "ja" [
      Rustで組込みプログラミングを行うときのより深い詳細が記載されています。
    ] else if lang == "zh" [
      用Rust进行嵌入式编程的细节．
    ] else { todo },
  
    [Rust, Embedded],
    link("https://docs.rust-embedded.org/faq.html")[embedded FAQ],
    if lang == "en" [
      Frequently asked questions about Rust in an embedded context.
    ] else if lang == "de" [
      Häufig gestellte Fragen zu Rust im Embedded-Umfeld.
    ] else if lang == "ja" [
      組込みでRustを使う際のよくある質問と回答です。
    ] else if lang == "zh" [
      Rust在嵌入式上下文中遇到的常见问题．
    ] else { todo },

    [Rust, Embedded],
    link("https://google.github.io/comprehensive-rust/bare-metal.html")[Comprehensive Rust 🦀: Bare Metal],
    if lang == "en" [
      Teaching material for a 4-day class on bare-metal Rust development
    ] else if lang == "de" [
      Unterrichtsmaterial für einen viertägigen Kurs zu Bare-Metal Rust development
    ] else if lang == "zh" [
      用于四天课时的裸机Rust开发课程的教学资料．
    ] else { todo },
  
    [Interrupts],
    link("https://en.wikipedia.org/wiki/Interrupt")[Interrupt],
    [-],

    [Memory-mapped IO/Peripherals],
    link("https://en.wikipedia.org/wiki/Memory-mapped_I/O")[Memory-mapped I/O],
    [-],

    [SPI, UART, RS232, USB, I2C, TTL],
    link("https://electronics.stackexchange.com/questions/37814/usart-uart-rs232-usb-spi-i2c-ttl-etc-what-are-all-of-these-and-how-do-th")[Stack Exchange about SPI, UART, and other interfaces],
    [-],
  )
)

== #(if lang == "en" [Translations]
  else if lang == "de" [Übersetzungen]
  else if lang == "uk" [Переклади]
  else if lang == "zh" [翻译]
  else { todo })

#{
let jp_ln = "https://tomoyuki-nakabayashi.github.io/book/"
let jp_rep = "https://github.com/tomoyuki-nakabayashi/book"
let cn_ln = "https://xxchang.github.io/book/"
let cn_rep = "https://github.com/XxChang/book"
if lang == "en" [
  This book has been translated by generous volunteers. If you would like
  your translation listed here, please open a PR to add it.
  - #link(jp_ln)[Japanese] (#link(jp_rep)[repository])
  - #link(cn_ln)[Chinese] (#link(cn_rep)[repository])
] else if lang == "de" [
  Dieses Buch wurde von großzügigen Freiwilligen übersetzt. Wenn Ihre
  Übersetzung hier aufgeführt werden soll, erstellen Sie bitte einen Pull
  Request, um sie hinzuzufügen.
  - #link(jp_ln)[Japanisch] (#link(jp_rep)[repository])
  - #link(cn_ln)[Chinesisch] (#link(cn_rep)[repository])
] else if lang == "uk" [
  Цю книгу перекладено волонтерами.
  Якщо ви хочете, щоб ваш переклад був тут, будь ласка,
  відкрийте запит на злиття, щоб додати його.
  - #link(jp_ln)[Японською] (#link(jp_rep)[репозиторій])
  - #link(cn_ln)[Китайською] (#link(cn_rep)[репозиторій])
] else if lang == "zh" [
  这本书是已经被一些慷慨的志愿者们翻译了。如果你想要将你的翻译列在这里，请打开一个PR去添加它。
  - #link(jp_ln)[日文] (#link(jp_rep)[repository])
  - #link(cn_ln)[中文] (#link(cn_rep)[repository])
] else { todo }
}

== #(if lang == "en" [How to Use This Book]
  else if lang == "de" [Wie Sie dieses Buch nutzen]
  else if lang == "ja" [この本はどう使う]
  else if lang == "uk" [Як читати цю книгу]
  else if lang == "zh" [如何使用这本书]
  else { todo })

#if lang == "en" [
  This book generally assumes that you're reading it front-to-back. Later
  chapters build on concepts in earlier chapters, and earlier chapters may
  not dig into details on a topic, revisiting the topic in a later
  chapter.
] else if lang == "de" [
  Dieses Buch ist im Allgemeinen so konzipiert, dass es von Anfang bis
  Ende gelesen wird. Spätere Kapitel bauen auf den Konzepten früherer
  Kapitel auf; dabei werden bestimmte Themen in den früheren Kapiteln
  möglicherweise noch nicht bis ins Detail behandelt, sondern erst in
  einem späteren Kapitel erneut aufgegriffen.
] else if lang == "ja" [
  この本は、前から順番に読んでいくことを想定しています。後半の章は、前半の章で説明する概念に基づいて成り立っています。前半の章では、トピックの詳細に深入りせず、後半の章で再訪問します。
] else if lang == "uk" [
  Ця книга зазвичай передбачає, що ви читаєте її послідовно. Подальші
  розділи ґрунтуються на концепціях попередніх розділів, і попередні розділи можуть
  не заглиблюватися в деталі теми, повертаючись до неї в наступному розділі.
] else if lang == "zh" [
  这本书通常假设你是按顺序阅读的。之后的章节是建立在先前的章节中提到的概念之上的，先前章节可能不会深入一个主题的细节，因为在随后的章节将会再次重温这个主题。
] else { todo }

#let url_f3disco = "http://www.st.com/en/evaluation-tools/stm32f3discovery.html"
#if lang == "en" [
  This book will be using the #link(url_f3disco)[STM32F3DISCOVERY]
  development board from STMicroelectronics for the majority of the
  examples contained within. This board is based on the ARM Cortex-M
  architecture, and while basic functionality is the same across most CPUs
  based on this architecture, peripherals and other implementation details
  of Microcontrollers are different between different vendors, and often
  even different between Microcontroller families from the same vendor.
] else if lang == "de" [
  Für den Großteil der in diesem Buch enthaltenen Beispiele wird das
  Entwicklungsboard #link(url_f3disco)[STM32F3DISCOVERY]
  von STMicroelectronics verwendet. Dieses Board basiert auf der
  ARM-Cortex-M-Architektur. Zwar ist die grundlegende Funktionalität bei
  den meisten auf dieser Architektur basierenden CPUs identisch, doch
  unterscheiden sich Peripheriekomponenten und andere
  Implementierungsdetails der Mikrocontroller je nach Hersteller -- und
  oft sogar zwischen verschiedenen Mikrocontroller-Familien desselben
  Herstellers.
] else if lang == "ja" [
  この本は、ほとんどの例で、STマイクロエレクトロニクスの#link(url_f3disco)[STM32F3DISCOVERY]開発ボードを使用します。このボードは、ARM
  Cortex-Mアーキテクチャをベースとしています。基本機能はこのアーキテクチャベースのCPUでは共通です。一方、ペリフェラルとマイクロコントローラ実装の詳細は、他のベンダーと異なります。同じSTマイクロエレクトロニクスのマイクロコントローラファミリでも、違いがあります。
] else if lang == "uk" [
  Для більшості наведених у цій книзі прикладів використовуватиметься
  розробна плата #link(url_f3disco)[STM32F3DISCOVERY] від STMicroelectronics. Ця плата
  заснована на архітектурі ARM Cortex-M, і хоча основні функції однакові
  для більшості процесорів на основі цієї архітектури, периферійні пристрої та інші
  деталі реалізації відрізняються у мікроконтролерах різних постачальників,
  і часто навіть різняться між сімействами мікроконтролерів одного й того ж
  постачальника.
] else if lang == "zh" [
  在大多数示例中这本书将使用#link(url_f3disco)[STM32F3DISCOVERY]开发板。这个板子是基于ARM
  Cortex-M架构的，且基本功能与大多数基于这个架构的CPUs功能相似。微处理器的外设和其它实现细节在不同的厂家之间是不同的，甚至来自同一个厂家，不同处理器系列之间也是不同的。
] else { todo }

#if lang == "en" [
  For this reason, we suggest purchasing the
  #link(url_f3disco)[STM32F3DISCOVERY]
  development board for the purpose of following the examples in this
  book.
] else if lang == "de" [
  Aus diesem Grund empfehlen wir die Anschaffung des Entwicklungsboards
  #link(url_f3disco)[STM32F3DISCOVERY],
  um die Beispiele in diesem Buch praktisch nachvollziehen zu können.
] else if lang == "ja" [
  上記の理由から、本書内の例を理解するために、#link(url_f3disco)[STM32F3DISCOVERY]開発ボードを購入することをお勧めします。
] else if lang == "uk" [
  З цієї причини ми пропонуємо придбати плату розробки
  #link(url_f3disco)[STM32F3DISCOVERY] щоб повторювати приклади з цієї книги.
] else if lang == "zh" [
  因此我们建议购买#link(url_f3disco)[STM32F3DISCOVERY]开发板来尝试这本书中的例子。
] else { todo }

== #(if lang == "en" [Contributing to This Book]
  else if lang == "de" [Beiträge zu diesem Buch]
  else if lang == "uk" [Внесок у цю книгу]
  else if lang == "zh" [贡献]
  else { todo })

#let url_repo = "https://github.com/rust-embedded/book"
#let url_team = "https://github.com/rust-embedded/wg#the-resources-team"
#if lang == "en" [
  The work on this book is coordinated in #link(url_repo)[this repository]
  and is mainly developed by the #link(url_team)[resources team].
] else if lang == "de" [
  Die Arbeit an diesem Buch wird in #link(url_repo)[diesem Repository] koordiniert
  und hauptsächlich vom #link(url_team)[Ressourcen-Team] vorangetrieben.
] else if lang == "uk" [
  Робота над цією книгою координується в #link(url_repo)[цьому сховищі]
  і в основному розробляється #link(url_team)[командою ресурсів].
] else if lang == "zh" [
  这本书的工作主要在#link(url_repo)[这个仓库]里管理，且主要由#link(url_team)[resouces team]开发。
] else { todo }

#let url_issues = "https://github.com/rust-embedded/book/issues/"
#if lang == "en" [
  If you have trouble following the instructions in this book or find that
  some section of the book is not clear enough or hard to follow then
  that's a bug and it should be reported in #link(url_issues)[the issue tracker]
  of this book.
] else if lang == "de" [
  Wenn Sie Schwierigkeiten haben, den Anweisungen in diesem Buch zu
  folgen, oder wenn ein Abschnitt des Buches nicht klar genug oder schwer
  verständlich ist, handelt es sich um einen Fehler; dieser sollte im
  #link(url_issues)[Problem-Verfolgungswerkzeug]
  des Buches gemeldet werden.
] else if lang == "uk" [
  Якщо у вас виникли проблеми з дотриманням інструкцій з цієї книги
  або ви вважаєте, що якийсь розділ книги недостатньо зрозумілий
  або складний для виконання, то це помилка, і про неї слід повідомити
  в #link(url_issues)[трекері випуску] цієї книги.
] else if lang == "zh" [
  如果你按着这本书的操作遇到了什么麻烦，或者这本书的一些部分不够清楚，或者很难进行下去，那这本书就是有个bug，这个bug应该被报道给这本书的#link("https://github.com/rust-embedded/book/issues/")[the issue tracker]
  。
] else { todo }

#if lang == "en" [
  Pull requests fixing typos and adding new content are very welcome!
] else if lang == "de" [
  Pull Requests, die Tippfehler korrigieren oder neue Inhalte hinzufügen,
  sind herzlich willkommen!
] else if lang == "uk" [
  Запити на виправлення помилок і додавання нового матеріалу дуже вітаються!
] else if lang == "zh" [
  修改拼写错误和添加新内容的Pull requests非常欢迎！
] else { todo }

= #(if lang == "en" [Re-using this material]
  else if lang == "de" [Wiederverwendung dieses Materials]
  else if lang == "uk" [Повторне використання цього матеріалу]
  else if lang == "zh" [二次使用这个材料]
  else { todo })

#{
let mit = "https://opensource.org/licenses/MIT"
let apache = "http://www.apache.org/licenses/LICENSE-2.0"
let legalcode = "https://creativecommons.org/licenses/by-sa/4.0/legalcode"
if lang == "en" [
  This book is distributed under the following licenses:
  - The code samples and free-standing Cargo projects contained within
    this book are licensed under the terms of both the
    #link(mit)[MIT License] and the
    #link(apache)[Apache License v2.0].
  - The written prose, pictures and diagrams contained within this book
    are licensed under the terms of the Creative Commons
    #link(legalcode)[CC-BY-SA v4.0]
    license.
] else if lang == "de" [
  Dieses Buch wird unter den folgenden Lizenzen vertrieben:
  - Die in diesem Buch enthaltenen Codebeispiele und eigenständigen
    Cargo-Projekte stehen unter den Bedingungen sowohl der
    #link(apache)[MIT-Lizenz] als auch der
    #link(apache)[Apache-Lizenz v2.0].
  - Die in diesem Buch enthaltenen Texte, Bilder und Diagramme stehen
    unter der Lizenz Creative Commons
    #link(legalcode)[CC-BY-SA v4.0].
] else if lang == "uk" [
  Ця книга розповсюджується за наступними ліцензіями:
  - Зразки коду та окремі проекти Cargo, що містяться в цій книзі, ліцензовано
    відповідно до умов #link(mit)[MIT License] та #link(apache)[Apache License v2.0].
  - Текст, малюнки та діаграми, що містяться в цій книзі, ліцензовані відповідно до
    умов ліцензії Creative Commons #link(legalcode)[CC-BY-SA v4.0].
] else if lang == "zh" [
  这本书根据以下许可证发布:
  - 本书中包含的代码示例和独立的Cargo项目均根据#link(mit)[MIT License]和#link(apache)[Apache License v2.0]发放许可的。
  - 本书中包含的文档，图片和表格均根据#link(legalcode)[CC-BY-SA v4.0]发放许可的。
] else { todo }

if lang == "en" [
  TL;DR: If you want to use our text or images in your work, you need to:
  - Give the appropriate credit (i.e.~mention this book on your slide, and
    provide a link to the relevant page)
  - Provide a link to the
    #link(legalcode)[CC-BY-SA v4.0]
    licence
  - Indicate if you have changed the material in any way, and make any
    changes to our material available under the same licence
] else if lang == "de" [
  Kurz gesagt: Wenn Sie unsere Texte oder Bilder für Ihre Arbeit verwenden
  möchten, müssen Sie:
  - Geben Sie die entsprechende Quellenangabe an (d.~h. erwähnen Sie
    dieses Buch auf Ihrer Folie und geben Sie einen Link zur entsprechenden Seite an).
  - Geben Sie einen Link zur
    #link(legalcode)[CC-BY-SA v4.0]-Lizenz an.
  - Geben Sie an, ob Sie das Material in irgendeiner Weise verändert
    haben, und stellen Sie Änderungen an unserem Material unter derselben
    Lizenz zur Verfügung.
] else if lang == "uk" [
  TL;DR: Якщо ви маєте намір використовувати наш текст або зображення у своїй роботі, вам потрібно:
  - Надати відповідне посилання (тобто згадати цю книгу
    на своєму слайді та надати посилання на відповідну сторінку)
  - Надати посилання на ліцензію #link(legalcode)[CC-BY-SA v4.0]
  - Вказати, чи змінювали ви матеріал будь-яким чином,
    і зробити зміни в наші матеріали доступними за тією ж ліцензією
] else if lang == "zh" [
  总之：如果你想在你的工作中使用我们的文档或者图片，你需要：
  - 提供合适的授信 (i.e.~在你的幻灯片中提到本书，提供相关页面的连接)
  - 提供#link(legalcode)[CC-BY-SA v4.0]的许可证的链接
  - 指出你是否改变了材料的内容，在同一个许可证下，可以对材料进行任何改变
] else { todo }
}

#if lang == "en" [
  Also, please do let us know if you find this book useful!
] else if lang == "de" [
  Teilen Sie uns bitte auch mit, ob Sie dieses Buch nützlich finden!
] else if lang == "uk" [
  Також, будь ласка, повідомте нам, якщо ви знайдете цю книгу корисною!
] else if lang == "zh" [
  也请告诉我这本书对你是否有帮助！
] else { todo }
