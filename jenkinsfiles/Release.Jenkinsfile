/*
 * Copyright 2025 gematik GmbH
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

@Library('gematik-jenkins-shared-library') _

def CHANNEL_ID = "19:5e4a353b87974bfca7ac6ac55ad7358b@thread.tacv2"
def GROUP_ID = "9c4c4366-476c-465d-8188-940f661574c3"
def branches = ['workshop/stage2', 'workshop/stage3', 'workshop/stage4', 'workshop/stage5', 'workshop/stage6', 'workshop/stage7', 'workshop/stage8', 'workshop/stage9', 'workshop/zion', 'workshop/rbelbuilder']

pipeline {
    options {
        disableConcurrentBuilds()
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5')
    }

    agent { label 'k8-backend-small' }

    tools {
        maven 'Default'
    }
    environment {
        JAVA_TOOL_OPTIONS = '-Xmx16g  -Xms1g -Dgwt.extraJvmArgs="-Xmx16g -Xms1g"'
    }

    parameters {
        choice(name: 'DRY_RUN', choices: ['NO', 'YES'], description: 'Execute the preparing steps but do not push anything.')
        choice(name: 'GITHUB', choices: ['YES', 'NO'], description: 'GitHub-Release wird ausgeführt.')
    }

    stages {
        stage('Initialise') {
            steps {
                useJdk('OPENJDK17')
            }
        }

        stage('GitHub-Release') {
            when {
                expression { params.GITHUB == 'YES' }
            }
            steps {
                script {
                    branches.each { branch ->
                        echo "Branchname:" + branch
                             build job: 'Tiger-tigerworkshop-GitHub-Release',
                                parameters: [
                                    string(name: 'GITLAB_TAG', value: String.valueOf(branch)),
                                    text(name: 'COMMIT_MESSAGE', value: String.valueOf("1.0.0")),
                                    text(name: 'REMOTE_BRANCH', value: String.valueOf(branch)),
                                    string(name: 'AUTOMATIC_MERGE', value: String.valueOf("YES")),
                                    string(name: 'GITHUB_TAG', value: String.valueOf(branch + "-1.0.0")),
                                ]
                    }
                }
            }
        }
    }
    post {
        always {
            sendEMailNotification(getTigerEMailList())
        }
        success {
            teamsSendNotificationToChannel(CHANNEL_ID, GROUP_ID)
        }
    }
}
