pipeline {
    agent any
    stages {
        stage('Clean workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Git Checkout') {
            steps {
                script {
                     git branch: 'jenkins_test',
                         credentialsID: 'jenkins',
                         url: 'https://github.com/YamashiFenikkusu/HarmoGestion_web.git'
                }
            }
        }
    }
}