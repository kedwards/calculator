pipeline {
    agent any 
    environment {
        DOCKER_IMAGE = 'kevinedwards/calculator'
        CONTAINER_NAME = 'calculator'
        DOCKER_HUB_CREDENTIAL_ID = '83e59579-5712-456e-9e9e-7395ea744909'
    }
    triggers {
        pollSCM('H/15 * * * *')
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/kedwards/calculator.git'
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
        stage('Code coverage') {
            steps {
                sh './gradlew jacocoTestCoverageVerification'
                publishHTML (target: [
                    reportDir: 'build/reports/jacoco/test/html',
                    reportFiles: 'index.html',
                    reportName: 'JaCoCo Report'
                ])
                sh './gradlew jacocoTestReport'
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
                    app = docker.build(${env.DOCKER_IMAGE})
                }
            }
        }
        stage('Docker push') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', ${DOCKER_HUB_CREDENTIAL_ID}) {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage("Deploy to staging") {
            steps {
                sh "docker container run -itd --rm -p 8765:8080 --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
            }
        }
        stage("Acceptance test") {
            steps {
                sleep 60
                sh './acceptance_test.sh'
            }
        }
    }   
    post {
        always {
            sh "docker container stop ${CONTAINER_NAME}"
        }
    }
}

