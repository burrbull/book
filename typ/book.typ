#import "config.typ": *
#import "mdbook/lib.typ": book

#let sources = (
  "intro/index": (
    content: include "intro/index.typ",
    title: if lang == "en" [Introduction]
      else if lang == "de" [Einleitung]
      else if lang == "uk" [Вступ]
      else if lang == "zh" [引言]
      else { todo },
    sub: (
      "intro/hardware": (
        content: include "intro/hardware.typ",
        title: if lang in ("en", "de") [Hardware]
          else if lang == "uk" [Залізо]
          else if lang == "zh" [硬件]
          else { todo }
      ),
      "intro/no-std": (
        content: include "intro/no-std.typ",
        title: `no_std`
      ),
      "intro/tooling": (
        content: include "intro/tooling.typ",
        title: if lang == "en" [Tooling]
          else if lang == "de" [Werkzeuge]
          else if lang == "uk" [Інструменти]
          else if lang == "zh" [工具]
          else { todo }
      ),
      "intro/install": (
        content: include "intro/install.typ",
        title: if lang in ("en", "de") [Installation]
          else if lang == "uk" [Встановлення]
          else if lang == "zh" [安装]
          else { todo },
        sub: (
          "intro/install/linux": (
            content: include "intro/install/linux.typ",
            title: [Linux]
          ),
          "intro/install/macos": (
            content: include "intro/install/macos.typ",
            title: [MacOS]
          ),
          "intro/install/windows": (
            content: include "intro/install/windows.typ",
            title: [Windows]
          ),
          "intro/install/verify": (
            content: include "intro/install/verify.typ",
            title: if lang == "en" [Verify Installation]
              else if lang == "de" [Die Installation überprüfen]
              else if lang == "uk" [Перевірка встановлення]
              else if lang == "zh" [验证工具链的安装]
              else { todo }
          )
        )
      ),
    ),
  ),
  "start/index":
  (
    content: include "start/index.typ",
    title: if lang == "en" [Getting started]
      else if lang == "de" [Erste Schritte]
      else if lang == "uk" [Початок роботи]
      else if lang == "zh" [开始]
      else { todo },
    sub: (
      "start/qemu": (
        content: include "start/qemu.typ",
        title: [QEMU]
      ),
      "start/hardware": (
        content: include "start/hardware.typ",
        title: if lang in ("en", "de") [Hardware]
          else if lang == "uk" [Залізо]
          else if lang == "zh" [硬件]
          else { todo }
      ),
      "start/registers": (
        content: include "start/registers.typ",
        title: if lang == "en" [Memory-mapped Registers]
          else if lang == "de" [Im Speicher abgebildete Register]
          else if lang == "uk" [Відображені в пам'яті регістри]
          else if lang == "zh" [存储映射的寄存器]
          else { todo }
      ),
      "start/semihosting": (
        content: include "start/semihosting.typ",
        title: if lang in ("en", "de", "uk") [Semihosting]
          else if lang == "zh" [半主机模式]
          else { todo }
      ),
      "start/panicking": (
        content: include "start/panicking.typ",
        title: if lang == "en" [Panicking]
          else if lang == "de" [In Panik geraten]
          else if lang == "uk" [Паніка]
          else if lang == "zh" [运行时恐慌(Panicking)]
          else { todo }
      ),
      "start/exceptions": (
        content: include "start/exceptions.typ",
        title: if lang in ("en", "de") [Exceptions]
          else if lang == "uk" [Виключення]
          else if lang == "zh" [异常]
          else { todo }
      ),
      "start/interrupts": (
        content: include "start/interrupts.typ",
        title: if lang in ("en", "de") [Interrupts]
          else if lang == "uk" [Переривання]
          else if lang == "zh" [中断]
          else { todo }
      ),
    )
  ),
  "peripherals/index": (
    content: include "peripherals/index.typ",
    title: if lang == "en" [Peripherals]
      else if lang == "de" [Peripheriegeräte]
      else if lang == "uk" [Периферійні пристрої]
      else if lang == "zh" [外设]
      else { todo },
    sub: (
      "peripherals/a-first-attempt": (
        content: include "peripherals/a-first-attempt.typ",
        title: if lang == "en" [A first attempt in Rust]
          else if lang == "de" [Ein erster Versuch in Rust]
          else if lang == "uk" [Перша спроба на Rust]
          else if lang == "zh" [Rust尝鲜]
          else { todo }
      ),
      "peripherals/borrowck": (
        content: include "peripherals/borrowck.typ",
        title: if lang == "en" [The Borrow Checker]
          else if lang == "de" [Der Borrow-Prüfer]
          else if lang == "uk" [Перевірка запозичень]
          else if lang == "zh" [借用检查器]
          else { todo }
      ),
      "peripherals/singletons": (
        content: include "peripherals/singletons.typ",
        title: if lang in ("en", "de") [Singletons]
          else if lang == "uk" [Одинаки]
          else if lang == "zh" [单例]
          else { todo }
      )
    )
  ),
  "static-guarantees/index": (
    content: include "static-guarantees/index.typ",
    title: if lang == "en" [Static Guarantees]
      else if lang == "de" [Statische Garantien]
      else if lang == "uk" [Статичні гарантії]
      else if lang == "zh" [静态保障(static guarantees)]
      else { todo },
    sub: (
      "static-guarantees/typestate-programming": (
        content: include "static-guarantees/typestate-programming.typ",
        title: if lang == "en" [Typestate Programming]
          else if lang == "de" [Typgestützte Programmierung]
          else if lang == "uk" [Програмування типів-станів]
          else if lang == "zh" [类型状态编程]
          else { todo }
      ),
      "static-guarantees/state-machines": (
        content: include "static-guarantees/state-machines.typ",
        title: if lang == "en" [Peripherals as State Machines]
          else if lang == "de" [Peripheriegeräte als Zustandsmaschinen]
          else if lang == "uk" [Периферія як кінцеві автомати]
          else if lang == "zh" [把外设当作状态机]
          else { todo }
      ),
      "static-guarantees/design-contracts": (
        content: include "static-guarantees/design-contracts.typ",
        title: if lang == "en" [Design Contracts]
          else if lang == "de" [Designverträge]
          else if lang == "uk" [Угоди щодо дизайну]
          else if lang == "zh" [设计约定]
          else { todo }
      ),
      "static-guarantees/zero-cost-abstractions": (
        content: include "static-guarantees/zero-cost-abstractions.typ",
        title: if lang == "en" [Zero Cost Abstractions]
          else if lang == "de" [Abstraktionen ohne Kosten]
          else if lang == "uk" [Безкоштовні абстракції]
          else if lang == "zh" [零成本抽象]
          else { todo }
      ),
    )
  ),
  "portability/index": (
    content: include "portability/index.typ",
    title: if lang == "en" [Portability]
      else if lang == "de" [Portabilität]
      else if lang == "uk" [Переносимість]
      else if lang == "zh" [可移植性]
      else { todo }
  ),
  "concurrency/index": (
    content: include "concurrency/index.typ",
    title: if lang == "en" [Concurrency]
      else if lang == "de" [Nebenläufigkeit]
      else if lang == "uk" [Паралелізм]
      else if lang == "zh" [并发]
      else { todo }
  ),
  "collections/index": (
    content: include "collections/index.typ",
    title: if lang == "en" [Collections]
      else if lang == "de" [Sammlungen]
      else if lang == "uk" [Колекції]
      else if lang == "zh" [容器]
      else { todo }
  ),
  "design-patterns/index": (
    content: include "design-patterns/index.typ",
    title: if lang == "en" [Design Patterns]
      else if lang == "de" [Desginmuster]
      else if lang == "uk" [Шаблони проектування]
      else if lang == "zh" [设计模式]
      else { todo },
    sub: (
      "design-patterns/hal/index": (
        content: include "design-patterns/hal/index.typ",
        title: if lang in ("en", "zh", "de") [HALs]
          else if lang == "uk" [HALи]
          else { todo },
        sub: (
          "design-patterns/hal/checklist": (
            content: include "design-patterns/hal/checklist.typ",
            title: if lang == "en" [Checklist]
              else if lang == "de" [Checkliste]
              else if lang == "uk" [Контрольний список]
              else if lang == "zh" [列表]
              else { todo }
          ),
          "design-patterns/hal/naming": (
            content: include "design-patterns/hal/naming.typ",
            title: if lang == "en" [Naming]
              else if lang == "de" [Benennung]
              else if lang == "uk" [Найменування]
              else if lang == "zh" [命名]
              else { todo }
          ),
          "design-patterns/hal/interoperability": (
            content: include "design-patterns/hal/interoperability.typ",
            title: if lang == "en" [Interoperability]
              else if lang == "de" [Interoperabilität]
              else if lang == "uk" [Сумісність]
              else if lang == "zh" [互操性]
              else { todo }
          ),
          "design-patterns/hal/predictability": (
            content: include "design-patterns/hal/predictability.typ",
            title: if lang == "en" [Predictability]
              else if lang == "de" [Vorhersehbarkeit]
              else if lang == "uk" [Передбачуваність]
              else if lang == "zh" [可预见性]
              else { todo }
          ),
          "design-patterns/hal/gpio": (
            content: include "design-patterns/hal/gpio.typ",
            title: [GPIO]
          ),
        )
      )
    )
  ),
  "c-tips/index": (
    content: include "c-tips/index.typ",
    title: if lang == "en" [Tips for embedded C developers]
      else if lang == "de" [Tipps für Entwickler im Bereich Embedded-C]
      else if lang == "uk" [Поради для розробників мовою C]
      else if lang == "zh" [给嵌入式C开发者的贴士]
      else { todo }
  ),
  "interoperability/index": (
    content: include "interoperability/index.typ",
    title: if lang == "en" [Interoperability]
      else if lang == "de" [Interoperabilität]
      else if lang == "uk" [Сумісність]
      else if lang == "zh" [互操性]
      else { todo },
    sub: (
      "interoperability/c-with-rust": (
        content: include "interoperability/c-with-rust.typ",
        title: if lang == "en" [A little C with your Rust]
          else if lang == "de" [Ein bisschen C zu Ihrem Rust]
          else if lang == "uk" [Трошки C в вашому Rust]
          else if lang == "zh" [使用C的Rust]
          else { todo }
      ),
      "interoperability/rust-with-c": (
        content: include "interoperability/rust-with-c.typ",
        title: if lang == "en" [A little Rust with your C]
          else if lang == "de" [Ein bisschen Rust zu Ihrem C]
          else if lang == "uk" [Трошки Rust в вашому C]
          else if lang == "zh" [使用Rust的C]
          else { todo }
      )
    )
  ),
  "unsorted/index": (
    content: include "unsorted/index.typ",
    title: if lang == "en" [Unsorted topics]
      else if lang == "de" [Unsortierte Themen]
      else if lang == "uk" [Невідсортовані теми]
      else if lang == "zh" [没有排序的主题]
      else { todo },
    sub: (
      "unsorted/speed-vs-size": (
        content: include "unsorted/speed-vs-size.typ",
        title: if lang == "en" [Optimizations: The speed size tradeoff]
          else if lang == "de" [Optimierungen: Der Kompromiss zwischen Geschwindigkeit und Größe]
          else if lang == "uk" [Оптимізація: компроміс між швидкістю та розміром]
          else if lang == "zh" [优化: 速度与大小间的博弈]
          else { todo }
      ),
      "unsorted/math": (
        content: include "unsorted/math.typ",
        title: if lang == "en" [Performing Math Functionality]
          else if lang == "de" [Ausführung mathematischer Funktionen]
          else if lang == "uk" [Виконання математики]
          else if lang == "zh" [执行数学运算]
          else { todo }
      )
    )
  ),
  "appendix/glossary": (
    content: include "appendix/glossary.typ",
    title: if lang == "en" [Appendix A: Glossary]
      else if lang == "de" [Anhang A: Glossar]
      else if lang == "uk" [Додаток А: Глосарій]
      else if lang == "zh" [附录A: 词汇表]
      else { todo }
  )
)

#book(
  tgt,
  sources,
  lang,
  languages,
  book_title: book_title,
)
