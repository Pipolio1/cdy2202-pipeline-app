pipeline {
    agent any

    environment {
        IMAGE_NAME = 'vehiculos-app'
        CONTAINER_NAME = 'contenedor_vehiculos'
        MYSQL_CONTAINER = 'mysql_vehiculos'
        PORT = '9090'
    }

    stages {

        stage('Stop Old Containers') {
            steps {
                sh '''
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
                '''
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

        stage('Deploy Application') {
            steps {
                sh '''
                docker run -d -p ${PORT}:8080 \
                --name ${CONTAINER_NAME} \
                -e SPRING_DATASOURCE_URL=jdbc:mysql://172.17.0.1:3306/vehiculos \
                -e SPRING_DATASOURCE_USERNAME=root \
                -e SPRING_DATASOURCE_PASSWORD=root123 \
                ${IMAGE_NAME}
                '''
            }
        }
    }

    post {
        success {
            echo 'Deploy completado correctamente'
        }
        failure {
            echo 'Error en el pipeline'
        }
    }
}
