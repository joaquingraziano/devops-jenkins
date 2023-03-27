pipeline {
  environment {
    registry = "jgraziano/lupitaap"
    registryCredential = 'dockerhub_id'
    dockerImage = ''
  }
  
  agent any
  stages {

    //Inicia Stage Build
    stage('build Image') {
      steps {
        sh 'ls'
        echo 'Haciendo el Build de la app'
        script {
          docker.build registry + ":v1.$BUILD_NUMBER"
        }  
      }
    }
    //Finaliza Stage Build

    //Inicia Stage Push
    stage('Push Image') {
      steps {
        echo 'Haciendo un Push a la registry de docker'
        script {
          docker.withRegistry('https://registry.hub.docker.com/', 'dockerhub_id') {
          docker.image("jgraziano/lupitaap:v1.$BUILD_NUMBER").push()
          }
        }
      }
    }
    //Finaliza Stage Push
    stage('Cleaning Image') {
      steps{
      sh "docker rmi $registry:v1.$BUILD_NUMBER"
      sh "docker rmi registry.hub.docker.com/$registry:v1.$BUILD_NUMBER"
      }
    }
  }
}