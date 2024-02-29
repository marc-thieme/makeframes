// Template design from: https://github.com/BeitianMa/typst-lecture-notes

#let break-page-after-chapters() = body => {
  show heading.where(level: 1): it => {
    // Start a new page unless this is the first chapter
    locate(loc => {
      let h1_before = query(heading.where(level: 1).before(loc), loc)
      if h1_before.len() != 1 {
        pagebreak()
      }
    })
    it
  }
  body
}

#let note-page

#{
  /* Headings of various levels */
  // Templates support up to three levels of headings,
  // and notes with more than three headings are usually mess :)
  let set-headings(body) = {
    set heading(numbering: "1.1.1")

    // 1st level heading
    show heading.where(level: 1): it => [
      #set text(1.3em, weight: "bold")
      // Font size and white space
      #block[Chapter #counter(heading).display(): #it.body]
      #v(0.8em)
    ]

    // 2st level heading
    show heading.where(level: 2): it => [
      #set text(1.2em, weight: "bold")
      #block[#it]
    ]

    // 3st level heading
    show heading.where(level: 3): it => [
      #set text(1.1em, weight: "bold")
      #block[#it]
    ]

    body
  }

  /* Cover page */
  // Create a note cover with the course name, author, and time
  // Modify parameters here if you want to add or modify information item
  let cover-page(title, author, professor, creater, time, abstract) = {
    set page(paper: "us-letter", header: align(right)[
      #smallcaps[#title]
      #v(-6pt)
      #line(length: 40%)
    ], footer: locate(loc => {
      align(center)[#loc.page()]
    }))

    block(height: 25%, fill: none)
    align(center, text(18pt)[*Lecture Notes: #title*])
    align(center, text(12pt)[*By #author*])
    align(center, text(11pt)[_Taught by Prof. #professor _])

    v(7.5%)
    abstract

    block(height: 35%, fill: none)
    align(center, [*#creater, #time*])
  }

  /* Outline page */
  // Defualt depth is 2
  let outline-page(title) = {
    set page(
      paper: "us-letter",
      // Headers are set to right- and left-justified
      // on odd and even pages, respectively
      header: locate(loc => {
        if calc.odd(loc.page()) {
          align(right)[
            #smallcaps[#title]
            #v(-6pt)
            #line(length: 40%)
          ]
        } else {
          align(left)[
            #smallcaps[#title]
            #v(-6pt)
            #line(length: 40%)
          ]
        }
      }),
      footer: locate(loc => {
        align(center)[#loc.page()]
      }),
    )

    show outline.entry.where(level: 1): it => {
      v(12pt, weak: true)
      strong("§ " + it)
    }

    align(center, text(18pt, weight: "bold")[#title])
    v(15pt)
    outline(title: none, depth: 2, indent: auto)
  }

  /* Body text page */
  // Format the headers and headings of the body
  let body-page(title, body) = {
    set page(
      paper: "us-letter",
      header: locate(
        loc => {
          let h1_before = query(heading.where(level: 1).before(loc), loc)

          let h1_after = query(heading.where(level: 1).after(loc), loc)

          // Right- and left-justified on odd and even pages, respectively
          // Automatically matches the nearest level 1 title
          // let nearest_heading = (h1_before, h1_after, (heading(""))).find(arr => arr != ()).body
          let headings = (..h1_before, ..h1_after)
          if headings.len() != 0 {
            let align_side = if calc.odd(loc.page()) { right } else { left }
            align(align_side)[_ #headings.first().body _ #v(-6pt) #line(length: 40%)]
          }
        },
      ),
      footer: locate(loc => {
        align(center)[#loc.page()]
      }),
    )

    set-headings(body)
  }

  /* All pages */
  // Organize all types of pages
  // If you want to add or modify other global Settings, please do so here
  let _note-page(title, author, professor, creater, time, abstract, body) = {
    set document(title: title, author: author)
    set par(justify: true)
    show math.equation.where(block: true) :it=>block(width: 100%, align(center, it))

    cover-page(title, author, professor, creater, time, abstract)

    outline-page("Outline")

    body-page(title, body)
  }
  note-page = _note-page
}
