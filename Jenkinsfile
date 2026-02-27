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
                docker run -d \
                --network bridge \
                -p ${PORT}:8080 \
                -e SPRING_DATASOURCE_URL=jdbc:mysql://172.17.0.3:3306/vehiculos \
                -e SPRING_DATASOURCE_USERNAME=root \
                -e SPRING_DATASOURCE_PASSWORD=root123 \
                -e SPRING_DATASOURCE_DRIVER_CLASS_NAME=com.mysql.cj.jdbc.Driver \
                -e SPRING_JPA_DATABASE_PLATFORM=org.hibernate.dialect.MySQLDialect \
                -e SPRING_JPA_HIBERNATE_DDL_AUTO=update \
                --name ${CONTAINER_NAME} ${IMAGE_NAME}
                '''
            }
        }
    }
}
