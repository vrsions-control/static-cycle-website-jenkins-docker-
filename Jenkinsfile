pipeline {
    agent any
    environment{
        registry="357643164931.dkr.ecr.us-east-2.amazonaws.com/static-website-repo"
        
    }
    stages {
        stage('Hello') {
            steps {
                git 'https://github.com/venkatreddybandi1999/static-website'
            }
        }
        stage ("Build Docker Image"){
            steps{
                sh "docker build -t static-website-image:${BUILD_NUMBER} ."
            }
        }
        stage ("Docker run"){
            steps{
                sh "docker run -itd --name static-website-cont -p 8081:80 static-website-image:${BUILD_NUMBER}"
            }
        }
        stage("AWS Configure"){
            steps{
                withCredentials([[
                    $class:'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-jenkins',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]){
                        sh "aws s3 ls"
                    }
            }
        }
        stage("Docker login"){
            steps{
              sh "aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 357643164931.dkr.ecr.us-east-2.amazonaws.com"
              sh "docker push static-website-image:${BUILD_NUMBER}"
            }
        }
    }
}

