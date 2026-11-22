#import "../config.typ": *

#h1((en: [Tips for embedded C developers],
  de: [Tipps für Embedded-C-Entwickler],
  ja: [組込みC開発者へのヒント],
  ru: [Советы для разработчиков встраиваемого C],
  zh: [给嵌入式C开发者的贴士],
))

#tr((
en: [
  This chapter collects a variety of tips that might be useful to
  experienced embedded C developers looking to start writing Rust. It will
  especially highlight how things you might already be used to in C are
  different in Rust.
],
de: [
  Dieses Kapitel versammelt eine Reihe von Tipps, die für erfahrene
  Embedded-C-Entwickler nützlich sein können, die mit der Programmierung
  in Rust beginnen möchten. Dabei wird insbesondere hervorgehoben, wie
  sich Dinge, die man aus C bereits kennt, in Rust unterscheiden.
],
ja: [
  この章では、組込みC開発の経験者が、Rustを書き始める時に役に立つ様々なヒントをまとめます。
  特に、既にC言語で慣れ親しんでいることが、Rustではどう違うのかを強調します。
],
ru: [
  В этой главе собраны различные советы, которые могут пригодиться опытным
  разработчикам встраиваемого C, которые хотят начать писать на Rust. В
  особенности здесь подчёркивается, чем на Rust отличаются вещи, к которым
  вы, возможно, уже привыкли в C.
],
zh: [
  这个章节收集了可能对于刚开始编写Rust的，有经验的嵌入式C开发者来说，有用的各种各样的贴士。它将解释你在C中可能已经用到的那些东西与Rust中的有何不同。
]))

== #tr((
  en: [Preprocessor],
  de: [Präprozessor],
  ja: [プリプロセッサ],
  ru: [Препроцессор],
  zh: [预处理器],
))

#tr((
en: [
  In embedded C it is very common to use the preprocessor for a variety of
  purposes, such as:
  - Compile-time selection of code blocks with `#ifdef`
  - Compile-time array sizes and computations
  - Macros to simplify common patterns (to avoid function call overhead)
],
de: [
  In der Embedded-C-Programmierung ist es sehr üblich, den Präprozessor
  für eine Vielzahl von Zwecken zu nutzen, wie zum Beispiel:
  - Auswahl von Codeblöcken zur Kompilierzeit mittels `#ifdef`
  - Zur Kompilierzeit festgelegte Array-Größen und Berechnungen
  - Makros zur Vereinfachung häufiger Muster (um den Overhead von
    Funktionsaufrufen zu vermeiden)
],
ja: [
  組込みCでは、次のような様々な目的でプリプロセッサを使うことが一般的です。
  - `#ifdef`を使ったコンパイル時のコードブロック選択
  - コンパイル時の配列サイズやコンパイル時計算
  - （関数呼び出しのオーバーヘッドを避けるための）共通パターンを簡単化するマクロ
],
ru: [
  Во встраиваемом C очень распространено использование препроцессора для
  самых разных целей, например:
  - выбор блоков кода на этапе компиляции с помощью `#ifdef`;
  - размеры массивов и вычисления на этапе компиляции;
  - макросы для упрощения типовых конструкций (чтобы избежать накладных
    расходов на вызов функции).
],
zh: [
  在嵌入式C中，为了各种各样的目的使用预处理器是很常见的，比如:
  - 使用`#ifdef`编译时选择代码块
  - 编译时的数组大小和计算
  - 用来简化常见的模式的宏(避免调用函数的开销)
]))

#tr((
en: [
  In Rust there is no preprocessor, and so many of these use cases are
  addressed differently. In the rest of this section we cover various
  alternatives to using the preprocessor.
],
de: [
  In Rust gibt es keinen Präprozessor, weshalb viele dieser
  Anwendungsfälle anders gelöst werden. Im weiteren Verlauf dieses
  Abschnitts behandeln wir verschiedene Alternativen zur Verwendung des
  Präprozessors.
],
ja: [
  Rustにはプリプロセッサはありません。上記のユースケースは異なる方法で解決されます。
  セクションの残りの部分では、プリプロセッサの様々な代替手段について説明します。
],
ru: [
  В Rust препроцессора нет, поэтому многие из этих задач решаются иначе. В
  остальной части этого раздела мы рассмотрим различные альтернативы
  использованию препроцессора.
],
zh: [
  在Rust中没有预处理器，所以许多案例有不同的处理方法。本章节剩下的部分，我们将介绍各种替代预处理器的方法。
]))

=== #tr((
  en: [Compile-Time Code Selection],
  de: [Code-Auswahl zur Kompilierzeit],
  ja: [コンパイル時コード選択],
  ru: [Выбор кода на этапе компиляции],
  zh: [编译时的代码选择],
))

#let url_features = "https://doc.rust-lang.org/cargo/reference/manifest.html#the-features-section"
#tr((
en: [
  The closest match to `#ifdef ... #endif` in Rust are
  #link(url_features)[Cargo features].
  These are a little more formal than the C preprocessor: all possible
  features are explicitly listed per crate, and can only be either on or
  off. Features are turned on when you list a crate as a dependency, and
  are additive: if any crate in your dependency tree enables a feature for
  another crate, that feature will be enabled for all users of that crate.
],
de: [
  Das Äquivalent zu `#ifdef ... #endif` in Rust sind
  #link(url_features)[Cargo-Features].
  Diese sind etwas formaler als der C-Präprozessor: Alle möglichen
  Features werden pro Crate explizit aufgelistet und können entweder
  aktiviert oder deaktiviert sein. Features werden eingeschaltet, sobald
  man ein Crate als Abhängigkeit angibt; sie sind zudem additiv: Wenn
  irgendein Crate im Abhängigkeitsbaum ein Feature für ein anderes Crate
  aktiviert, ist dieses Feature für alle Nutzer jenes Crates aktiviert.
],
ja: [
  `#ifdef ... #endif`に最も近いRustの機能は、#link(url_features)[Cargoフィーチャ]です。
  Cargoフィーチャは、Cプリプロセッサよりももう少し秩序だったものです。
  フィーチャの候補は、クレートごとに明示的にリスト化されており、オンまたはオフのいずれかになります。
  依存関係としてクレートを記載すると、フィーチャが有効になります。またこのフィーチャは追加式です。
  依存ツリー内の何らかのクレートが、別クレートのフィーチャを有効化した場合、そのフィーチャは、そのクレートを使う全てのユーザに対して有効化されます。
],
ru: [
  Ближайший аналог `#ifdef ... #endif` в Rust --- это
  #link(url_features)[feature-флаги Cargo (features)].
  Они немного формальнее, чем препроцессор C: все возможные feature явно
  перечисляются для каждого крейта и могут быть только включены или
  выключены. Feature включаются, когда вы указываете крейт как
  зависимость, и они аддитивны: если какой-либо крейт в дереве
  зависимостей включает feature другого крейта, этот feature будет включён
  для всех пользователей этого крейта.
],
zh: [
  Rust中最接近`#ifdef ... #endif`的是#link(url_features)[Cargo features]。这些比C预处理器更正式一点:
  每个crate显式列举的，所有可能的features只能是关了的或者打开了的。当你把一个crate列为依赖项时，Features被打开，且是可添加的：如果你依赖树中的任何crate为另一个crate打开了一个feature，那么这个feature将为所有使用那个crate的用户而打开。
]))

#tr((
en: [
  For example, you might have a crate which provides a library of signal
  processing primitives. Each one might take some extra time to compile or
  declare some large table of constants which you'd like to avoid. You
  could declare a Cargo feature for each component in your `Cargo.toml`:
],
de: [
  Angenommen, du hast ein Crate, das eine Bibliothek von Grundbausteinen
  für die Signalverarbeitung bereitstellt. Jeder dieser Bausteine ​​könnte
  zusätzliche Kompilierzeit beanspruchen oder eine umfangreiche Tabelle
  von Konstanten definieren, die du gerne vermeiden möchtest. Du könntest
  für jede Komponente in deiner `Cargo.toml` ein Cargo-Feature definieren:
],
ja: [
  例えば、信号処理プリミティブを提供するライブラリがあるとします。
  それぞれが、大きな定数テーブルをコンパイルまたは宣言するのに余分な時間がかかるとすると、その時間を回避したいと思うでしょう。
  `Cargo.toml`内で各コンポーネントのフィーチャを宣言することができます。
],
ru: [
  Например, у вас может быть крейт, который предоставляет библиотеку
  примитивов обработки сигналов. Каждый из них может требовать
  дополнительного времени на компиляцию или объявлять большую таблицу
  констант, которой вы хотели бы избежать. Вы можете объявить feature
  Cargo для каждого компонента в своём `Cargo.toml`:
],
zh: [
  比如，你可能有一个crate，其提供一个信号处理的基本类型库(library of
  signal processing
  primitives)。每个基本类型可能带来一些额外的时间去编译大量的常量，你想要避开这些常量。你可以为你的`Cargo.toml`中每个组件声明一个Cargo
  feature。
]))

```toml
[features]
FIR = []
IIR = []
```

#tr((
en: [
  Then, in your code, use `#[cfg(feature="FIR")]` to control what is
  included.
],
de: [
  Verwenden Sie dann in Ihrem Code `#[cfg(feature="FIR")]`, um zu steuern,
  was einbezogen wird.
],
ja: [
  それから、コード内で、何をインクルードするか制御するために`#[cfg(feature="FIR")]`を使います。
],
ru: [
  Затем в коде используйте `#[cfg(feature="FIR")]`, чтобы управлять тем,
  что включается.
],
zh: [
  然后，在你的代码中，使用`#[cfg(feature="FIR")]`去控制要包含什么东西。
]))

#raw(block: true, lang: "rust",
"/// " + ts((
    en: "In your top-level lib.rs",
    de: "In deiner lib.rs auf oberster Ebene",
    ja: "トップレベルのlib.rs内",
    ru: "В вашем верхнеуровневом lib.rs",
    zh: "在你的顶层的lib.rs中"
  )) + "

