pipeline {
    agent any
    environment {
        SONARQUBE_ENV = 'SonarQube'  // SonarQube environment name
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                git branch: 'AmalNahdi',
                    url: 'https://github.com/amalnahdi/ProjetEvent.git'
                echo 'Checkout completed.'
            }
        }

        stage('Clean') {
            steps {
                echo 'Cleaning the workspace...'
                sh 'mvn clean'
                echo 'Clean completed.'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo 'Starting SonarQube Analysis...'
                withSonarQubeEnv(SONARQUBE_ENV) {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=sonar'
                }
                echo 'SonarQube analysis completed.'
            }
        }

        stage('Package') {
            steps {
                echo 'Packaging Stage...'
                sh 'mvn package'
                echo 'Package completed.'
            }
        }

        stage('Build') {
            steps {
                echo 'Building Stage...'
                sh 'mvn install -Dmaven.test.skip=true'
                echo 'Build completed.'
            }
        }
    }

    post {
        success {
            echo 'Build finished successfully!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}