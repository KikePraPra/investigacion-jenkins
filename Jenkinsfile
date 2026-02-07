pipeline {
    agent any

    options {
        // Esto limpia el workspace antes de que comience el build
        skipDefaultCheckout(false)
    }
    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs() // Borra todo lo viejo antes de bajar lo nuevo
            }
        }
        stage('Checkout') {
            steps {
                checkout scm // Baja el código fresco de GitHub
            }
        }
        // ... tus otros stages (Build y Deploy)
    }

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
               script {
            // 1. Ver qué archivos hay realmente en el workspace
            sh "ls -la"
            // 2. Ver el contenido del index.html para confirmar si es el nuevo
            sh "cat index.html" 
            // 3. Construir sin caché
            sh "docker build --no-cache -t ${IMAGE_NAME} ."
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
}