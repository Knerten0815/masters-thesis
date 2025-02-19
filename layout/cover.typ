#import "/layout/fonts.typ": *
#import "logos.typ": *

// Main cover function
#let cover(
  title: "",
  degree: "",
  program: "",
  author: "",
) = {
  set page(
    margin: (left: 1cm, right: 1cm, top: 1cm, bottom: 1cm),
  )
 
  set text(
    font: fonts.body,
    size: 12pt,
    lang: "en"
  )
 
  set par(leading: 1em)
 
  logos_horizontal_upper_caption()

  v(15mm)
  align(center, text(font: fonts.sans, 1.3em, weight: 100, degree + "'s Thesis in " + program))
  v(15mm)
 
  align(center, text(font: fonts.sans, 2em, weight: 700, title))
 
  v(10mm)
  align(center, text(font: fonts.sans, 2em, weight: 500, author))
}