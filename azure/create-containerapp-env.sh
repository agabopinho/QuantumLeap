group="quantumleap"
name="quantumleap"
logs_workspace="quantumleap"

az containerapp env create -n $name -g $group \
    --logs-workspace-id $(az monitor log-analytics workspace show -n $logs_workspace -g $group --query customerId | tr -d \"-) \
    --logs-workspace-key $(az monitor log-analytics workspace get-shared-keys -n $logs_workspace -g $group --query primarySharedKey | tr -d \") \
    --location brazilsouth