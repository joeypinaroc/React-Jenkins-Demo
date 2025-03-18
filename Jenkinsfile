pipeline {
    agent any

    environment {
        NETLIFY_SITE_ID = '9e2f3529-7627-40fc-8cf3-8f291c81520f'
        NETLIFY_AUTH_TOKEN = credentials('react-app-demo')
    }

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
                    ls -la
                    node --version
                    npm --version
                    npm install
                    npm run build
                    ls -la
                '''
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'node:20.11.0-bullseye'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    test -f build/index.html
                    npm test
                '''
            }
        }

        stage('Deploy') {
            agent {
                docker {
                    image 'node:20.11.0-bullseye'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    npm install netlify-cli
                    node_modules/.bin/netlify --version
                    echo "Deploying to Site ID: $NETLIFY_SITE_ID"
                    node_modules/.bin/netlify status
                    node_modules/.bin/netlify deploy --prod --dir=build
                '''
            }
        }
    }
}
