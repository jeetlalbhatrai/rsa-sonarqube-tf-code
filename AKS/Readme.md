to login to cluster....
az aks get-credentials --resource-group rsa-aks --name rsa-aks-cluster --overwrite-existing

Put taints on nodes...
kubectl taint nodes aks-frontend-25355228-vmss000000 role=frontend:NoSchedule
kubectl taint nodes aks-backend-30266339-vmss000000 role=backend:NoSchedule


Command to install applications....
helm upgrade --install -name frontend . -f ../../value-store/frontend.yaml --namespace frontend --create-namespace
helm upgrade --install -name backend . -f ../../value-store/backend.yaml --namespace backend --create-namespace

To forward port-->
kubectl port-forward pod/frontend-6c5b5b959f-2lhlr -n frontend 7234:3000


-->
AKS created by Terraform.
SQL Server/ SQL database (key vault we can use to security)- Manually.




dbadmin
db@12345


dbname- rsadb


connection_string = "DRIVER={ODBC Driver 17 for SQL Server};SERVER=rsasql.database.windows.net;DATABASE=rsadb;UID=dbadmin;PWD=db@12345"


rsasql.database.windows.net