param iotcName string
param iotcDisplayName string
param subdomain string
param location string
param sku string

resource iotc 'Microsoft.IoTCentral/iotApps@2021-06-01' = {
  name: iotcName
  location: location
  properties: {
    displayName: iotcDisplayName
    subdomain: subdomain
  }
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: sku
  }
}
