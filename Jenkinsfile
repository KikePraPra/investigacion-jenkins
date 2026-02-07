pipeline {
    agent any
    
    stages {
        stage('Limpieza y Código') {
            steps {
                cleanWs()
                checkout scm
                // Verificamos qué versión de código bajó Jenkins
                sh "cat index.html"
            }
        }
        
        stage('Construir Imagen') {
            steps {
                // Usamos un nombre único con el número de build
                // Si el archivo se llama 'dockerfile' (minúscula), cámbialo aquí abajo:
                sh "docker build --no-cache -t app-nueva:${BUILD_NUMBER} -f dockerfile ."
            }
        }
        
        stage('Desplegar') {
            steps {
                script {
                    // Borramos el viejo por nombre
                    sh "docker rm -f grocy-app || true"
                    // Corremos la imagen recién creada
                    sh "docker run -d --name grocy-app -p 8081:80 app-nueva:${BUILD_NUMBER}"
                }
            }
        }
        
        stage('Verificar') {
            steps {
                // Esto nos dirá en el log de Jenkins si el contenedor quedó vivo
                sh "docker ps | grep grocy-app"
            }
        }
    }
}