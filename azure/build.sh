group="quantumleap"
acr="quantumleap"
log="quantumleap"
envname="quantumleap"

az group create -n $group -l brazilsouth 
az acr create -n $acr -g $group --sku Basic
az acr identity assign -n $acr -g $group --identities [system]
az monitor log-analytics workspace create -n $log -g $group 
az containerapp env create -n $envname -g $group \
    --logs-workspace-id $(az monitor log-analytics workspace show -n $log -g $group --query customerId | tr -d \"-) \
    --logs-workspace-key $(az monitor log-analytics workspace get-shared-keys -n $log -g $group --query primarySharedKey | tr -d \") \
    -l brazilsouth