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
                    }
    
    def tasks = [:]

    tasks["task_1"] = {
    stage ("checkstyle"){    
        sh 'mvn checkstyle:checkstyle'
        cobertura autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: ' **/target/site/cobertura/coverage.xml', conditionalCoverageTargets: '70, 0, 0', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false
  }
}
    tasks["task_2"] = {
    stage ("cobertura"){    
        sh 'mvn cobertura:cobertura'
        scanForIssues tool: acuCobol(pattern: '**/target/checkstyle-result.xml')
  }
}
parallel tasks
}

