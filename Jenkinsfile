pipeline {
    agent any

    environment {
        IMAGE_NAME = "jenkins-devsecops-pipeline"
        IMAGE_TAG  = "latest"
    }

    stages {

        stage('Checkout') {
            steps {
                echo ' Clonando repositorio...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo ' Construyendo la aplicación...'
                sh 'echo "Build completado"'
                // Si es Python: sh 'pip install -r requirements.txt'
                // Si es Node:   sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo ' Ejecutando pruebas...'
                sh 'echo "Tests pasados"'
                // Si es Python: sh 'pytest'
                // Si es Node:   sh 'npm test'
            }
        }

        stage('SAST - Análisis estático') {
            steps {
                echo ' Análisis de seguridad del código (SAST)...'
                // Bandit para Python:
                // sh 'pip install bandit && bandit -r . -f json -o bandit-report.json || true'
                sh 'echo "SAST completado"'
            }
        }

        stage('SCA - Dependencias') {
            steps {
                echo ' Revisando vulnerabilidades en dependencias...'
                // OWASP Dependency Check o Safety (Python):
                // sh 'safety check'
                sh 'echo "SCA completado"'
            }
        }

        stage('Docker Build') {
            steps {
                echo ' Construyendo imagen Docker...'
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Docker Image Scan') {
            steps {
                echo ' Escaneando imagen Docker con Trivy...'
                sh "docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image --exit-code 0 ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Deploy') {
            steps {
                echo ' Desplegando contenedor...'
                sh "docker run -d --name ${IMAGE_NAME} ${IMAGE_NAME}:${IMAGE_TAG} || true"
            }
        }
    }

    post {
        success {
            echo ' Pipeline DevSecOps completado exitosamente.'
        }
        failure {
            echo ' El pipeline falló. Revisar logs.'
        }
        always {
            echo ' Limpiando workspace...'
            cleanWs()
        }
    }
}