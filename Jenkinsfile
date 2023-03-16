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
    stage('Push Docker Image') {
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com/', 'dockerhub_id') {
          docker.push("jgraziano/lupitaap:$BUILD_NUMBER")
          }
        }
      }
    }
  }

}