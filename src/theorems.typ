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
  let (name, ..tags) = if tags == () { (none, ()) } else { tags }
  set figure.caption(position: top)
  show figure.caption: boxy-caption.with(color, tags: tags)
  figure(
    caption: name,
    gap: 0pt,
    supplement: supplement,
    kind: kind,
    boxy-body(color, body),
  )
}

#let calculate-colors(count) = {
  let samples = for i in range(count) {
    (i * 100% / count,)
  }
  gradient.linear(..color.map.turbo.rev()).samples(..samples)
  .map(color => color.lighten(80%).desaturate(50%))
}

#let init-theorems-dictionary(theorems, kind, colors) = {
  assert(
    type(colors) == dictionary,
    message: "When assigning using named arguments, you must provide the colors as a dictionary",
  )
  // calculate the keys that are missing in colors
  let missing-keys-in-colors = theorems.keys().filter(key => key not in colors)
  colors += calculate-colors(missing-keys-in-colors.len())
  .zip(missing-keys-in-colors)
  .map(((color, key)) => ((key): color))
  .sum()
  for (theorem, supplement) in theorems.pairs() {
    ((theorem): theorem-factory(supplement, colors.at(theorem), kind: kind))
  }
}

#let init-theorems-array(theorems, kind, colors) = {
  assert(
    type(colors) == array,
    message: "When assigning using positional arguments, you must provide the colors as an array",
  )
  colors += calculate-colors(theorems.len() - colors.len())
  for (supplement, color) in theorems.zip(colors) {
    (theorem-factory(supplement, color, kind: kind),)
  }
}

#let init-theorems(..theorems, kind: "main-theorem", colors: auto) = {
  assert(
    theorems.named() == (:) or theorems.pos() == (),
    message: "You can provide either named or positional arguments but not both!",
  )
  if theorems.pos() == () {
    init-theorems-dictionary(theorems.named(), kind, if colors == auto { (:) } else { colors })
  } else {
    init-theorems-array(theorems.pos(), kind, if colors == auto { () } else { colors })
  }
}

