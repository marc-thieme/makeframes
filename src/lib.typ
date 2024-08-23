#import "parse.typ" as parse
#import "layout.typ" as layout
#import "styles.typ" as styles

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
