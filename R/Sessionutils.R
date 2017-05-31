library(httr)
library(jsonlite)

hostname <- 'xxx'
casusr <- 'xxx'
viyauser <- 'xxx'
pwd <- 'xxx'




POST(paste(hostname, 'cas', 'sessions',sep='/'), authenticate(viyauser,pwd))
