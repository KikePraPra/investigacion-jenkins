pipeline {
    agent any
    environment {
        IMAGE_NAME = "grocy-app-image"
        CONTAINER_NAME = "grocy-app"
    }
    stages {
        stage('1. Sincronización') {
            steps {
                cleanWs()
                checkout scm
                // ESTO NOS DIRÁ LA VERDAD:
                sh "echo '--- CONTENIDO DE INDEX.HTML ---'"
                sh "cat index.html" 
            }
        }
        stage('2. Build Forzado') {
            steps {
                script {
                    // Borramos imagen vieja para que no haya dudas
                    sh "docker rmi ${IMAGE_NAME}:latest || true"
                    // Construimos
                    sh "docker build --no-cache -t ${IMAGE_NAME}:latest ."
                }
            }
        }
        stage('3. Deploy Limpio') {
            steps {
                script {
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                    sh "docker run -d --name ${CONTAINER_NAME} -p 8081:80 ${IMAGE_NAME}:latest"
                }
            }
        }
    }
}