pipeline {
  environment {
    registry = "jgraziano/lupitaap"
    registryCredential = 'dockerhub'
  }
  
  agent any
  stages {
    
    stage('build image') {
      steps {
        echo 'prueba de echo, lupitamanda'
        script {
          docker.build registry + ":$BUILD_NUMBER"
        }  
      }
    }
        stage('Deploy Image') {
        steps{
          script {
             docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
      }
    }
  }
}
    
  }
}
