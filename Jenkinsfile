pipeline {
    agent any 
    triggers {
        pollSCM('* * * * *')
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/kedwards/calculator.git'
            }
        }
        stage("Static code analysis") {
            steps {
                sh "./gradlew checkstyleMain"
                publishHTML (target: [
                    reportDir: 'build/reports/checkstyle/',
                    reportFiles: 'main.html',
                    reportName: "Checkstyle Report"
                ])
            }
        }
        stage("Compile") {
            steps {
                sh "./gradlew compileJava"
            }
        }
        stage('Test') { 
            steps {
                script {
                    def browsers = ['chrome', 'firefox']
                    for (int i = 0; i < browsers.size(); ++i) {
                        echo "Testing the ${browsers[i]} browser."
                    }
                }
            }
        }
        stage("Code coverage") {
            steps {
                sh "./gradlew jacocoTestReport"
                publishHTML (target: [
                    reportDir: 'build/reports/jacoco/test/html',
                    reportFiles: 'index.html',
                    reportName: "JaCoCo Report"
                ])
                sh "./gradlew jacocoTestCoverageVerification"
            }
        }
		stage("Package") {
			 steps {
				  sh "./gradlew build"
			 }
		}

		stage("Docker build") {
			 steps {
				  sh "docker build -t kevinedwards/calculator ."
			 }
		}
		stage("Docker push") {
			 steps {
				  sh "docker push kevinedwards/calculator"
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

