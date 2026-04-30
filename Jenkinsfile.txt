pipeline {
    agent any
    environment {
        registryCredential = 'docker'
    }
    tools {
        maven 'Maven'
        jdk 'JDK25'
    }
    stages {
        stage('Git Checkout') {
            steps {
                script {
                     git branch: 'jenkins_test',
                         credentialsID: 'jenkins',
                         url: 'https://github.com/YamashiFenikkusu/HarmoGestion_web.git'
                }
            }
        }
        stage('Build Maven') {
            steps {
                bat 'mvn clean package'
            }
        }
        stage('Rapport Allure') {
            steps {
                bat 'mvn allure:report'
            }
        }
        stage('Build image Docker') {
            steps {
                script {
                    docker.build('yamashifenikkusu/harmogestion:latest', '-f Dockerfile .')
                }
            }
        }
        stage('Push vers Dockerhub') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        docker.image('yamashifenikkusu/harmogestion:latest').push()
                    }
                }
            }
        }
        stage('Deploiement avec le Docker Compose') {
            steps {
                script {
                    bat 'docker-compose up -d --build --force-recreate --remove-orphans'
                }
            }
        }
    }
    post {
        always {
            allure([
                includeProperties: false,
                jdk: '',
                properties: [],
                reportBuildPolicy: 'ALWAYS',
                results: [[path: 'target/allure-results']]
            ])
        }
    }
}