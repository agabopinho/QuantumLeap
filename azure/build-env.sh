group="quantumleap"
acr="quantumleap"
logsworkspace="quantumleap"
appenv="quantumleap"

echo "creating resource group"
az group create -n $group -l brazilsouth 

echo "creating acr"
az acr create -n $acr -g $group --sku Basic
az acr identity assign -n $acr -g $group --identities [system]

echo "creating log-analytics workspace"
az monitor log-analytics workspace create -n $logsworkspace -g $group 

echo "creating containerapp env"
az containerapp env create -n $appenv -g $group \
    --logs-workspace-id $(az monitor log-analytics workspace show -n $logsworkspace -g $group --query customerId | tr -d \"-) \
    --logs-workspace-key $(az monitor log-analytics workspace get-shared-keys -n $logsworkspace -g $group --query primarySharedKey | tr -d \") \
    -l brazilsouth