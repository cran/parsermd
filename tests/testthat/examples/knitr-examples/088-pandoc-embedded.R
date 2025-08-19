library(knitr)

stopifnot(packageVersion('knitr') > '1.1')
knit('088-pandoc-embedded.Rmd')
pandoc('088-pandoc-embedded.md')
pandoc('088-pandoc-embedded.md', format = 'latex')
pandoc('088-pandoc-embedded.md', format = c('latex', 'html', 'odt'))
