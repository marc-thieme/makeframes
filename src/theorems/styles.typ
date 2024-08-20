#let boxy-style(title, tags, body, supplement, number, custom-arg) = {
  assert(
    type(custom-arg) == color,
    message: "Please provide a color as argument for the theorem instance" + supplement,
  )
  let color = custom-arg

  let header() = align(
    left,
    {
      let box = box.with(inset: 0.5em)
      let display-title = title not in ([], "")

      if display-title {
        box(fill: color, stroke: color, title)
      }

      tags.map(box.with(stroke: color)).join()

      if display-title or tags != () {
        h(1fr)
      }

      box(outset: (
        y: 0em,
      ))[#supplement #number]
    },
  )

  let board() = align(
    left,
    block(
      width: 100%,
      inset: 0.8em,
      stroke: color + 0.13em,
      spacing: 0em,
      outset: (y: 0em),
      body,
    ),
  )

  let parts = ()

  if title != none {
    parts.push(header())
  }

  if body != none {
    parts.push(board())
  }

  stack(..parts)
}

#let default-style = boxy-style
