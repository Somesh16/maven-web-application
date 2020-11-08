node
{
    properties([pipelineTriggers([cron(''), pollSCM('* * * * *')])])
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
    
}
