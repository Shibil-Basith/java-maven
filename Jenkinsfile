pipeline {

    agent none

    stages {

        stage("build") {
            agent {
                label 'built-in'
            }
            steps {
                git branch: 'main', url: 'https://github.com/Shibil-Basith/java-maven.git'
                sh "mvn clean package"
                stash name: 'build', includes: 'target/*.war'
            }
        }

        stage('deploy') {
            agent {
                label 'slave'
            }
            steps {
                unstash 'build'
                sh "mv target/*.war target/ROOT.war"
                sh "cp target/ROOT.war /opt/tomcat/webapps/"
            }
        }

    }
}
