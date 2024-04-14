pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'nginx:latest'
        HTML_DIR = '/usr/share/nginx/html'
    }

    stages {
        stage('Build') {
            steps {
                sh 'cp index.html ${HTML_DIR}'
                script {
                    docker.build("my-static-app", "-f Dockerfile.static .")
                }
            }
        }
        stage('Test') {
            steps {
                // Add test steps if needed
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_REGISTRY_CREDS}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin docker.io"
                    sh 'docker push my-static-app'
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout'
        }
    }
}
