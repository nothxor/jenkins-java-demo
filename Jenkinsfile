pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building with Gradle...'
                sh './gradlew build'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh './gradlew test'
            }
        }
        
        stage('Package') {
            steps {
                echo 'Creating JAR file...'
                sh './gradlew jar'
            }
        }
        
        stage('Archive') {
            steps {
                echo 'Archiving JAR file...'
                archiveArtifacts artifacts: 'build/libs/*.jar', allowEmptyArchive: false
            }
        }
        
        stage('Deploy Info') {
            steps {
                echo 'Application built successfully!'
                echo 'JAR file archived and ready for k3s deployment.'
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline completed!'
        }
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
