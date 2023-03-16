pipeline {
  environment {
    registry = "jgraziano/lupitaap"
    registryCredential = 'dockerhub'
    dockerImage = ''
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
             withDockerRegistry([ credentialsId: "dockerhub", url: "https://registry.hub.docker.com/" ]) {
                docker.image("jgraziano/lupitaap:$BUILD_NUMBER").push()
      }
    }
  }
}
    
  }
}
