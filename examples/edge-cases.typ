#import "../src/lib.typ": *

#let (example, note, definition, theorem) = init-theorems("theorems", 
  theorem: ("Satz",),
  definition: ("Definition",),
  example: ("Beispiel", gray),
  note: ("Note",)
)

#definition[Test][Here comes a lot of text. This should make it so there is no room for the supplement][]

#definition[Here][Tags have different sizes][$ sum_sum^sum$][Some vertical space: #v(1cm)][
  #lorem(20)
]
