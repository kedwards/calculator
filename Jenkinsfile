pipeline {
    agent any 
    environment {
        refistry = 'kevinedwards/calculator'
        registryCredential = '83e59579-5712-456e-9e9e-7395ea744909'
    }
    triggers {
        pollSCM('H * * * *')
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
        stage('Test') { 
            steps {
                script {
                    def browsers = ['chrome', 'firefox']
                    for (int i = 0; i < browsers.size(); ++i) {
                        echo 'Testing the ${browsers[i]} browser.'
                    }
                }
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
                    dockerImage = docker.build registry + ':$BUILD_NUMBER'
                }
            }
        }
        stage('Docker push') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
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

