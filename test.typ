#import "zju-exp-report/report-template.typ": project

#let (cover,report-title,doc) = project(
  course: "Hello",
  name: "233",
  id: "11111111",
)

#cover(name:"hhhh")
#show: doc
#report-title(course: "World")
#report-title()