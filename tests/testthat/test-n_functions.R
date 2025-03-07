test_that("n_non_numeric counts non-numeric elements correctly", {
  x <- c("10", "abc", "5.5", "NaN", "NA", "42", "3e2")
  expect_equal(n_non_numeric(x), 1)
  
  y <- c("1", "2", "3", "4", "5")
  expect_equal(n_non_numeric(y), 0)
  
  z <- c("apple", "banana", "orange")
  expect_equal(n_non_numeric(z), 3)
})

test_that("nc_get_dim_min_max handles missing dimension", {
  mock_nc <- list(dim = list(time = list(vals = 1:10)))
  expect_equal(nc_get_dim_min_max(mock_nc, "time"), c(1, 10))
  expect_error(nc_get_dim_min_max(mock_nc, "depth"), "depth not found in file")
})

test_that("nc_as_data_frame rejects mismatched points", {
  mock_nc <- list(dim = list(lon = list(vals = 1:10), lat = list(vals = 1:10)))
  expect_error(nc_as_data_frame(mock_nc, vars = c("temp"), lon_points = c(1,2), lat_points = c(3)), "lon_points and lat_points have unequal lengths")
})

test_that("next_default_item generates unique item names", {
  existing_names <- c("item1", "item2", "item3")
  
  expect_equal(next_default_item("item3", existing_names), "item31")
  expect_equal(next_default_item("newItem", existing_names), "newItem")
  expect_equal(next_default_item("item", existing_names, include_index = TRUE, start_index = 5), "item4")
})

test_that("Not-in operator works as expected", {
  expect_true(5 %notin% c(1, 2, 3, 4))
  expect_false("a" %notin% c("a", "b", "c"))
  expect_true("z" %notin% c("a", "b", "c"))
})
