# Runs the tests from project directory and writes results JSON to the root of the project
# as .tmc_results.json.
#
# Args:
#  project_path: The absolute path to the root of the project being tested.
#  print: If TRUE, prints results; if not, not. DEFAULT is FALSE.
#
runTests <- function(projectPath, print=FALSE) {
  tmcrTestRunnerProjectPath <- getwd()

  #runs test for project, returns testthatOuput with added points.
  #using tryCatch: if any errors occur testthatOutput is NULL.
  testthatOutput <- tryCatch({
    .RunTestsProject(projectPath)}
    ,error=function(error) { return(NULL)})

  #There was an error in runTests
  if (is.null(testthatOutput)) {
    #Results only contain traceback of error. TODO: traceback
    jsonResults <- list(list(traceback = c("")))
    if (print) cat("Error while running tests. Sorry, no traceback yet.")
  } else {
    jsonResults <- .CreateJsonResults(testthatOutput)
    if (print) .PrintResultsFromJson(jsonResults)
  }

  .WriteJson(jsonResults)
  setwd(tmcrTestRunnerProjectPath)
}

.RunTestsProject <- function(projectPath) {
  setwd(projectPath)

  testthatOutput <- list()

  #Lists all the files in the path beginning with "test" and ending in ".R"
  testFiles <- list.files(path="tests/testthat", pattern = "test.*\\.R", full.names = T, recursive = FALSE)

  for (testFile in testFiles) {
    testFileOutput <- .RunTestsFile(testFile)
    testthatOutput <- c(testthatOutput, testFileOutput)
  }
  return(testthatOutput)
}

.RunTestsFile <- function(filePath) {
  .GlobalEnv$points <- list()
  .GlobalEnv$points_for_all_tests <- list()

  testFileOutput <- test_file(filePath, reporter = "silent")
  testFileOutput <- .AddPointsToTestOutput(testFileOutput)

  return(testFileOutput)
}

.AddPointsToTestOutput <- function(testOutput) {
  for (i in 1 : length(testOutput)) {
    testOutput[[i]]$points <- .GetTestPoints(testOutput[[i]]$test)
  }
  return(testOutput)
}

.GetTestPoints <- function(testName) {
  if (is.null(points[[testName]])) {
    testPoints <- vector()
  } else {
    testPoints <- points[[testName]]
  }
  testPoints <- c(.GlobalEnv$points_for_all_tests, testPoints)
  return(testPoints)
}

runTestsWithDefault <- function(bol) {
  runTests(getwd(), bol)
}
