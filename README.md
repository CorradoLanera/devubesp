
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

## Example

The package, *de facto*, provide a single function. The aim of the
function \``create_ubesp_analysis()` is to setup all the folders’
structure, with all the needed and sample files to conduct analyses at
UBESP. Does not matter if they are for a thesis, a project, a simple
analyses, the initial structure for the project should be the same.

The main characteristics are: - presence of folder (`analyses/`) that
can be safely copy-pasted to a costumer folder or to an external one
(e.g., SharePoint). It will contains all the reports, outputs, and
script useful to easily find the results and also to reproduce them. -
presence of an external folder to collect and manage *data-raw* which
can be huge, sensitive, and so often they cannot be shared or uploaded
on the net (e.g., on GitHub). On the other hand, the folder itself can
be copy-pasted to a costumer folder or to an external one (e.g.,
SharePoint) if usefull/admitted. - presence of a package-folder
infrastructure which can be use to safely implement/include any custom
or additional function usefull for the analyses. This can be VCS with
git and GitHub safely, without risk to fill the space with data.
Moreover, the folder `analyses` is inside the package main folder but it
is `.Rbuildignored`, this means that can be git-tracked but it is not
provided in the package boundle. Hence, the package can be safely shared
both through GitHub or CRAN without risk to share data or anayses. -
presence of folders and files to track: - literature used - papers
written (in all the draft, submitted and published shape) - minutes -
proposal - personal and private notes or comments not to be shared.

This is a basic example which shows you how to simple it is to be
used:\[1\]

``` r
devubesp::create_ubesp_analysis("~/test")
```

## Code of Conduct

Please note that the “devubesp” project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.

1.  the tilda (“`~`”), here, expands to the home directory from the “r
    point-of-view”, i.e. the classical home/ on Unix systems, but to the
    “user/documents” on windows (instead of the simple “user/”).
