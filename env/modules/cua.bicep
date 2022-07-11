param cuaGuid string

resource customerAttribution 'Microsoft.Resources/deployments@2020-06-01' = {
  name: 'pid-${cuaGuid}'
  properties: {
    mode: 'Incremental'
    template: {
      '$schema': 'https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      resources: []
    }
  }
}
