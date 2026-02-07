pipeline {
    agent any
    environment {
        IMAGE_NAME = "grocy-app-image:latest"
        CONTAINER_NAME = "grocy-app"
        // Esta es la ruta donde la EC2 ve los archivos de Jenkins
        EC2_WORKSPACE = "/var/lib/docker/volumes/jenkins_home/_data/workspace/prueba2"
    }
    stages {
        stage('Clean & Checkout') {
            steps {
                cleanWs()
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Obligamos a Docker a buscar los archivos en la ruta de la EC2
                    sh "docker build --no-cache -t ${IMAGE_NAME} -f ${EC2_WORKSPACE}/Dockerfile ${EC2_WORKSPACE}"
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                    sh "docker run -d --name ${CONTAINER_NAME} -p 8081:80 ${IMAGE_NAME}"
                }
            }
        }
    }
}