pipeline {
    agent any
 
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
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials-id') {
                        docker.image('rani2909/nginx:latest').push('latest')
                    }
                }
            }
        }
 
        stage('Deploy to EC2') {
            steps {
                // Use SSH or other deployment tools to deploy the Docker image to your EC2 instance
                ssh 'ec2-3-84-2-134.compute-1.amazonaws.com' 'docker pull rani2909/nginx:latest && docker stop cicd_pipeline && docker rm cicd_pipeline && docker run -d --name cicd_pipeline -p 80:80 nginx:latest'
            }
        }
    }
}
