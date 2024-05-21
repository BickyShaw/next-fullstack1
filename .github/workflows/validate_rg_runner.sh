templateFile="./bicep/rg.bicep"
uuid="$(cat /proc/sys/kernel/random/uuid)"
location="centralus"
rgName=$1

parameterFile="./bicep/rg_parameters_dev.json"

agencyCode=$1

az deployment sub validate --name $uuid --location $location --template-file $templateFile \
    --parameters @$parameterFile \
    --parameters agencyCode=$agencyCode

az deployment sub what-if --name $uuid --location $location --template-file $templateFile \
    --parameters @$parameterFile \
    --parameters agencyCode=$agencyCode



