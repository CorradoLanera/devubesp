test_that("pipe works", {
    expect_equal(sum(1, 2), 1 %>% sum(2))
})
