pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'SonarQube'  // SonarQube environment name
        NEXUS_CREDENTIALS_ID = 'deploymentRepo'  // Nexus credentials ID in Jenkins
        DOCKER_CREDENTIALS = credentials('docker-hub-credentials')
        RELEASE_VERSION = "1.0"
        registry = "farahdiouani/gestion-station-ski"
        registryCredential = 'docker-hub-credentials'
        IMAGE_TAG = "${RELEASE_VERSION}-${env.BUILD_NUMBER}"
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




        stage('Build') {
            steps {
                echo 'Building Stage...'
                sh 'mvn install -Dmaven.test.skip=true'
                echo 'Build completed.'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo 'Starting SonarQube Analysis...'
                withSonarQubeEnv(SONARQUBE_ENV) {
                    echo 'Running SonarQube analysis...'
                    sh 'mvn sonar:sonar -Dsonar.projectKey=sonar'
                }
                echo 'SonarQube analysis completed.'
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