#import "theorems/parse.typ"
#import "theorems/layout.typ"
#import "theorems/styles.typ"

#let init-theorems(kind, ..theorems) = {
  for (id, supplement, color) in parse.parse-args(theorems) {
    ((id): layout.factory(styles.default-style, supplement, kind, color))
  }
}

/*
Definition of styling:

let factory(title: content, tags: (content), body: content, supplement: string or content, numbering)
*/
