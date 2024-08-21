#let boxy(title, tags, body, supplement, number, accent-color) = {
  assert(
    type(accent-color) == color,
    message: "Please provide a color as argument for the theorem instance" + supplement,
  )

  let round-corners(box-args, ..args) = {
    assert(args.pos() == ())
    let new-radius-dict = box-args.named().at("radius", default: (:)) + args.named()
    arguments(..box-args, radius: new-radius-dict)
  }

  let corner-radius = 5pt

  let header(round-bottom) = align(
    left,
    {
      let box = box.with(inset: 0.5em)
      let display-title = title not in ([], "")

      let boxes-args = ()

      if display-title {
        boxes-args.push(arguments(
          fill: accent-color,
          stroke: accent-color,
          title
          )
        )
      }

      boxes-args += tags.map(it => arguments(stroke: accent-color, it))

      if boxes-args != () {
        boxes-args.first() = round-corners(boxes-args.first(), top-left: corner-radius)
        boxes-args.last() = round-corners(boxes-args.last(), top-right: corner-radius)

        if round-bottom {
          boxes-args.first() = round-corners(boxes-args.first(), bottom-left: corner-radius)
          boxes-args.last() = round-corners(boxes-args.last(), bottom-right: corner-radius)
        }
      }

      boxes-args.map(it => box(..it)).join()


      if display-title or tags != () {
        h(1fr)
      }

      box(outset: (
        y: 0em,
      ))[#supplement #number]
    },
  )

  let board(round-left-corner) = {
  let round-corners = (bottom: corner-radius, top-right: corner-radius)
  if round-left-corner {
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
    let round-bottom = body == []
    parts.push(header(round-bottom))
  }

  if body != [] {
    let round-corner = title in ([], none)
    parts.push(board(round-corner))
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

    let tag-str = if tags != () {[~(#tags.join(", "))~]} else {[]}
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
