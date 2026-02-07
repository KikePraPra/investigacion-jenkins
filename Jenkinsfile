pipeline {
    agent any

    environment {
        IMAGE_NAME = "grocy-app-image:latest"
        CONTAINER_NAME = "grocy-app"
        HOST_PORT = "8081"
        CONTAINER_PORT = "80"
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
                    // Usamos el archivo en minúscula y sin caché para asegurar archivos nuevos
                    sh "docker build --no-cache -t ${IMAGE_NAME} -f dockerfile ."
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Limpieza total antes de arrancar
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                    sh "docker run -d --name ${CONTAINER_NAME} -p ${HOST_PORT}:${CONTAINER_PORT} ${IMAGE_NAME}"
                }
            }
        }
    }
}