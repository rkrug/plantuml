
server_stop()

test_that(
  "Server is not starting when server_url != \"localhost\"",
  {
    expect_snapshot_error(
      {
        server_start()
      }
    )
  }
)

test_that(
  "Starting of server works as expected",
  {
    expect_snapshot(
      {
        server_set("local")
        #
        s <- server_start()
        s$version <- "NA"
        s
        #
        s <- server_status()
        s$version <- "NA"
        s
        #
        s <- server_start()
        s$version <- "NA"
        s
        #
        s <- server_info()
        s$version <- "NA"
        s
        #
        server_set("remote")
      }
    )
  }
)

test_that(
  "Stopping of server works as expected",
  {
    expect_snapshot(
      {
        server_set("local")
        #
        s <- server_stop()
        s$version <- "NA"
        s
        Sys.sleep(2)
        s <- server_status()
        s$version <- "NA"
        s
        s <- server_info()
        s$version <- "NA"
        s
        s <- server_start()
        s$version <- "NA"
        s
        #
        server_set("remote")
      }
    )
  }
)
