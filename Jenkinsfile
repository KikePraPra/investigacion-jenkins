pipeline {
    agent any
    stages {
        stage('Probando') {
            steps {
                script {
                    sh "echo '--- SI PUEDES LEER ESTO, JENKINS ESTA FUNCIONANDO ---'"
                    sh "ls -la"
                    sh "cat index.html"
                }
            }
        }
        stage('Build y Deploy') {
            steps {
                script {
                    sh "docker build --no-cache -t grocy-app-image:latest ."
                    sh "docker rm -f grocy-app || true"
                    sh "docker run -d --name grocy-app -p 8081:80 grocy-app-image:latest"
                }
            }
        }
    }
}