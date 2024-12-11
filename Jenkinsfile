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

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker Image...'
                sh "docker build -t ${registry}:${IMAGE_TAG} ."
                echo "Docker image built: ${registry}:${IMAGE_TAG}"
            }
        }

        stage('Login to Docker') {
            steps {
                script {
                    echo 'Logging into Docker Hub...'
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    echo 'Pushing Docker image to Docker Hub...'
                    sh "docker push ${registry}:${IMAGE_TAG}"
                    echo "Docker image pushed: ${registry}:${IMAGE_TAG}"
                }
            }
        }

        stage('Deploy with Docker Compose') {
                    steps {
                        script {
                            echo 'Deploying with Docker Compose...'

                            // Update docker-compose.yml to use the new image tag
                            sh "sed -i 's|image: ${registry}:.*|image: ${registry}:${IMAGE_TAG}|' docker-compose.yml"

                            // Stop existing containers if running
                            sh 'docker compose down || true'

                            // Start the services
                            sh 'docker compose up -d'

                            // Wait for services to initialize
                            sh 'sleep 30'

                            // Verify deployment status
                            sh 'docker compose ps'
                        }
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
