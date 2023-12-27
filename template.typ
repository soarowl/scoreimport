// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let article(
  title: "",
  authors: ("卓能文",),
  date: datetime.today(),
  logo: "logo.jpg",
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set heading(numbering: "1.1")
  set page(number-align: center, paper: "a4")
  set text(font: "SimSun", lang: "zh")

  // Title page.
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  set page(numbering: none)
  v(0.6fr)
  if logo != none {
    align(right, image(logo, width: 26%))
  }
  v(0.4fr)

  align(center, text(2em, weight: 700, title))

  // Author information.
  pad(
    top: 0.7em,
    ..authors.map(author => align(center, strong(author))),
  )

  // Date
  v(8fr)
  align(
    center,
    text(0.8em, date.display("[year]年[month]月[day]日")),
  )
  pagebreak()

  // Page header
  set page(header: [#h(1fr)#title#h(1fr) \ #line(length: 100%)])

  // Table of contents.
  set page(numbering: "I")
  counter(page).update(1)
  outline(
    depth: 3,
    indent: true,
    title: [#h(1fr)目 录#h(1fr)],
  )
  pagebreak()

  // Main body.
  set page(numbering: "1")
  counter(page).update(1)
  set par(justify: true)

  body
}

#let outlinebox(
  title: "title",
  color: none,
  width: 100%,
  radius: 2pt,
  centering: true,
  body,
) = {
  let strokeColor = luma(70)

  if color == "red" {
    strokeColor = rgb(237, 32, 84)
  } else if color == "green" {
    strokeColor = rgb(102, 174, 62)
  } else if color == "blue" {
    strokeColor = rgb(29, 144, 208)
  }

  return block(
    stroke: 2pt + strokeColor,
    radius: radius,
    width: width,
    above: 26pt,
  )[
      #if centering [
        #place(
          top + center,
          dy: -12pt,
        )[
            #block(
              fill: strokeColor,
              inset: 8pt,
              radius: radius,
            )[
                #text(fill: white, weight: "bold")[#title]
              ]
          ]
      ] else [
        #place(
          top + start,
          dy: -12pt,
          dx: 20pt,
        )[
            #block(
              fill: strokeColor,
              inset: 8pt,
              radius: radius,
            )[
                #text(fill: white, weight: "bold")[#title]
              ]
          ]
      ]

      #block(
        width: 100%,
        inset: (top: 20pt, x: 10pt, bottom: 10pt),
      )[
          #body
        ]
    ]
}

#let codecounter = counter("codecounter")

#let code(
  caption: "示例代码",
  content,
) = {
  codecounter.step()
  outlinebox(
    title: "代码 " + codecounter.display() + ": " + caption,
    color: "green",
    centering: true,
  )[#content]
}

#let codefile(name: "", caption: "", lang: "") = {
  let text = read(name)
  code(caption: caption, raw(text, lang: lang))
}

#let coderesult(content) = {
  outlinebox(title: "运行结果")[#content]
}