#[cfg(feature=\"FIR\")]
pub mod fir;

#[cfg(feature=\"IIR\")]
pub mod iir;
")

#tr((
en: [
  You can similarly include code blocks only if a feature is _not_
  enabled, or if any combination of features are or are not enabled.
],
de: [
  Sie können Codeblöcke analog dazu nur dann einfügen, wenn eine Funktion
  _nicht_ aktiviert ist oder wenn eine beliebige Kombination von
  Funktionen aktiviert oder deaktiviert ist.
],
ja: [
  同様に、フィーチャが有効になって _いない_
  場合にだけコードブロックをインクルードすることができます。
  また、フィーチャの組み合わせや、フィーチャが有効か無効かに関わらず、コードブロックをインクルードすることもできます。
],
ru: [
  Аналогичным образом можно включать блоки кода, только если feature
  _не_ включён, или при любом сочетании включённых и выключенных
  feature.
],
zh: [
  同样地，你可以控制，只有当某个feature _没有_
  被打开时，包含代码块，或者某些features的组合被打开或者被关闭时。
]))

#let url_conditional = "https://doc.rust-lang.org/reference/conditional-compilation.html"
#tr((
en: [
  Additionally, Rust provides a number of automatically-set conditions you
  can use, such as `target_arch` to select different code based on
  architecture. For full details of the conditional compilation support,
  refer to the #link(url_conditional)[conditional compilation]
  chapter of the Rust reference.
],
de: [
  Darüber hinaus bietet Rust eine Reihe automatisch gesetzter Bedingungen,
  die Sie verwenden können, beispielsweise `target_arch`, um je nach
  Architektur unterschiedlichen Code auszuwählen. Ausführliche
  Informationen zur bedingten Kompilierung finden Sie im Kapitel
  #link(url_conditional)[Bedingte Kompilierung]
  der Rust-Referenz.
],
ja: [
  さらに、Rustは、自動的に設定される数々の条件を提供します。例えば、アーキテクチャに基づいて異なるコードを選択する`target_arch`です。
  条件コンパイルがサポートしている全ての詳細については、Rustリファレンスの#link(url_conditional)[条件コンパイル]の章を参照して下さい。
],
ru: [
  Кроме того, Rust предоставляет ряд автоматически задаваемых условий,
  которые можно использовать, например `target_arch`, чтобы выбирать
  разный код в зависимости от архитектуры. Полные подробности о поддержке
  условной компиляции см. в главе
  #link(url_conditional)[условная компиляция] справочника Rust.
],
zh: [
  另外，Rust提供了许多可以使用的自动配置了的条件，比如`target_arch`用来选择不同的代码所基于的架构。对于条件编译的全部细节，可以参看the
  Rust
  reference的#link(url_conditional)[conditional compilation]章节。
]))

#tr((
en: [
  The conditional compilation will only apply to the next statement or
  block. If a block can not be used in the current scope then the `cfg`
  attribute will need to be used multiple times. It's worth noting that
  most of the time it is better to simply include all the code and allow
  the compiler to remove dead code when optimising: it's simpler for you
  and your users, and in general the compiler will do a good job of
  removing unused code.
],
de: [
  Die bedingte Kompilierung bezieht sich nur auf die unmittelbar folgende
  Anweisung oder den folgenden Block. Kann im aktuellen Gültigkeitsbereich
  kein Block verwendet werden, muss das `cfg`-Attribut mehrfach eingesetzt
  werden. Es sei darauf hingewiesen, dass es meist besser ist, den
  gesamten Code einzubeziehen und den Compiler bei der Optimierung nicht
  mehr benötigten Code („Dead Code") entfernen zu lassen: Dies ist für Sie
  und Ihre Nutzer einfacher, und der Compiler leistet im Allgemeinen gute
  Arbeit beim Entfernen von ungenutztem Code.
],
ja: [
  条件コンパイルは、次のステートメントまたはブロックにのみ適用されます。
  現在のスコープ内でブロックが使えない場合、`cfg`アトリビュートは複数回必要になります。
  ほとんどの場合、単純に全てのコードをインクルードして、コンパイラが最適化時にデッドコードを削除できるようにするほうが良いことに、注意すべきです。
  これは、あなたにも、あなたのユーザにとってもより簡単です。そして、通常、コンパイラは使用されていないコードをうまく削除します。
],
ru: [
  Условная компиляция применяется только к следующему оператору или блоку.
  Если блок нельзя использовать в текущей области видимости, атрибут `cfg`
  придётся указывать несколько раз. Стоит отметить, что чаще всего лучше
  просто включить весь код и позволить компилятору удалить мёртвый код при
  оптимизации: это проще для вас и ваших пользователей, и, как правило,
  компилятор хорошо справляется с удалением неиспользуемого кода.
],
zh: [
  条件编译将只应用于下一条语句或者块。如果一个块不能在现在的作用域中被使用，那么`cfg`属性将需要被多次使用。值得注意的是大多数时间，仅是包含所有的代码而让编译器在优化时去删除死代码(dead
  code)更好，通常，在移除不使用的代码方面的工作，编译器做得很好。
]))

=== #tr((
  en: [Compile-Time Sizes and Computation],
  de: [Größen und Berechnungen zur Kompilierzeit],
  ja: [コンパイル時サイズとコンパイル時計算],
  ru: [Размеры и вычисления на этапе компиляции],
  zh: [编译时大小和计算],
))

#tr((
en: [
  Rust supports `const fn`, functions which are guaranteed to be evaluable
  at compile-time and can therefore be used where constants are required,
  such as in the size of arrays. This can be used alongside features
  mentioned above, for example:
],
de: [
  Rust unterstützt `const fn` -- Funktionen, die garantiert zur
  Kompilierzeit ausgewertet werden können und sich daher überall dort
  einsetzen lassen, wo Konstanten erforderlich sind, etwa bei der Größe
  von Arrays. Dies lässt sich mit den zuvor genannten Funktionen
  kombinieren, zum Beispiel:
],
ja: [
  Rustは`const fn`を提供しています。この関数はコンパイル時に評価されることが保証されているため、配列のサイズなど、定数が求められる場所で使用できます。
  const fnは、上述したフィーチャと同時に使う事ができます。例を示します。
],
ru: [
  Rust поддерживает `const fn` --- функции, которые гарантированно
  вычисляются на этапе компиляции и поэтому могут использоваться там, где
  требуются константы, например для размера массивов. Это можно сочетать с
  описанными выше feature, например:
],
zh: [
  Rust支持`const fn`，`const fn`是在编译时可以被计算的函数，因此可以被用在需要常量的地方，比如在数组的大小中。这个能与上述的features一起使用，比如:
]))

```rust
const fn array_size() -> usize {
    #[cfg(feature="use_more_ram")]
    { 1024 }
    #[cfg(not(feature="use_more_ram"))]
    { 128 }
}

static BUF: [u32; array_size()] = [0u32; array_size()];
```

#tr((
en: [
  These are new to stable Rust as of 1.31, so documentation is still
  sparse. The functionality available to `const fn` is also very limited
  at the time of writing; in future Rust releases it is expected to expand
  on what is permitted in a `const fn`.
],
de: [
  Diese Funktionen sind seit Version 1.31 in Stable Rust verfügbar,
  weshalb die Dokumentation noch spärlich ist. Auch der für `const fn`
  verfügbare Funktionsumfang ist zum Zeitpunkt der Erstellung dieses
  Textes stark eingeschränkt; es ist jedoch zu erwarten, dass die in einer
  `const fn` zulässigen Operationen in künftigen Rust-Versionen erweitert werden.
],
ja: [
  これらは、Rust
  1.31以降の新しい機能であるため、ドキュメントはまだわずかしかありません。
  執筆時点では、`const fn`で利用可能な機能は、非常に限られています。
  将来のRustでは、`const fn`内で許可されることが拡張されていくでしょう。
],
ru: [
  Эти возможности появились в стабильном Rust начиная с версии 1.31,
  поэтому документации по ним пока мало. Функциональность, доступная для
  `const fn`, на момент написания также очень ограничена; ожидается, что в
  будущих версиях Rust круг допустимого в `const fn` расширится.
],
zh: [
  这些对于stable版本的Rust来说是新的特性，从1.31开始引入，因此文档依然很少。在写这篇文章的时候`const fn`可用的功能也非常有限;
  在未来的Rust release版本中，我们可以期望`const fn`将带来更多的功能。
]))

=== #tr((
  en: [Macros],
  de: [Makros],
  ja: [マクロ],
  ru: [Макросы],
  zh: [宏],
))

