pipeline {
    agent any

    // environment {
    //     NETLIFY_SITE_ID = '9e2f3529-7627-40fc-8cf3-8f291c81520f'
    //     NETLIFY_AUTH_TOKEN = credentials('react-app-demo')
    // }

    stages {
        // using a custom docker image
        // stage('Docker') {
        //     steps {
        //         sh 'docker build -t my-docker-image .'
        //     }
        // }
        // stage('Build') {
        //     agent {
        //         docker {
        //             image 'node:20.11.0-bullseye'
        //             reuseNode true
        //         }
        //     }
        //     steps {
        //         sh '''
        //             ls -la
        //             node --version
        //             npm --version
        //             npm install
        //             npm run build
        //             ls -la
        //         '''
        //     }
        // }

        // stage('Test') {
        //     agent {
        //         docker {
        //             image 'node:20.11.0-bullseye'
        //             reuseNode true
        //         }
        //     }
        //     steps {
        //         sh '''
        //             test -f build/index.html
        //             npm test
        //         '''
        //     }
        // }

        // stage('Deploy') {
        //     agent {
        //         docker {
        //             image 'node:20.11.0-bullseye' // regular dockerhub image
        //             // image 'my-docker-image' // custom docker image
        //             reuseNode true
        //         }
        //     }
        //     steps {
        //         sh '''
        //             # regular netlify deploy
        //             npm install netlify-cli
        //             node_modules/.bin/netlify --version
        //             echo "Deploying to Site ID: $NETLIFY_SITE_ID"
        //             node_modules/.bin/netlify status
        //             node_modules/.bin/netlify deploy --prod --dir=build

        //             ## if using dockerfile, no need to install netlify-cli
        //             # netlify --version
        //             # echo "Deploying to Site ID: $NETLIFY_SITE_ID"
        //             # netlify status
        //             # netlify deploy --prod --dir=build


        //         '''
        //     }
        // }
        stage('AWS') {
            agent {
                docker {
                    image 'amazon/aws-cli:2.24.27'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    aws --version
                '''
            }
        }
    }
}
