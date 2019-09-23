pipeline {

    agent any
    tools { 
        maven 'Maven 3.5.3' 
        jdk 'jdk8' 
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }
            stage ('Build') {
            steps {
                sh 'mvn -Dmaven.test.skip=true clean package' 
            }
        }
			stage ('Build image') {
	        /* This builds the actual image; synonymous to
	         * docker build on the command line */
	         steps {
	        	sh "docker build -t ratan/petclinic:${env.BUILD_ID} ."
			sh "docker tag ratan/petclinic:${env.BUILD_ID} ratanmistry3010/petclinic:latest"
	         }

	    }
			stage ('Push image') {
		        /* Finally, we'll push the image with two tags:
		         * First, the incremental build number from Jenkins
		         * Second, the 'latest' tag.
		         * Pushing multiple tags is cheap, as all the layers are reused. */
		         steps {
		         	withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        			sh "docker login -u ${USERNAME} -p ${PASSWORD}"
        			sh "docker push ratanmistry3010/petclinic:latest"
      				}
		        }
		        
		    }

    }
 }
