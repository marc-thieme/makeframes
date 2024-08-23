#import "../src/lib.typ": *

#let (example, note, definition, theorem) = init-theorems("theorems", 
  theorem: ("Satz",),
  definition: ("Definition",),
  example: ("Beispiel", gray),
  note: ("Note",)
)

#definition[Test][Here comes a lot of text. This should make it so there is no room for the supplement][]
