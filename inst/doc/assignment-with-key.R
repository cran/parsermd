## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 5
)


## ----setup--------------------------------------------------------------------
library(parsermd)
library(stringr)


## ----show-assignment----------------------------------------------------------
# Load the sample assignment
assignment_path = system.file("examples/hw03-full.qmd", package = "parsermd")
cat(readLines(assignment_path), sep = "\n")


## ----parse-document-----------------------------------------------------------
# Parse the assignment
rmd = parse_rmd(assignment_path)

# Display the document structure
print(rmd)


## ----examine-tibble-----------------------------------------------------------
# Convert to tibble for easier inspection
as_tibble(rmd)


## ----create-student-version---------------------------------------------------
# Select student chunks and all non-chunk content
student_version = rmd |>
  rmd_select(
    # Easier to specify the nodes we want to remove
    !has_label("*-key")
  )

# Display the student version structure
student_version


## ----remove-student-suffix----------------------------------------------------
student_version = student_version |>
  rmd_modify(
    function(node) {
      rmd_node_label(node) = stringr::str_remove(rmd_node_label(node), "-student")
      node
    },
    has_label("*-student")
  )

# Show the first few chunks to see the label changes
student_version


## ----student-document---------------------------------------------------------
# Convert to document and display first few sections
as_document(student_version) |>
  cat(sep = "\n")


## ----save-student, eval=FALSE-------------------------------------------------
# # Save student version (not run in vignette)
# as_document(student_version) |>
#   writeLines("homework-student.qmd")


## ----create-instructor-key----------------------------------------------------
# Select solution chunks and all non-chunk content
instructor_key = rmd |>
  rmd_select(
    # Again this is easier to specify the nodes we want to remove
    !has_label("*-student")
  )

# Display the instructor key structure
instructor_key


## ----instructor-document------------------------------------------------------
# Convert to document
instructor_doc = as_document(instructor_key)

# Display first part of the document
cat(head(strsplit(instructor_doc, "\n")[[1]], 50), sep = "\n")


## ----create-minimalist-key----------------------------------------------------
# Select only headings and solution chunks
minimalist_key = rmd |>
  rmd_select(
    # Keep yaml and exercise headings for structure
    has_type("rmd_yaml"),
    has_heading(c("Exercise *", "Bonus*")),
    # Keep only solution chunks
    has_label(c("*-key", "setup"))
  ) |>
  rmd_modify(
    function(node) {
      rmd_node_options(node) = list(include = FALSE)
      node
    },
    has_label("setup")
  )

# Display the minimalist key structure
minimalist_key


## ----minimalist-document------------------------------------------------------
# Convert to document
minimalist_doc = as_document(minimalist_key)
cat(minimalist_doc, sep = "\n")

