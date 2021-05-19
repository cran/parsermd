
<!-- README.md is generated from README.Rmd. Please edit that file -->

# parsermd

<!-- badges: start -->

[![R-CMD-check](https://github.com/rundel/parsermd/workflows/R-CMD-check/badge.svg)](https://github.com/rundel/parsermd/actions)
[![CRAN
status](https://www.r-pkg.org/badges/version/parsermd)](https://CRAN.R-project.org/package=parsermd)
<!-- badges: end -->

The goal of parsermd is to extract the content of an R Markdown file to
allow for programmatic interactions with the document’s contents
(i.e. code chunks and markdown text). The goal is to capture the
fundamental structure of the document and as such we do not attempt to
parse every detail of the Rmd. Specifically, the yaml front matter,
markdown text, and R code are read as text lines allowing them to be
processed using other tools.

## Installation

You can install the development version of parsermd from
[GitHub](https://github.com/rundel/parsermd) with:

``` r
remotes::install_github("rundel/parsermd")
```

``` r
library(parsermd)
```

## Basic Usage

For more details see the getting started
[vignette](https://rundel.github.io/parsermd/articles/parsermd.html) or
any of the topic specific articles.

``` r
(rmd = parsermd::parse_rmd(system.file("minimal.Rmd", package = "parsermd")))
#> ├── YAML [4 lines]
#> ├── Heading [h1] - Setup
#> │   └── Chunk [r, 1 opt, 1 lines] - setup
#> └── Heading [h1] - Content
#>     ├── Heading [h2] - R Markdown
#>     │   ├── Markdown [6 lines]
#>     │   ├── Chunk [r, 1 lines] - cars
#>     │   └── Chunk [r, 1 lines] - <unnamed>
#>     └── Heading [h2] - Including Plots
#>         ├── Markdown [2 lines]
#>         ├── Chunk [r, 1 opt, 1 lines] - pressure
#>         └── Markdown [2 lines]

as_tibble(rmd)
#> # A tibble: 12 x 5
#>    sec_h1  sec_h2          type          label      ast           
#>    <chr>   <chr>           <chr>         <chr>      <rmd_ast>     
#>  1 <NA>    <NA>            rmd_yaml_list  <NA>      <yaml>        
#>  2 Setup   <NA>            rmd_heading    <NA>      <heading [h1]>
#>  3 Setup   <NA>            rmd_chunk     "setup"    <chunk [r]>   
#>  4 Content <NA>            rmd_heading    <NA>      <heading [h1]>
#>  5 Content R Markdown      rmd_heading    <NA>      <heading [h2]>
#>  6 Content R Markdown      rmd_markdown   <NA>      <markdown [6]>
#>  7 Content R Markdown      rmd_chunk     "cars"     <chunk [r]>   
#>  8 Content R Markdown      rmd_chunk     ""         <chunk [r]>   
#>  9 Content Including Plots rmd_heading    <NA>      <heading [h2]>
#> 10 Content Including Plots rmd_markdown   <NA>      <markdown [2]>
#> 11 Content Including Plots rmd_chunk     "pressure" <chunk [r]>   
#> 12 Content Including Plots rmd_markdown   <NA>      <markdown [2]>

rmd_select(rmd, by_section("Content"))
#> └── Heading [h1] - Content
#>     ├── Heading [h2] - R Markdown
#>     │   ├── Markdown [6 lines]
#>     │   ├── Chunk [r, 1 lines] - cars
#>     │   └── Chunk [r, 1 lines] - <unnamed>
#>     └── Heading [h2] - Including Plots
#>         ├── Markdown [2 lines]
#>         ├── Chunk [r, 1 opt, 1 lines] - pressure
#>         └── Markdown [2 lines]

rmd_select(rmd, by_section(c("Content", "*"))) %>%
  rmd_select(has_type(c("rmd_chunk", "rmd_heading")))
#> └── Heading [h1] - Content
#>     ├── Heading [h2] - R Markdown
#>     │   ├── Chunk [r, 1 lines] - cars
#>     │   └── Chunk [r, 1 lines] - <unnamed>
#>     └── Heading [h2] - Including Plots
#>         └── Chunk [r, 1 opt, 1 lines] - pressure

rmd_select(rmd, "pressure")
#> └── Chunk [r, 1 opt, 1 lines] - pressure

rmd_select(rmd, 1:3)
#> ├── YAML [4 lines]
#> └── Heading [h1] - Setup
#>     └── Chunk [r, 1 opt, 1 lines] - setup
```
