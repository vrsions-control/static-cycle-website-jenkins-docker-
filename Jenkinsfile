pipeline {
    agent any
    environment{
        registry="357643164931.dkr.ecr.us-east-2.amazonaws.com/static-website-repo"
    }
    stages {
        stage('Checkout') {
            steps {
               checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/venkatreddybandi1999/static-website.git']])
            }
        }
        
        // Building docker image
        stage('Build docker image'){
            steps{
                sh "docker build -t $registry:${BUILD_NUMBER} ."
            }
        }
        
        // Uploading Docker image into ECR
        stage("Uploading to ECR"){
            steps{
                sh "aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin $registry"
                sh "docker push $registry:${BUILD_NUMBER}"
            }
        }
        
        // stopping previous container and removing
        stage("Stopping previous container"){
            steps{
                sh "docker ps -f name=website-cont -q |xargs --no-run-if-empty docker container stop"
                sh "docker ls -a -f name=website-cont -q | xargs -r docker container rm"
            }
        }
        
        // docker run
        stage("Docker run"){
            steps{
                sh "docker run -itd --name website-cont -p 8081:80 $registry:${BUILD_NUMBER}"
            }
        }
    }
}
// pipeline {
//     agent any
//     environment{
//         registry="357643164931.dkr.ecr.us-east-2.amazonaws.com/static-website-repo"
        
//     }
//     stages {
//         stage('Hello') {
//             steps {
//                 git 'https://github.com/venkatreddybandi1999/static-website'
//             }
//         }
//         stage ("Build Docker Image"){
//             steps{
//                 sh "docker build -t static-website-image:${BUILD_NUMBER} ."
//             }
//         }
//         stage ("Docker run"){
//             steps{
//                 sh "docker run -itd --name static-website-cont -p 8081:80 static-website-image:${BUILD_NUMBER}"
//             }
//         }
//         stage("AWS Configure"){
//             steps{
//                 withCredentials([[
//                     $class:'AmazonWebServicesCredentialsBinding',
//                     credentialsId: 'aws-jenkins',
//                     accessKeyVariable: 'AWS_ACCESS_KEY_ID',
//                     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]){
//                         sh "aws s3 ls"
//                     }
//             }
//         }
//         stage("Docker login"){
//             steps{
//               sh "aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 357643164931.dkr.ecr.us-east-2.amazonaws.com"
//               sh "docker push static-website-image:${BUILD_NUMBER}"
//             }
//         }
//     }
// }

