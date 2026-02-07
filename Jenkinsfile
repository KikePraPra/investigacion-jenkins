pipeline {
    agent any
    stages {
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