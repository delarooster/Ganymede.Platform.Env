param eventHubName string
param location string
param capacity int
param skuName string
param skuTier string

resource eventHubNamespace 'Microsoft.EventHub/namespaces@2021-11-01' = {
  name: eventHubName
  location: location
  sku: {
    name: skuName
    tier: skuTier
    capacity: capacity
  }
  properties: {
    disableLocalAuth: false
    zoneRedundant: true
    isAutoInflateEnabled: false
    maximumThroughputUnits: 0
    kafkaEnabled: true
  }
}

resource emblazenAuthRules 'Microsoft.EventHub/namespaces/AuthorizationRules@2021-11-01' = {
  parent: eventHubNamespace
  name: 'emblazenListen'
  properties: {
    rights: [
      'Listen'
    ]
  }
}
resource defaultNetworkRules 'Microsoft.EventHub/namespaces/networkRuleSets@2021-11-01' = {
  parent: eventHubNamespace
  name: 'default'
  properties: {
    publicNetworkAccess: 'Enabled'
    defaultAction: 'Allow'
    virtualNetworkRules: []
    ipRules: []
  }
}

// Ganymede event hub
resource ganymedeEventHub 'Microsoft.EventHub/namespaces/eventhubs@2021-11-01' = {
  parent: eventHubNamespace
  name: 'ganymede'
  properties: {
    messageRetentionInDays: 1
    partitionCount: 2
    status: 'Active'
  }
}

resource iotcAuthRules 'Microsoft.EventHub/namespaces/eventhubs/authorizationRules@2021-11-01' = {
  parent: ganymedeEventHub
  name: 'iotcSend'
  properties: {
    rights: [
      'Send'
    ]
  }
}

resource emblazenConsumerGroup 'Microsoft.EventHub/namespaces/eventhubs/consumergroups@2021-11-01' = {
  parent: ganymedeEventHub
  name: 'emblazen'
  properties: {}
}

// Nauticon event hub
resource nauticonEventHub 'Microsoft.EventHub/namespaces/eventhubs@2021-11-01' = {
  parent: eventHubNamespace
  name: 'nauticon'
  properties: {
    messageRetentionInDays: 1
    partitionCount: 2
    status: 'Active'
  }
}

resource nauticonConsumerGroup 'Microsoft.EventHub/namespaces/eventhubs/consumergroups@2021-11-01' = {
  parent: nauticonEventHub
  name: 'emblazen'
  properties: {}
}

resource deviceServiceAuthRules 'Microsoft.EventHub/namespaces/eventhubs/authorizationRules@2021-11-01' = {
  parent: nauticonEventHub
  name: 'deviceServiceSend'
  properties: {
    rights: [
      'Send'
    ]
  }
}
