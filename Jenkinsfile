pipeline {
    agent any
    environment {
        TF_VAR_aws_region = 'ap-south-1'
    }

    parameters {
        choice(
            name: 'ACTION',
            choices: ['plan', 'apply'],
            description: 'Select the action to perform'
        )
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/REQ00112233']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/akshaydivekar0624/Terraform-Automation.git']])
            }
        }

        stage('Debug env') {
            steps {
                sh '''
                    echo "AWS_REGION=$AWS_REGION"
                    echo "AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION"
                    echo "TF_VAR_aws_region=$TF_VAR_aws_region"
                    echo "TF_VAR_key_name=$TF_VAR_key_name"
                    env | sort | egrep "AWS|TF_VAR" || true
                '''
            }
        }
    
        stage ("terraform init") {
            steps {
                sh ("terraform init -reconfigure") 
            }
        }

        stage ("Action") {
            steps {
                script {
                    switch (params.ACTION) {
                        case 'plan':
                            echo 'Executing Plan...'
                            sh "terraform plan"
                            break
                        case 'apply':
                            echo 'Executing Apply...'
                            sh "terraform apply --auto-approve"
                            break
                        default:
                            error 'Unknown action'
                    }
                }
            }
        }
    }
}
