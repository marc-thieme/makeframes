#let boxy(title, tags, body, supplement, number, accent-color) = {
  assert(
    type(accent-color) == color,
    message: "Please provide a color as argument for the theorem instance" + supplement,
  )

  let corner-radius = 5pt

  let round-bottom-corners-of-tags = body == []
  let display-title = title not in ([], "")
  let round-top-left-body-corner = title in ([], none)

  let calculate-corner-roundings-for-each-box() = {
    let corner-roundings = ((:),) * (tags.len() + int(display-title))
    if corner-roundings != () {
      corner-roundings.first() += (top-left: corner-radius)
      corner-roundings.last() += (top-right: corner-radius)
      if round-bottom-corners-of-tags {
        corner-roundings.first() += (bottom-left: corner-radius)
        corner-roundings.last() += (bottom-right: corner-radius)
      }
    }
    corner-roundings
  }

  let header() = align(
    left,
    {

      let box = box.with(inset: 0.5em)
      let tag-box(..args, body) = box.with(..args, stroke, align(horizon, body))
      let roundings = calculate-corner-roundings-for-each-box()

      if display-title {
        box(
          fill: accent-color,
          stroke: accent-color,
          radius: roundings.first(),
          title,
        )
      }

      tags
        .zip(roundings.slice(1))
        .map(((tag, rounding)) => box(
            stroke: accent-color,
            radius: rounding,
            tag,
          ))
        .join()

      if display-title or tags != () {
        h(1fr)
      }

      box(outset: (
        y: 0em,
      ))[#supplement #number]
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
        stroke: accent-color + 0.13em,
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
