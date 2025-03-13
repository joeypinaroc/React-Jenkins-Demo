pipeline {
    agent any

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:20.11.0-bullseye'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    node --version
                '''
            }
        }
    }
}
