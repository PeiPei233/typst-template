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

#let update_arg(dict1, dict2) = {
  for (k,v) in dict2 {
    if k in dict1{
      dict1.insert(k,v)
    }
  }
  dict1
}

#let cover_default = (
  course: "",
  name: "",
  college: "",
  department: "",
  major: "",
  id: "",
  advisor: "",
  date: datetime.today(), 
)

#let cover(
  ..args
) = {
  let info = args.named()
  let info-key(body) = {
    block(
      inset: (top: 5pt),
      align(right)[#body],
    )
  }

  let info-value(body) = {
    block(
      inset: (top: 8pt),
      stroke: (bottom: 0.5pt),
      body
    )
  }

  set align(center)
  set text(font: song, size: si, lang: "zh")
  set block(width: 100%, height: 23pt)

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
    info-key("课程名称："), info-value(info.course),
    info-key("姓       名："), info-value(info.name),
    info-key("学       院："), info-value(info.college),
    info-key("系："), info-value(info.department),
    info-key("专       业："), info-value(info.major),
    info-key("学       号："), info-value(info.id),
    info-key("指导教师："), info-value(info.advisor),
  )
  v(50pt)
  info.date

  pagebreak(weak: true)

}

#let report_title_default = (
  course: " ",
  type: " ",
  title: " ",
  name: " ",
  major: " ",
  id: " ",
  collaborator: " ",
  advisor: " ",
  location: " ",
  date-year: " ",
  date-month: " ",
  date-day: " ",
)

#let report-title(
  ..args
) = {
  pagebreak(weak: true)
  let info = args.named()
  let info-key(body) = {
    block(
      inset: 3pt,
      body
    )
  }

  let info-value(body) = {
    block(
      inset: 4pt,
      stroke: (bottom: 0.5pt),
      body
    )
  }

  set align(center)
  set text(font: song, size: xiaosi, lang: "zh")
  set block(width: 100%)
  set table(inset: 0pt,stroke: none)
  show table: set block(spacing: 0.8em)
  text(font: "Source Han Serif SC", size: xiaosan, weight: "bold")[浙江大学实验报告]
  v(15pt)
  table(
    columns: (1fr, 51%, 1fr, 21%),
    inset: 0pt,
    stroke: none,
    info-key("课程名称："), info-value(info.course),
    info-key("实验类型："), info-value(info.type),
  )
  // v(-1em)
  table(
    columns: (1fr, 81%),
    info-key("实验项目名称："), info-value(info.title),
  )
  // v(-1em)
  table(
    columns: (5fr, 15%, 3fr, 33%, 3fr, 21%),
    info-key("学生姓名："), info-value(info.name),
    info-key("专业："), info-value(info.major),
    info-key("学号："), info-value(info.id),
  )
  // v(-1em)
  table(
    columns: (7fr, 47%, 5fr, 20%),
    info-key("同组学生姓名："), info-value(info.collaborator),
    info-key("指导教师："), info-value(info.advisor),
  )
  // v(-1em)
  table(
    columns: (4fr, 43%, 4fr, 9%, 1fr, 5%, 1fr, 5%, 1fr),
    info-key("实验地点："), info-value(info.location),
    info-key("实验日期："),
    info-value(info.date-year), info-key("年"),
    info-value(info.date-month), info-key("月"),
    info-value(info.date-day), info-key("日"),
  )
}

#let project(
  title: " ",
  course: " ",
  name: " ",
  id: " ",
  collaborator: " ",
  advisor: " ",
  college: " ",
  department: " ",
  major: " ",
  location: " ",
  type: " ",
  year: str(datetime.today().year()),
  month: str(datetime.today().month()),
  day: str(datetime.today().day()),
) = {
  let info = (
    title: title,
    course: course,
    name: name,
    id: id,
    collaborator: collaborator,
    advisor: advisor,
    college: college,
    department: department,
    major: major,
    location: location,
    type: type,
    date: year + " 年 " + month + " 月 " + day + " 日 ",
  )

  (
    cover: (..args) => {
      cover(..update_arg(cover_default,info),..args)
    },
    report-title: (..args) => {
      report-title(..update_arg(report_title_default,info),..args)
    },
    doc: (body) => {
      set page(numbering: (..numbers) => {
      if numbers.pos().at(0) > 1 {
          numbering("1", numbers.pos().at(0) - 1)
        }
      })
      set text(font: "Linux Libertine", lang: "en")
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
        set text(font: ("Lucida Sans Typewriter", "Source Han Sans HW SC"))
        if it.lines.len() > 1 [
            #it
            #fake-par
        ] else [
            #it
        ]
      }
      show enum: it => {
        it
        fake-par
      }

      show list: it => {
        it
        fake-par
      }

      show figure: it => {
        it
        fake-par
      }

      show table: it => {
        it
        fake-par
      }
      body
    }
  )
}