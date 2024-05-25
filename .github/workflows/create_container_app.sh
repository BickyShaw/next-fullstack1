templateFile="./bicep/main.bicep"
uuid="$(cat /proc/sys/kernel/random/uuid)"
parameterFile="./bicep/main.json"

az provider register --namespace Microsoft.App
az deployment group create --resource-group demo-rg --template-file $templateFile --parameters $parameterFile




