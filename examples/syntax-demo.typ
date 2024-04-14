#import "../lecture-notes.typ": *

#let draw-single(theorem) = theorem[WS21][SS22][lorem ipsum][#lorem(50)]
#let draw(..theorems) = theorems.pos().map(draw-single).join()

#let (theorem, definition, lemma, note, help) = init-theorems(
  "theorems",
  theorem: ("Satz", red),
  definition: ("Definition", green),
  lemma: ("Lemma", auto),
  help: ("Help", yellow),
  note: ("Note", auto)
)

#draw(theorem, definition, lemma, help, note)