#let url_macros = "https://doc.rust-lang.org/book/ch19-06-macros.html"
#tr((
en: [
  Rust provides an extremely powerful #link(url_macros)[macro system].
  While the C preprocessor operates almost directly on the text of your
  source code, the Rust macro system operates at a higher level. There are
  two varieties of Rust macro: _macros by example_ and
  _procedural macros_. The former are simpler and most common; they
  look like function calls and can expand to a complete expression,
  statement, item, or pattern. Procedural macros are more complex but
  permit extremely powerful additions to the Rust language: they can
  transform arbitrary Rust syntax into new Rust syntax.
],
de: [
  Rust bietet ein äußerst leistungsfähiges #link(url_macros)[Makrosystem].
  Während der C-Präprozessor fast direkt auf dem Text des Quellcodes
  arbeitet, operiert das Rust-Makrosystem auf einer höheren Ebene. Es gibt
  zwei Arten von Rust-Makros: _Macros by Example_ (Makros nach
  Muster) und _prozedurale Makros_. Erstere sind einfacher und weiter
  verbreitet; sie sehen wie Funktionsaufrufe aus und können zu einem
  vollständigen Ausdruck, einer Anweisung, einem Element oder einem Muster
  expandiert werden. Prozedurale Makros sind komplexer, ermöglichen jedoch
  äußerst leistungsfähige Erweiterungen der Sprache Rust: Sie können
  beliebige Rust-Syntax in neue Rust-Syntax umwandeln.
],
ja: [
  Rustは、極めて強力な#link(url_macros)[マクロシステム]を提供しています。
  Cプリプロセッサがソースコードのテキストにほぼ直接作用するのに対して、Rustのマクロシステムはより上位レベルで作用します。
  Rustのマクロは2種類あります。_例によるマクロ_ と
  _手続きマクロ_ です。
  前者はより単純で最も一般的なものです。関数呼び出しのように見えて、完全な式やステートメント、アイテム、パターンに展開できます。
  手続きマクロは、より複雑ですが、Rust言語に非常に強力な拡張を許可します。任意のRust構文を、新しいRust構文に変換することができます。
],
ru: [
  Rust предоставляет чрезвычайно мощную #link(url_macros)[систему макросов].
  Препроцессор C работает почти непосредственно с текстом исходного кода,
  тогда как система макросов Rust работает на более высоком уровне.
  Существует два вида макросов Rust: _макросы по примеру_ (macros by
  example) и _процедурные макросы_. Первые проще и распространённее:
  они выглядят как вызовы функций и могут раскрываться в целое выражение,
  оператор, элемент или шаблон. Процедурные макросы сложнее, но позволяют
  очень мощно расширять язык Rust: они могут преобразовывать произвольный
  синтаксис Rust в новый синтаксис Rust.
],
zh: [
  Rust提供一个极度强大的#link(url_macros)[宏系统]。虽然C预处理器几乎直接在你的源代码之上进行操作，但是Rust宏系统可以在一个更高的级别上操作。存在两种Rust宏:
  _声明宏_ 和 _过程宏_ 。前者更简单也最常见;
  它们看起来像是函数调用，且能扩展成一个完整的表达式，语句，项，或者模式。过程宏更复杂但是却能让Rust更强大:
  它们可以把任一条Rust语法变成一个新的Rust语法。
]))

#tr((
en: [
  In general, where you might have used a C preprocessor macro, you
  probably want to see if a macro-by-example can do the job instead. They
  can be defined in your crate and easily used by your own crate or
  exported for other users. Be aware that since they must expand to
  complete expressions, statements, items, or patterns, some use cases of
  C preprocessor macros will not work, for example a macro that expands to
  part of a variable name or an incomplete set of items in a list.
],
de: [
  Wenn Sie normalerweise ein C-Präprozessor-Makro verwenden würden,
  sollten Sie im Allgemeinen prüfen, ob stattdessen ein „Macro-by-Example"
  (Makro-durch-Beispiel) die Aufgabe erfüllen kann. Solche Makros lassen
  sich in Ihrem Crate definieren und sowohl intern verwenden als auch für
  andere Nutzer exportieren. Beachten Sie jedoch, dass sie zu
  vollständigen Ausdrücken, Anweisungen, Elementen (Items) oder Mustern
  expandieren müssen; bestimmte Anwendungsfälle von C-Präprozessor-Makros
  funktionieren daher nicht -- etwa Makros, die nur einen Teil eines
  Variablennamens oder unvollständige Listenelemente erzeugen.
],
ja: [
  通常、Cプリプロセッサマクロを使っていた場所に、例によるマクロで同じことができるかどうか、確認したいと思います。
  マクロは、クレート内に定義でき、自身のクレート内で簡単に使ったり、他のユーザにエクスポートしたりできます。
  マクロは、完全な式や、ステートメント、アイテム、パターンに展開されなければならないため、Cプリプロセッサマクロのいくつかのユースケースではうまく機能しません。
  例えば、変数名や、リスト内の不完全なアイテムの一部に展開するようなマクロです。
],
ru: [
  В общем случае там, где вы могли бы использовать макрос препроцессора C,
  стоит проверить, справится ли с задачей макрос по примеру. Такие макросы
  можно определить в своём крейте, легко использовать внутри собственного
  крейта или экспортировать для других пользователей. Имейте в виду, что,
  поскольку они должны раскрываться в целые выражения, операторы, элементы
  или шаблоны, некоторые сценарии использования макросов препроцессора C
  не будут работать; например, макрос, который раскрывается в часть имени
  переменной, или неполный набор элементов в списке.
],
zh: [
  通常，你可能想知道在那些使用一个C预处理器宏的地方，能否使用一个声明宏做同样的工作。你可以在crate中定义它们，且在你的crate中轻松使用它们或者导出给其他人用。但是请注意，因为它们必须扩展成完整的表达式，语句，项或者模式，因此C预处理器宏的某些用例没法用，比如可以扩展成一个变量名的一部分的宏或者可以把列表中的项扩展成不完整的集合的宏。
]))

#let url_inline = "https://doc.rust-lang.org/reference/attributes.html#inline-attribute"
#tr((
en: [
  As with Cargo features, it is worth considering if you even need the
  macro. In many cases a regular function is easier to understand and will
  be inlined to the same code as a macro. The `#[inline]` and
  `#[inline(always)]` #link(url_inline)[attributes]
  give you further control over this process, although care should be
  taken here as well --- the compiler will automatically inline functions
  from the same crate where appropriate, so forcing it to do so
  inappropriately might actually lead to decreased performance.
],
de: [
  Wie bei Cargo-Features lohnt es sich auch hier zu überlegen, ob das
  Makro überhaupt erforderlich ist. Oftmals ist eine gewöhnliche Funktion
  leichter verständlich und wird vom Compiler zu demselben Maschinencode
  expandiert (geinlined) wie ein Makro. Die Attribute `#[inline]` und
  `#[inline(always)]`-#link(url_inline)[Attribute]
  bieten Ihnen zusätzliche Kontrolle über diesen Vorgang, wobei jedoch
  Vorsicht geboten ist: Der Compiler inlined Funktionen aus demselben
  Crate ohnehin automatisch, wenn dies sinnvoll ist; ein erzwungenes
  Inlining in ungeeigneten Fällen kann die Leistung sogar verschlechtern.
],
ja: [
  Cargoフィーチャと同様、本当にマクロが必要かどうか、は検討する価値があります。
  多くの場合、通常の関数は理解しやすく、マクロと同様にインライン化されます。
  `#[inline]`および`#[inline(always)]`の#link(url_inline)[アトリビュート]を使用すると、このプロセスをさらに細かく制御できます。
  ここでも注意が必要です。コンパイラは、適切な場合、関数を自動的にインライン化します。
  そのため、不適切なインライン化を強制すると、パフォーマンスが低下する可能性があります。
],
ru: [
  Как и в случае с feature-флагами Cargo, стоит подумать, нужен ли вам
  вообще макрос. Во многих случаях обычная функция проще для понимания и
  будет встроена (inlined) в тот же код, что и макрос. Атрибуты
  #link(url_inline)[`#[inline]` и `#[inline(always)]`]
  дают дополнительный контроль над этим процессом, но и здесь нужна
  осторожность: компилятор автоматически встраивает функции из того же
  крейта там, где это уместно, поэтому принудительное встраивание не к
  месту может привести к снижению производительности.
],
zh: [
  和Cargo
  features一样，值得考虑下你是否真的需要宏。在一些例子中一个常规的函数更容易被理解，它也能被内联成和一个和宏一样的代码。`#[inline]`和`#[inline(always)]`
  #link(url_inline)[attributes]
  能让你更深入控制这个过程，这里也要小心 -
  编译器会从同一个crate的恰当的地方自动地内联函数，因此不恰当地强迫它内联函数实际可能会导致性能下降。
]))

#tr((
en: [
  Explaining the entire Rust macro system is out of scope for this tips
  page, so you are encouraged to consult the Rust documentation for full
  details.
],
de: [
  Eine Erläuterung des gesamten Rust-Makrosystems würde den Rahmen dieser
  Tipps-Seite sprengen; für alle Einzelheiten sei daher auf die
  Rust-Dokumentation verwiesen.
],
ja: [
  Rustのマクロシステムの全体を説明することは、このヒントページのスコープ範囲外です。
  詳細については、Rustのドキュメントの参照をお勧めします。
],
ru: [
  Подробно объяснять всю систему макросов Rust выходит за рамки этой
  страницы с советами, поэтому мы рекомендуем обратиться к документации
  Rust за полными сведениями.
],
zh: [
  研究完整的Rust宏系统超出了本节内容，因此我们鼓励你去查阅Rust文档了解完整的细节。
]))

== #tr((
  en: [Build System],
  de: [Build System],
  ja: [ビルドシステム],
  ru: [Система сборки],
  zh: [编译系统],
))

#let url_build_scripts = "https://doc.rust-lang.org/cargo/reference/build-scripts.html"
#tr((
en: [
  Most Rust crates are built using Cargo (although it is not required).
  This takes care of many difficult problems with traditional build
  systems. However, you may wish to customise the build process. Cargo
  provides
  #link(url_build_scripts)[`build.rs` scripts]
  for this purpose. They are Rust scripts which can interact with the
  Cargo build system as required.
],
de: [
  Die meisten Rust-Crates werden mit Cargo erstellt (auch wenn dies nicht
  zwingend erforderlich ist). Cargo löst dabei viele der schwierigen
  Probleme, die mit herkömmlichen Build-Systemen verbunden sind. Dennoch
  kann es sinnvoll sein, den Build-Prozess individuell anzupassen. Hierfür
  stellt Cargo #link(url_build_scripts)[`build.rs`-Skripte]
  bereit. Dabei handelt es sich um Rust-Skripte, die bei Bedarf mit dem
  Cargo-Build-System interagieren können.
],
ja: [
  （必須ではありませんが）ほとんどのRustのクレートは、Cargoを使ってビルドされます。
  Cargoは、従来のビルドシステムに関する多くの難しい問題の面倒を見ています。
  しかし、ビルドプロセスをカスタマイズしたいと思うかもしれません。このため、Cargoは#link(url_build_scripts)[`build.rs`スクリプト]を提供しています。
  build.rsスクリプトはRustで書かれたスクリプトで、必要に応じてCargoのビルドシステムとやり取りします。
],
ru: [
  Большинство крейтов Rust собираются с помощью Cargo (хотя это не
  обязательно). Cargo решает многие сложные проблемы традиционных систем
  сборки. Однако вы можете захотеть настроить процесс сборки. Для этого
  Cargo предоставляет #link(url_build_scripts)[скрипты `build.rs`].
  Это скрипты на Rust, которые при необходимости могут взаимодействовать с
  системой сборки Cargo.
],
zh: [
  大多数Rust crates使用Cargo编译
  (即使这不是必须的)。这解决了传统编译系统带来的许多难题。然而，你可能希望自定义编译过程。为了实现这个目的，Cargo提供了#link(url_build_scripts)[`build.rs`脚本]。它们是可以根据需要与Cargo编译系统进行交互的Rust脚本。
]))

