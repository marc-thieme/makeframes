#import "styles.typ" as styles

#let init-theorems(kind, style: styles.hint, ..theorems) = {
  import "parse.typ"
  import "layout.typ"

  for (id, supplement, color) in parse.parse-args(theorems) {
    ((id): layout.factory(style, supplement, kind, color))
  }
}

/*
Definition of styling:

let factory(title: content, tags: (content), body: content, supplement: string or content, numbering)
*/
