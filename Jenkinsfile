pipeline {
    agent any

    environment {
        DOCKER_BUILDKIT = '1'
    }

    parameters {
        string(name: 'BRANCH', defaultValue: 'main', description: 'Branch to build')
        string(name: 'REPO_URL', defaultValue: 'https://github.com/dhyey0512/employee-managenet-system-mern.git', description: 'Repository URL')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: "${params.BRANCH}", url: "${params.REPO_URL}"
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
                    sh "${tool('SonarQubeScanner')}/bin/sonar-scanner"
                }
            }
        }

        stage('Trivy Security Scan') {
            steps {
                def version = "${env.BUILD_NUMBER}"
                sh "trivy image employee-management-backend:${version}"
                sh "trivy image employee-management-frontend:${version}"
            }
        }

        stage('Build Docker Images') {
            steps {
                def version = "${env.BUILD_NUMBER}"
                sh "docker build -t employee-management-backend:${version} ./backend"
                sh "docker build -t employee-management-frontend:${version} ./frontend"
            }
        }

        stage('Deploy to Server') {
            steps {
                sshagent(['905069a7-6049-4c2b-ba1b-ea9aa311c77b']) {
                    sh '''
                    docker-compose down --rmi all --volumes --remove-orphans
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
            archiveArtifacts artifacts: '**/logs/*.log', allowEmptyArchive: true
        }
    }
}
