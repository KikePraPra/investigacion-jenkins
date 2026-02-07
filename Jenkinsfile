pipeline {
    agent any

    environment {
        IMAGE_NAME = "grocy-app-image"
        CONTAINER_NAME = "grocy-app"
        HOST_PORT = "8081"  // Puerto en tu EC2, puede ser cualquiera
        CONTAINER_PORT = "80"  // Puerto dentro del contenedor, Nginx default
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
                // Validamos que estamos en el directorio correcto
                sh "ls -la" 
                // Construimos la imagen
                sh "docker build -t ${IMAGE_NAME} -f Dockerfile ."
            }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Detener y eliminar contenedor previo si existe
                    sh "docker rm -f ${CONTAINER_NAME} || true"

                    // Levantar contenedor mapeando puerto de host al contenedor
                    sh "docker run -d --name ${CONTAINER_NAME} -p ${HOST_PORT}:${CONTAINER_PORT} --restart unless-stopped ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        success {
            echo "✅ ¡Aplicación desplegada exitosamente! Accede en http://<IP_de_tu_EC2>:${HOST_PORT}"
        }
        failure {
            sh "docker logs ${CONTAINER_NAME} || true"
            echo "❌ Hubo un error durante el deploy."
        }
    }
}
