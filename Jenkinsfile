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

    stage('Update Deployment') {
      steps {
        script {
                    // borra el directorio y lo vuelve a clonar
                    sh "rm argocd -R"
                    sh "git clone https://github.com/joaquingraziano/argocd.git"
                
                dir('argocd/') {
                    //modifica version en manifiesto
                    sh 'chmod u+w Dev/app/deployment.yml'
                    def deploymentFile = 'Dev/app/deployment.yml'
                    def deploymentContent = readFile(deploymentFile)
                    def updatedDeploymentContent = deploymentContent.replaceAll('jgraziano/lupitaap:v1.*', "jgraziano/lupitaap:v1.${"$BUILD_NUMBER"}")
                    writeFile file: deploymentFile, text: updatedDeploymentContent
                    sh 'cat Dev/deployment.yml'
                                     
                    // Pushea los cambios al repositorio
                    withCredentials([gitUsernamePassword(credentialsId: 'github_id', gitToolName: 'git-tool')]){
                        sh 'git config --global user.email "jgraziano@example.com"'
                        sh 'git config --global user.name "jgraziano"'
                        sh 'git status'
                        sh 'git add -v Dev/app/deployment.yml'
                        sh 'git commit -v -m "Update deployment"'
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
          sh "docker rmi $registry:v1.$BUILD_NUMBER"
          sh "docker rmi registry.hub.docker.com/$registry:v1.$BUILD_NUMBER"
      }
    }
  }
