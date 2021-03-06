library(httr)
library(jsonlite)

hostname <- 'xxx:8777'
server <- 'cas-shared-default'              # CAS server name
uri.token <- 'SASLogon/oath/token'
uri.casManagement <- 'casManagement/servers'
uri.casProxy <- 'casProxy/servers'
user <- 'xxx'
pass <- 'xxx'

# Create new session
sess <- content(POST(paste(hostname, 'cas', 'sessions', sep='/'), authenticate(user,pass)))$session


# Upload file
filepath <- 'C:\\Users\\sacrok\\OneDrive\\SAS\\JupyterDemos_JW\\data\\'
filename <- 'CLOUD-PRICING'
params <- paste('{"casout": {"caslib": "casuser", "name":"', filename,'"}, "importOptions": {"fileType": "CSV"} }',sep='')
print(params)

PUT(paste(hostname, 'cas', 'sessions', sess, 'actions', 'table.upload', sep='/'),
         body=upload_file(paste(filepath,filename,'.csv',sep='')),
         authenticate(user,pass),
         add_headers('JSON-Parameters'=params, 'Content-Type'='binary/octet-stream')
)

t.info <- POST(paste(hostname, 'cas', 'sessions', session, 'actions', action, sep='/'), 
          body=params,
          authenticate(user,pass),
          content_type('application/json'),
          accept_json(),
          encode='json',
          verbose())


# Run Regression
reg.results <- POST(paste(hostname, 'cas', 'sessions', sess, 'actions', 'regression.glm', sep='/'), 
          body=list(table='CLOUD-PRICING',model=list(depvar='Price',effects='mem')),
          authenticate(user,pass),
          content_type('application/json'),
          accept_json(),
          encode='json'
          #,verbose()
)



write(x = as.character(reg.results),file='reg_results.json')
