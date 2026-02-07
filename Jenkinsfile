pipeline {
    agent any

    environment {
        IMAGE_NAME = "container-v1"
        CONTAINER_NAME = "grocy-app"
        PORT = "3000"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/KikePraPra/investigacion-jenkins.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construye la imagen
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Si existe un contenedor previo, lo detenemos y eliminamos
                    sh "docker rm -f ${CONTAINER_NAME} || true"

                    // Lanza el contenedor en el puerto especificado
                    sh "docker run -d --name ${CONTAINER_NAME} -p ${PORT}:${PORT} --restart unless-stopped ${IMAGE_NAME}"
                }
            }
        }
    }
}
