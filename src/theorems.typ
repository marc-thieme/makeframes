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

#let boxy-body(color, body) = align(
  left,
  block(width: 100%, inset: body-inset, stroke: color + 0.13em, body),
)

// Wrap it in a second figure because of three facts: 
// 1. We need to return a type figure to make it labellable
// 2. We need to specify rules (set and show) to modify caption styling
// 3. If we specify rules in the block which is returned, a type 'styled' is returned instead of the figure
#let theorem-factory(supplement, color, kind: "theorem") = (..tags, body) => figure(kind: kind, supplement: supplement, {
  assert(tags.named() == (:))
  tags = tags.pos()
  let (name, ..tags) = if tags == () { (none, ()) } else { tags }
  // Offset that our outer helper figure has the same kind. We can't introduct its own kind for this helper 
  // because the user might rely on the outer one having the kind he knows when he's writing rules for references
  show figure: it => {it.counter.update(old => old - 1); it}
  set figure.caption(position: top)
  show figure.caption: boxy-caption.with(color, tags: tags)
  figure(caption: name, supplement: supplement, gap: 0pt, boxy-body(color, body), kind: kind)
})

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

#let init-theorems(..theorems, kind: "theorem", colors: auto) = {
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
