library("vcr")

vcr_dir <- vcr::vcr_test_path("fixtures", "vcr")
vcr::vcr_configure_log(file = file.path(vcr_dir, "vcr.log"))

# if (!nzchar(Sys.getenv("openalexR.apikey"))) {
#   if (dir.exists(vcr_dir)) {
#     # Fake API token to fool our package
#     Sys.setenv("openalexR.apikey" = "foobar")
#   } else {
#     # If there's no mock files nor API token, impossible to run tests
#     stop("No API key nor cassettes, tests cannot be run.", call. = FALSE)
#   }
# }

invisible(vcr::vcr_configure(
  dir = vcr_dir #,
  # Filter the request header where the token is sent, make sure you know
  # how authentication works in your case and read the Security chapter :-)
  # filter_request_headers = list(Authorization = "My bearer token is safe")
))
