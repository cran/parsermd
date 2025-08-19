## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)


## ----setup--------------------------------------------------------------------
library(parsermd)


## ----parse-document-----------------------------------------------------------
hw = system.file("examples/hw01.Rmd", package = "parsermd")
(rmd = parse_rmd(hw))


## ----modify-chunk-options-----------------------------------------------------
rmd_figs = rmd |>
  rmd_modify(
    # The function to apply to each selected node
    .f = function(node) {
      rmd_node_set_options(node, fig.width = 8, fig.height = 5)
    },
    # The selection criteria - chunks that already have figure options
    has_type("rmd_chunk")
  )

# Let's inspect the options of the original plot-dino chunk before modification
rmd_select(rmd, has_label("plot-dino"), keep_yaml = FALSE) |>
  rmd_node_options() |>
  str()

# and after modification
rmd_select(rmd_figs, has_label("plot-dino"), keep_yaml = FALSE) |>
  rmd_node_options() |>
  str()


## ----modify-text-content------------------------------------------------------
# Create a function to replace text in markdown nodes
replace_content = function(node) {
  rmd_node_set_content(
    node,
    stringr::str_replace(
      rmd_node_content(node),
      "correlation",
      "covariance"
    )
  )
}

# Apply this function to the "Exercise 2" section markdown nodes
rmd_text = rmd |>
  rmd_modify(
    .f = replace_content,
    by_section("Exercise 2") & has_type("rmd_markdown")
  )

# Let's see the modified text
rmd_text |>
  rmd_select(by_section("Exercise 2")) |>
  as_document() |>
  cat(sep = "\n")


## ----create-setup-chunk-------------------------------------------------------
# Create a new setup chunk
setup = rmd_chunk(
  engine = "r",
  label = "setup",
  options = list(include = FALSE),
  code = "knitr::opts_chunk$set(echo = TRUE)"
)

setup


## ----insert-setup-chunk-------------------------------------------------------
# Insert the new chunk after the YAML node
rmd_setup = rmd |>
  rmd_insert(
    has_type("rmd_yaml"),
    nodes = setup,
    location = "after"
  )

# Print the top of the document to see the new chunk
print(rmd_setup)


## ----wrap-in-callout----------------------------------------------------------
# Wrap the selected section in a warning callout
rmd_wrap = rmd |>
  rmd_fenced_div_wrap(
    by_section("Exercise 1"),
    open = rmd_fenced_div_open(classes = ".callout-warning", id = "#note-callout")
  )

# Let's view the new structure as a document
rmd_wrap |>
  rmd_select(by_section("Exercise 1"))


## -----------------------------------------------------------------------------
rmd_select(
  rmd_wrap,
  by_fenced_div(class=".callout-warning"),
  keep_yaml = FALSE
)


## -----------------------------------------------------------------------------
doc = c(
  "---",
  "title: My Video Collection",
  "---",
  "",
  "# Introduction",
  "",
  "Here is my first video:",
  "{{< video https://example.com/video1.mp4 >}}",
  "",
  "And here is another one with more options:",
  "{{< video https://example.com/video2.mp4 title=\"Second Video\" >}}",
  "",
  "{{< pagebreak >}}",
  "",
  "That's all for now!"
)

# Parse the text
qmd = parse_qmd(doc)


## -----------------------------------------------------------------------------
# Select the markdown node containing the first shortcode
md = rmd_select(qmd, has_type("rmd_markdown") & has_shortcode(), keep_yaml = FALSE) 

# Extract shortcodes from that node
(shortcodes = rmd_extract_shortcodes(md, flatten = TRUE))


## -----------------------------------------------------------------------------
replace_videos = function(node) {
  # Check if the node contains a video shortcode
  if (rmd_has_shortcode(node, "video")) {
    rmd_node_set_content(
      node,
      stringr::str_replace_all(
        rmd_node_content(node),
        "\\{\\{< video .* >\\}\\}",
        "[VIDEO PLACEHOLDER]"
      )
    )
  } else {
    # If not a video shortcode, return the node unchanged
    node
  }
}

# Apply the modification to the whole document
qmd_modified = rmd_modify(qmd, replace_videos)

# See the result
as_document(qmd_modified) |>
  cat(sep="\n")

