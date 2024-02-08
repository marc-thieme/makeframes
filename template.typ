#import "typst-lecture-notes.typ" as template
#import template: definition, theorem

#let note(body) = template.note_block(
  body, class: "Note", fill: rgb("#ef8064"), stroke: rgb("#8c4a39")
)

#let notation(body) = template.note_block(
  body, class: "Notation", fill: rgb("#edcd82"), stroke: rgb("#966901")
)

#let project(title, professor, author, body) = {
  let time = datetime.today().display("[day].[month].[year]")
  let abstract = []
  template.note_page(title, author, professor, author, time, abstract, body)
}

#show table: align.with(center)
#set table(inset: 3mm)

