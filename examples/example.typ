#import "../src/lecture-notes.typ": *

#let (example, note, ..all-different-theorems) = init-theorems("theorems", 
  theorem: ("Satz",),
  definition: ("Definition",),
  property: ("Eigenschaft",),
  note: ("Note",),
  example: ("Beispiel", gray),
  question: ("Frage",),
)

#note[This is a note][!][
  Make sure to not forget this!
]

#example[][
  This is how it looks when omitting the title
]

#note[
  Also, we can remove the entire header.
]

The colors are always spersed over the color wheel as you can see here:
#v(1cm)

#for (id, func) in all-different-theorems [
  = #id
  We can have a large theorem with lots of text:

  #func[lorem ipsum][WS21][SS22][
    #lorem(50)
  ]

  Or we can have a slim version where the body is omitted
  #func[lorem ipsum][WS21][SS22][]
]