#tr((
en: [
  Common use cases for build scripts include:
  - provide build-time information, for example statically embedding the
    build date or Git commit hash into your executable
  - generate linker scripts at build time depending on selected features
    or other logic
  - change the Cargo build configuration
  - add extra static libraries to link against
],
de: [
  Zu den häufigen Anwendungsfällen für Build-Skripte gehören:
  - Informationen zum Build-Zeitpunkt bereitstellen, zum Beispiel durch
    das statische Einbetten des Build-Datums oder des Git-Commit-Hashs in
    die ausführbare Datei.
  - Linker-Skripte zur Build-Zeit generieren, abhängig von ausgewählten
    Funktionen oder anderer Logik.
  - die Cargo-Build-Konfiguration ändern
  - Zusätzliche statische Bibliotheken für den Linkvorgang hinzufügen
],
ja: [
  ビルドスクリプトの一般的なユースケースを示します。
  - ビルド時の情報を提供します。例えば、実行ファイルにビルド日時やGitのコミットハッシュを静的に埋め込みます。
  - 選択されたフィーチャやその他のロジックに応じて、リンカスクリプトをビルド時に生成します。
  - Cargoのビルド設定を変更します。
  - リンクする静的ライブラリを追加します。
],
ru: [
  Типичные сценарии использования скриптов сборки:
  - предоставление информации, известной на этапе сборки, например
    статическое встраивание даты сборки или хеша коммита Git в исполняемый
    файл;
  - генерация скриптов компоновщика на этапе сборки в зависимости от
    выбранных feature-флагов или другой логики;
  - изменение конфигурации сборки Cargo;
  - добавление дополнительных статических библиотек для компоновки.
],
zh: [
  与编译脚本有关的常见用例包括:
  - 提供编译时信息，比如静态嵌入编译日期或者Git commit
    hash进你的可执行文件中
  - 根据被选择的features或者其它逻辑在编译时生成链接脚本
  - 改变Cargo的编译配置
  - 添加额外的静态链接库以进行链接
]))

#tr((
en: [
  At present there is no support for post-build scripts, which you might
  traditionally have used for tasks like automatic generation of binaries
  from the build objects or printing build information.
],
de: [
  Derzeit gibt es keine Unterstützung für Post-Build-Skripte, wie man sie
  üblicherweise für Aufgaben wie die automatische Erstellung von
  Binärdateien aus den Build-Objekten oder die Ausgabe von
  Build-Informationen verwendet hat.
],
ja: [
  現状、ビルド後に実行するスクリプトは提供されていません。
  そのようなスクリプトは、従来では、ビルドしたオブジェクトからバイナリを自動的に生成したり、ビルド情報を表示したりするタスクに使われています。
],
ru: [
  На данный момент постсборочные скрипты не поддерживаются --- то есть те,
  которые традиционно использовались для таких задач, как автоматическое
  создание бинарных файлов из объектных файлов сборки или вывод информации
  о сборке.
],
zh: [
  现在还不支持post-build脚本，通常将它用于像是从编译的对象自动生生成二进制文件或者打印编译信息这类任务中。
]))

=== #tr((
  en: [Cross-Compiling],
  de: [Cross-Kompilierung],
  ja: [クロスコンパイル],
  ru: [Кросс-компиляция],
  zh: [交叉编译],
))

#let app_pth = `target/thumbv6m-none-eabi/debug/myapp`
#tr((
en: [
  Using Cargo for your build system also simplifies cross-compiling. In
  most cases it suffices to tell Cargo `--target thumbv6m-none-eabi` and
  find a suitable executable in #app_pth.
],
de: [
  Die Verwendung von Cargo als Build-System vereinfacht auch die
  Cross-Kompilierung. In den meisten Fällen genügt es, Cargo die Option
  `--target thumbv6m-none-eabi` mitzugeben und die entsprechende
  ausführbare Datei unter #app_pth zu finden.
],
ja: [
  Cargoをビルドシステムに使用するとクロスコンパイルも簡単になります。
  多くの場合、Cargoに`--target thumbv6m-none-eabi`を伝えるだけで十分です。
  そうすると、適切な実行ファイルが#app_pth;に見つかります。
],
ru: [
  Использование Cargo в качестве системы сборки также упрощает
  кросс-компиляцию. В большинстве случаев достаточно указать Cargo
  `--target thumbv6m-none-eabi` и найти подходящий исполняемый файл в #app_pth.
],
zh: [
  为你的编译系统使用Cargo也能简化交叉编译。在大多数例子里，告诉Cargo
  `--target thumbv6m-none-eabi`就行了，可以在#app_pth;中找到一个合适的可执行文件。
]))

#let ln_xargo = link("https://github.com/japaric/xargo")[Xargo]
#tr((
en: [
  For platforms not natively supported by Rust, you will need to build
  `libcore` for that target yourself. On such platforms,
  #ln_xargo can be used as a
  stand-in for Cargo which automatically builds `libcore` for you.
],
de: [
  Für Plattformen, die nicht nativ von Rust unterstützt werden, müssen Sie
  `libcore` für das jeweilige Zielsystem selbst kompilieren. Auf solchen
  Plattformen lässt sich #ln_xargo
  als Ersatz für Cargo verwenden, da es `libcore` automatisch für Sie
  erstellt.
],
ja: [
  Rustが本来サポートしていないプラットフォームの場合、ターゲットの`libcore`を自分自身でビルドする必要があります。
  そのようなプラットフォームでは、#ln_xargo;をCargoの代わりに使うことができ、自動的に`libcore`をビルドしてくれます。
],
ru: [
  Для платформ, которые Rust не поддерживает нативно, вам самостоятельно
  понадобится собрать `libcore` для этой целевой платформы. Для таких
  платформ можно использовать #ln_xargo как замену Cargo,
  которая автоматически собирает `libcore` за вас.
],
zh: [
  对于那些并不是Rust原生支持的平台，将需要自己为那个目标平台编译`libcore`。遇到这样的平台，#ln_xargo;可以作为Cargo的替代来使用，它可以自动地为你编译`libcore`。
]))

== #tr((
  en: [Iterators vs Array Access],
  de: [Iteratoren vs.~Array-Zugriff],
  ja: [イテレータ vs 配列アクセス],
  ru: [Итераторы вместо доступа по индексу],
  zh: [迭代器与数组访问],
))

#tr((
en: [
  In C you are probably used to accessing arrays directly by their index:
],
de: [
  In C sind Sie es wahrscheinlich gewohnt, direkt über den Index auf
  Arrays zuzugreifen:
],
ja: [
  Cでは、おそらくインデックスによって直接配列にアクセスしているでしょう。
],
ru: [
  В C вы, вероятно, привыкли обращаться к массивам напрямую по индексу:
],
zh: [
  在C中，你可能习惯于通过索引直接访问数组:
]))

```c
int16_t arr[16];
int i;
for(i=0; i<sizeof(arr)/sizeof(arr[0]); i++) {
    process(arr[i]);
}
```

#tr((
en: [
  In Rust this is an anti-pattern: indexed access can be slower (as it
  needs to be bounds checked) and may prevent various compiler
  optimisations. This is an important distinction and worth repeating:
  Rust will check for out-of-bounds access on manual array indexing to
  guarantee memory safety, while C will happily index outside the array.
],
de: [
  In Rust ist dies ein Anti-Muster: Indexzugriffe können langsamer sein
  (da eine Bereichsprüfung erforderlich ist) und verschiedene
  Compiler-Optimierungen verhindern. Dieser Unterschied ist wichtig und
  sollte wiederholt werden: Rust prüft bei manueller Array-Indizierung auf
  Zugriffe außerhalb der Grenzen, um Speichersicherheit zu gewährleisten,
  während C problemlos auf Bereiche außerhalb des Arrays zugreift.
],
ja: [
  Rustでは、これはアンチパターンです。インデックスによるアクセスは、低速（境界チェックが必要なため）で様々なコンパイラの最適化を妨げます。
  これは重要な違いであり、繰り返す価値があります。
  Rustは、メモリ安全性を保証するために、手動で配列のインデックスを指定する際、境界を越えたアクセスをチェックします。
  一方、Cでは配列外のインデックスにアクセスできてしまいます。
],
ru: [
  В Rust это антипаттерн: доступ по индексу может быть медленнее (так как
  требует проверки границ) и может помешать различным оптимизациям
  компилятора. Это важное различие, поэтому стоит повторить: Rust
  проверяет выход за границы при ручной индексации массива, чтобы
  гарантировать безопасность памяти, тогда как C спокойно позволит
  индексировать за пределами массива.
],
zh: [
  在Rust中，这是一个反模式(anti-pattern)：索引访问可能会更慢(因为它可能需要做边界检查)且可能会阻止编译器的各种优化。这是一个重要的区别，值得再重复一遍:
  Rust会在手动的数组索引上进行越界检查以保障内存安全性，而C允许索引数组外的内容。
]))

