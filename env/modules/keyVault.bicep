param doDeploySharedKeyVault bool
param keyVaultName string
param location string
param sku object
param storageName string

resource sharedKeyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = if (doDeploySharedKeyVault) {
  name: keyVaultName
  location: location
  properties: {
    accessPolicies: [
    {
      objectId: 'a5280b34-0b66-4a5c-8bbf-bc4c14694b1f' //Austin DeLaRosa
      permissions: {
        secrets: [
          'get'
          'list'
          'set'
        ]
      }
      tenantId: subscription().tenantId
    }
    {
      objectId: 'cfcaecd2-1ddf-41b2-8663-a867749458a2' //MESH service principal
      permissions: {
        secrets: [
          'get'
          'list'
          'set'
        ]
      }
      tenantId: subscription().tenantId
    }
    ]
    sku: {
      family: sku.family
      name: sku.name
    }
    tenantId: subscription().tenantId
  }
}
