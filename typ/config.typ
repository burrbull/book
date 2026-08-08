#let default_lang = sys.inputs.at("default-lang", default: "en")
#let lang = sys.inputs.at("lang", default: default_lang)
#let languages = (
  "en": [English],
  "de": [German],
  "ja": [Japanese],
  "uk": [Ukrainian],
  "zh": [Chinese]
)
#let tgt = sys.inputs.at("target", default: "html")
#let whole = int(tgt == "pdf")

// str: use in code blocks
#let todos = {
  (
    en: "untranslated",
    de: "unübersetzt",
    ja: "未翻訳",
    uk: "не перекладено",
    zh: "未翻译",
  ).at(lang)
}
// content: use in other places
#let todo = text(
  fill: red,
  todos
)
// str: use in code blocks
#let todoupds(l) = {
  (
    en: "translation is outdated",
    de: "die Übersetzung ist veraltet",
    ja: "翻訳が古くなっています",
    uk: "переклад застарів",
    zh: "翻译已过时",
  ).at(lang)
} // content: use in other places
#let todoupd(l) = text(
  fill: orange,
  todoupds(l)
)

#let book_title = "The Embedded Rust Book"

#let h1(it, offset: 0) = if tgt == "pdf" {
  heading(it, depth: 1, offset: offset)
} else {
  title(it)
}
