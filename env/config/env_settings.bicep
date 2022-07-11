param environment string
param region string

var environmentSettings = {
  sd: {
    name: 'Sandbox'
    storage: {
      sku: 'Standard_LRS'
    }
    iotc: {
      sku: 'ST0'
      displayName: 'Emblazen ${iotcRegionDisplay[region]} [SANDBOX]'
    }
    acr: {
      sku: 'Basic'
    }
    eventHub: {
      capacity: 1
      skuTier: 'Standard'
      skuName: 'Standard'
    }
    keyVault: {
      sku: {
        family: 'A'
        name: 'standard'
      }
    }
  }
  dv: {
    name: 'Develop'
    storage: {
      sku: 'Standard_LRS'
    }
    iotc: {
      sku: 'ST0'
      displayName: 'Emblazen ${iotcRegionDisplay[region]} [DEV]'
    }
    acr: {
      sku: 'Basic'
    }
    eventHub: {
      capacity: 1
      skuTier: 'Standard'
      skuName: 'Standard'
    }
    keyVault: {
      sku: {
        family: 'A'
        name: 'standard'
      }
    }
  }
  ts: {
    name: 'Test'
    storage: {
      sku: 'Standard_LRS'
    }
    iotc: {
      sku: 'ST0'
      displayName: 'Emblazen ${iotcRegionDisplay[region]} [TEST]'
    }
    acr: {
      sku: 'Basic'
    }
    eventHub: {
      capacity: 1
      skuTier: 'Standard'
      skuName: 'Standard'
    }
    keyVault: {
      sku: {
        family: 'A'
        name: 'standard'
      }
    }
  }
  sg: {
    name: 'Staging'
    storage: {
      sku: 'Standard_LRS'
    }
    iotc: {
      sku: 'ST0'
      displayName: 'Emblazen ${iotcRegionDisplay[region]} [STAGING]'
    }
    acr: {
      sku: 'Basic'
    }
    eventHub: {
      capacity: 1
      skuTier: 'Standard'
      skuName: 'Standard'
    }
    keyVault: {
      sku: {
        family: 'A'
        name: 'standard'
      }
    }
  }
  pd: {
    name: 'Production'
    storage: {
      sku: 'Standard_LRS'
    }
    iotc: {
      sku: 'ST2'
      displayName: 'Emblazen ${iotcRegionDisplay[region]} [PROD]'
    }
    acr: {
      sku: 'Basic'
    }
    eventHub: {
      capacity: 3
      skuTier: 'Standard'
      skuName: 'Standard'
    }
    keyVault: {
      sku: {
        family: 'A'
        name: 'standard'
      }
    }
  }
}

var iotcRegionDisplay = {
  AUS: 'Australia'
  USA: 'USA'
  UK: 'UK'
  JAP: 'Japan'
  ASA: 'Asia'
}

output settings object = environmentSettings[environment]

