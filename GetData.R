library("Rfacebook")
library("keyring")
library("dplyr")
library("lubridate")

# ask for API token
key_set(service = 'MyToken')

# create API cal URL using token and GET API call reults
url.data <- httr::GET(paste0("https://graph.facebook.com/718783211555593/insights?pretty=0&since=1582922000&metric=page_impressions&access_token=", key_get('MyToken')))

#extract content of API call
content <- rjson::fromJSON(rawToChar(url.data$content))

values <- content$data[[1]]$values %>%
  bind_rows %>%
  mutate(date = as_date(end_time))