#tr((
en: [
  Instead, use iterators:
],
de: [
  Verwenden Sie stattdessen Iteratoren.
],
ja: [
  代わりに、イテレータを使います。
],
ru: [
  Вместо этого используйте итераторы:
],
zh: [
  可以使用迭代器来替代:
]))

```rust
let arr = [0u16; 16];
for element in arr.iter() {
    process(*element);
}
```

#tr((
en: [
  Iterators provide a powerful array of functionality you would have to
  implement manually in C, such as chaining, zipping, enumerating, finding
  the min or max, summing, and more. Iterator methods can also be chained,
  giving very readable data processing code.
],
de: [
  Iteratoren bieten eine Vielzahl leistungsstarker Funktionen, die Sie in
  C manuell implementieren müssten, wie z. B. Verkettung, Zipping,
  Aufzählung, Minimum- und Maximumsuche, Summierung und vieles mehr.
  Iteratormethoden lassen sich ebenfalls verketten, was zu sehr lesbarem
  Code für die Datenverarbeitung führt.
],
ja: [
  イテレータは、chaining、zipping、enumerating、最小値や最大値の検索、合計の算出など、Cでは手動で実装する必要がある強力な配列の機能を提供します。
  イテレータのメソッドは、連鎖することができ、非常に読みやすいデータ処理のコードになります。
],
ru: [
  Итераторы предоставляют мощный набор функциональности, который в C
  пришлось бы реализовывать вручную: цепочки, объединение (zip), нумерацию
  (enumerate), поиск минимума или максимума, суммирование и многое другое.
  Методы итераторов также можно объединять в цепочки, что даёт очень
  читаемый код обработки данных.
],
zh: [
  迭代器提供了一个有强大功能的数组，在C中你不得不手动实现它，比如chaining，zipping，enumerating，找到最小或最大值，summing，等等。迭代器方法也能被链式调用，提供了可读性非常高的数据处理代码。
]))

#let url_iter_book = "https://doc.rust-lang.org/book/ch13-02-iterators.html"
#let url_iter_doc = "https://doc.rust-lang.org/core/iter/trait.Iterator.html"
#tr((
en: [
  See the #link(url_iter_book)[Iterators in the Book] and
  #link(url_iter_doc)[Iterator documentation] for more details.
],
de: [
  Weitere Informationen finden Sie unter
  #link(url_iter_book)[Iteratoren im Buch]
  und #link(url_iter_doc)[Iterator-Dokumentation].
],
ja: [
  詳細は#link(url_iter_book)[the Bookのイテレータ]と#link(url_iter_doc)[イテレータのドキュメント]を参照して下さい。
],
ru: [
  Подробнее см. #link(url_iter_book)[Итераторы в книге]
  и #link(url_iter_doc)[документацию по итераторам].
],
zh: [
  阅读#link(url_iter_book)[Iterators in the Book]和#link(url_iter_doc)[Iterator documentation]获取更多细节。
]))

== #tr((
  en: [References vs Pointers],
  de: [Referenzen vs.~Zeiger],
  ja: [参照 vs ポインタ],
  ru: [Ссылки и указатели],
  zh: [引用和指针],
))

#let url_derefraw = "https://doc.rust-lang.org/book/ch19-01-unsafe-rust.html#dereferencing-a-raw-pointer"
#tr((
en: [
  In Rust, pointers (called #link(url_derefraw)[_raw pointers_])
  exist but are only used in specific circumstances, as dereferencing them
  is always considered `unsafe` -- Rust cannot provide its usual
  guarantees about what might be behind the pointer.
],
de: [
  In Rust gibt es zwar Zeiger (sogenannte
  #link(url_derefraw)[_Raw Pointer_]),
  diese werden jedoch nur unter bestimmten Umständen verwendet, da ihre
  Dereferenzierung stets als `unsafe` gilt -- Rust kann nämlich nicht die
  üblichen Garantien darüber geben, was sich hinter dem Zeiger befindet.
],
ja: [
  Rustでも、ポインタ（\[_生ポインタ_
  と呼びます\]）は存在しますが、限られた状況でしか使いません。
  ポインタの参照外しは、常に`unsafe`と考えられるからです。
  Rustは、ポインタの背後にあるかもしれないものについて、通常の保証を提供できません。
],
ru: [
  В Rust указатели (называемые
  #link(url_derefraw)[_сырыми указателями_])
  существуют, но используются только в особых случаях, поскольку
  разыменование их всегда считается `unsafe` --- Rust не может обеспечить
  свои обычные гарантии относительно того, что находится за указателем.
],
zh: [
  在Rust中，存在指针(被叫做
  #link(url_derefraw)[_裸指针_])但是只能在特殊的环境中被使用，因为解引用裸指针总是被认为是`unsafe`的 -- Rust通常不能保障指针背后有什么。
]))

#tr((
en: [
  In most cases, we instead use _references_, indicated by the `&`
  symbol, or _mutable references_, indicated by `&mut`. References
  behave similarly to pointers, in that they can be dereferenced to access
  the underlying values, but they are a key part of Rust's ownership
  system: Rust will strictly enforce that you may only have one mutable
  reference _or_ multiple non-mutable references to the same value at
  any given time.
],
de: [
  Meistens verwenden wir stattdessen _Referenzen_ (gekennzeichnet
  durch das Symbol `&`) oder _veränderbare Referenzen_
  (gekennzeichnet durch `&mut`). Referenzen verhalten sich ähnlich wie
  Zeiger, da sie dereferenziert werden können, um auf die
  zugrundeliegenden Werte zuzugreifen; sie sind jedoch ein wesentlicher
  Bestandteil des Ownership-Systems von Rust: Rust stellt strikt sicher,
  dass zu jedem Zeitpunkt entweder nur eine veränderbare Referenz
  _oder_ mehrere unveränderbare Referenzen auf denselben Wert
  existieren dürfen.
],
ja: [
  代わりに、ほとんどの場合、`&`のシンボルで表現される _参照_ もしくは
  `&mut`で表現される _ミュータブルな参照_ を使います。
  参照は、ポインタと似た働きをします。つまり、裏にある値にアクセスするために参照外しができます。
  しかし、参照は、Rustの所有権システムの重要な一部です。
  Rustは、どんな時でも同じ値に対して、唯一のミュータブル参照を持つか、_あるいは_、複数のイミュータブル参照を持つか、を厳密に強制します。
],
ru: [
  В большинстве случаев вместо них мы используем _ссылки_,
  обозначаемые символом `&`, или _изменяемые ссылки_, обозначаемые
  `&mut`. Ссылки ведут себя похоже на указатели в том смысле, что их можно
  разыменовать, чтобы получить доступ к базовым значениям, но они являются
  ключевой частью системы владения Rust: Rust строго следит за тем, что в
  любой момент времени для одного и того же значения может существовать
  только одна изменяемая ссылка _или_ несколько неизменяемых ссылок.
],
zh: [
  在大多数例子里，我们使用 _引用_ 来替代，由`&`符号指出，或者
  _可变引用_，由`&mut`指出。引用与指针相似，因为它能被解引用来访问底层的数据，但是它们是Rust的所有权系统的一个关键部分:
  Rust将严格强迫你在任何给定时间只有一个可变引用 _或者_
  对相同数据的多个不变引用。
]))

#tr((
en: [
  In practice this means you have to be more careful about whether you
  need mutable access to data: where in C the default is mutable and you
  must be explicit about `const`, in Rust the opposite is true.
],
de: [
  In der Praxis bedeutet dies, dass man genauer abwägen muss, ob man
  veränderbaren Zugriff auf Daten benötigt: Während in C Veränderbarkeit
  der Standard ist und `const` explizit angegeben werden muss, verhält es
  sich in Rust genau umgekehrt.
],
ja: [
  実際のところ、データへのミュータブルアクセスが必要かどうか、をより慎重に検討する必要があることを意味します。
  Cではデフォルトがミュータブルであり、明示的に`const`をつける必要があります。Rustではその反対です。
],
ru: [
  На практике это означает, что нужно внимательнее относиться к тому,
  нужен ли вам изменяемый доступ к данным: тогда как в C по умолчанию всё
  изменяемо и нужно явно указывать `const`, в Rust верно обратное.
],
zh: [
  在实践中，这意味着你必须要更加小心你是否需要对数据的可变访问：在C中默认是可变的，你必须显式地使用`const`，在Rust中正好相反。
]))

#tr((
en: [
  One situation where you might still use raw pointers is interacting
  directly with hardware (for example, writing a pointer to a buffer into
  a DMA peripheral register), and they are also used under the hood for
  all peripheral access crates to allow you to read and write
  memory-mapped registers.
],
de: [
  Eine Situation, in der man dennoch „Raw Pointer" (rohe Zeiger) verwenden
  könnte, ist die direkte Interaktion mit Hardware (zum Beispiel beim
  Schreiben eines Zeigers auf einen Puffer in ein DMA-Peripherieregister);
  zudem kommen sie im Hintergrund bei allen Crates für den
  Peripheriezugriff zum Einsatz, um das Lesen und Schreiben
  speicherabgebildeter Register (memory-mapped registers) zu ermöglichen.
],
ja: [
  生ポインタを使う可能性のある状況の1つは、直接ハードウェアとやり取りする時です（DMAペリフェラルのレジスタにバッファのポインタを書き込むなど）。
  また、生ポインタは、メモリマップドレジスタの読み書きを可能にするために、ペリフェラルアクセスクレートの内部で使われています。
],
ru: [
  Одна из ситуаций, в которых вы всё же можете использовать сырые
  указатели, --- прямое взаимодействие с аппаратурой (например, запись
  указателя на буфер в регистр периферии DMA). Кроме того, они
  используются «под капотом» всех крейтов доступа к периферии, чтобы
  позволить читать и записывать регистры, отображённые в память.
],
zh: [
  某个情况下，你可能仍然要使用裸指针直接与硬件进行交互(比如，写入一个指向DMA外设寄存器中的缓存的指针)，它们也被所有的外设访问crates在底层使用，让你可以读取和写入存储映射寄存器。
]))

