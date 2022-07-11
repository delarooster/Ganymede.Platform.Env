@description('A 2 letter designator for environment')
param env string

@description('BCIT Application Id')
param appId string
param region string
param env_descriptor string

@description('A 3-4 letter customer affix')
param clientAffix string
@description('A 3-9 letter project affix')
param projectAffix string
@description('Location of regional deployment environment, e.g. eastus, centralus')
param location string
@description('Customer usage attribution GUID')
param cuaGuid string
@description('Set to true when wanting a fresh deploy of the key vault')
param doDeploySharedKeyVault bool = true
@description('Set to true when the project affix is generic ie Remote Monitoring (rmtmon), traXsmart (txs), etc ')
param qualifyProjectAffix bool = false
@description('The environment index - 0 is the default for the initial environment')
@minValue(0)
@maxValue(9)
param envIndex int = 0

var salt = substring(uniqueString(resourceGroup().id), 0, 4)
var resourceNames = {
  storage: toLower('sanasaapp${appId}${envDescriptor[env_descriptor]}${resourceGroupSuffix[location]}${salt}')
  keyVault: toLower('KvAsgApp${appId}${envDescriptor[env_descriptor]}${salt}')
  iotc: 'iotcapp${appId}${envDescriptor[env_descriptor]}${resourceGroupSuffix[location]}${salt}'
  acr: toLower('crnasaapp${appId}${envDescriptor[env_descriptor]}${resourceGroupSuffix[location]}${salt}')
  eventHubNs: 'EHNS-NASA-APP${appId}-${envDescriptor[env_descriptor]}-${resourceGroupSuffix[location]}-${salt}'
}

module cua 'modules/cua.bicep' = {
  name: 'customerUsageAttribution'
  params: {
    cuaGuid: cuaGuid
  }
}
module environment 'config/env_settings.bicep' = {
  name: 'environmentSettings'
  params: {
    environment: toLower(env)
    region: region
  }
}
module iotcentral 'modules/iotc.bicep' = {
  name: toLower(resourceNames.iotc)
  params: {
    location: location
    sku: environment.outputs.settings.iotc.sku
    iotcDisplayName: environment.outputs.settings.iotc.displayName
    subdomain: toLower(resourceNames.iotc)
    iotcName: toLower(resourceNames.iotc)
  }
}

module containerRegistry 'modules/acr.bicep' = {
  name: resourceNames.acr
  params: {
    location: location
    sku: environment.outputs.settings.acr.sku
    acrName: resourceNames.acr
  }
}
module eventHub 'modules/eventhub.bicep' = {
  name: resourceNames.eventHubNs
  params: {
    location: location
    capacity: environment.outputs.settings.eventHub.capacity
    skuTier: environment.outputs.settings.eventHub.skuTier
    skuName: environment.outputs.settings.eventHub.skuName
    eventHubName: resourceNames.eventHubNs
  }
}

module keyVault 'modules/keyVault.bicep' = {
  name: resourceNames.keyVault
  params: {
    location: location
    sku: environment.outputs.settings.keyVault.sku
    keyVaultName: resourceNames.keyVault
    doDeploySharedKeyVault: doDeploySharedKeyVault
    storageName: resourceNames.storage
  }
}

module storage 'modules/storage.bicep' = {
  name: resourceNames.storage
  params: {
    location: location
    storageSkuName: environment.outputs.settings.storage.sku
    storageName: resourceNames.keyVault
  }
}

output keyVaultName string = keyVault.name
output iotcName string = iotcentral.name
output eventHubNamespace string = eventHub.name

var envDescriptor = {
  non_production: 'N'
  production: 'P'
  infrastructure: 'I'
  training: 'T'
}

var resourceGroupSuffix = {
  australiaeast: 'AE01'
  australiasoutheast: 'ASE01'
  brazilsouth: 'BS01'
  centralindia: 'CI01'
  centralus: 'CUS01'
  eastasia: 'EA01'
  eastus: 'EUS01'
  eastus2: 'EUS02'
  japanwest: 'JW01'
  japaneast: 'JE01'
  northcentralus: 'NCUS01'
  northeurope: 'NEU01'
  southcentralus: 'SCUS01'
  southeastasia: 'SEA01'
  southindia: 'SI01'
  westcentralus: 'WCUS01'
  westeurope: 'WEU01'
  westindia: 'WI01'
  westus: 'WUS01'
  westus2: 'WUS02'
  uksouth: 'UKS01'
}

