library(knitr)

stopifnot(packageVersion('knitr') > '1.1')

knit('084-pandoc.Rmd')
pandoc('084-pandoc.md', format = 'html')
pandoc('084-pandoc.md', format = 'dzslides')
pandoc('084-pandoc.md', format = 'latex')
pandoc('084-pandoc.md', format = 'beamer')
pandoc('084-pandoc.md', format = 'docx')
pandoc('084-pandoc.md', format = 'odt')
pandoc('084-pandoc.md', format = 'epub')
if (FALSE) {
  opts_chunk$set(dev = 'pdf')
  knit('084-pandoc.Rmd')

  pandoc('084-pandoc.md', format = 'latex')
}
