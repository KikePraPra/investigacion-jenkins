pipeline {
    agent any

    environment {
        IMAGE_NAME = "grocy-app-image"
        CONTAINER_NAME = "grocy-app"
    }

    stages {
        stage('Sincronizacion') {
            steps {
                cleanWs()
                checkout scm
            }
        }

        stage('Build Docker') {
            steps {
                script {
                    // El punto final es vital, indica el contexto actual


                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                    sh "docker run -d --name ${CONTAINER_NAME} -p 8081:80 ${IMAGE_NAME}:latest"
                }
            }
        }
    }
}