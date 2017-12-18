library('testthat')

points_for_all_tests(c("r1"))

test("Paste works.", c("r1.1"), {
    expect_true(exists("used_paste_args"))
    expect_equal(pasted, "ab")
    expect_true(length(used_paste_args) == 2)
    expect_equal(pasted2, "1b")
})

test("Plot works.", c("r1.2"), {
    expect_true(exists("used_plot_args"))
    expect_equal(used_plot_args, c(1, 2))
})
