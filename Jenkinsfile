pipeline {
  environment {
    registry = "jgraziano/webdemo-dev"
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
/*
    //Inicia Stage Push
    stage('Push Image') {
      steps {
        echo 'Haciendo un Push a la registry de docker'
        script {
          docker.withRegistry('https://registry.hub.docker.com/', 'dockerhub_id') {
          docker.image("jgraziano/webdemo-dev:v1.$BUILD_NUMBER").push()
          }
        }
      }
    }

    stage('Update Deployment') {
      steps {
        script {
                    // borra el directorio y lo vuelve a clonar
                    sh "rm argocd -R || true"
                    sh "git clone https://github.com/joaquingraziano/argocd.git"
                
                dir('argocd/') {
                    //modifica version en manifiesto
                    sh 'chmod u+w dev/app/deployment.yml'
                    def deploymentFile = 'dev/app/deployment.yml'
                    def deploymentContent = readFile(deploymentFile)
                    def updatedDeploymentContent = deploymentContent.replaceAll('jgraziano/webdemo-dev:v1.*', "jgraziano/webdemo-dev:v1.${"$BUILD_NUMBER"}")
                    writeFile file: deploymentFile, text: updatedDeploymentContent
                    // Pushea los cambios al repositorio
                    withCredentials([gitUsernamePassword(credentialsId: 'github_id', gitToolName: 'git-tool')]){
                        sh 'git config --global user.email "jgraziano@example.com"'
                        sh 'git config --global user.name "jgraziano"'
                        sh 'git status'
                        sh 'git add -v dev/app/deployment.yml'
                        sh 'git commit -a -m "Update deployment"'
                        sh 'git push origin master'
                    }
                }
            }
        }
    //Finaliza Stage Push
  }*/

// Agregado Stage Snyk Scan
    stage('Snyk Scan') {
      steps {
        withCredentials([string(credentialsId: 'snyktoken', variable: 'SNYK_TOKEN')]) {
        sh 'snyk auth $SNYK_TOKEN'
        sh "snyk container test $registry:v1.$BUILD_NUMBER --json --severity-threshold=high > snyk_report.json || true"
        }
      }
    }
        // Agregado Stage Snyk Issue
    stage('Snyk Issue') {
      steps {
        script {
          def report = readJSON file: 'snyk_report.json'
          report.vulnerabilities.each { vuln ->
            def issueTitle = "Snyk Issue: ${vuln.id}"
            def issueDescription = "Vulnerabilidad encontrada: ${vuln.id}"
            withCredentials([string(credentialsId: 'token-github', variable: 'GITHUB_TOKEN')]) {
              sh "curl -X POST -H 'Content-Type: application/json' -H 'Authorization: token ${GITHUB_TOKEN}' -d '{\"title\":\"${issueTitle}\", \"body\":\"${issueDescription}\", \"labels\":[\"Seguridad\"]}' https://api.github.com/repos/joaquingraziano/devops-jenkins/issues"
            }
          }
        }
      }
    }
    




  //fin de stages
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
