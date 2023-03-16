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
       stage('Deploy Image') {
        steps{
          script {
             withDockerRegistry([ credentialsId: "dockerhub_id", url: "https://hub.docker.com/r/jgraziano/lupitaap" ]) {
                dockerImage.push()
      }
    }
  }
}
    
  }
}
