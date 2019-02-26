pipeline {
    agent any 
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('83e59579-5712-456e-9e9e-7395ea744909')
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
                    app = docker.build('kevinedwards/calculator')
                }
            }
        }
        stage('Docker push') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', '83e59579-5712-456e-9e9e-7395ea744909') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('Deploy') { 
            steps {
                echo 'Deploy Stage' 
            }
        }
    }   
    post {
        always {
            echo 'mail to somebody here'
        }
    }
}

