pipeline {
  environment {
    registry = "jgraziano/lupitaap"
    registryCredential = 'dockerhub_id'
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
      stage('Push image') {
        withDockerRegistry([ credentialsId: "dockerhub_id", url: "https://registry.hub.docker.com/" ]) {
        bat "docker push jgraziano/lupitaap:$BUILD_NUMBER"
        }
    
  }
}

}