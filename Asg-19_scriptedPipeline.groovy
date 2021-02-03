node{
    stage('Stage1: Clone') {
                        sh '''message1="cloning the git repository"
                        echo $message1'''
                        git credentialsId: 'eccf8fd4-b099-4a7e-8774-9dc5638b730e', url: 'https://gitlab.com/sidhharth.gupta/samplejavaproject.git'
                    }
    stage ('Stage2: Maven Build'){
                    sh '''message2="Maven Activities performed"
                    echo $message2'''
                    sh 'mvn package'
                    sh 'mvn site'
                    sh 'mvn checkstyle:checkstyle'
                    sh 'mvn cobertura:cobertura'
                    }
    stage ('Stage3: Generate Reports'){
                    sh '''message3="Generating the reports"
                    echo $message3'''
                    scanForIssues tool: acuCobol(pattern: '**/target/checkstyle-result.xml')
                    scanForIssues tool: checkStyle(pattern: '**/checkstyle-result.xml')
                    cobertura autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: ' **/target/site/cobertura/coverage.xml', conditionalCoverageTargets: '70, 0, 0', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false
                }
    stage ('Stage4: Archive Jar'){
                    sh '''message3="Archive the jar files"
                    echo $message3'''
                    archiveArtifacts artifacts: '**/target/sourceCode-0.0.1-SNAPSHOT.jar'
                }
}
