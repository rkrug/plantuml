test_that(
  "Server is running after loading of the package",
  {
    expect_snapshot(
      {
        server_status()
        server_info()
      }
    )
  }
)

test_that(
  "Starting of server works as expected",
  {
    expect_snapshot(
      {
        server_start()
        server_status()
        server_info()
      }
    )
  }
)

test_that(
  "Stopping of server works as expected",
  {
    expect_snapshot(
      {
        server_stop()
        Sys.sleep(2)
        server_status()
        server_info()
        server_start()
      }
    )
  }
)
