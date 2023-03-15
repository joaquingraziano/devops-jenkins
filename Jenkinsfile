pipeline {
  environment {
    registry = "jgraziano/lupitaap"
    registryCredential = 'dockerhub'
  }
  
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/joaquingraziano/devops-jenkins.git'
      }
    stage('build image') {
      steps {
        echo 'prueba de echo, lupitamanda'
        script {
          docker.build registry + ":$BUILD_NUMBER"
        }  
      }
    }
    
  }
}
