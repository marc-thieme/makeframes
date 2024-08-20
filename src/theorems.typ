#import "theorems/parse.typ" as parse
#import "theorems/layout.typ" as layout
#import "theorems/styles.typ" as styles

#let styles = styles

#let init-theorems(kind, style: styles.boxy, ..theorems) = {
  for (id, supplement, color) in parse.parse-args(theorems) {
    ((id): layout.factory(style, supplement, kind, color))
  }
}

/*
Definition of styling:

let factory(title: content, tags: (content), body: content, supplement: string or content, numbering)
*/
