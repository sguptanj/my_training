pipeline{
     agent any 
        stages{
            stage('Stage1: Print Details') {
                steps {
                        sh '''message1="Printing the user entered details"
                        echo $message1'''
                        sh 'echo $artifact_name'
                        sh 'echo $local_artifact_location'
                        sh 'echo $remote_server_location'
                        sh 'echo $host_server_name'
                      }
                }
            stage('Stage2: Deployment') {
                steps {
                        sh 'sudo cp $local_artifact_location/$artifact_name $remote_server_location/'
                        sh 'sudo service $host_server_name restart'
                      }
                }
        }
}
