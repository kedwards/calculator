pipeline {
    agent { label 'latest' }
    environment {
        DOCKER_IMAGE = 'kevinedwards/calculator'
        GITHUB_IMAGE = 'kedwards/calculator'
        CONTAINER_NAME = 'calculator'
        DOCKER_SERVER = '35.182.66.188:2376'
        DOCKER_HUB_CREDENTIAL_ID = '015cdcef-f928-4288-9ccd-7f91f75d2178'
    }
    triggers {
        pollSCM('H/30 * * * *')
    }
    stages {
        stage('Checkout') {
            steps {
                git url: "https://github.com/${GITHUB_IMAGE}"
            }
        }
        stage('Static code analysis') {
            steps {
                sh './gradlew checkstyleMain'
                publishHTML (target: [
                    reportDir: 'build/reports/checkstyle/',
                    reportFiles: 'main.html',
                    reportName: 'Checkstyle Report'
                ])
            }
        }
        stage('Compile') {
            steps {
                sh './gradlew compileJava'
            }
        }
        stage("Unit test") {
            steps { 
                sh "./gradlew test"
            }
        }
        stage('Code coverage') {
            steps {
                sh './gradlew jacocoTestReport'
                publishHTML (target: [
                    reportDir: 'build/reports/jacoco/test/html',
                    reportFiles: 'index.html',
                    reportName: 'JaCoCo Report'
                ])
                sh './gradlew jacocoTestCoverageVerification'
            }
        }
        stage('Package') {
            steps {
                sh './gradlew build'
            }
        }
        stage('Docker build') {
            steps {
                script {
                    docker.withServer("tcp://${DOCKER_SERVER}", '16a780ab-6713-4daa-8684-11f54eeab3b1') {
                        app = docker.build("${DOCKER_IMAGE}") 
                    }
                }
            }
        }
        stage('Docker push') {
            steps {
                script {
                    docker.withServer("tcp://${DOCKER_SERVER}", '16a780ab-6713-4daa-8684-11f54eeab3b1') {
                        docker.withRegistry('https://registry.hub.docker.com', "${DOCKER_HUB_CREDENTIAL_ID}") {
                            app.push("${BUILD_TIMESTAMP}")
                        }
                    }
                }
            }
        }
        // stage('Deploy and Acceptance test') {
        //     steps {
        //         script {
        //             docker.withServer("tcp://${DOCKER_SERVER}", '16a780ab-6713-4daa-8684-11f54eeab3b1') {
        //                 sh "docker-compose -f docker-compose.yml -f acceptance/docker-compose.yml build test"
        //                 sh "docker-compose -f docker-compose.yml -f acceptance/docker-compose.yml -p acceptance up -d"
        //                 sh 'test $(docker wait acceptance_test_1) -eq 0'
        //             }
        //         }
        //     }
        // }
        stage('Deploy to Staging') {
            steps {
                sh "ansible-playbook playbook.yml -i inventory --limit=calc-stage"
                sleep 30
            }
        }

        // Performance test stages

        stage("Acceptance test") {
            steps {
                sh "./acceptance_test.sh"
            }
        }  
        stage('Deploy to Production') {
            steps {
                sh "ansible-playbook playbook.yml -i inventory --limit=calc-prod"
                sleep 30
            }
        }
        stage("Smoke test") { 
            steps { 
                sh "./smoke_test.sh"
            } 
        }
    }   
    // post {
    //     always {
    //         script {
    //             docker.withServer("tcp://${DOCKER_SERVER}", '16a780ab-6713-4daa-8684-11f54eeab3b1') {
    //                 sh "docker-compose -f docker-compose.yml -f acceptance/docker-compose.yml -p acceptance down"
    //             } 
    //         }
    //     }     
    // }
}

