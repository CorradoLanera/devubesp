#' ---
#' title: "{{{ title }}}"
#' author: "{{{ analyst }}}"
#' date: "`r Sys.Date()`"
#' output:
#'   word_document:
#'     reference: "../docx-template/template.docx"
#'     toc: true
#' bibliography: "../bibtex-files/biblio.bib"
#' ---
#'
#' ```{r setup, include=FALSE}
#' knitr::opts_chunk$set(
#'     echo = FALSE,
#'     comment = "#>",
#'     collapse = TRUE
#' )
#' ```
#'


# package loading -------------------------------------------------

#+ packages, include = FALSE

# install.packages("devtools")
# devtools::install_github("CorradoLanera/depigner")
stopifnot(requireNamespace("depigner", quietly = TRUE))
library(depigner)

library(pander)
    panderOptions("round", 2)
    panderOptions("table.split.table", Inf)
    panderOptions("table.alignment.default",
        function(df) {
            n <- length(df) - 1L
            c("left", rep("center", n))
        }
    )

library(tidyverse)
library(lubridate)

library(glue)
library(here)

library(rms)
    options(datadist = "dd")

# library({{{ package_name }}})




# Begin analyses --------------------------------------------------

#'
#' # Introduction
#'
#'
#' # Material and Methods
#'
#'
#' # Analyses
#'
#'
#' ## Descriptives
#'

#+ describe
dd <- datadist(mtcars)
summary(am~.,
        data = mtcars,
        method = "reverse",
        test = TRUE,
        overall = TRUE,
        continuous = 4
    ) %>%
    tidy_summary(prtest = "P") %>%
    adjust_p() %>%
    pander()


#'
#' ## Models
#'

#+ model-1
big_deal <- ols(am ~ vs*carb + gear + rcs(wt, 3),
    data = mtcars,
    x = TRUE, y = TRUE,
    se.fit = TRUE
)
ggplot(Predict(big_deal))
