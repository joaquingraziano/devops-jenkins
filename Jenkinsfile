pipeline {
  environment {
    registry = "jgraziano/lupitaap"
    registryCredential = 'dockerhub_id'
    dockerImage = ''
  }
  
  agent any
  stages {
    //inicia prueba
    stage('Clone GitHub repo') {
            steps {
                git branch: 'main', url: 'https://github.com/joaquingraziano/argocd.git'
            }
        }
        stage('Get latest image version') {
            steps {
                script {
                    def imageName = 'jgraziano/lupitaap'
                    def version = sh(script: "curl -s https://registry.hub.docker.com/v1/repositories/${imageName}/tags | jq -r '.[].name' | sort -V | tail -n1", returnStdout: true).trim()
                    env.VERSION = version
                }
            }
        }
        stage('Update Deployment') {
            steps {
                script {
                    def deploymentFile = 'manifiestos-eks/dev/deployment.yml'
                    def deploymentContent = readFile(deploymentFile)
                    def updatedDeploymentContent = deploymentContent.replaceAll('jgraziano/lupitaap:.*', "jgraziano/lupitaap:${env.VERSION}")
                    writeFile file: deploymentFile, text: updatedDeploymentContent
                }
            }
        }
        stage('Push changes to GitHub') {
            steps {
                gitPush(branch: 'main', credentialsId: 'joaquingraziano', message: 'Actualizar Deployment a la última versión de la imagen', url: 'https://github.com/joaquingraziano/argocd.git')
            }
        }
    }
}





    //finaliza prueba
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
/*falta probar
   stage('Test') {
          steps {
                // Ejecuta tus pruebas en la imagen Docker construida anteriormente
                sh 'docker run backend:v1 npm test'
            }
          }
        
  */
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
  