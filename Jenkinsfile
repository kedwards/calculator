pipeline {
    agent any 
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/kedwards/calculator.git'
            }
        }
        stage("Compile") {
            steps {
                sh "./gradlew compileJava"
            }
        }
        stage('Build') { 
            steps {
                echo 'Build Stage' 
            }
        }
        stage('Test') { 
            steps {
                echo 'Test Stage' 
                script {
                    def browsers = ['chrome', 'firefox']
                    for (int i = 0; i < browsers.size(); ++i) {
                        echo "Testing the ${browsers[i]} browser."
                    }
                }
            }
        }
        stage("Unit test") {
            steps {
                sh "./gradlew test"
            }
        }
        stage('Deploy') { 
            steps {
                echo 'Deploy Stage' 
            }
        }
    }
}

