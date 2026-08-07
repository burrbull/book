#import "../config.typ": *

#h1(if lang == "en" [Design Patterns]
  else if lang == "de" [Design-Muster]
  else { todo })

#if lang == "en" [
  This chapter aims to collect various useful design patterns for embedded Rust.
] else if lang == "de" [
  Dieses Kapitel zielt darauf ab, verschiedene nützliche Entwurfsmuster
  für Embedded-Rust zusammenzustellen.
] else { todo }
