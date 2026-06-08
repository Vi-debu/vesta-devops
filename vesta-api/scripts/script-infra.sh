

WEB_APP_NAME="webapp-vesta"      
RESOURCE_GROUP="rg-vesta-devops-2026"
LOCATION="brazilsouth"
APP_SERVICE_PLAN="plan-vesta-backend"

az group create --name $RESOURCE_GROUP --location $LOCATION

az appservice plan create \
    --name $APP_SERVICE_PLAN \
    --resource-group $RESOURCE_GROUP \
    --sku B1 \
    --is-linux \
    --location $LOCATION

az webapp create \
    --resource-group $RESOURCE_GROUP \
    --plan $APP_SERVICE_PLAN \
    --name $WEB_APP_NAME \
    --runtime "JAVA|17-java17"

echo "URL: https://$WEB_APP_NAME.azurewebsites.net"