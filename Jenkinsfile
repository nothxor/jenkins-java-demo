pipeline {
    agent {
        kubernetes {
            yaml '''
                apiVersion: v1
                kind: Pod
                spec:
                  containers:
                  - name: gradle
                    image: gradle:8-jdk17
                    command:
                    - sleep
                    args:
                    - 99d
                  - name: kubectl
                    image: bitnami/kubectl:latest
                    command:
                    - sleep
                    args:
                    - 99d
            '''
        }
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo "Checked out code from ${env.GIT_BRANCH}"
            }
        }
        
        stage('Build') {
            steps {
                container('gradle') {
                    sh './gradlew clean build -x test'
                    echo 'Build completed successfully'
                }
            }
        }
        
        stage('Test') {
            steps {
                container('gradle') {
                    sh './gradlew test'
                    echo 'Tests completed'
                }
            }
        }
        
        stage('Package') {
            steps {
                container('gradle') {
                    sh './gradlew jar'
                    echo 'JAR packaging completed'
                }
            }
        }
        
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'build/libs/*.jar', 
                                fingerprint: true,
                                allowEmptyArchive: false
                echo 'Artifacts archived successfully'
            }
        }
        
        stage('Deploy to k3s') {
            when {
                branch 'main'
            }
            steps {
                container('kubectl') {
                    sh '''
                        kubectl apply -f k3s-manifests/java-demo-deployment.yaml
                        kubectl rollout restart deployment/java-demo
                        kubectl rollout status deployment/java-demo --timeout=300s
                        echo "Deployment completed!"
                    '''
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}
