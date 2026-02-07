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
                sh 'git log -1 --oneline'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Verificamos en el log de Jenkins si el archivo es el nuevo
                    sh "cat index.html"
                    
                    // --no-cache es vital para que no use el index.html viejo
                    sh "docker build --no-cache -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Detener y borrar con fuerza el contenedor anterior
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                    
                    // Limpiar imágenes huérfanas para no llenar el disco de la EC2
                    sh "docker image prune -f"
                    
                    // Lanzar el nuevo contenedor
                    sh "docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                }
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