pipeline {
    agent any
    
    environment {
        // Nombre simple para la imagen y el contenedor
        IMAGE_NAME = "mi-app-web"
        CONTAINER_NAME = "grocy-app"
    }

    stages {
        stage('1. Obtener Código') {
            steps {
                cleanWs()
                checkout scm
                // ESTA LÍNEA ES CLAVE: Veremos en el log de Jenkins si el código es el nuevo
                sh "cat index.html"
            }
        }
        
        stage('2. Construir Imagen') {
            steps {
                script {
                    // Construimos la imagen desde cero
                    sh "docker build --no-cache -t ${IMAGE_NAME}:latest -f dockerfile ."
                }
            }
        }
        
        stage('3. Desplegar') {
            steps {
                script {
                    // Como dijiste que no hay nada, el 'stop' y 'rm' fallarán. 
                    // El '|| true' evita que el pipeline se detenga por eso.
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                    
                    // Lanzamos el contenedor en el puerto 8081
                    sh "docker run -d --name ${CONTAINER_NAME} -p 8081:80 ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('4. Verificación Final') {
            steps {
                // Esto nos confirmará que el contenedor quedó corriendo
                sh "docker ps"
            }
        }
    }
}