#let base-color = red.lighten(70%)
#let default-colors = (
base-color,
base-color.rotate(95deg),
base-color.rotate(200deg).lighten(30%),
base-color.rotate(30deg).saturate(5%),
gray.lighten(60%),
base-color.rotate(150deg),
base-color.rotate(60deg),
base-color.rotate(280deg)
)

#let body-inset = 0.8em
#let caption-inset = 0.5em

#let boxy-caption(color, tags: (), caption) = {
  set box(inset: 0.5em)
  box(fill: color, stroke: color, caption.body)

  for tag in tags {
    box(stroke: color, " " + text(size: 0.9em, tag))
  }
  h(1fr)
  box[#caption.supplement #caption.counter.display(caption.numbering)]
}

#let boxy-body(color, body) = {
  set align(left)
  block(width: 100%, inset: body-inset, stroke: color + 0.13em, body)
}

#let theorem-factory(supplement, color, kind: "main-theorem") = (..tags, body) => {
  assert(tags.named() == (:))
  tags = tags.pos()
  let (name, ..tags) = if tags == () {(none, ())} else {tags}
  set figure.caption(position: top)
  show figure.caption: boxy-caption.with(color, tags: tags)
  figure(caption: name, gap: 0pt, supplement: supplement, kind: kind, boxy-body(color, body))
}

#let init-theorems(..theorems, kind: "main-theorem", colors: auto) = {
  if colors == auto {
    colors = default-colors
  }
  assert(theorems.named() == (:) or theorems.pos() == (), "You can provide either named or positional arguments but not both!")
  if theorems.pos() == () {
    for (theo, color) in theorems.named().pairs().zip(colors) {
      let (theorem, supplement) = theo
      ( (theorem): theorem-factory(supplement, color, kind: kind) )
    }
  } else {
    for (supplement, color) in theorems.pos().zip(colors) {
      theorem-factory(supplement, color, kind: kind)
    }
  }
}
