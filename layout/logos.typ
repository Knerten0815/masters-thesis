#import "fonts.typ": *
#import "colors.typ": *

// Constants for logo styling
#let LOGO_STYLES = {
	let logo_size = 100pt
	(
		logo_size: logo_size,
		text_size: logo_size * (9.6/60),
		leading: logo_size * (8/60),
		logo_offset: logo_size * (-4.5/60),
		logo_gutter: logo_size * (28.3465/60)
	)
}

#let logo(logo: "", color: colors.red, font: fonts.hsd, size: LOGO_STYLES.logo_size, leading: LOGO_STYLES.leading, offset: LOGO_STYLES.logo_offset ) = {
	align(left)[
		#set par(leading: leading)
		#h(offset)
		#text(font: font, size: size, fill: color)[#logo]
	]
}

#let caption(title, subtitle, color: colors.red, font: fonts.body, size: LOGO_STYLES.text_size, leading: LOGO_STYLES.leading) = {
	align(left)[
		#set par(leading: leading)
		#text(font: font, size: size, fill: color)[
			*#title*\
			#subtitle
		]
	]
}

#let hsd_logo() = {
	logo(
		logo_text: "HSD",
		logo_font: fonts.hsd,
		color: colors.red
	)
}

#let faculty_logo() = {
	logo(
		logo_text: "",
		logo_font: fonts.faculty,
		color: colors.black
	)
}

// Base logo function
#let logo_upper_caption(title, subtitle, logo_text: "", font: fonts.hsd, color: colors.black) = {
	caption(title, subtitle, color: color)
	logo(logo: logo_text, font: font, color: color)
}

#let logo_lower_caption(title, subtitle, logo_text: "", font: fonts.body, color: black) = {
	logo(logo: logo_text, font: font, color: color)
	caption(title, subtitle, color: color)
}

#let logos_horizontal_upper_caption(gutter: LOGO_STYLES.logo_gutter) = {
	grid(
		columns: (auto, auto),
		gutter: gutter,
		logo_upper_caption("Hochschule Düsseldorf", "University of Applied Sciences", logo_text: "HSD", font: fonts.hsd, color: colors.red),
		logo_upper_caption("Fachbereich Medien", "Faculty of Media", logo_text: "", font: fonts.faculty, color: colors.black),
	)
}

#let logo_horizontal_lower_caption(gutter: LOGO_STYLES.logo_gutter) = {
	grid(
		columns: (auto, auto),
		gutter: gutter,
		logo_lower_caption("Hochschule Düsseldorf", "University of Applied Sciences", logo_text: "HSD", font: fonts.hsd, color: colors.red),
		logo_lower_caption("Fachbereich Medien", "Faculty of Media", logo_text: "", font: fonts.faculty, color: colors.black),
	)
}

#let logos_vertical_upper_caption() = {
	logo_upper_caption("Hochschule Düsseldorf", "University of Applied Sciences", logo_text: "HSD", font: fonts.hsd, color: colors.red)
	logo_upper_caption("Fachbereich Medien", "Faculty of Media", logo_text: "", font: fonts.faculty, color: colors.black)
}

#let logos_vertical_lower_caption() = {
	logo_lower_caption("Hochschule Düsseldorf", "University of Applied Sciences", logo_text: "HSD", font: fonts.hsd, color: colors.red)
	logo_lower_caption("Fachbereich Medien", "Faculty of Media", logo_text: "", font: fonts.faculty, color: colors.black)
}