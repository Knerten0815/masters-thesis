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
 
  set par(leading: LOGO_STYLES.leading)

  logos_horizontal_upper_caption()
	v(2mm)
	align(left, text(size: LOGO_STYLES.text_size, [*Zentrum für Digitalisierung und Digitalität*]))
	align(left, text(size: LOGO_STYLES.text_size, [Centre for Digitalisation and Digitality]))

  v(55mm)
  align(center, text(font: fonts.sans, LOGO_STYLES.text_size, weight: 100, degree + "'s Thesis in " + program))
  align(center, text(font: fonts.body, 2em, weight: 700, title))
 
  v(25mm)
  align(center, text(font: fonts.sans, 2em, weight: 500, author))
}