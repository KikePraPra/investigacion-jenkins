pipeline {
    agent any

    environment {
        IMAGE_NAME = "grocy-app-image:latest"
        CONTAINER_NAME = "grocy-app"
        HOST_PORT = "8081"
        CONTAINER_PORT = "80"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                sh 'git log -1 --oneline'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                docker build -t ${IMAGE_NAME} .
                """
            }
        }

        stage('Deploy Container') {
            steps {
                sh """
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
                docker run -d \
                  -p ${HOST_PORT}:${CONTAINER_PORT} \
                  --name ${CONTAINER_NAME} \
                  ${IMAGE_NAME}
                """
            }
        }
    }

    post {
        success {
            echo "✅ Deploy exitoso en http://13.218.25.210:8081"
        }
        failure {
            echo "❌ Falló el pipeline"
        }
    }
}
