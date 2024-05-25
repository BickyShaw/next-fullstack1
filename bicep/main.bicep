param isInitialDeployment bool = false
param containerImage string = 'myimage:latest'
param location string

//resource existingContainerApp 'Microsoft.Web/containerApps@2021-03-01' existing = {
//  name: 'myContainerApp'
//}


resource containerApp 'Microsoft.Web/containerApps@2021-03-01' = if (!isInitialDeployment || (isInitialDeployment && containerImage != '')) {
  name: 'myContainerApp'
  location: location
  properties: {
    kubeEnvironmentId: resourceId('Microsoft.Web/kubeEnvironments', 'myKubeEnv')
    configuration: {
      ingress: {
        external: true
        targetPort: 80
      }
    }
    template: {
      containers: [
        {
          name: 'myContainer'
          image: containerImage
//          image: isInitialDeployment ? containerImage : existingContainerApp.properties.template.containers[0].image
          resources: {
            cpu: 1
            memory: '1.0Gi'
          }
        }
      ]
      scale: {
        minReplicas: 1
        maxReplicas: 5
      }
    }
  }
}
