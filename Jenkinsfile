pipeline {
  environment {
    registry = "jgraziano/lupitaap"
    registryCredential = 'dockerhub_id'
    dockerImage = ''
  }
  
  agent any
  stages {
    //Inicia Stage Build
    stage('build') {
      steps {
        echo 'Haciendo el Build de la app'
        script {
          docker.build registry + ":$BUILD_NUMBER"
        }  
      }
    }
    //Finaliza Stage Build

    //Inicia Stage Deploy
    stage('deploy') {
      steps {
        echo 'Haciendo un Push a la registry de docker'
        script {
          docker.withRegistry('https://registry.hub.docker.com/', 'dockerhub_id') {
          docker.image("jgraziano/lupitaap:$BUILD_NUMBER").push()
          }
        }
      }
    }
    //Finaliza Stage Deploy

  }
}