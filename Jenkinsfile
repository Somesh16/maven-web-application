node
{ 
    def mavenHome =tool name: "maven"
    stage('Checkout code from Github')
    {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '53bb0b77-07a1-4d97-b58d-d82c6563c5a7', url: 'https://github.com/Somesh16/maven-web-application.git']]])
    }
      stage('Compile the code')
    {
        sh "${mavenHome}/bin/mvn compile"
    }
    stage('Create Package')
    {
        sh "${mavenHome}/bin/mvn package"
    }
    stage('Code coverage check')
    {
        sh "${mavenHome}/bin/mvn sonar:sonar"
    }
    stage('Store build artifacts in artifactory repository')
    {
        sh "${mavenHome}/bin/mvn deploy"
    }
    stage('Deploy build artifacts to tomcat')
    {
         sshagent(['Tomcat_Credential'])
         {
             sh "scp -o StrictHostKeyChecking=No target/maven-web-application.war ec2-user@65.0.130.128:/opt/apache-tomcat-9.0.39/webapps"
         }
    } 
    stage('Creating docker image')
    {
        sshagent(['Docker'])
        {
            sh "scp -o StrictHostKeyChecking=no target/maven-web-application.war ubuntu@13.232.234.232:/home/ubuntu"
            sh "scp -o StrictHostKeyChecking=no Dockerfile ubuntu@13.232.234.232:/home/ubuntu"
            sh "ssh -o StrictHostKeyChecking=no ubuntu@13.232.234.232 docker build -t somesh16/myapp:${BUILD_NUMBER} ."
        }
    }
    stage('Login to dockerhub and pushing docker image')
    {
        sshagent(['Docker'])
        {
            withCredentials([string(credentialsId: 'Dockerhub', variable: 'Dockerhub')]) 
            {
                sh "ssh -o StrictHostKeyChecking=no ubuntu@13.232.234.232 docker login -u somesh16 -p ${Dockerhub}"
            }
            sh "ssh -o StrictHostKeyChecking=no ubuntu@13.232.234.232 docker push somesh16/myapp:${BUILD_NUMBER} "
        }
    }
}
        
  
    

