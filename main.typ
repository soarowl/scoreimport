#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: article.with(
  authors: ("卓能文",),
  date: datetime(
    year: 2023,
    month: 11,
    day: 19,
  ),
  logo: "logo.jpg",
  title: "教务系统成绩自动录入",
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

= 教务系统成绩自动录入

更新记录：

2023-07-17： 加入学号字段，自动填充学号对应的学生成绩。无论教务系统的学生名单是如何排列的，确保成绩录入是正确的。

目前教务系统录入成绩不能从Excel自动导入，必须手动输入，相当麻烦。特地编写了一个小脚本。以FireFox为例，浏览器正常登录后，在录入成绩时，按`F12`进入调试模式：

#figure(
  image(
    "Screenshot_20230714_085512.png",
    width: 80%,
  ),
  caption: "F12进入调试模式",
)<F12>

按`Ctrl+B`或单击 @F12 箭头所示位置，进入多行编辑模式：

#figure(
  image(
    "Screenshot_20230714_091558.png",
    width: 80%,
  ),
  caption: "多行输入模式",
)<multi>

录入成绩时，复制下面脚本，并修改学生成绩后，将所有内容全部复制到调试器编辑窗口，单击`run`按钮，学生成绩会自动填入输入框，单击页面中的提交按钮完成成绩录入。

#outlinebox(
  title: "建议",
  color: "blue",
  centering: true,
)[如果采用其它浏览器，建议复制下面的代码，并在某个编辑器中修改好学生成绩后，复制所有内容到浏览器调试窗口，然后按回车键才会开始执行脚本，切记！]

== 成绩注入脚本

#codefile(
  name: "mark.js",
  caption: "成绩注入脚本",
  lang: "js",
)

== 欢迎提需求

如果您发现什么问题，欢迎反馈，本人会尽快修复。
