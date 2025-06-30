// all the hex values were taken from PowerPoint template design colors.
// the 2 templates have different color palettes though, which is weird.
//
// example usage:
// #import "../layout/colors.typ": *
// uncolored text #text("some colored text", fill: colors.blues.at(1))
// #text("some other color", fill: colors.green)


#let colors = (
  // primary colors from style guide page 14-17
  red: rgb("#e60028"), // PANTONE 185, CMYK 0 100 80 0, RGB 230 0 40 (#e60028)
  yellow: rgb("#ffeb00"), // PANTONE 101, CMYK 0 0 90 0, RGB 255 235 0 (#ffeb00)
  blue: rgb("#00afd7"), // PANTONE 638, CMYK 85 0 10 0, RGB 0 175 215 (#00afd7)
  green: rgb("#64B432"), // PANTONE 360, CMYK 60 0 95 0, RGB 100 180 50 (#64b432)
  // infographic colors from HSD_PPTX_Masterdatei_16_9.pptx and style guide page 31
  white: rgb("#ffffff"),
  black: rgb("#000000"),
  teal: rgb("#004C5F"),
  darkyellow: rgb("#937E00"),
  darkred: rgb("#780B24"),
  lightred: rgb("#E0BDB3"),
  lightblue: rgb("#ABCBD7"),
  lightgreen: rgb("#8FFF7B"),
  // additional colors from HSD_Presentation_Vorlage_16x9.pptx
  lightgrey: rgb("#E6E6E6"),
  grey: rgb("#C8C8C8"),
  darkgrey: rgb("#464646"),
  beige: rgb("#EEECE1"),
  // shades (each with 5 shades)
  reds: (
    rgb("#FFC7D1"),
    rgb("#FF8FA2"),
    rgb("#FF5774"),
    rgb("#AD001E"),
    rgb("#730014"),
  ),
  yellows: (
    rgb("#FFFBCC"),
    rgb("#FFF799"),
    rgb("#FFF366"),
    rgb("#BFB000"),
    rgb("#7F7500"),
  ),
  blues: (
    rgb("#C4F4FF"),
    rgb("#89E9FF"),
    rgb("#4EDEFF"),
    rgb("#0083A1"),
    rgb("#00576C"),
  ),
  greens: (
    rgb("#DFF3D3"),
    rgb("#C0E7A7"),
    rgb("#A0DA7C"),
    rgb("#4B8726"),
    rgb("#325A19"),
  ),
  whites: (
    rgb("#F2F2F2"),
    rgb("#D9D9D9"),
    rgb("#BFBFBF"),
    rgb("#A6A6A6"),
    rgb("#7F7F7F"),
  ),
  blacks: (
    rgb("#7F7F7F"),
    rgb("#595959"),
    rgb("#404040"),
    rgb("#262626"),
    rgb("#0D0D0D"),
  ),
  teals: (
    rgb("#D6F7FF"),
    rgb("#97EAFF"),
    rgb("#30D5FF"),
    rgb("#009FC7"),
    rgb("#006D89"),
  ),
  darkyellows: (
    rgb("#FFF5B6"),
    rgb("#FFEA6E"),
    rgb("#FFE025"),
    rgb("#6E5F00"),
    rgb("#4A3F00"),
  ),
  darkreds: (
    rgb("#F9BAC8"),
    rgb("#F27491"),
    rgb("#EC2F5A"),
    rgb("#5A081B"),
    rgb("#3C0612"),
  ),
  lightreds: (
    rgb("#F9F2F0"),
    rgb("#F3E5E1"),
    rgb("#ECD7D1"),
    rgb("#C37F6B"),
    rgb("#8F4D3A"),
  ),
  lightblues: (
    rgb("#EEF5F7"),
    rgb("#DDEAEF"),
    rgb("#CDE0E7"),
    rgb("#6AA3B8"),
    rgb("#3E7083"),
  ),
  lightgreens: (
    rgb("#E9FFE5"),
    rgb("#D2FFCA"),
    rgb("#BCFFB0"),
    rgb("#3FFF1D"),
    rgb("#1DBD00"),
  ),
  // the lightgrey shades become darker than the grey shades. Kinda weird, but follows the HSD_Presentation_Vorlage_16x9.pptx design colors
  lightgreys: (
    rgb("#CFCFCF"),
    rgb("#ADADAD"),
    rgb("#737373"),
    rgb("#3A3A3A"),
    rgb("#171717"),
  ),
  greys: (
    rgb("#F4F4F4"),
    rgb("#E9E9E9"),
    rgb("#DEDEDE"),
    rgb("#969696"),
    rgb("#646464"),
  ),
  darkgreys: (
    rgb("#DADADA"),
    rgb("#B5B5B5"),
    rgb("#909090"),
    rgb("#353535"),
    rgb("#232323"),
  ),
  beiges: (
    rgb("#DDD9C3"),
    rgb("#C4BD97"),
    rgb("#948A54"),
    rgb("#4A452A"),
    rgb("#1E1C11"),
  ),
)
