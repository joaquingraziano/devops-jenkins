pipeline {
  environment {
    registry = "jgraziano/lupitaap"
    registryCredential = 'dockerhub'
  }
  
  agent any
  stages {
    stage('build') {
      steps {
        echo 'prueba de echo, lupitamanda'
        script {
          docker.build registry + ":$BUILD_NUMBER"
        }
        
      }
    }

  }
}
