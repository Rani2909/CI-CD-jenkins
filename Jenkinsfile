pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub'
    }
 
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Rani2909/CI-CD-jenkins.git'
            }
        }
 
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('rani2909/nginx:latest')
                }
            }
        }
 
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', dockerhub) {
                        docker.image('rani2909/nginx:latest').push('latest')
                    }
                }
            }
        }
 
        stage('Deploy to EC2') {
            steps {
                script {
                    // Ensure Docker is installed and configured on the Jenkins agent
                    sh 'docker --version'
                    
                    // Use AWS credentials to interact with EC2
                    withAWS(credentials: 'EC2', region: 'us-east-1 {
                        // Pull the Docker image from Docker Hub
                        sh 'docker pull rani2909/nginx:latest'
                        
                        // Stop and remove existing container, then run a new one
                        sh 'docker stop cicd_pipeline || true'
                        sh 'docker rm cicd_pipeline || true'
                        sh 'docker run -d --name cicd_pipeline -p 80:80 rani2909/nginx:latest'
                    }
                }
            }
        }
    }
}
