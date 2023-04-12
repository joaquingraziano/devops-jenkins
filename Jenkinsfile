pipeline {
  environment {
    registry = "jgraziano/webdemo"
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

    stage('Update Deployment') {
      steps {
        script {
                    // borra el directorio y lo vuelve a clonar
                    sh "rm argocd -R"
                    sh "git clone https://github.com/joaquingraziano/argocd.git"
                
                dir('argocd/') {
                    //modifica version en manifiesto
                    sh 'chmod u+w dev/app/deployment.yml'
                    def deploymentFile = 'dev/app/deployment.yml'
                    def deploymentContent = readFile(deploymentFile)
                    def updatedDeploymentContent = deploymentContent.replaceAll('jgraziano/webdemo:P1.*', "jgraziano/webdemo:P1.${"$BUILD_NUMBER"}")
                    writeFile file: deploymentFile, text: updatedDeploymentContent
                    // Pushea los cambios al repositorio
                    withCredentials([gitUsernamePassword(credentialsId: 'github_id', gitToolName: 'git-tool')]){
                        sh 'git config --global user.email "jgraziano@example.com"'
                        sh 'git config --global user.name "jgraziano"'
                        sh 'git status'
                        sh 'git add -v dev/app/deployment.yml'
                        sh 'git commit -a -m "Update deployment"'
                        sh 'git push origin main'
                    }
                }
            }
        }
    //Finaliza Stage Push
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
