#import "../src/lib.typ": *

#let (example, note, ..all-different-theorems) = init-theorems("theorems", default-style: styles.boxy,
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
  
  #styles.divide()

  In this boxy style, we can also divide the body into multiple sections by using the `divide()` function.
  
]<this-note>

You can also reference stuff like @this-note naturally.

#example[][
  We have two ways to spawn theorems without a title.
  Either by providing an empty title.
  In this case, the supplement will be displayed in place of a title.
]

#example[
  Or only providing one argument, which is the body. 
  This is to make the theorem as unobstructive as possible.
  The supplement and number is hidden.
]

#note[Also possible][to give an empty body, which omits the body entirely][]

#note[][In all cases][
  When you give an empty title, it is not displayed.
]

#note(style: styles.hint)[Hints][smaller][seemless][We can also provide `style: styles.hint` which creates a
more streamlined styling for a theorem.
This also supports all the above syntax.
#styles.divide()
This also includes the divider.
]

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

  We also provide less intrusive styles. 
  This style is actually the default. 
  For this example file however, we have overridden the default to be the boxy style instead.
  You can do this by specifying the according parameter in the init-theorems function.
  This style supports the same combinations of title/tags/contents as the boxy style does.

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

#note[][
  #note[][
    #note(style: styles.hint)[][
      When nesting definitions, we want the counter to increase from outer to inner.
    ]
  ]
]

#note[][
  And have the counter continue normally.
]
