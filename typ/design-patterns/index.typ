#import "../config.typ": *

#h1(if lang == "en" [Design Patterns]
  else if lang == "de" [Design-Muster]
  else if lang == "zh" [设计模式]
  else { todo })

#if lang == "en" [
  This chapter aims to collect various useful design patterns for embedded Rust.
] else if lang == "de" [
  Dieses Kapitel zielt darauf ab, verschiedene nützliche Entwurfsmuster
  für Embedded-Rust zusammenzustellen.
] else if lang == "zh" [
  这个章节的目标是为嵌入式Rust收集不同的有用的设计模式。
] else { todo }
