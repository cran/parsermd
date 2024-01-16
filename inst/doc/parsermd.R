## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(magrittr)

## -----------------------------------------------------------------------------
library(parsermd)

## ----example------------------------------------------------------------------
rmd = parsermd::parse_rmd(system.file("minimal.Rmd", package = "parsermd"))

## ----tree---------------------------------------------------------------------
print(rmd)

## ----no_headings--------------------------------------------------------------
print(rmd, use_headings = FALSE)

## ----tibble-------------------------------------------------------------------
as_tibble(rmd)

## ----as_ast-------------------------------------------------------------------
as_ast( as_tibble(rmd) )

## ----as_doc-------------------------------------------------------------------
cat(
  as_document(rmd),
  sep = "\n"
)

## -----------------------------------------------------------------------------
rmd = parse_rmd(system.file("hw01-student.Rmd", package="parsermd"))
rmd

## -----------------------------------------------------------------------------
rmd_select(rmd, by_section( c("Exercise 1", "Solution") ))

## -----------------------------------------------------------------------------
rmd_select(rmd, by_section( c("Exercise 1", "Solution") )) %>%
  as_document()

## -----------------------------------------------------------------------------
rmd_select(rmd, by_section(c("Exercise 1", "Solution")) & has_type("rmd_markdown")) %>%
  as_document()

## -----------------------------------------------------------------------------
rmd_select(rmd, by_section(c("Exercise 1", "Solution"))) %>%
  rmd_select(has_type("rmd_markdown")) %>%
  as_document()

## -----------------------------------------------------------------------------
rmd_select(rmd, by_section(c("Exercise *", "Solution")))

## -----------------------------------------------------------------------------
rmd_select(rmd, has_label("plot*"))

## -----------------------------------------------------------------------------
tbl = as_tibble(rmd)
tbl

## -----------------------------------------------------------------------------
rmd_select(tbl, by_section(c("Exercise *", "Solution")))

## -----------------------------------------------------------------------------
tbl_lines = tbl %>%
  dplyr::mutate(lines = rmd_node_length(ast))

tbl_lines

## -----------------------------------------------------------------------------
rmd_select(tbl_lines, by_section(c("Exercise 2", "Solution")))

## -----------------------------------------------------------------------------
tbl_lines %>%
  dplyr::filter(sec_h3 == "Exercise 2", sec_h4 == "Solution")

## -----------------------------------------------------------------------------
tbl %>%
  dplyr::filter(sec_h3 == "Exercise 2", sec_h4 == "Solution", type == "rmd_chunk")

## -----------------------------------------------------------------------------
tbl %>%
  dplyr::filter(sec_h3 == "Exercise 2", sec_h4 == "Solution", type == "rmd_chunk") %>%
  as_document() %>% 
  cat(sep="\n")

## -----------------------------------------------------------------------------
tbl %>%
  rmd_select(by_section(c("Exercise 2", "Solution")) & has_type("rmd_chunk")) %>%
  as_document() %>% 
  cat(sep="\n")

