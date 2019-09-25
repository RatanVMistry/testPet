pipeline {
    agent any
    stages {
        stage ('Clone') {
            steps {
                git branch: 'jfrog', url: "https://github.com/RatanVMistry/testPet.git"
            }
        }

        stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: "JFrogServer",
                    url: "https://ratraja30101.jfrog.io/ratraja30101",
                    credentialsId: jFrog
                )

                rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "JFrogServer",
                    releaseRepo: "libs-release-local",
                    snapshotRepo: "libs-snapshot-local"
                )

                rtMavenResolver (
                    id: "MAVEN_RESOLVER",
                    serverId: "JFrogServer",
                    releaseRepo: "libs-release",
                    snapshotRepo: "libs-snapshot"
                )
            }
        }

        stage ('Exec Maven') {
            steps {
                rtMavenRun (
                    tool: Maven3.6.2, // Tool name from Jenkins configuration
                    pom: 'pom.xml',
                    goals: 'clean install',
                    deployerId: "MAVEN_DEPLOYER",
                    resolverId: "MAVEN_RESOLVER"
                )
            }
        }

        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: "JFrogServer"
                )
            }
        }
    }
}
