pipeline {
  environment {
    registry = "jgraziano/webdemo"
    registryCredential = 'dockerhub_id'
    dockerImage = ''
  }

  arameters {
    string(name: 'WORKPLACE', description: 'workplace environment')
  }
  
  agent any
  stages {

    //Inicia Stage Build
    stage('build Image') {
      steps {
        sh 'ls'
        echo 'Haciendo el Build de la app'
        script {
          docker.build registry + ":P1.$BUILD_NUMBER"
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
          docker.image("jgraziano/webdemo:P1.$BUILD_NUMBER").push()
          }
        }
      }
    }
    //Finaliza Stage Push
    //Inicia deploy manifiesto
    stage('Update Deployment') {

      steps {
        script {
          // Clone GitHub repo
          git branch: 'master', url: 'https://github.com/Jiolloker/manifest-eks'  
          // Cambia el nombre del repo
          // Update Deployment
          sh "chmod u+w ${params.WORKPLACE}/app/deployment.yml"
          def deploymentFile = "${params.WORKPLACE}/app/deployment.yml"
          def deploymentContent = readFile(deploymentFile)
          def updatedDeploymentContent = deploymentContent.replaceAll('fcambres/webdemo:v1.*', "fcambres/webdemo:v1.${"$BUILD_NUMBER"}")
          writeFile file: deploymentFile, text: updatedDeploymentContent
          sh "cat ${params.WORKPLACE}/app/deployment.yml"
          // Push changes to GitHub
          withCredentials([gitUsernamePassword(credentialsId: 'github_id', gitToolName: 'git-tool')]){
            sh """
            git config --global user.email "jiolloker@example.com"
            git config --global user.name "jiolloker"
            git status
            git add -v "${params.WORKPLACE}/app/deployment.yml"
            git commit -v -m 'Update deployment of ${params.WORKPLACE} with build number v1.$BUILD_NUMBER'
            git push origin master
            """
          }
        }
      }



    //Finaliza deploy manifiesto
  }
    }     
    post {
      always {
        //limpia imagenes
          echo 'Se limpian las imagenes pusheadas'
          sh "docker rmi $registry:P1.$BUILD_NUMBER"
          sh "docker rmi registry.hub.docker.com/$registry:P1.$BUILD_NUMBER"
      }
    }
  }
