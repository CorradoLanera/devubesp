#' Create a UBESP analysis project
#'
#' @description
#' This function create a standard UBESP analysis project:
#'     * `create_ubesp_analisis()` creates a UBESP R analysis project
#'
#' The function can be called on an existing project; you will be asked
#' before any existing files are changed.
#'
#' @param path A path. If it exists, it is used. If it does not exist,
#'     it is created, provided that the parent path exists.
#' @param rstudio If `TRUE`, calls [use_rstudio()] to make the new
#'   supporting package and analysis project into [RStudio
#'   Projects](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects).
#'   If `FALSE` and a non-package project, a sentinel `.here` file is
#'   placed so that the directory can be recognized as a project by the
#'   [here](https://here.r-lib.org) or
#'   [rprojroot](https://rprojroot.r-lib.org) packages.
#' @param open If `TRUE`, [activates][proj_activate()] the new
#'   analysis project:
#'
#'     * If RStudio desktop, the package is opened in a new session.
#'     * If on RStudio server, the current RStudio project is activated.
#'     * Otherwise, the working directory and active project is changed.
#' @param affiliation the affiliaton for the project (default = "ubesp")
#' @return Path to the newly created project or package, invisibly.
#' @export
#' @examples
#' \dontrun{
#'     create_ubesp_analysis("~/test")
#' }
create_ubesp_analysis <- function(path,
    affiliation = "ubesp",
    rstudio = rstudioapi::isAvailable(),
    open = interactive()
) {
    path <- fs::path_expand_r(path)
    prj_dir <- fs::path_dir(path)

    name <- fs::path_file(path)
    check_package_name(name)

    prj_name <- paste0(substr(Sys.Date(), 1, 4), "-", name)
    prj_path <- fs::path(prj_dir, prj_name)

    stopifnot(is.character(affiliation))
    pkg_name <- paste0(name, ".", affiliation)

    filename_prefix <- paste0(gsub("-", "", Sys.Date()), "-", name)

    create_directory(prj_path)

    create_directory(fs::path(prj_path, "minutes"))
    fs::file_create(fs::path(prj_path, "minutes",
        paste0(filename_prefix, "_meeting"), ext = "txt"
    ))

    create_directory(fs::path(prj_path, "essential-bibliography"))

    create_directory(fs::path(prj_path, "papers"))
    create_directory(fs::path(prj_path, "papers", "drafts"))
    create_directory(fs::path(prj_path, "papers", "submitted"))
    create_directory(fs::path(prj_path, "papers", "published"))

    create_directory(fs::path(prj_path, "data-raw"))
    use_template(
        "import-data.R",
        save_as = fs::path(
            prj_path, "data-raw", "import_data", ext = "R"
        ),
        data = list(
            name = paste0(name, "_data"),
            path_to_data = fs::path_expand_r(
                fs::path(prj_path, pkg_name, "analyses", "data")
            )
        ),
        ignore = FALSE,
        open = FALSE,
        package = "devubesp"
    )

    create_directory(fs::path(prj_path, pkg_name))
    create_directory(fs::path(prj_path, pkg_name, "analyses"))

    create_directory(fs::path(prj_path, pkg_name, "analyses", "docx-template"))
    fs::file_copy(
        system.file("templates/template.docx", package = "devubesp"),
        fs::path(prj_path, pkg_name, "analyses", "docx-template",
                 "template", ext = "docx"
        )
    )

    create_directory(fs::path(prj_path, pkg_name, "analyses", "bibtex-files"))
    fs::file_copy(
        system.file("templates/biblio.bib", package = "devubesp"),
        fs::path(prj_path, pkg_name, "analyses", "bibtex-files",
                 "biblio", ext = "bib"
        )
    )

    create_directory(fs::path(prj_path, pkg_name, "analyses", "outputs"))
    create_directory(fs::path(prj_path, pkg_name, "analyses", "reports"))

    fs::file_create(fs::path(prj_path, "personal-notes", ext = "md"))
    fs::file_create(fs::path(prj_path, "_proposal-to_be_substitute_with_the_real_one", ext = "docx"))

    usethis::ui_done("Project main structure ready")

    usethis::create_project(
        fs::path(prj_path, pkg_name, "analyses"),
        open = FALSE
    )
    use_template(
        "sample-analysis.R",
        save_as = fs::path(
            prj_path, pkg_name, "analyses", "R",
            paste0(filename_prefix, "_analysis"), ext = "R"
        ),
        data = list(
            title = paste("Analyses for the", name, "project"),
            analyst = getOption("usethis.full_name"),
            package_name = pkg_name
        ),
        ignore = FALSE,
        open = FALSE,
        package = "devubesp"
    )

    usethis::ui_done("R-project for the analyses ready")

    usethis::create_package(fs::path(prj_path, pkg_name), open = FALSE)

    usethis::ui_done("Suporting R-packge ready")

    usethis::write_union(
        fs::path(prj_path, pkg_name, ".Rbuildignore"),
        "^analyses$"
    )

    usethis::ui_done(
        "Structure for the {usethis::ui_value(name)} project ready."
    )

    usethis::ui_info(
        "{usethis::ui_path(fs::path(prj_path, pkg_name, 'analyses'))}\\
    is the R-proj for the analyses.
    Can be shared directly (by a full copy) to the customer.
    Please, use:
        * {usethis::ui_code('R/')} for the analyses (i.e., R script producing reports)
        * {usethis::ui_code('reports/')} to move the {usethis::ui_code('.docx')} reports
        * {usethis::ui_code('output/')} to store the output (e.g., plots)
        * {usethis::ui_code('docx-template/')} for the report's templates
        * {usethis::ui_code('bibtex-files/')} for the file {usethis::ui_code('.bib')} for the reports' references
    ")


    usethis::ui_todo(
        "Please, put all the raw data into the folder \\
    {usethis::ui_path(fs::path(prj_path, 'data-raw'))}.
    ")
    usethis::ui_todo(
        "Process and save raw data filling the script in {usethis::ui_path(fs::path(prj_path, 'data-raw'))}."
    )


    usethis::ui_info(
        "{usethis::ui_path(fs::path(prj_path, pkg_name))}\\
    contains your R pakage skeleton.
    ")
    usethis::ui_todo(
        "You may visit {usethis::ui_path('http://bit.ly/rpkg-setup')} \\
    to set it up tidyly.
    ")
    usethis::ui_todo(
        "Develop the package to include custom functions for the analyses.
    It is intended to be shared through GitHub or CRAN.
    (NOTE: its {usethis::ui_code('analyses/')} subfolder is {usethis::ui_code('.Rbuildignore')}d.)
    ")

    return(invisible(TRUE))
}
