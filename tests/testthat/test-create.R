test_that("error on wrong input", {
    tmp <- tempdir()
    expect_error(create_ubesp_analisis("a-b"))
    expect_error(create_ubesp_analisis(tmp, affiliation = 7))
})