== #tr((
  en: [Volatile Access],
  de: [Volatiler (unsicherer) Zugriff],
  ja: [Volatileアクセス],
  ru: [Летучий (volatile) доступ],
  zh: [Volatile访问],
))

#tr((
en: [
  In C, individual variables may be marked `volatile`, indicating to the
  compiler that the value in the variable may change between accesses.
  Volatile variables are commonly used in an embedded context for
  memory-mapped registers.
],
de: [
  In C können einzelne Variablen mit `volatile` gekennzeichnet werden, um
  dem Compiler mitzuteilen, dass sich ihr Wert zwischen den Zugriffen
  ändern kann. Volatile Variablen werden häufig in eingebetteten Systemen
  für im Speicher abgebildete Register verwendet.
],
ja: [
  Cでは、個別の変数に`volatile`を付けることができます。
  これは、変数の値がアクセスごとに変わるかもしれない、ということをコンパイラに伝えます。
  組込みでは、Volatile変数はメモリマップドレジスタに広く使用されています。
],
ru: [
  В C отдельные переменные можно пометить как `volatile`, что указывает
  компилятору, что значение переменной может измениться между обращениями.
  Volatile-переменные обычно используются во встраиваемом контексте для
  регистров, отображённых в память.
],
zh: [
  在C中，某个变量可能被标记成`volatile`，向编译器指出，变量中的值在访问间可能改变。Volatile变量通常用于一个与存储映射的寄存器有关的嵌入式上下文中。
]))

#let ln_read = link("https://doc.rust-lang.org/core/ptr/fn.read_volatile.html")[`core::ptr::read_volatile`]
#let ln_write = link("https://doc.rust-lang.org/core/ptr/fn.write_volatile.html")[`core::ptr::write_volatile`]
#tr((
en: [
  In Rust, instead of marking a variable as `volatile`, we use specific
  methods to perform volatile access: #ln_read and #ln_write.
  These methods take a `*const T` or a `*mut T` (_raw pointers_, as
  discussed above) and perform a volatile read or write.
],
de: [
  In Rust verwenden wir anstelle der Kennzeichnung einer Variable als
  `volatile` spezielle Methoden für den Zugriff auf unsichere Daten:
  #ln_read und #ln_write.
  Diese Methoden akzeptieren einen `*const T` oder einen `*mut T`
  (Rohzeiger, wie oben beschrieben) und führen einen flüchtigen Lese- bzw.
  Schreibvorgang durch.
],
ja: [
  Rustでは、変数に`volatile`を付けるのではなく、volatileアクセスをするための特定のメソッドを使います。
  #ln_read;と#ln_write;です。
  これらのメソッドは、`*const T`か`*mut T`（上述の通り _生ポインタ_
  です）を受け取り、volatileな読み書きを行います。
],
ru: [
  В Rust вместо пометки переменной как `volatile` мы используем
  специальные методы для volatile-доступа:
  #ln_read и #ln_write.
  Эти методы принимают `*const T` или `*mut T` (_сырые указатели_, о
  которых говорилось выше) и выполняют volatile-чтение или запись.
],
zh: [
  在Rsut中，并不使用`volatile`标记变量，我们使用特定的方法去执行volatile访问:
  #ln_read 和 #ln_write。这些方法使用一个
  `*const T` 或者一个 `*mut T` (上面说的 _裸指针_
  )，执行一个volatile读取或者写入。
]))

#tr((
en: [
  For example, in C you might write:
],
de: [
  In C könnten Sie zum Beispiel schreiben:
],
ja: [
  例えば、Cでは次のように書きます。
],
ru: [
  Например, в C можно написать:
],
zh: [
  比如，在C中你可能这样写:
]))
 
#raw(block: true, lang: "c",
"volatile bool signalled = false;

void ISR() {
    // " + ts((
        en: "Signal that the interrupt has occurred",
        de: "Signalisieren, dass der Interrupt aufgetreten ist",
        ja: "割り込みが発生したというシグナル",
        ru: "Сигнализируем, что прерывание произошло",
        zh: "提醒中断已经发生了"
      )) + "
    signalled = true;
}

void driver() {
    while(true) {
        // " + ts((
            en: "Sleep until signalled",
            de: "Schlafen bis zum Signal",
            ja: "シグナルがあるまでスリープします",
            ru: "Спим, пока не получим сигнал",
            zh: "睡眠直到信号来了",
          )) + "
        while(!signalled) { WFI(); }
        // " + ts((
            en: "Reset signalled indicator",
            de: "Signalisierten Indikator zuruecksetzen",
            ja: "シグナルをリセットします",
            ru: "Сбрасываем индикатор сигнала",
            zh: "重置信号提示符"
          )) + "
        signalled = false;
        // " + ts((
            en: "Perform some task that was waiting for the interrupt",
            de: "Fuehren Sie eine Aufgabe aus, die auf den Interrupt gewartet hat",
            ja: "割り込みを待っていた何らかのタスクを実行します",
            ru: "Выполняем задачу, которая ждала прерывания",
            zh: "执行一些正在等待这个中断的任务",
          )) + "
        run_task();
    }
}
")

#tr((
en: [
  The equivalent in Rust would use volatile methods on each access:
],
de: [
  Das Äquivalent in Rust würde bei jedem Zugriff volatile Methoden verwenden:
],
ja: [
  Rustで同じことをするには、各アクセスにvolatileメソッドを使用します。
],
ru: [
  Эквивалент на Rust использовал бы volatile-методы при каждом обращении:
],
zh: [
  在Rust中对每个访问使用volatile方法能达到相同的效果:
]))

#raw(block: true, lang: "rust",
"static mut SIGNALLED: bool = false;

#[interrupt]
fn ISR() {
    // " + ts((
        en: "Signal that the interrupt has occurred
    // (In real code, you should consider a higher level primitive,
    //  such as an atomic type).",
        de: "Signalisieren, dass eine Unterbrechung aufgetreten ist
    // (Im realen Code sollten Sie eine hoeherwertige primitive Datenstruktur, 
    // wie z. B. einen atomaren Datentyp, in Betracht ziehen).",
        ja: "割り込みが発生したというシグナル
    // （実際のコードでは、アトミック型のような、より上位レベルのプリミティブを検討して下さい）",
        ru: "Сигнализируем, что прерывание произошло
    // (В реальном коде стоит рассмотреть примитив более высокого уровня,
    //  например атомарный тип.)",
        zh: "提醒中断已经发生
    // (在正在的代码中，你应该考虑一个更高级的基本类型,
    // 比如一个原子类型)"
      )) + "
    unsafe { core::ptr::write_volatile(&mut SIGNALLED, true) };
}

fn driver() {
    loop {
        // " + ts((
            en: "Sleep until signalled",
            de: "Schlafen bis zum Signal",
            ja: "シグナルがあるまでスリープします",
            ru: "Спим, пока не получим сигнал",
            zh: "睡眠直到信号来了",
          )) + "
        while unsafe { !core::ptr::read_volatile(&SIGNALLED) } {}
        // " + ts((
            en: "Reset signalled indicator",
            de: "Signalisierten Indikator zuruecksetzen",
            ja: "シグナルをリセットします",
            ru: "Сбрасываем индикатор сигнала",
            zh: "重置信号指示符",
          )) + "
        unsafe { core::ptr::write_volatile(&mut SIGNALLED, false) };
        // " + ts((
            en: "Perform some task that was waiting for the interrupt",
            de: "Fuehren Sie eine Aufgabe aus, die auf den Interrupt gewartet hat",
            ja: "割り込みを待っていた何らかのタスクを実行します",
            ru: "Выполняем задачу, которая ждала прерывания",
            zh: "执行一些正在等待中断的任务",
          )) + "
        run_task();
    }
}
")

#tr((
en: [
  A few things are worth noting in the code sample:
  - We can pass `&mut SIGNALLED` into the function requiring `*mut T`, since `&mut T`
    automatically converts to a `*mut T` (and the same for `*const T`)
  - We need `unsafe` blocks for the `read_volatile`/`write_volatile` methods,
    since they are `unsafe` functions. It is the programmer's responsibility
    to ensure safe use: see the methods' documentation for further details.
],
de: [
  Am Codebeispiel sind einige Dinge erwähnenswert:
  - Wir können `&mut SIGNALLED` an die Funktion übergeben, die `*mut T`
    erwartet, da `&mut T` automatisch in `*mut T` umgewandelt wird (und
    das Gleiche gilt für `*const T`).
  - Für die Methoden `read_volatile` und `write_volatile` benötigen wir
    `unsafe`-Blöcke, da es sich um `unsafe`-Funktionen handelt. Es liegt
    in der Verantwortung des Programmierers, für eine sichere Verwendung
    zu sorgen; weitere Einzelheiten sind der Dokumentation der jeweiligen
    Methoden zu entnehmen.
],
ja: [
  このコードサンプルには、いくつかの注目すべき点があります。
  - `*mut T`を要求する関数に、`&mut SIGNALLED`を渡すことができます。
  これは、`&mut T`が`*mut T`に自動的に変換されるためです（`*const T`についても同じです）。
  - `read_volatile`/`write_volatile`メソッドに`unsafe`ブロックが必要です。
  これらの関数は`unsafe`だからです。安全な使用を保証することはプログラマの責任です。
  詳細は、メソッドのドキュメントを参照して下さい。
],
ru: [
  В этом примере кода стоит отметить несколько моментов:
  - Мы можем
    передать `&mut SIGNALLED` в функцию, требующую `*mut T`, поскольку
    `&mut T` автоматически преобразуется в `*mut T` (то же самое верно и для
    `*const T`);
  - Нам нужны блоки `unsafe` для методов
    `read_volatile`/`write_volatile`, так как это `unsafe`-функции.
    Программист несёт ответственность за безопасное использование:
    подробности см. в документации к этим методам.
],
zh: [
  在示例代码中有些事情值得注意:
  - 我们可以把`&mut SIGNALLED`传递给要求`*mut T`的函数中，因为`&mut T`会自动转换成一个`*mut T`
  (对于`*const T`来说是一样的)
  - 我们需要为`read_volatile`/`write_volatile`方法使用`unsafe`块，因为它们是`unsafe`的函数。确保操作安全变成了程序员的责任：看方法的文档获得更多细节。
]))

