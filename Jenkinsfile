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
        
    
        stage("Testing for all"){
            steps{

                script{
                    
                   
                    
                    // res=sh (script: "bash testing.sh ",
                    // returnStdout: true).trim()
                    // echo "$res"
                    //7 tests performed
                    ///////////////////
                    // Server is set to app:8080
                    // Test level is set to sanity
                    // Wait time is set to 5
                    // Waiting 5 seconds before starting to send test messages...
                    // 7 tests performed in 0:00:05.13.
                    


                    //docker run -dit --name toxi2 -p 8083:8080 --network ubuntu_default  toxi_img bash
                }
            }

        }
        stage("is pass"){
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

                    
                    sh "docker run -d --name app --network ubuntu_default -p 8083:8080 toxictypoapp:1.0-SNAPSHOT "
                    
                    sh "docker build -t testing-img ./src/test/" 
                    sh "docker run --rm --name testing --network ubuntu_default testing-img"
                }
            }
        }
        stage("is pass"){
            when{
                anyOf {
                        branch "main"
                        branch "master"
                }
            }
            steps{
                script{
                    sh "docker tag app shoval_private_ecr:toxi"
                    docker.withRegistry("http://644435390668.dkr.ecr.eu-west-3.amazonaws.com/shoval_private_ecr", "ecr:eu-west-3:644435390668") {
                    docker.image("shoval_private_ecr:toxi").push()
                    }
                }
            } 

        }

    //     stage("is a release"){
    //         when{
    //             expression{
    //                 return GIT_BRANCH.contains('release/')
    //             }
    //         }
    //         steps{
    //             echo "===============================================Executing Calc==============================================="
    //             script{
    //                 Ver_Br=sh (script: "echo $GIT_BRANCH | cut -d '/' -f2",
    //                 returnStdout: true).trim()
    //                 echo "${Ver_Br}"
    //                 Ver_Calc=sh (script: "bash calc.sh ${Ver_Br}",
    //                 returnStdout: true).trim()
    //                 echo "${Ver_Calc}"

    //             }     
                
    //         }
           
    //     }
    //     stage("is a release2"){
    //         when{
    //             expression{
    //                 return GIT_BRANCH.contains('release/')
    //             }
    //         }
            
    //         steps{
    //             echo "===============================================Executing Push==============================================="
    //             configFileProvider([configFile(fileId: 'my_settings.xml', variable: 'set')]) {
    //                 sh "mvn versions:set -DnewVersion=${Ver_Calc} && mvn -s ${set} deploy "
    //                 }
    //             script{
    //                 withCredentials([gitUsernamePassword(credentialsId: '2053d2c3-e0ab-4686-b031-9a1970106e8d', gitToolName: 'Default')]){
    //                         // sh "git checkout release/${VER}"
    //                         sh "git tag $Ver_Calc"
    //                         sh "git push origin $Ver_Calc"
                    
    //                     }
    //             }

    // //
    //         }
           
    //     }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}