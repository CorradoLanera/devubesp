
<!-- README.md is generated from README.Rmd. Please edit that file -->

# devubesp

<!-- badges: start -->

[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/CorradoLanera/devubesp?branch=master&svg=true)](https://ci.appveyor.com/project/CorradoLanera/devubesp)
[![Travis build
status](https://travis-ci.org/CorradoLanera/devubesp.svg?branch=master)](https://travis-ci.org/CorradoLanera/devubesp)
[![Codecov test
coverage](https://codecov.io/gh/CorradoLanera/devubesp/branch/master/graph/badge.svg)](https://codecov.io/gh/CorradoLanera/devubesp?branch=master)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN
status](https://www.r-pkg.org/badges/version/devubesp)](https://cran.r-project.org/package=devubesp)
<!-- badges: end -->

The goal of devubesp is to automate analyses setup tasks that are
otherwise performed manually. This includes setting up directories,
supporting packages and projects.

## Installation

You can install the development version from
[GitHub](https://github.com/) with the following procedure:

``` r
# install.packages("devtools")
devtools::install_github("CorradoLanera/devubesp")
```

## Preamble

The package, *de facto*, provide a single function. The aim of the
function \``create_ubesp_analysis()` is to setup all the folders’
structure, with all the needed and sample files to conduct analyses at
UBESP. Does not matter if they are for a thesis, a project, a simple
analyses, the initial structure for the project should be the same.

The aim is to drastically reduce (up to the phisical limit of write a
single line of code) the time needed to set up a well-organized and
standardized structure for all the project, from the simplest to the
most complex.

My first hope is to have provaided a simple and effective instrument to
reduce the direct time in the preparation of any project. The second,
and more relevant, hope is that all of this will be shared between the
colleagues in a way to reduce also the future time to understand each
other projects structure and work-flow in conducting analyses with R
within the same unit.

## Characteristics

The main characteristics of the resulting structure of files and folders
created are:

  - A main folder name which is not ambiguous in time, this is achieved
    pre-appending the year to the name of the main project name.\[1\]

  - presence of a first-level folder to collect and manage *data-raw*,
    which can be huge, and sensitive, hence often they cannot be shared
    or uploaded on the Net (e.g., GitHub). For this reason this folder
    is outside the one promoted to be VCS trakked by git.GitHub. On the
    other hand, the folder itself can be copy-pasted to a costumer
    folder, a supervisor folder, or to an external folder (e.g.,
    SharePoint), if usefull and admitted, because it contains only the
    raw data and the script to import (merge and) import them in the
    analyses folder (if necessary).
    
    The folder structure is very simple and it contains only a
    preconfigured script to import and save the data in the right
    position.

  - presence of a folder (`analyses/`) that can be safely copy-pasted to
    a costumer folder, to supervisor folder, or to an external folder
    (e.g., SharePoint). This has to be happen without any worry to brake
    some VCS controller (like git) nor to share unwanted information,
    comments, notes, data that should remain private to the analyst. It
    will contain all the reports, the outputs, and the scripts useful to
    find the results and also to reproduce them.
    
    The main folder structure is:
    
        analyses/
            |- R/                # R script for analyses and reports (.R)
            |- reports/          # Final version of the reports (.docx)
            |- outputs/          # Output to share for the analyses (.png)
            |- docx-template/    # Template to fine knit the report (.docx) 
            |- bibtex-files/     # Reference cited in the report (.bib)
    
    This folder, because it is an analyses one, is already preconfigured
    as an RStudio `.Rproj`.

  - presence of a package-folder infrastructure which can be use to
    implement and include any custom or additional function usefull for
    the analyses. Making able to test, document, trakking their changes,
    and share with everyone else easily.
    
    This can be VCS with git and GitHub safely, without the risk to
    overfull the space at the disposal with messy and uncompressed raw
    data.
    
    The folder `analyses/` is stored in the first level inside of the
    package-folder, so it is easy to find, and use them for the
    analyses. On the other hande, `analyses/` is `.Rbuildignore`d from
    the package, this way it that can be git-tracked (by default it is)
    but it is not provided in the package boundle.\[2\] Hence, the
    package can be safely shared both through GitHub or CRAN without
    risk to share data or analyses, and everyone (future-you too) can
    easily use all the function you provide with the package as simply
    as `devtools::install_gitub("UBESP-DCTV/<project_name>")`.

  - presence of (standardized) additional common project and utility
    folders and files. These are all subfolders of the main project
    folder:
    
        yyyy-prjname/
            |- essential-bibliography/        # used literature (.pdf) 
            |- papers/            # maintaining ordered in writings
                |- draft/         # from drafts (`.docx`) 
                |- submitted/     # to submissions (`.docx`, `.png`, `.pdf`)
                |- published/     # up to the publishing (`.pdf`, only)
            |- minutes/           # for the minutes (example `.txt` inside)
            |- proposal.docx      # requests (replace example w/ current!)
            |- personal-notes.md  # personal notes, not to be shared 

## Example of usage

The simplest example is all you need to view to learn how simple it is
to be used:\[3\]

``` r
devubesp::create_ubesp_analysis("~/test")
# next, read and follow the instructions appering on the screen :-)
```

You can also include longer path to aggregate similar kynd of projects:

``` r
devubesp::create_ubesp_analysis("~/theses/cl")
devubesp::create_ubesp_analysis("~/department-analyses/cardio/xxx")
devubesp::create_ubesp_analysis("~/whatever/whatelse")
```

## Feature request

If you need some more features, please file an issue on
[github](https://github.com/CorradoLanera/devubesp/issues).

## Bug reports

If you encounter a bug, please file a
[reprex](https://github.com/tidyverse/reprex) (minimal reproducible
example) on [github](https://github.com/CorradoLanera/devubesp/issues).

## Code of Conduct

Please note that the “devubesp” project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.

## Attribution

Most of the underlying function used to create this package comes
directly or with slightly modifications from the
[usethis](https://github.com/r-lib/usethis) package, by Hadley Wickham
and Jennifer Bryan.

## Footnotes

1.  In the `minutes/` folder there where also an empty `.txt` file named
    with the current date (`yymmdd`) and the project name, to permit to
    setup initial official notes (time-trakked).

2.  If you want to not git trakking the `analyses/` folder too, add it
    to `.gitignore`.

3.  the tilda (“`~`”), here, expands to the home directory from the “r
    point-of-view”, i.e. the classical home/ on Unix systems, but to the
    “user/documents” on windows (instead of the simple “user/”).
