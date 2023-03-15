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
  /* Finally, we'll push the image with two tags:
  * First, the incremental build number from Jenkins
  * Second, the 'latest' tag.
  * Pushing multiple tags is cheap, as all the layers are reused. */
  docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
    app.push("${env.BUILD_NUMBER}")
    app.push("latest")
  }
}
    
  }
}
