#import "/layout/fonts.typ": *
#import "logos.typ": *

#let titlepage(
  title: "",
  titleGerman: "",
  degree: "",
  program: "",
  supervisor: "",
  advisors: (),
  author: "",
  startDate: datetime,
  submissionDate: datetime,
) = {
  // Quality checks
  assert(degree in ("Bachelor", "Master"), message: "The degree must be either 'Bachelor' or 'Master'")
  
  set page(
    margin: (left: 1cm, right: 1cm, top: 1cm, bottom: 2.5cm),
    numbering: none,
    number-align: center,
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

  v(30mm)
  align(center, text(font: fonts.sans, LOGO_STYLES.text_size, weight: 100, degree + "'s Thesis in " + program))
  align(center, text(font: fonts.body, 2em, weight: 700, title))
 
  v(20mm)
  align(center, text(font: fonts.sans, 2em, weight: 500, author))
  align(center, text(font: fonts.sans, 2em, weight: 500, titleGerman))

  let entries = ()
  entries.push(("Author: ", author))
  entries.push(("Supervisor: ", supervisor))
  // Only show advisors if there are any
  if advisors.len() > 0 {
    entries.push(("Advisors: ", advisors.join(", ")))
  }
  entries.push(("Start Date: ", startDate.display("[day].[month].[year]")))
  entries.push(("Submission Date: ", submissionDate.display("[day].[month].[year]")))

  v(1cm)
  align(
    center + bottom,
    grid(
      columns: 2,
      gutter: 1em,
      align: left,
      ..for (term, desc) in entries {
        (strong(term), desc)
      }
    )
  )
}
