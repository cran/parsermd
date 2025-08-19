## -----------------------------------------------------------------------------
#| include: false
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)


## -----------------------------------------------------------------------------
library(parsermd)


## -----------------------------------------------------------------------------
#| label: example
rmd = parsermd::parse_rmd(system.file("examples/minimal.Rmd", package = "parsermd"))


## -----------------------------------------------------------------------------
#| label: tree
print(rmd)


## -----------------------------------------------------------------------------
#| label: no_headings
print(rmd, flat = TRUE)


## -----------------------------------------------------------------------------
#| label: tibble
as_tibble(rmd)


## -----------------------------------------------------------------------------
#| label: as_ast
as_ast( as_tibble(rmd) )


## -----------------------------------------------------------------------------
#| label: as_doc
cat(
  as_document(rmd),
  sep = "\n"
)


## -----------------------------------------------------------------------------
rmd = parse_rmd(system.file("examples/hw01-student.Rmd", package="parsermd"))
rmd


## -----------------------------------------------------------------------------
rmd_select(rmd, by_section( c("Exercise 1", "Solution") ))


## -----------------------------------------------------------------------------
rmd_select(rmd, by_section( c("Exercise 1", "Solution") )) |>
  as_document()


## -----------------------------------------------------------------------------
rmd_select(rmd, by_section(c("Exercise 1", "Solution")) & has_type("rmd_markdown")) |>
  as_document()


## -----------------------------------------------------------------------------
rmd_select(rmd, by_section(c("Exercise 1", "Solution"))) |>
  rmd_select(has_type("rmd_markdown")) |>
  as_document()


## -----------------------------------------------------------------------------
rmd_select(rmd, by_section(c("Exercise *", "Solution")))


## -----------------------------------------------------------------------------
rmd_select(rmd, has_label("plot*"))

