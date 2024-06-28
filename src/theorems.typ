#let boxy-caption(color, tags: (), caption) = align(left, {
  let box = box.with(inset: 0.5em)
  let caption-is-set = caption.body not in ([], "")

  if caption-is-set {
    box(fill: color, stroke: color, caption.body)
  }

  for tag in tags {
    box(stroke: color, tag)
  }

  if caption-is-set {
    h(1fr)
  }

  box[#caption.supplement #caption.counter.display(caption.numbering)]
})

#let inline-caption-box(color, tags: (), body) = move(dy: 0.2em, {
  set text(0.85em)
  let box = box.with(inset: 0.3em, stroke: color)

  box(fill: color, body)
  for tag in tags {
    box(tag)
  }
})

#let boxy-body(color, body) = align(
  left,
  block(width: 100%, inset: 0.8em, stroke: color + 0.13em, body),
)

// Wrap it in a second figure because of three facts: 
// 1. We need to return a type figure to make it labellable
// 2. We need to specify rules (set and show) to modify caption styling
// 3. If we specify rules in the block which is returned, a type 'styled' is returned instead of the figure
#let spawn-theorem(supplement, kind, color, tags, name, body) = figure(kind: kind, supplement: supplement, {
    // Offset that our outer helper figure has the same kind. We can't introduct its own kind for this helper 
    // because the user might rely on the outer one having the kind he knows when he's writing rules for references
    show figure: it => {it.counter.update(old => old - 1); it}
    set figure.caption(position: top)
    show figure.caption: boxy-caption.with(color, tags: tags)
    figure(caption: name, supplement: supplement, gap: 0pt, body, kind: kind)
  }
)

#let block-factory(supplement, color, kind) = (..tags, body) => {
  assert(tags.named() == (:))
  tags = tags.pos()
  let (..tags, name) = if tags == () { ((), none) } else { tags }
  spawn-theorem(supplement, kind, color, tags, name, boxy-body(color, body))
}

#let slim-factory(supplement, color, kind) = (..tags, name) => {
  assert(tags.named() == (:))
  spawn-theorem(supplement, kind, color, tags.pos(), name, none)
}

#let inline-factory(color) = (..tags, name) => box(inline-caption-box(color, tags: tags.pos(), name))

#let calculate-colors(count) = {
  let samples = for i in range(count) {
    (i * 100% / count,)
  }
  gradient.linear(..color.map.rainbow.rev()).samples(..samples)
  .map(color => color.lighten(80%).desaturate(50%))
}

#let prepare-args(theorems) = {
  assert(theorems.pos() == (), message: "Unexpected positional arguments: " + repr(theorems.pos()))

  let args = for (id, args) in theorems.named() {
    assert(type(args) == array, message: "Please provide an array for each theorem")
    let (supplement, col, ..) = args + (auto,) // Denote color with 'auto' if omitted
    assert(type(supplement) in (content, str))
    assert(type(col) in (color, type(auto)), message: "Please provide a color as second arguments: "+supplement+" (was "+type(col)+")")
    ((id, supplement, col), )
  }
  let auto-count = args.filter(((_, _, col)) => col == auto).len()
  let generated-colors = calculate-colors(auto-count)
  let next-color-idx = 0

  for (id, supplement, col) in args {
    if col == auto {
      col = generated-colors.at(next-color-idx)
      next-color-idx += 1
    }
    ((id, supplement, col),)
  }
}

#let init-theorems(kind, ..theorems) = {
  for (id, supplement, col) in prepare-args(theorems) {
    if col == auto {
      col = generated-colors.at(next-color-idx)
      next-color-idx += 1
    }
    ((id): block-factory(supplement, col, kind))
  }
  (slim: {
      for (id, supplement, col) in prepare-args(theorems) {
        if col == auto {
          col = generated-colors.at(next-color-idx)
          next-color-idx += 1
        }
        ((id): slim-factory(supplement, col, kind))
      }
    }
  )
  (inline: {
      for (id, supplement, col) in prepare-args(theorems) {
        if col == auto {
          col = generated-colors.at(next-color-idx)
          next-color-idx += 1
        }
        ((id): inline-factory(col))
      }
  })
}
