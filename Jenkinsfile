pipeline{
    agent any

    options {
        timestamps()
        gitLabConnection('my-repo')  
    }
    tools {
        maven 'my-work-maven'
        jdk 'java-8-work'
    }
    environment{
        def res="not work"
    }
    stages{
        stage("CHEKOUT"){
            steps{
                echo "===============================================Executing CHEKOUT==============================================="
                // echo sh(script: 'env|sort', returnStdout: true)
                // sh 'printenv'
                //  echo "===================================================================================Executing deleteDir()==================================================================================="
                deleteDir()
                // echo sh(script: 'env|sort', returnStdout: true)
                // sh 'printenv'
                // echo "===================================================================================Executing checkout scm==================================================================================="
                checkout scm
                // echo sh(script: 'env|sort', returnStdout: true)
                // sh 'printenv'
            }
        }
        

        stage("is all"){
            when{
                anyOf {
                        branch "main"
                        branch "feature/*"
                        branch "master"
                }
            } 
            
            steps{
                script{
                    echo "======================================================================================================================================================================"
                    sh "docker rm -f app "
                    // sh "docker rm -f testing"
                    //toxictypoapp:1.0-SNAPSHOT
                    configFileProvider([configFile(fileId: 'my_settings.xml', variable: 'set')]) {
                    sh "mvn -s ${set} verify"
                    }
                    echo "======================================================================================================================================================================"

                     sh "docker rm -f app "

                    sh "docker run -d --name app --network ubuntu_default -p 8083:8080 toxictypoapp:1.0-SNAPSHOT "
                    
                    sh "docker build -t testing-img ./src/test/" 
                    
                    
                }
            }
        }
        stage("test"){
            parallel{
            stage("testing1"){ 
                steps{
                    sh "docker run --name testing1 --network ubuntu_default -e FILE=e2e1 testing-img" 
                }
            }
            stage("testing2"){ 
                steps{
                    sh "docker run --name testing2 --network ubuntu_default -e FILE=e2e2 testing-img" 
                }
            }
            stage("testing3"){ 
                steps{
                    sh "docker run --name testing3 --network ubuntu_default -e FILE=e2e3 testing-img" 
                }
            }
            stage("testing4"){ 
                steps{
                    sh "docker run --name testing4 --network ubuntu_default -e FILE=e2e4 testing-img" 
                }
            }
            stage("testing5"){ 
                steps{
                    sh "docker run --name testing5 --network ubuntu_default -e FILE=e2e5 testing-img" 
                }
            }
            stage("testing6"){ 
                steps{
                    sh "docker run --name testing6 --network ubuntu_default -e FILE=e2e6 testing-img" 
                }
            }
            stage("testing7"){ 
                steps{
                    sh "docker run --name testing7 --network ubuntu_default -e FILE=e2e7 testing-img" 
                }
            }
            stage("testing8"){ 
                steps{
                    sh "docker run --name testing8 --network ubuntu_default -e FILE=e2e8 testing-img" 
                }
            }

            }
        }
        stage("is deploy to prod"){
            when{
                anyOf {
                        branch "main"
                        branch "master"
                }
            }
            steps{
                script{
                    sh "docker tag toxictypoapp:1.0-SNAPSHOT shoval_toxi:toxictypoapp"
                    docker.withRegistry("http://644435390668.dkr.ecr.eu-west-3.amazonaws.com/shoval_toxi", "ecr:eu-west-3:644435390668") {
                    docker.image("shoval_toxi:toxictypoapp").push()
                    }
                }
            } 

        }
        stage("is main"){
            when{
                anyOf {
                        branch "main"
                        branch "master"
                }
            }
            steps{
                script{
                    sh """ 
                        ssh ubuntu@43.0.10.85 "docker rm -f prod"
                        ssh ubuntu@43.0.10.85 "aws ecr get-login-password --region eu-west-3 | docker login --username AWS --password-stdin 644435390668.dkr.ecr.eu-west-3.amazonaws.com"
                        ssh ubuntu@43.0.10.85 "docker run -d --name prod -p 80:8080  644435390668.dkr.ecr.eu-west-3.amazonaws.com/shoval_toxi:toxictypoapp"
                    """
                    }
               
            } 

        }

    }
    post{
        always{
            sh "docker rm -f testing1 testing2 testing3 testing4 testing5 testing6 testing7 testing8"
            echo "========always========"
        }
        success{
           script{
                script{
                    emailext to: 'shoval123055@gmail.com',
                    subject: 'Congratulations!', body: 'Well, this time you didnt mess up',  
                    attachLog: true
                }     
            
            
                gitlabCommitStatus(connection: gitLabConnection(gitLabConnection: 'my-repo' , jobCredentialId: ''),name: 'report'){
                    echo "that good"
                }
            }
        }
        failure{
                script{
                // emailext   recipientProviders: [culprits()],
                // subject: 'YOU ARE BETTER THEN THAT !!! ', body: 'Dear programmer, you have broken the code, you are asked to immediately sit on the chair and leave the coffee corner.',  
                // attachLog: true
                emailext   to: 'shoval123055@gmail.com',
                subject: 'YOU ARE BETTER THEN THAT !!! ', body: 'Dear programmer, you have broken the code, you are asked to immediately sit on the chair and leave the coffee corner.',  
                attachLog: true
            }      
           
            gitlabCommitStatus(connection: gitLabConnection(gitLabConnection: 'my-repo' , jobCredentialId: ''),name: 'report'){
                echo "ahh"
            }

        }
    }
}