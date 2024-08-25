#let boxy(title, tags, body, supplement, number, accent-color) = {
  assert(
    type(accent-color) == color,
    message: "Please provide a color as argument for the theorem instance" + supplement,
  )

  let corner-radius = 5pt
  let stroke = accent-color + 0.13em

  let round-bottom-corners-of-tags = body == []
  let display-title = title not in ([], "")
  let round-top-left-body-corner = title in ([], none)

  let header() = align(
    left,
    {
      let inset = 0.5em

      let tag-elements = tags
      if display-title {
        let title-cell = grid.cell(fill: accent-color, title)
        tag-elements.insert(0, title-cell)
      }

      let rounded-corners = (top: corner-radius)
      if round-bottom-corners-of-tags {
        rounded-corners.bottom = corner-radius
      }

      let grid-cells = tag-elements.intersperse(grid.vline(stroke: stroke))
      let tag-grid = grid(columns: tag-elements.len(), align: horizon, inset: inset, ..grid-cells)
      box(inset: 0pt, stroke: stroke, radius: rounded-corners, tag-grid)

      if tag-elements != () {
        h(1fr)
      }

      box(
        inset: inset,
        outset: (
          y: 0em,
        ),
      )[#supplement #number]
    },
  )

  let board() = {
    let round-corners = (bottom: corner-radius, top-right: corner-radius)
    if round-top-left-body-corner {
      round-corners.top-left = corner-radius
    }
    align(
      left,
      block(
        width: 100%,
        inset: 0.8em,
        radius: round-corners,
        stroke: stroke,
        spacing: 0em,
        outset: (y: 0em),
        body,
      ),
    )
  }

  let parts = ()

  let rounded-corners = (bottom: corner-radius)

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
      title = [~~#title~]
    }

    let tag-str = if tags != () {
      [~(#tags.join(", "))~]
    } else {
      []
    }
    let supplement-str = text(gray.darken(50%))[#supplement #number]
    [~#supplement-str~*#(title)*_#(tag-str)_:~]
  }

  block(
    width: 100%,
    inset: 0.7em,
    stroke: (left: stroke),
    align(left, header + body),
  )
}
