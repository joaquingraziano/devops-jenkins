pipeline {
  environment {
    registry = "jgraziano/test"
    registryCredential = 'dockerhub_id'
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
