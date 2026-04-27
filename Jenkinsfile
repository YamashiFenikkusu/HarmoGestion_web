pipeline {
    agent any
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