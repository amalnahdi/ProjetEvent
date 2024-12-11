pipeline {
    agent any
    environment {
        SONARQUBE_ENV = 'SonarQube'  // SonarQube environment name
        NEXUS_CREDENTIALS_ID = 'deploymentRepo'  // Nexus credentials ID in Jenkins
        DOCKER_CREDENTIALS = credentials('docker-hub-credentials')
        RELEASE_VERSION = "1.0"
        registry = "amalnahdii/events-project"
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

        stage('Compile') {
            steps {
                echo 'Compiling the code...'
                sh 'mvn compile'
                echo 'Compilation completed.'
            }
        }

        /* stage('SonarQube Analysis') {
            steps {
                echo 'Starting SonarQube Analysis...'
                withSonarQubeEnv(SONARQUBE_ENV) {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=sonar'
                }
                echo 'SonarQube analysis completed.'
            }
        }*/

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

       // stage('Deploy to Nexus') {
        //    steps {
          //      echo 'Deploying to Nexus...'
           //     sh "mvn deploy -Dmaven.test.skip=true -DaltDeploymentRepository=deploymentRepo::default::http://192.168.33.10:8081/repository/AmalNahdi5sae1/"
            //    echo 'Deployment to Nexus completed.'
           // }
       // }

        stage('Build Image') {
            steps {
                echo 'Building Docker Image...'
                script {
                    def dockerImage = docker.build("${registry}:${IMAGE_TAG}")
                    env.BUILT_IMAGE = dockerImage.imageName()
                    echo "Docker image built: ${env.BUILT_IMAGE}"
                }
                echo 'Docker Build Image stage completed.'
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
