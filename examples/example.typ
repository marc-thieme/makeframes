#import "../src/lib.typ": *

#let (example, note, ..all-different-theorems) = init-theorems("theorems", 
  theorem: ("Satz",),
  definition: ("Definition",),
  example: ("Beispiel", gray),
  note: ("Note",)
)

#note[A note][
  The most standard way to write down a theorem is by providing a title as first
  argument and a body as second argument.
]

#note[Note][with tag][!][
  Our blocks can have an arbitrary number of tags to be put between title and body.
]<this-note>

You can also reference stuff like @this-note naturally.

#example[][
  We have two way to spawn theorems without a title.
  Either by providing an empty title.
  In this case, the supplement will be displayed in place of a title.
]

#example[
  Or only providing one argument, which is the body. 
  This is to make the theorem as unobstructive as possible.
  The supplement and number is hidden.
]

#note[Also possible][to give an empty body, which omits the body entirely][]

#note(style: styles.hint)[Hints][smaller][seemless][We can also provide `style: styles.hint` which creates a
more streamlined styling for a theorem.
This also supports all the above syntax]

The colors are always spersed over the color wheel as you can see here.
Here are examples for the other theorems defined above.
#v(1cm)

#for (id, func) in all-different-theorems [
  = #id
  We can have a large theorem with lots of text:

  #func[lorem ipsum][WS21][SS22][
    #lorem(50)
  ]

  Or we can have a slim version where the body is omitted
  #func[lorem ipsum][WS21][SS22][]

  We also provide less intrusive styles

  #func(style: styles.hint)[lorem ipsum][#lorem(50)]
]

= Edge Cases
Here, we present a few edge cases which we also handle gracefully.
#note[Test][Here comes a lot of text. This should make it so there is no room for the supplement][
  #lorem(20)
]

#note[Here][Tags have different sizes][$ sum_sum^sum$][Some vertical space: #v(1cm)][
  #lorem(20)
]
