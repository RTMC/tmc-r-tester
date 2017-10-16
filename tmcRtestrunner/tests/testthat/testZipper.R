test_resources_dir <- paste(sep = "", getwd(), "/resources")

pack_folder_path <- paste(sep = "", test_resources_dir, "/pack")


test_that("Zipfile is created", {
  .tmc_zip(pack_folder_path, "resources/testZip")
  expect_true(file.exists("resources/testZip.zip"))
  file.remove("resources/testZip.zip")
})

test_that("Tarfile is created", {
  .tmc_tar(pack_folder_path, "resources/testTar")
  expect_true(file.exists("resources/testTar.tar"))
  file.remove("resources/testTar.tar")
})

test_that("Zipfile is unpacked", {
  .tmc_zip(pack_folder_path, "resources/testZip")
  .tmc_unzip("resources/testZip.zip", "resources/unpack")
  file.remove("resources/testZip.zip")
  expect_true(file.exists("resources/unpack/packfile1.R"))
})

test_that("Tarfile is unpacked", {
  .tmc_tar(pack_folder_path, "resources/testTar")
  .tmc_untar("resources/testTar.tar", "resources/unpack")
  file.remove("resources/testTar.tar")
  expect_true(file.exists("resources/unpack/packfile1.R"))
})
