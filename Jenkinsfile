pipeline {
    agent any
    stages {
            stage('Checkout') {
                steps {
                    git branch: 'AmalNahdi',
                    url: 'https://github.com/amalnahdi/ProjetEvent.git';
                }
            }
             stage('Build') {
                  steps {
                      sh 'mvn install -Dmaven.test.skip=true'
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