#tr((
en: [
  It is rare to require these functions directly in your code, as they
  will usually be taken care of for you by higher-level libraries. For
  memory mapped peripherals, the peripheral access crates will implement
  volatile access automatically, while for concurrency primitives there
  are better abstractions available (see the
  #link(<concurrency>)[Concurrency chapter]).
],
de: [
  Es ist selten erforderlich, diese Funktionen direkt im eigenen Code zu
  verwenden, da sie üblicherweise von höherwertigen Bibliotheken für Sie
  übernommen werden. Bei speicherabgebildeten Peripheriekomponenten
  implementieren die entsprechenden „Peripheral Access Crates" den
  volatilen Zugriff automatisch, während für Nebenläufigkeits-Primitive
  bessere Abstraktionen zur Verfügung stehen (siehe das Kapitel
  #link(<concurrency>)[Nebenläufigkeit]).
],
ja: [
  これらの関数をコードに直接書くことは稀です。通常、より上位レベルのライブラリで面倒を見てくれます。
  メモリマップドペリフェラルについては、ペリフェラルアクセスクレートがvolatileアクセスを自動的に実装します。
  並行性プリミティブの場合、より優れた抽象化が利用できます（#link(<concurrency>)[並行性の章]を参照して下さい）。
],
ru: [
  Редко приходится вызывать эти функции напрямую в своём коде, так как
  обычно о них позаботятся библиотеки более высокого уровня. Для
  регистров, отображённых в память, крейты доступа к периферии реализуют
  volatile-доступ автоматически, а для примитивов конкурентности есть
  более подходящие абстракции (см.
  #link(<concurrency>)[главу о конкурентности]).
],
zh: [
  在你的代码中直接使用这些函数是很少见的，因为它们通常由更高级的库封装起来为你提供服务。对于存储映射的外设，提供外设访问的crates将自动实现volatile访问，而对于并发的基本类型，存在更好的抽象可用。(看#link(<concurrency>)[并发章节])
]))

== #tr((
  en: [Packed and Aligned Types],
  de: [Gepackte und ausgerichtete Datentypen],
  ja: [パック型と整列型],
  ru: [Упакованные и выровненные типы],
  zh: [填充和对齐类型],
))

#tr((
en: [
  In embedded C it is common to tell the compiler a variable must have a
  certain alignment or a struct must be packed rather than aligned,
  usually to meet specific hardware or protocol requirements.
],
de: [
  In der Embedded-Programmierung mit C ist es üblich, dem Compiler
  vorzugeben, dass eine Variable eine bestimmte Ausrichtung (Alignment)
  aufweisen oder eine Struktur „gepackt" (packed) statt ausgerichtet sein
  muss -- meist, um spezifische Hardware- oder Protokollanforderungen zu erfüllen.
],
ja: [
  組込みCでは、通常、特定のハードウェアやプロトコルの要件を満たすために、変数に特定のアライメントが必要なことや、
  構造体が整列されているだけでなくパックされている必要があることを、コンパイラに指示することが一般的です。
],
ru: [
  Во встраиваемом C часто требуется сообщить компилятору, что переменная
  должна иметь определённое выравнивание или что структура должна быть
  упакованной (packed), а не выровненной, обычно чтобы соответствовать
  требованиям конкретной аппаратуры или протокола.
],
zh: [
  在嵌入式C中，告诉编译器一个变量必须遵守某个对齐或者一个结构体必须被填充而不是对齐，是很常见的行为，通常是为了满足特定的硬件或者协议要求。
]))

#tr((
en: [
  In Rust this is controlled by the `repr` attribute on a struct or union.
  The default representation provides no guarantees of layout, so should
  not be used for code that interoperates with hardware or C. The compiler
  may re-order struct members or insert padding and the behaviour may
  change with future versions of Rust.
],
de: [
  In Rust wird dies über das `repr`-Attribut an einer `struct` oder
  `union` gesteuert. Die Standarddarstellung macht keine Zusagen über das
  Speicherlayout und sollte daher nicht für Code verwendet werden, der mit
  Hardware oder C interagiert. Der Compiler kann die Reihenfolge der
  Strukturmitglieder ändern oder Füllbytes (Padding) einfügen, und das
  Verhalten kann sich in zukünftigen Rust-Versionen ändern.
],
ja: [
  Rustでは、これは構造体または共用体の`repr`アトリビュートによって制御されます。
  デフォルトでは、レイアウトは保証されないため、ハードウェアやCとやり取りするコードでは使うべきではありません。
  コンパイラは、構造体のメンバを並べ替えたり、パディングを挿入したりする可能性があります。この動作は将来のバージョンのRustで変更になる可能性があります。
],
ru: [
  В Rust это управляется атрибутом `repr` для структуры или объединения
  (union). Представление по умолчанию не даёт никаких гарантий о
  раскладке, поэтому его не следует использовать для кода, который
  взаимодействует с аппаратурой или C. Компилятор может переупорядочивать
  поля структуры или вставлять дополнительные байты заполнения (padding),
  и поведение может измениться в будущих версиях Rust.
],
zh: [
  在Rust中，这由一个结构体或者联合体上的`repr`属性来控制。默认的表示(representation)不保障布局，因此不应该被用于与硬件或者C互用的代码。编译器可能会对结构体成员重新排序或者插入填充，且这种行为可能在未来的Rust版本中改变。
]))

#raw(block: true, lang: "rust",
"struct Foo {
    x: u16,
    y: u8,
    z: u16,
}

fn main() {
    let v = Foo { x: 0, y: 0, z: 0 };
    println!(\"{:p} {:p} {:p}\", &v.x, &v.y, &v.z);
}

// 0x7ffecb3511d0 0x7ffecb3511d4 0x7ffecb3511d2
// " + ts((
    en: "Note ordering has been changed to x, z, y to improve packing.",
    de: "Die Reihenfolge der Noten wurde auf x, z, y geaendert, um die Packdichte zu 
// verbessern.",
    ja: "データの詰め方を改善するために、x, y, zの順序が入れ替わっていることに注目して下さい。",
    ru: "0x7ffecb3511d0 0x7ffecb3511d4 0x7ffecb3511d2
// Обратите внимание, что порядок изменён на x, z, y для лучшей упаковки.",
    zh: "0x7ffecb3511d0 0x7ffecb3511d4 0x7ffecb3511d2
// 注意为了改进填充，顺序已经被变成了x, z, y"
  )) + "
")

#tr((
en: [
  To ensure layouts that are interoperable with C, use `repr(C)`:
],
de: [
  Um Layouts zu gewährleisten, die mit C interoperabel sind, verwenden Sie `repr(C)`:
],
ja: [
  Cと相互にやり取りできるレイアウトを保証するためには、`repr(C)`を使います。
],
ru: [
  Чтобы гарантировать раскладку, совместимую с C, используйте `repr(C)`:
],
zh: [
  使用`repr(C)`可以确保布局可以与C互用。
]))

#raw(block: true, lang: "rust",
"#[repr(C)]
struct Foo {
    x: u16,
    y: u8,
    z: u16,
}

fn main() {
    let v = Foo { x: 0, y: 0, z: 0 };
    println!(\"{:p} {:p} {:p}\", &v.x, &v.y, &v.z);
}

// 0x7fffd0d84c60 0x7fffd0d84c62 0x7fffd0d84c64
// " + ts((
    en: "Ordering is preserved and the layout will not change over time.
// `z` is two-byte aligned so a byte of padding exists between `y` and `z`.",
    de: "Die Reihenfolge bleibt erhalten und das Layout veraendert sich im Laufe der 
// Zeit nicht.
// `z` ist auf Zwei-Byte-Grenzen ausgerichtet, sodass sich zwischen `y` und `z` 
// ein Padding-Byte befindet.",
    ja: "順序は維持され、レイアウトは時間が経っても変化しません。
// `z`は2バイトで整列されており、`y`と`z`の間には、1バイトのパディングが存在します。",
    ru: "0x7fffd0d84c60 0x7fffd0d84c62 0x7fffd0d84c64
// Порядок сохранён, и раскладка не будет меняться со временем.
// `z` выровнен по двум байтам, поэтому между `y` и `z` есть один байт заполнения.",
    zh: "0x7fffd0d84c60 0x7fffd0d84c62 0x7fffd0d84c64
// 顺序被保留了，布局将不会随着时间而改变
// `z`是两个字节对齐，因此在`y`和`z`之间填充了一个字节。"
  )) + "
")

#tr((
en: [
  To ensure a packed representation, use `repr(packed)`:
],
de: [
  Um eine kompakte Darstellung zu gewährleisten, verwenden Sie `repr(packed)`:
],
ja: [
  パックされた表現を保証する場合、`repr(packed)`を使います。
],
ru: [
  Чтобы гарантировать упакованное представление, используйте `repr(packed)`:
],
zh: [
  使用`repr(packed)`去确保表示(representation)被填充了:
]))

#raw(block: true, lang: "rust",
"#[repr(packed)]
struct Foo {
    x: u16,
    y: u8,
    z: u16,
}

