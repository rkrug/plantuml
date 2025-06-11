# test_that(
#   "Automatic download when calling plantuml_run()",
#   {
#     expect_snapshot(
#       {
#         plantuml_run()
#       }
#     )
#   }
# )

unlink(getPlantumlOption("jar_name"))

vcr::local_cassette("update_plantuml_jar_beta")
test_that("plantuml_update(tag = 'snapshot')", {
  expect_snapshot(
    {
      plantuml_update(tag = "snapshot")
      file.exists(getPlantumlOption("jar_name"))
      unlink(getPlantumlOption("jar_name"))
    }
  )
})


vcr::local_cassette("update_plantuml_jar_release")
test_that("plantuml_update(tag = 'release')", {
  expect_snapshot(
    {
      plantuml_update(tag = "release")
      file.exists(getPlantumlOption("jar_name"))
    }
  )
})
