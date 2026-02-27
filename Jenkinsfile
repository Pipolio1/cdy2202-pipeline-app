pipeline {
    agent any

    environment {
        IMAGE_NAME = 'vehiculos-app'
        CONTAINER_NAME = 'contenedor_vehiculos'
        PORT = '9090'
    }

    stages {

        stage('Stop Old Container') {
            steps {
                sh '''
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
                '''
            }
        }

        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build WAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker run -d -p ${PORT}:8080 \
                -e SPRING_DATASOURCE_URL=jdbc:mysql://TU_IP_MYSQL:3306/vehiculos \
                -e SPRING_DATASOURCE_USERNAME=root \
                -e SPRING_DATASOURCE_PASSWORD=tu_password \
                --name ${CONTAINER_NAME} ${IMAGE_NAME}
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline ejecutado correctamente 🚀'
        }
        failure {
            echo 'Pipeline falló ❌ Revisar Console Output'
        }
    }
}
