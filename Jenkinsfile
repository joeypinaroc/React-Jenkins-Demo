pipeline {
    agent any

    // environment {
        // DOCKER_HOST = 'unix:///var/run/docker.sock'
        // NETLIFY_SITE_ID = '9e2f3529-7627-40fc-8cf3-8f291c81520f'
        // NETLIFY_AUTH_TOKEN = credentials('react-app-demo')
    // }

    environment {
        AWS_DEFAULT_REGION = "us-east-2"
        AWS_DOCKER_REGISTRY = "819167064042.dkr.ecr.us-east-2.amazonaws.com/my-react-app-image"
        APP_NAME = "my-react-app-image"
    }

    stages {
    //     // // using a custom docker image
    //     // stage('Docker') {
    //     //     steps {
    //     //         sh 'docker build -t my-docker-image .'
    //     //     }
    //     // }
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
        //             # echo "Docker host: $DOCKER_HOST"
        //             node --version
        //             npm --version
        //             # npm install
        //             npm ci
        //             npm run build
        //             ls -la
        //         '''
        //     }
        // }

    //     stage('Test') {
    //         agent {
    //             docker {
    //                 image 'node:20.11.0-bullseye'
    //                 reuseNode true
    //             }
    //         }
    //         steps {
    //             sh '''
    //                 test -f build/index.html
    //                 npm test
    //             '''
    //         }
    //     }

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

        // ** for AWS
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
        //             # echo "Docker host: $DOCKER_HOST"
        //             node --version
        //             npm --version
        //             # npm install
        //             npm ci
        //             npm run build
        //             ls -la
        //         '''
        //     }
        // }
        // stage('AWS') {
        //     agent {
        //         docker {
        //             image 'amazon/aws-cli'
        //             reuseNode true
        //             args '--entrypoint=""'
        //         }
        //     }
        //     environment {
        //         AWS_S3_BUCKET = 'me-new-jenkins-bucket'
        //     }
        //     steps {
        //         withCredentials([usernamePassword(credentialsId: 'aws-s3-key', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
        //             sh '''
        //                 aws --version
        //                 aws s3 ls
        //                 echo "Hello S3!" > index.html
        //                 aws s3 cp index.html s3://me-new-jenkins-bucket/index.html
        //                 aws s3 sync build s3://$AWS_S3_BUCKET
        //             '''
        //         }
        //     }
        // }
        
        stage('Build') {
            agent {
                docker {
                    image 'node:22-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    # list all files
                    ls -la
                    node --version
                    npm --version
                    # npm install
                    npm ci
                    npm run build
                    ls -la
                '''
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'node:22-alpine'
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

        stage('Create Docker image') {
            agent {
                docker {
                    image 'amazon/aws-cli'
                    reuseNode true
                    args '-u root -v /var/run/docker.sock:/var/run/docker.sock --entrypoint=""'
                }
            }
            steps {
                sh '''
                    amazon-linux-extras install docker
                    docker build -t my-docker-image-aws .

                    # push image to ECR
                    aws ecr get-login-password | docker login --username AWS --password-stdin $AWS_DOCKER_REGISTRY
                    docker push $AWS_DOCKER_REGISTRY/$APP_NAME:latest
                '''
            }
        }
        // stage('Deploy to AWS') {
        //     agent {
        //         docker {
        //             image 'amazon/aws-cli'
        //             reuseNode true
        //             args '-u root --entrypoint=""'
        //         }
        //     }
        //     steps {
        //         withCredentials([usernamePassword(credentialsId: 'aws-s3-key', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
        //             sh '''
        //                 aws --version
        //                 yum install jq -y

        //                 aws ecs register-task-definition --cli-input-json file://aws/task-definition.json
        //                 LATEST_TD_REVISION=$(aws ecs register-task-definition --cli-input-json file://aws/task-definition.json | jq '.taskDefinition.revision')
        //                 aws ecs update-service --cluster task-cluster-react-prod --service my-new-Service-Prod --task-definition Temp-TaskDefinition-Prod:$LATEST_TD_REVISION
        //             '''
        //         }
        //     }
        // }
    }
}
