#import "styles.typ" as styles
#import "styling.typ" as styling
#import "layout.typ": divide

#let init-theorems(kind, default-style: styles.hint, ..theorems) = {
  import "parse.typ"
  import "layout.typ"

  for (id, supplement, color) in parse.parse-args(theorems) {
    ((id): layout.factory(default-style, supplement, kind, color))
  }
}

/*
Definition of styling:

let factory(title: content, tags: (content), body: content, supplement: string or content, numbering)
*/
