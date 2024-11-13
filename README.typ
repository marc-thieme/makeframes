#import "src/lib.typ": *

#set page(height: auto)

#let (example, feature, variant) = make-frames(
  "core-frames",
  feature: ("Feature",),
  variant: ("Feature Variant",),
  example: ("Example", gray),
)
= Introduction
This library allows you to easily define and use a variety of custom environments
in your documents. The syntax is designed to integrate well into the source code.

We ship two different predefined styles. On top of that, you can freely define your own
styling function which can access the features provided by the user.

= Feature highlight
#feature[An unobstrusive style][ideal to be used regularily][does not break the flow][
  The default style is to only highlight the text with a colored line on the side.

]
Whereas:
#feature(style: styles.boxy)[Special Highlight][Use less regularily][Strong highlight][
  The secondary style called `styles.boxy` is much more eye-catching and not embed
  seamlessly into the textflow.
]

#example[A different type][
  As you can see, this element displays a different kind and color. In fact,
  we can define arbitrary such kinds. The colors can be provided or automatically generated.

  As long as all kinds are associated with the same identifier in the call to `make-frames`,
  they will use the same counter.
]

= Feature List
#let layout-features(style) = [
  #let (example, feature, variant) = (
    example.with(style: style),
    variant.with(style: style),
    feature.with(style: style),
  )

  
#feature[Element without tags][
  The most standard way to write down an element is by providing a title as first
  argument and a body as second argument.
]

#variant[Element][with tag][!][
  Our blocks can have an arbitrary number of tags to be put between title and body.
]

#feature[][
  If you do not want to display a custom title but still the kind of this element, 
  you can provide `[]` in place of the title.
]

#variant[][A tag][
  Providing tags is still possible.
]

#variant[
  If you do not want a header at all, you can just leave out the title parameter.
]

#feature[Element without a body][Tags are still possible][]
If you want to be brief, you can provide `[]` as body (i.e. last parameter) and the body is going to be omitted.

#feature[Element with dividor][
  With `divide()`
  #divide()
  You can place a divider inside your text body to add a visual layer of separation.
]
]

Here is a list of features. This text is repeated two times for both styles.
== Style that embeds with the text flow
#layout-features(styles.hint)
== Style that draws boxes
#layout-features(styles.boxy)

#feature[References][
  Lastly, you can reference elements as usual with `<… tag …>`.
] <reference-tag>

Just like here: @reference-tag.

= Edge Cases
#let (example, feature, variant) = (
  example.with(style: styles.boxy),
  variant.with(style: styles.boxy),
  feature.with(style: styles.boxy),
)

Here, we present some gracefully handled edge cases.
#example[Test][Here comes a lot of text. This should make it so there is no room for the supplement][
  #lorem(20)
]

#example[Here][Tags have different sizes][$ sum_sum^sum$][Some vertical space: #v(1cm)][
  #lorem(20)
]

#example[][
  #example[][
    #example(style: styles.hint)[][
      When nesting definitions, we want the counter to increase from outer to inner.
    ]
  ]
]

#example[][
  And have the counter continue normally.
]
