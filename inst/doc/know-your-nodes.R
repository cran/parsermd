## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, collapse = TRUE, comment = "#>")
library(parsermd)


## -----------------------------------------------------------------------------
ast = rmd_ast(list(
  rmd_yaml(list(title = "Example Document")),
  rmd_heading(name = "Introduction", level = 1L),
  rmd_markdown(lines = "This is some text."),
  rmd_chunk(
    engine = "r",
    code = c("x <- 1:5", "mean(x)")
  )
))


## -----------------------------------------------------------------------------
print(ast, flat = FALSE)


## -----------------------------------------------------------------------------
print(ast, flat = TRUE)


## -----------------------------------------------------------------------------
# Create a heading node
heading = rmd_heading(name = "Section Title", level = 2L)

# Access properties with @
heading@name
heading@level


## -----------------------------------------------------------------------------
yaml_node = rmd_yaml(list(
  title = "My Document",
  author = "John Doe",
  date = "2023-01-01"
))
yaml_node


## -----------------------------------------------------------------------------
heading_node = rmd_heading(
  name = "Introduction", 
  level = 1L
)
heading_node


## -----------------------------------------------------------------------------
markdown_node = rmd_markdown(
  lines = c("This is a paragraph.", "With multiple lines.")
)
markdown_node


## -----------------------------------------------------------------------------
# Traditional-style options
chunk_node_traditional = rmd_chunk(
  engine = "r",
  label = "example",
  options = list(eval = "TRUE", echo = "FALSE"),
  code = c("x <- 1:10", "mean(x)")
)

# YAML-style options with proper types
chunk_node_yaml = rmd_chunk(
  engine = "r",
  label = "example",
  options = list(eval = TRUE, echo = FALSE),
  code = c("x <- 1:10", "mean(x)")
)

chunk_node_yaml


## -----------------------------------------------------------------------------
raw_chunk_node = rmd_raw_chunk(
  format = "html",
  code = c(
    "<div class='custom'>", 
    "  <p>Custom HTML content</p>", 
    "</div>"
  )
)
raw_chunk_node


## -----------------------------------------------------------------------------
code_block_node = rmd_code_block(
  classes = c("python"),
  code = c(
    "def hello():", 
    "    print('Hello, World!')"
  )
)
code_block_node


## -----------------------------------------------------------------------------
code_block_literal_node = rmd_code_block_literal(
  attr = "r, echo=TRUE, eval=FALSE",
  code = c(
    "x <- 1:10", 
    "mean(x)"
  )
)
code_block_literal_node


## -----------------------------------------------------------------------------
# Create the opening node
fenced_div_open_node = rmd_fenced_div_open(
  classes = c(".warning"),
  attr = c(id = "important")
)

# Create the closing node
fenced_div_close_node = rmd_fenced_div_close()

# These would typically be combined with content nodes in an rmd_ast
ast_with_div = rmd_ast(list(
  fenced_div_open_node,
  rmd_markdown(
    lines = "This content is inside the fenced div."
  ),
  rmd_markdown(
    lines = "More content here."
  ),
  fenced_div_close_node
))


## -----------------------------------------------------------------------------
# Create directly
inline_code_obj = rmd_inline_code(
  engine = "r",
  code = "2 + 2",
  braced = FALSE
)
inline_code_obj


## -----------------------------------------------------------------------------
# Create directly
shortcode_obj = rmd_shortcode(
  func = "embed",
  args = c("type=video", "src=example.mp4")
)
shortcode_obj


## -----------------------------------------------------------------------------
# Create directly
span_obj = rmd_span(
  text = "Important text",
  id = c("#key"),
  classes = c(".highlight")
)
span_obj

