#let default_lang = sys.inputs.at("default-lang", default: "en")
#let lang = sys.inputs.at("lang", default: default_lang)
#let languages = (
  "en": [English],
  "de": [German],
  "uk": [Ukrainian],
  "zh": [Chinese]
)
#let tgt = sys.inputs.at("target", default: "html")
#let whole = int(tgt == "pdf")

// str: use in code blocks
#let todos = (if lang == "de" { "unübersetzt" }
  else if lang == "uk" { "не перекладено" }
  else if lang == "zh" { "未翻译" }
  else { "untranslated" }
)
// content: use in other places
#let todo = text(
  fill: red,
  todos
)
// str: use in code blocks
#let todoupds(l) = {
  assert(l in languages, message: "add language name")
  if lang == "de" { "die Übersetzung ist veraltet" }
    else if lang == "uk" { "переклад застарів" }
    else if lang == "zh" { "翻译已过时" }
    else { "translation is outdated" }
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
