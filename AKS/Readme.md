
Command to install applications....
helm upgrade --install -name frontend . -f ../../value-store/frontend.yaml -n app
helm upgrade --install -name backend . -f ../../value-store/backend.yaml -n app

-->
AKS created by Terraform.
SQL Server/ SQL database (key vault we can use to security)- Manually.




dbadmin
db@12345


dbname- rsadb


connection_string = "DRIVER={ODBC Driver 17 for SQL Server};SERVER=rsasql.database.windows.net;DATABASE=rsadb;UID=dbadmin;PWD=db@12345"


rsasql.database.windows.net