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
                echo 'Checkout'
                git url: "https://github.com/${GITHUB_IMAGE}"
            }
        }
        // stage('Static code analysis') {
        //     steps {
        //         echo 'Static code analysis'
        //         sh './gradlew checkstyleMain'
        //         publishHTML (target: [
        //             reportDir: 'build/reports/checkstyle/',
        //             reportFiles: 'main.html',
        //             reportName: 'Checkstyle Report'
        //         ])
        //     }
        // }
        // stage('Compile') {
        //     steps {
        //         echo 'Compile'
        //         sh './gradlew compileJava'
        //     }
        // }
        // stage('Code coverage') {
        //     steps {
        //         echo 'Code coverage'
        //         sh './gradlew jacocoTestReport'
        //         publishHTML (target: [
        //             reportDir: 'build/reports/jacoco/test/html',
        //             reportFiles: 'index.html',
        //             reportName: 'JaCoCo Report'
        //         ])
        //         sh './gradlew jacocoTestCoverageVerification'
        //     }
        // }
        stage('Package') {
            steps {
                echo 'Package'
                sh './gradlew build'
            }
        }
        stage('Docker build') {
            steps {
                echo 'Docker build'
                script {
                    docker.withServer("tcp://${DOCKER_SERVER}", '16a780ab-6713-4daa-8684-11f54eeab3b1') {
                        app = docker.build("${DOCKER_IMAGE}") 
                    }
                }
            }
        }
        stage('Docker push') {
            steps {
                echo 'Docker Publish'
                script {
                    docker.withServer("tcp://${DOCKER_SERVER}", '16a780ab-6713-4daa-8684-11f54eeab3b1') {
                        docker.withRegistry('https://registry.hub.docker.com', "${DOCKER_HUB_CREDENTIAL_ID}") {
                            app.push("${env.BUILD_NUMBER}")
                            app.push("latest")
                        }
                    }
                }
            }
        }
        stage('Deploy to staging') {
            steps {
                echo 'Deploy to staging'
                script {
                    docker.withServer("tcp://${DOCKER_SERVER}", '16a780ab-6713-4daa-8684-11f54eeab3b1') {
                        // sh "docker run -d -p 8765:8080 --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
                        sh 'docker-compose up -d'
                    }
                }
            }
        }
		stage('Acceptance test') {
			steps {
				echo 'Acceptance test'
                script {
                    docker.withServer("tcp://${DOCKER_SERVER}", '16a780ab-6713-4daa-8684-11f54eeab3b1') {
                        // sh "docker-compose -f docker-compose.yml -f acceptance/docker-compose.yml build test"
                        // sh "docker-compose -f docker-compose.yml -f acceptance/docker-compose.yml -p acceptance up -d"
                        // sh 'test $(docker wait acceptance_test_1) -eq 0'
                        sleep 10
                        // sh './acceptance_test.sh'
                        // sh 'docker-compose -f docker-compose.yml -f acceptance/docker-compose-acceptance.yml -p acceptance up -d --build'
                        sh: """
                            test \$(curl -s localhost:8080/sum?a=1\\&b=2) -eq 3
                        """
                    }
                }
			}
		}
    }   
    post {
        always {
            echo 'Always send this message'
            script {
                docker.withServer("tcp://${DOCKER_SERVER}", '16a780ab-6713-4daa-8684-11f54eeab3b1') {
                    // sh "docker rm -f ${CONTAINER_NAME}"
                    // sh 'docker-compose down'
			        // sh 'docker-compose -f docker-compose.yml -f acceptance/docker-compose-acceptance.yml -p acceptance down'
                } 
            }
        }     
    }
}

