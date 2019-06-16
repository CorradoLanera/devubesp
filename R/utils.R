check_package_name <- function(name) {
    if (!valid_package_name(name)) {
        usethis::ui_stop(c(
            "{usethis::ui_value(name)} is not a valid package name. It should:",
            "* Contain only ASCII letters, numbers, and '.'",
            "* Have at least two characters",
            "* Start with a letter",
            "* Not end with '.'"
        ))
    }

}
valid_package_name <- function(x) {
    grepl("^[a-zA-Z][a-zA-Z0-9.]+$", x) && !grepl("\\.$", x)
}


create_directory <- function(path) {
    if (fs::dir_exists(path)) {
        return(invisible(FALSE))
    } else if (fs::file_exists(path)) {
        usethis::ui_stop(
            "{usethis::ui_path(path)} exists but is not a directory."
        )
    }

    fs::dir_create(path)
    usethis::ui_done("Creating {usethis::ui_path(path)}")
    invisible(TRUE)
}

use_template <- function(template,
    save_as = template, data = list(), ignore = FALSE, open = FALSE,
    package = "usethis")
{
    template_contents <- render_template(template, data, package = package)
    new <- usethis::write_over(save_as, template_contents)
    if (ignore) {
        usethis::use_build_ignore(save_as)
    }
    if (open && new) {
        usethis::edit_file(save_as)
    }
    invisible(new)
}

render_template <- function(template, data = list(), package = "usethis") {
    template_path <- find_template(template, package = package)
    strsplit(whisker::whisker.render(readLines(template_path, encoding = "UTF-8"), data), "\n")[[1]]
}

find_template <- function(template_name, package = "usethis") {
    path <- tryCatch(
        fs::path_package(package = package, "templates", template_name),
        error = function(e) ""
    )
    if (identical(path, "")) {
        usethis::ui_stop(
            "Could not find template {ui_value(template_name)}\\
      in package {ui_value(package)}."
        )
    }
    path
}


#' save_data
#'
#' wrapper to \code{\link[base]{save}}).
#'
#' @param ... the (unquoted) set of object to save
#'
#' @param path the path in which to save the data
#' @param overwrite (lgl, default = FALSE) if TRUE and files with the
#'     same names already exist, they were overwritten
#' @param compress the compression algoritm (default = xz)
#' @param compression_level  the compresson level (default = 9)
#' @param version the workspace format version to use (see
#' \code{\link[base]{save}}).
#'
#' @export
save_data <- function(..., path,
    overwrite = FALSE,
    compress = "xz", compression_level = 9,
    version = 2
) {
    objs <- get_objs_from_dots(dots(...))
    create_directory(path)
    paths <- fs::path(path, objs, ext = "rda")

    check_files_absent(paths, overwrite = overwrite)

    usethis::ui_done("Saving {usethis::ui_value(unlist(objs))} to {usethis::ui_value(paths)}")

    envir <- parent.frame()
    mapply(save, list = objs, file = paths,
        MoreArgs = list(
            envir = envir,
            compress = compress,
            version = version
        )
    )
    invisible()
}

check_files_absent <- function(paths, overwrite) {
    if (overwrite) return()

    ok <- !fs::file_exists(paths)

    if (all(ok)) return()

    usethis::ui_stop(
        "
    {usethis::ui_path(paths[!ok])} already exist.,
    Use {usethis::ui_code('overwrite = TRUE')} to overwrite.
    "
    )
}

get_objs_from_dots <- function(.dots) {
    if (length(.dots) == 0L) {
        usethis::ui_stop("Nothing to save.")
    }

    is_name <- vapply(.dots, is.symbol, logical(1))
    if (any(!is_name)) {
        usethis::ui_stop("Can only save existing named objects.")
    }

    objs <- vapply(.dots, as.character, character(1))
    duplicated_objs <- which(stats::setNames(duplicated(objs), objs))
    if (length(duplicated_objs) > 0L) {
        objs <- unique(objs)
        usethis::ui_warn(
            "
        Saving duplicates only once: {ui_value(names(duplicated_objs))}
        "
        )
    }
    objs
}

dots <- function(...) {
    eval(substitute(alist(...)))
}
