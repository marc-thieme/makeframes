#let boxy(title, tags, body, supplement, number, accent-color) = {
  assert(
    type(accent-color) == color,
    message: "Please provide a color as argument for the theorem instance" + supplement,
  )

  let header() = align(
    left,
    {
      let box = box.with(inset: 0.5em)
      let display-title = title not in ([], "")

      if display-title {
        box(fill: accent-color, stroke: accent-color, title)
      }

      tags.map(box.with(stroke: accent-color)).join()

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
      stroke: accent-color + 0.13em,
      spacing: 0em,
      outset: (y: 0em),
      body,
    ),
  )

  let parts = ()

  if title != none {
    parts.push(header())
  }

  if body != [] {
    parts.push(board())
  }

  stack(..parts)
}

#let hint(title, tags, body, supplement, number, accent-color) = {
  let stroke = stroke(
    thickness: 3.5pt,
    paint: accent-color,
    cap: "round",
    dash: "dotted",
  )

  let header = if title == none {
    none
  } else {
    if title != [] {
      title = [#title~]
    }

    let tag-str = [_(#tags.join(", ")) _]
    [~*#supplement #number~ _#title _*#tag-str*:* ~]
  }

  block(
    width: 100%,
    inset: 0.7em,
    stroke: (left: stroke),
    align(left, header + body),
  )
}
