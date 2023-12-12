#let song = ("Times New Roman", "SimSun")
// #let song = "Source Han Serif SC"
#let san = 16pt
#let xiaosan = 15pt
#let si = 14pt
#let xiaosi = 12pt

#let fake-par = {
  v(-1em)
  show par: set block(spacing: 0pt)
  par("")
}

#let cover(
  course: "",
  name: "",
  college: "",
  department: "",
  major: "",
  id: "",
  advisor: "",
  date: "",
) = {

  let info-key(body) = {
    rect(
      width: 100%,
      height: 23pt,
      inset: (x: 0pt, bottom: 1pt),
      stroke: none,
      align(right)[
        #text(
          font: song,
          size: si,
          body,
      )],
    )
  }

  let info-value(body) = {
    rect(
      width: 100%,
      height: 23pt,
      inset: (x: 0pt, bottom: 1pt),
      stroke: (bottom: 0.5pt),
      text(
        font: song,
        size: si,
        body,
      ),
    )
  }

  set align(center)
  set text(font: song, size: si, lang: "zh")

  pagebreak(weak: true)

  v(60pt)
  image("logo.svg", width: 50%)
  v(20pt)
  text(font: "Source Han Serif SC", size: san, weight: "bold")[本科实验报告]
  v(50pt)
  table(
    columns: (75pt, 300pt),
    row-gutter: 13pt,
    stroke: none,
    info-key("课程名称："), info-value(course),
    info-key("姓       名："), info-value(name),
    info-key("学       院："), info-value(college),
    info-key("系："), info-value(department),
    info-key("专       业："), info-value(major),
    info-key("学       号："), info-value(id),
    info-key("指导教师："), info-value(advisor),
  )
  v(50pt)
  date

  pagebreak(weak: true)

}

#let report-title(
  course: "",
  type: "",
  title: "",
  name: "",
  major: "",
  id: "",
  collab: "",
  advisor: "",
  location: "",
  date-year: "",
  date-month: "",
  date-day: "",
) = {
  
  let info-key(body) = {
    rect(
      width: 100%,
      height: 23pt,
      inset: (left: 3pt, bottom: 2pt),
      stroke: none,
      align(left)[
        #text(
          font: song,
          size: xiaosi,
          body,
      )],
    )
  }

  let info-value(body) = {
    rect(
      width: 100%,
      inset: (bottom: 2pt),
      stroke: (bottom: 0.5pt),
      text(
        font: song,
        size: xiaosi,
        body,
      ),
    )
  }

  set align(center)
  set text(font: song, size: xiaosi, lang: "zh")
  text(font: "Source Han Serif SC", size: xiaosan, weight: "bold")[浙江大学实验报告]
  v(15pt)
  table(
    columns: (1fr, 51%, 1fr, 21%),
    inset: 0pt,
    stroke: none,
    info-key("课程名称："), info-value(course),
    info-key("实验类型："), info-value(type),
  )
  v(-1em)
  table(
    columns: (1fr, 81%),
    inset: 0pt,
    stroke: none,
    info-key("实验项目名称："), info-value(title),
  )
  v(-1em)
  table(
    columns: (5fr, 15%, 3fr, 33%, 3fr, 21%),
    inset: 0pt,
    stroke: none,
    info-key("学生姓名："), info-value(name),
    info-key("专业："), info-value(major),
    info-key("学号："), info-value(id),
  )
  v(-1em)
  table(
    columns: (7fr, 47%, 5fr, 20%),
    inset: 0pt,
    stroke: none,
    info-key("同组学生姓名："), info-value(collab),
    info-key("指导教师："), info-value(advisor),
  )
  v(-1em)
  table(
    columns: (4fr, 43%, 4fr, 9%, 1fr, 5%, 1fr, 5%, 1fr),
    inset: 0pt,
    stroke: none,
    info-key("实验地点："), info-value(location),
    info-key("实验日期："),
    info-value(date-year), info-key("年"),
    info-value(date-month), info-key("月"),
    info-value(date-day), info-key("日"),
  )
  
}

#let project(
  title: " ",
  course: " ",
  author: " ",
  id: " ",
  collaborator: " ",
  advisor: " ",
  college: " ",
  department: " ",
  major: " ",
  location: " ",
  type: " ",
  year: 2023,
  month: 12,
  day: 3,
  body
) = {
  // Set the document's basic properties.
  // set document(author: authors.map(a => a.name), title: title)
  
  cover(
    course: course,
    name: author,
    college: college,
    department: department,
    major: major,
    id: id,
    advisor: advisor,
    date: [#year] + "  年  " + [#month] + "  月  " + [#day] + "  日  ",
  )

  set page(numbering: (..numbers) => {
    if numbers.pos().at(0) > 1 {
      numbering("1", numbers.pos().at(0) - 1)
    }
  })
  set text(font: "Linux Libertine", lang: "en")

  report-title(
    course: course,
    type: type,
    title: title,
    name: author,
    major: major,
    id: id,
    collab: collaborator,
    advisor: advisor,
    location: location,
    date-year: [#year],
    date-month: [#month],
    date-day: [#day],
  )

  set par(
    first-line-indent: 1em,
    justify: true
  )
  set heading(numbering: "1.1 ")
  set list(indent: 1em, body-indent: 1em)
  set enum(indent: 1em, body-indent: 1em)

  show heading: it => {
    it
    v(5pt)
    fake-par
  }
  
  show terms: it => {
    set par(first-line-indent: 0pt)
    set terms(indent: 10pt, hanging-indent: 9pt)
    it
    fake-par
  }
  
  show raw: it => {
    set text(font: "Lucida Sans Typewriter")
    if it.lines.len() > 1 [
        #it
        #fake-par
    ] else [
        #it
    ]
  }

  body
}