fn main() {
    let v = Foo { x: 0, y: 0, z: 0 };
    // " + ts((
        en: "References must always be aligned, so to check the addresses of the
    // struct's fields, we use `std::ptr::addr_of!()` to get a raw pointer
    // instead of just printing `&v.x`.",
        de: "Referenzen muessen stets korrekt ausgerichtet sein; um also die 
    // Adressen der Struct-Felder zu ueberpruefen, verwenden wir 
    // `std::ptr::addr_of!()`, um einen Rohzeiger (Raw Pointer) zu erhalten, 
    // anstatt einfach `&v.x` auszugeben.",
        ja: "パックされた構造体のフィールドを借用するには、アンセーフが必要です。",
        ru: "Ссылки всегда должны быть выровненными, поэтому чтобы проверить адреса
    // полей структуры, мы используем `std::ptr::addr_of!()`, чтобы получить сырой указатель,
    // вместо того чтобы просто выводить `&v.x`.",
        zh: "引用必须总是对齐的，因此为了检查结构体字段的地址，我们使用
    // `std::ptr::addr_of!()`去获取一个裸指针而不仅是打印`&v.x`"
      )) + "
    let px = std::ptr::addr_of!(v.x);
    let py = std::ptr::addr_of!(v.y);
    let pz = std::ptr::addr_of!(v.z);
    println!(\"{:p} {:p} {:p}\", px, py, pz);
}

// 0x7ffd33598490 0x7ffd33598492 0x7ffd33598493
// " + ts((
    en: "No padding has been inserted between `y` and `z`, so now `z` is unaligned.",
    de: "Zwischen `y` und `z` wurde kein Padding eingefuegt, daher ist `z` nun 
// nicht ausgerichtet.",
    ja: "`y`と`z`の間にパディングは挿入されていません。そのため、`z`は整列されていません。",
    ru: "0x7ffd33598490 0x7ffd33598492 0x7ffd33598493
// Между `y` и `z` не вставлено заполнение, поэтому теперь `z` не выровнено.",
    zh: "0x7ffd33598490 0x7ffd33598492 0x7ffd33598493
// 在`y`和`z`没有填充被插入，因此现在`z`没有被对齐。"
  )) + "
")

#tr((
en: [
  Note that using `repr(packed)` also sets the alignment of the type to `1`.
],
de: [
  Beachten Sie, dass die Verwendung von `repr(packed)` die Ausrichtung des
  Typs ebenfalls auf `1` setzt.
],
ja: [
  `repr(packed)`を使うと、型のアライメントも`1`に設定されることに注意して下さい。
],
ru: [
  Обратите внимание, что использование `repr(packed)` также устанавливает
  выравнивание типа равным `1`.
],
zh: [
  注意使用`repr(packed)`也会将类型的对齐设置成`1` 。
]))

#tr((
en: [
  Finally, to specify a specific alignment, use `repr(align(n))`, where
  `n` is the number of bytes to align to (and must be a power of two):
],
de: [
  Um eine bestimmte Ausrichtung festzulegen, verwenden Sie schließlich
  `repr(align(n))`, wobei `n` die Anzahl der auszurichtenden Bytes ist
  (und eine Zweierpotenz sein muss).
],
ja: [
  最後に、特定のアライメントを指定するために、`repr(align(n))`を使います。
  ここで`n`は、整列するバイト数です（2の累乗である必要があります）。
],
ru: [
  Наконец, чтобы задать конкретное выравнивание, используйте
  `repr(align(n))`, где `n` --- количество байтов, по которым нужно
  выравнивать (и оно должно быть степенью двойки):
],
zh: [
  最后，为了指定一个特定的对齐，可以使用`repr(align(n))`，`n`是要对齐的字节数(必须是2的幂):
]))

#raw(block: true, lang: "rust",
"#[repr(C)]
#[repr(align(4096))]
struct Foo {
    x: u16,
    y: u8,
    z: u16,
}

fn main() {
    let v = Foo { x: 0, y: 0, z: 0 };
    let u = Foo { x: 0, y: 0, z: 0 };
    println!(\"{:p} {:p} {:p}\", &v.x, &v.y, &v.z);
    println!(\"{:p} {:p} {:p}\", &u.x, &u.y, &u.z);
}

// 0x7ffec909a000 0x7ffec909a002 0x7ffec909a004
// 0x7ffec909b000 0x7ffec909b002 0x7ffec909b004
// " + ts((
    en: "The two instances `u` and `v` have been placed on 4096-byte alignments,
// evidenced by the `000` at the end of their addresses.",
    de: "Die beiden Instanzen `u` und `v` wurden an 4096-Byte-Grenzen ausgerichtet, 
// was an den `000` am Ende ihrer Adressen erkennbar ist.",
    ja: "2つのインスタンス`u`と`v`は4096バイトのアライメントで配置されます。
// インスタンスのアドレスの最後は`000`になっています。",
    ru: "0x7ffec909a000 0x7ffec909a002 0x7ffec909a004
// 0x7ffec909b000 0x7ffec909b002 0x7ffec909b004
// Два экземпляра `u` и `v` размещены на границах 4096 байт,
// о чём свидетельствуют `000` в конце их адресов.",
    zh: "`u`和`v`两个实例已经被放置在4096字节的对齐上。
// 它们地址结尾处的`000`证明了这件事。"
  )) + "
")

#tr((
en: [
  Note we can combine `repr(C)` with `repr(align(n))` to obtain an aligned
  and C-compatible layout. It is not permissible to combine
  `repr(align(n))` with `repr(packed)`, since `repr(packed)` sets the
  alignment to `1`. It is also not permissible for a `repr(packed)` type
  to contain a `repr(align(n))` type.
],
de: [
  Beachten Sie, dass wir `repr(C)` mit `repr(align(n))` kombinieren
  können, um ein ausgerichtetes und C-kompatibles Layout zu erhalten. Die
  Kombination von `repr(align(n))` mit `repr(packed)` ist nicht zulässig,
  da `repr(packed)` die Ausrichtung auf `1` setzt. Ebenso ist es nicht
  zulässig, dass ein `repr(packed)`-Typ einen `repr(align(n))`-Typ
  enthält.
],
ja: [
  整列されていてCと互換性のあるレイアウトを取得するため、`repr(C)`と`repr(align(n))`とを組み合わせることができます。
  `repr(align(n))`と`repr(packed)`とを組み合わせることはできません。`repr(packed)`はアライメントを`1`に設定するからです。
  `repr(packed)`の型を`repr(align(n))`の型に含めることもできません。
],
ru: [
  Обратите внимание, что `repr(C)` можно комбинировать с `repr(align(n))`,
  чтобы получить выровненную раскладку, совместимую с C. Нельзя
  комбинировать `repr(align(n))` с `repr(packed)`, так как `repr(packed)`
  устанавливает выравнивание равным `1`. Также `repr(packed)`-тип не может
  содержать тип с `repr(align(n))`.
],
zh: [
  注意我们可以结合`repr(C)`和`repr(align(n))`来获取一个对齐的c兼容的布局。不允许将`repr(align(n))`和`repr(packed)`一起使用，因为`repr(packed)`将对齐设置为`1`。也不允许一个`repr(packed)`类型包含一个`repr(align(n))`类型。
]))

#let url_layout = "https://doc.rust-lang.org/reference/type-layout.html"
#tr((
en: [
  For further details on type layouts, refer to the #link(url_layout)[type layout]
  chapter of the Rust Reference.
],
de: [
  Weitere Details zu Typ-Layouts finden Sie im Kapitel
  #link(url_layout)[Typ-Layout] der Rust-Referenz.
],
ja: [
  型レイアウトに関するさらなる詳細は、Rustリファレンスの#link(url_layout)[型レイアウト]の章を参照して下さい。
],
ru: [
  Подробнее о раскладке типов см. главу #link(url_layout)[type layout]
  справочника Rust.
],
zh: [
  关于类型布局更多的细节，参考the Rust Reference的#link(url_layout)[type layout]章节。
]))

== #tr((
  en: [Other Resources],
  de: [Weitere Ressourcen],
  ja: [その他のリソース],
  ru: [Другие ресурсы],
  zh: [其它资源],
))

#let url_faq = "https://docs.rust-embedded.org/faq.html"
#let url_for_c = "http://blahg.josefsipek.net/?p=580"
#let url_pointers = "https://github.com/diwic/reffers-rs/blob/master/docs/Pointers.html"
#tr((
en: [
  - In this book:
    - #link(<c-with-rust>)[A little C with your Rust]
    - #link(<rust-with-c>)[A little Rust with your C]
  - #link(url_faq)[The Rust Embedded FAQs]
  - #link(url_for_c)[Rust Pointers for C Programmers]
  - #link(url_pointers)[I used to use pointers - now what?]
],
de: [
  - In diesem Buch:
    - #link(<c-with-rust>)[Ein bisschen C zu Ihrem Rust]
    - #link(<rust-with-c>)[Ein bisschen Rust zu Ihrem C]
  - #link(url_faq)[Die Rust-Embedded-FAQs]
  - #link(url_for_c)[Rust-Pointer für C-Programmierer]
  - #link(url_pointers)[Früher habe ich Pointer verwendet -- und jetzt?]
],
ja: [
  - 本書内
    - #link(<c-with-rust>)[Rustと少しのC]
    - #link(<rust-with-c>)[Cと少しのRust]
  - #link(url_faq)[組込みRustよくある質問]
  - #link(url_for_c)[CプログラマのためのRustのポインタ]
  - #link(url_pointers)[昔はポインタを使っていました。今は？]
],
ru: [
  - В этой книге:
    - #link(<c-with-rust>)[Немного C в вашем Rust]
    - #link(<rust-with-c>)[Немного Rust в вашем C]
  - #link(url_faq)[Часто задаваемые вопросы о Rust для встраиваемых систем]
  - #link(url_for_c)[Указатели Rust для программистов на C]
  - #link(url_pointers)[I used to use pointers - now what?]

],
zh: [
  - 这本书中:
    - #link(<c-with-rust>)[使用C的Rust]
    - #link(<rust-with-c>)[使用Rust的C]
  - #link(url_faq)[The Rust Embedded FAQs]
  - #link(url_for_c)[Rust Pointers for C Programmers]
  - #link(url_pointers)[I used to use pointers - now what?]
]))
