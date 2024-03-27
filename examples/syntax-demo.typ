#import "../lecture-notes.typ": *

#let draw-single(theorem) = theorem[WS21][SS22][lorem ipsum][#lorem(50)]
#let draw(..theorems) = theorems.pos().map(draw-single).join()

= Array Syntax
#let (theorem, definition, lemma, note) = init-theorems("Satz", "Definition", "Lemma", "Note", colors: (red, auto, yellow))
#draw(theorem, definition, lemma, note)

= Dictionary Syntax
#let (theorem, definition, lemma) = init-theorems(theorem: "Satz", definition: "Definition", lemma: "Lemma")
#let (theorem, definition, lemma) = init-theorems(
  theorem: "Satz",
  definition: "Definition",
  lemma: "Lemma",
  colors: (theorem: red, lemma: blue),
)
#draw(theorem, definition, lemma)
