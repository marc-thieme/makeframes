#import "typst-lecture-notes.typ" as template

#let definition = template.note_block.with(
  class: "Definition", fill: rgb("#EDF1D6"), stroke: rgb("#609966")
)

#let theorem = template.note_block.with(
  class: "Theorem", fill: rgb("#FEF2F4"), stroke: rgb("#EE6983")
)

#let lemma = template.note_block.with(
  class: "Lemma", fill: rgb("#FFF4E0"), stroke: rgb("#F4B183")
)

#let corollary = template.note_block.with(
  class: "Corollary", fill: rgb("#F7FBFC"), stroke: rgb("#769FCD")
)

#let note(body) = template.note_block.with(
  class: "Note", fill: rgb("#ef8064"), stroke: rgb("#8c4a39")
)

#let notation(body) = template.note_block.with(
  class: "Notation", fill: rgb("#edcd82"), stroke: rgb("#966901")
)

#let proof(body) = block(spacing: 11.5pt, {
  emph[Proof.]
  [ ] + body
  h(1fr)
  box(scale(160%, origin: bottom + right, sym.square.stroked))
})

#let project(title, professor, author, body) = {
  let time = datetime.today().display("[day].[month].[year]")
  let abstract = []
  template.note_page(title, author, professor, author, time, abstract, body)
}

#show table: align.with(center)
#set table(inset: 3mm)

