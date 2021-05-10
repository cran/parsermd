## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(parsermd)
library(magrittr)

## -----------------------------------------------------------------------------
(rmd = parse_rmd(system.file("hw01.Rmd", package = "parsermd")))

## -----------------------------------------------------------------------------
rmd_select(rmd, by_section(c("Exercise 1", "Solution")) & has_type("rmd_markdown")) %>%
  as_document()

## -----------------------------------------------------------------------------
(rmd_sols = rmd_select(rmd, by_section(c("Exercise *", "Solution"))))

## -----------------------------------------------------------------------------
(rmd_tmpl = rmd_template(rmd_sols, keep_content = TRUE))

## -----------------------------------------------------------------------------
rmd_check_template(system.file("hw01-student.Rmd", package = "parsermd"), rmd_tmpl)

## -----------------------------------------------------------------------------
rmd_sols %>%
  rmd_select( !(by_section(c("Exercise 3", "Solution")) & has_type("rmd_markdown")) )

## -----------------------------------------------------------------------------
rmd_sols %>%
  rmd_select( !(by_section(c("Exercise 3", "Solution")) & has_type("rmd_markdown")) ) %>%
  rmd_template(keep_content = TRUE) %>%
  rmd_check_template(system.file("hw01-student.Rmd", package = "parsermd"), .)

