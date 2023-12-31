#import "@preview/gentle-clues:0.4.0":*
#import "@preview/i-figured:0.2.3"
#import "@preview/sourcerer:0.2.1": code
#import "@preview/tbl:0.0.4"

#let article(
  title: "",
  authors: (),
  date: datetime.today().display(),
  logo: none,
  body,
) = {
  set document(title: title, author: authors.join(" "))
  set heading(numbering: "1.1")
  set text(font: ("Times New Roman", "SimSun"), lang: "zh")

  //************ 图形、代码及表格列表设置
  // this `level: 2` instructs the figure counters to be reset for every
  // level 2 section, so at every level 1 and level 2 heading.
  show heading: i-figured.reset-counters.with(level: 1)
  // this `level: 2` instructs the figure numbering to include the first
  // two levels of the current heading numbering.
  // how this should behave with zeros can be set using `zero-fill`.
  // e.g., setting `zero-fill: false` and `leading-zero: false` assures
  // there is never a `0` in the numbering.
  show figure: i-figured.show-figure.with(level: 1)
  // master 版本不能编译
  // show math.equation: i-figured.show-equation

  // set figure(numbering: "1-1") // don't work, maybe a typst bug
  set figure.caption(position: top, separator: [#h(1em)])
  show figure.where(kind: image): set figure.caption(position: bottom)
  //************

  //************ 代码框设置
  show raw.where(block: true): it => {
    code(it)
  }
  //************

  //************ 表格设置
  show: tbl.template.with(box: false, breakable: true, tab: "|")
  //************

  //************ 标题页设置
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  if logo != none {
    v(0.4fr)
    align(right, image(logo, width: 26%))
    v(9.6fr)
  }

  set align(center)

  v(20fr, weak: true)
  text(2em, weight: 700, title)

  // 作者
  v(1.5em, weak: true)
  let by = authors.map(author => [#strong(author)]).join(" ")
  text(1.2em, by)

  v(70fr)
  text(1.1em, date)

  set align(left)
  pagebreak()
  //************

  //************ 页眉、页脚
  set page(
    header: [#h(1fr)#title#h(1fr)#line(length: 100%, stroke: 2pt)],
    number-align: center,
  )
  //************

  //************ 目录
  set page(numbering: "I")
  counter(page).update(1)

  show outline: it => {
    show heading: set align(center)
    it
  }
  outline(title: [目#h(2em)录], indent: true, depth: 3)
  i-figured.outline(title: [图形列表])
  i-figured.outline(target-kind: table, title: [表格列表])
  i-figured.outline(target-kind: raw, title: [代码列表])
  // master 版本不能编译
  // i-figured.outline(target: math.equation, title: [公式列表])
  pagebreak()
  //************

  //************ 正文
  set page(numbering: "1")
  counter(page).update(1)
  set par(first-line-indent: 2em, justify: true)
  show par: set block(spacing: 0.65em)
  // Workaround 3: Automatically add empty paragraph after heading
  show heading: it => {
    it
    par(text(size: 0.35em, h(0.0em)))
  } // Only works for paragraphs directly after heading

  body
  //************
}
