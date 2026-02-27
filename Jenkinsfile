pipeline {
    agent any

    stages {

        stage('Stop Old Container') {
            steps {
                sh 'docker stop contenedor_vehiculos || true'
                sh 'docker rm contenedor_vehiculos || true'
            }
        }

        stage('Build Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t vehiculos-app .'
            }
        }

        stage('Deploy Container') {
            steps {
                sh 'docker run -d -p 9090:8080 --name contenedor_vehiculos vehiculos-app'
            }
        }

    }
}
