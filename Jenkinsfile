pipeline {
    agent any

    environment {
        DOCKER_BUILDKIT = '1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/dhyey0512/employee-managenet-system-mern.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
                    sh 'cd backend && npm install'
                    sh 'cd frontend && npm install'
                }
            }
        }

        stage('Run Tests') {
            steps {
                catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
                    sh 'cd backend && npm test'
                    sh 'cd frontend && npm test'
                }
            }
        }

        stage('Code Analysis with SonarQube') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'sonar-scanner'
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                sh 'docker build -t employee-management-backend ./backend'
                sh 'docker build -t employee-management-frontend ./frontend'
            }
        }

        stage('Deploy to Server') {
            steps {
                sshagent(['your-ssh-credentials']) {
                    sh '''
                    cd path/to/docker-compose-directory
                    docker-compose down
                    docker-compose up -d
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
