pipeline {
    agent any
    environment {
        // Usamos el número de build para que la imagen sea única cada vez
        IMAGE_TAG = "grocy-app:${BUILD_NUMBER}"
        CONTAINER_NAME = "grocy-app"
        EC2_WORKSPACE = "/var/lib/docker/volumes/jenkins_home/_data/workspace/prueba2"
    }
    stages {
        stage('Clean & Checkout') {
            steps {
                cleanWs()
                checkout scm
            }
        }
        stage('Build') {
            steps {
                script {
                    // Imprimimos el index para estar 100% seguros en el log
                    sh "cat index.html"
                    // Construimos con el tag único
                    sh "docker build --no-cache -t ${IMAGE_TAG} -f ${EC2_WORKSPACE}/Dockerfile ${EC2_WORKSPACE}"
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Matamos el anterior
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                    // Corremos la imagen recién creada con su tag único
                    sh "docker run -d --name ${CONTAINER_NAME} -p 8081:80 ${IMAGE_TAG}"
                }
            }
        }
    }
}