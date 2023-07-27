library 'reference-pipeline'
library 'AppServiceAccount'
//library 'CICD-FOSS-V2'

pipeline {
    agent any
    parameters {
        choice(name: 'ENVIRONMENT', choices: 'None\nL2\nL3\nL4\nL3DR', description: 'Target Environment')
        choice(name: 'ACTION', choices: 'None\ndeploy weblogic\nstart weblogic\nrestart weblogic\nundeploy weblogic\nstop weblogic\nclean weblogic\nmigration data\nNM Script', description: 'Target Action')
    }
    tools {
        jdk 'JAVA_8'
        maven 'Maven 3.3.3'
    }
    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '20'))
    }
    environment {
        EAI_NUMBER = "28"
        EAI_NAME = "Gencore"
        NEXUS_URL="nexus.prod.cloud.fedex.com:8443/nexus"
        NEXUS_CREDS_ID="5337855_Account"
        NEXUS_URL_VERSION="nexus3"
        SVC_ACCT_LOGIN = credentials('28')
        SVC_ACCT_LOGIN_USER="${SVC_ACCT_LOGIN_USER}"
        SVC_ACCT_LOGIN_PASS="${SVC_ACCT_LOGIN_PASS}"
        NEXUSIQ_NAME = "APP28"
        GIT_BRANCH = "${env.BRANCH_NAME}"
        SSH_OPTIONS='-oStrictHostKeyChecking=no -oBatchMode=yes -oLogLevel=error -oUserKnownHostsFile=/dev/null'
        SSH_AGENT="hermes-keyper_app28_devtest_gencore"
        SSH_USER="gencore"
        //CloudOps Provisioning Config
        OKTA_CREDS=credentials('okta_app28')
        S3_CREDS=credentials('s3_app28')
        MF_BROKER="mf-broker.app.paas.fedex.com"
        S3_ENDPOINT="https://s3-cf.ecs.ute.fedex.com"
        ISSUER="https://purpleid.okta.com/oauth2/aus9s4vjt7GKaQnPf357/v1/token?grant_type=client_credentials&response_type=token"
        PROXY="internet.proxy.fedex.com:3128"
        //PIPELINE_STATUS_EMAIL="4582579@fedex.com,4534517@fedex.com"
        DOMAIN_CREDS_NONPROD=credentials('gencore_weblogic_nonprod')
        L4_DB_CREDS=credentials('L4_DB_CREDS')
        L4_DB_URL_1=credentials('L4_DB_URL_1')
        L4_DB_URL_2=credentials('L4_DB_URL_2')
        L3_DB_URL_1=credentials('L3_DB_URL_1')
        L3_DB_URL_2=credentials('L3_DB_URL_2')
    }

stages {
  stage('Checkout') {
      steps {
          checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: '*/condor_migration_Gencore']], extensions: [], userRemoteConfigs: [[credentialsId: 'GENCORE28', url: 'git@github.com:FedEx/eai-28-dmi.git']]]
      }
  }
  stage('checkoutJMSlib') {
    steps{
	  	dir('jmslib'){
	         checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: '*/classpath_Jars']], extensions: [], userRemoteConfigs: [[credentialsId: 'GENCORE28', url: 'git@github.com:FedEx/eai-28-GenesisJmsLib.git']]]
             }
		 	}
    } //End of checkout Stage
    stage('checkout-Migration-Data') {
      when {                
				    anyOf {
		  		    environment name: 'ACTION', value: 'migration data'
              environment name: 'ACTION', value: 'deploy weblogic'
              environment name: 'ACTION', value: 'undeploy weblogic'
				    }
				  }
    steps{
	  	dir('migration-data'){
	         checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GENCORE28', url: 'git@github.com:FedEx/eai-28-SecurityRealm.git']]]
             }
		 	}
    } //End of checkout Stage
        stage('Environment') {
            steps {
                script {
                    switch(ENVIRONMENT) {
                        case 'L2' :
                            env.WLVM_TARGET_SERVERS='u1062091.test.cloud.fedex.com,u1062084.test.cloud.fedex.com,u1062083.test.cloud.fedex.com,u1062085.test.cloud.fedex.com,u1061786.test.cloud.fedex.com,u1062357.test.cloud.fedex.com,u1062358.test.cloud.fedex.com'
                            env.WLVM_ADMIN_HOST='u1062091.test.cloud.fedex.com'
                            env.WLVM_CORE_SERVERS='u1062091.test.cloud.fedex.com,u1062084.test.cloud.fedex.com,u1062083.test.cloud.fedex.com,u1062085.test.cloud.fedex.com'
                            env.WLVM_DATAENTRY_SERVERS='u1061786.test.cloud.fedex.com'
                            env.WLVM_RECOG_SERVERS='u1062357.test.cloud.fedex.com'
                            env.WLVM_SCAN_SERVERS='u1062358.test.cloud.fedex.com'
                            env.WLVM_TARGET_JRE='/opt/fedex/genesis/java8_current'
                            env.WLVM_TARGET_ORACLE='/opt/fedex/genesis/wl12214_current'
                            env.WLVM_TARGET_WLS="${WLVM_TARGET_ORACLE}/wlserver"
                            env.WLVM_TARGET_OPT='/opt/fedex/genesis'
                            env.WLVM_CORE_OPT="${WLVM_TARGET_OPT}/gencore"
                            env.WLVM_DATAENTRY_OPT="${WLVM_TARGET_OPT}/gendataentry"
                            env.WLVM_RECOG_OPT="${WLVM_TARGET_OPT}/genrecog"
                            env.WLVM_SCAN_OPT="${WLVM_TARGET_OPT}/genscan"
                            env.WLVM_TARGET_VAR='/var/fedex/genesis'
                            env.WLVM_CORE_VAR="${WLVM_TARGET_VAR}/gencore"
                            env.WLVM_DATAENTRY_VAR="${WLVM_TARGET_VAR}/gendataentry"
                            env.WLVM_RECOG_VAR="${WLVM_TARGET_VAR}/genrecog"
                            env.WLVM_SCAN_VAR="${WLVM_TARGET_VAR}/genscan"
                            env.WLVM_CORE_TMP="${WLVM_CORE_VAR}/tmp"
                            env.WLVM_DATAENTRY_TMP="${WLVM_DATAENTRY_VAR}/tmp"
                            env.WLVM_RECOG_TMP="${WLVM_RECOG_VAR}/tmp"
                            env.WLVM_SCAN_TMP="${WLVM_SCAN_VAR}/tmp"
                            env.WLVM_DOMAIN_NAME='genintl'
                            env.WLVM_CORE_DOMAIN_PARENT="${WLVM_CORE_OPT}/current"
                            env.WLVM_CORE_DOMAIN_HOME="${WLVM_CORE_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_DATAENTRY_DOMAIN_PARENT="${WLVM_DATAENTRY_OPT}/current"
                            env.WLVM_DATAENTRY_DOMAIN_HOME="${WLVM_DATAENTRY_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_RECOG_DOMAIN_PARENT="${WLVM_RECOG_OPT}/current"
                            env.WLVM_RECOG_DOMAIN_HOME="${WLVM_RECOG_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_SCAN_DOMAIN_PARENT="${WLVM_SCAN_OPT}/current"
                            env.WLVM_SCAN_DOMAIN_HOME="${WLVM_SCAN_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_SSH_AGENT='hermes-keyper_app28_devtest_gencore'
                            env.WLVM_SSH_AGENT_DATAENTRY='gendataentry_ssh_key'
                            env.WLVM_SSH_AGENT_GENRECOG='genrecog_ssh_key'
                            env.WLVM_SSH_AGENT_GENSCAN='genscan_ssh_key'
                            env.CORE_CLOUDOPS_HOSTS='u1062091.test.cloud.fedex.com,u1062084.test.cloud.fedex.com,u1062083.test.cloud.fedex.com,u1062085.test.cloud.fedex.com'
                            env.DATAENTRY_CLOUDOPS_HOSTS='u1061786.test.cloud.fedex.com'
                            env.RECOG_CLOUDOPS_HOSTS='u1062357.test.cloud.fedex.com'
                            env.SCAN_CLOUDOPS_HOSTS='u1062358.test.cloud.fedex.com'
                            env.WLVM_SSH_USER='gencore'
                            env.WLVM_SSH_USER_DATAENTRY='gendataentry'
                            env.WLVM_SSH_USER_RECOG='genrecog'
                            env.WLVM_SSH_USER_SCAN='genscan'
                            env.WLVM_TF_WORKSPACE='L2'
                            env.WLVM_SERVER_MANAGED_PORT=7261
                            env.WLVM_TARGET='L2'
                            env.WLVM_SERVER_APPD=false
                            env.WLVM_DOMAIN_USERNAME="${DOMAIN_CREDS_NONPROD_USR}"
                            env.WLVM_DOMAIN_PASSWORD="${DOMAIN_CREDS_NONPROD_PSW}"
                            env.WLVM_CORE_SERVER_MANAGED_PREFIX='gencore'
                            env.WLVM_DATAENTRY_SERVER_MANAGED_PREFIX='gendataentry'
                            env.WLVM_RECOG_SERVER_MANAGED_PREFIX='genrecog'
                            env.WLVM_SCAN_SERVER_MANAGED_PREFIX='genscan'
                            env.DB_PWD_STG="${L4_DB_CREDS_PSW}"
                        break

                        case 'L3' :
                            env.WLVM_TARGET_SERVERS='u1051234.test.cloud.fedex.com,u1051185.test.cloud.fedex.com,u1051186.test.cloud.fedex.com,u1051187.test.cloud.fedex.com,u1059752.test.cloud.fedex.com,u1059753.test.cloud.fedex.com,u1059755.test.cloud.fedex.com,u1061897.test.cloud.fedex.com,u1061896.test.cloud.fedex.com,u1051543.test.cloud.fedex.com,u1060036.test.cloud.fedex.com,u1062263.test.cloud.fedex.com,u1062264.test.cloud.fedex.com'
                            env.WLVM_ADMIN_HOST='u1051234.test.cloud.fedex.com'
                            env.WLVM_CORE_SERVERS='u1051234.test.cloud.fedex.com,u1051185.test.cloud.fedex.com,u1051186.test.cloud.fedex.com,u1051187.test.cloud.fedex.com,u1059752.test.cloud.fedex.com,u1059753.test.cloud.fedex.com,u1059755.test.cloud.fedex.com'
                            env.WLVM_DATAENTRY_SERVERS='u1061897.test.cloud.fedex.com,u1061896.test.cloud.fedex.com'
                            env.WLVM_RECOG_SERVERS='u1051543.test.cloud.fedex.com,u1060036.test.cloud.fedex.com'
                            env.WLVM_SCAN_SERVERS='u1062263.test.cloud.fedex.com,u1062264.test.cloud.fedex.com'
                            env.WLVM_TARGET_JRE='/opt/fedex/genesis/java8_current'
                            env.WLVM_TARGET_ORACLE='/opt/fedex/genesis/wl12214_current'
                            env.WLVM_TARGET_WLS="${WLVM_TARGET_ORACLE}/wlserver"
                            env.WLVM_TARGET_OPT='/opt/fedex/genesis'
                            env.WLVM_CORE_OPT="${WLVM_TARGET_OPT}/gencore"
                            env.WLVM_DATAENTRY_OPT="${WLVM_TARGET_OPT}/gendataentry"
                            env.WLVM_RECOG_OPT="${WLVM_TARGET_OPT}/genrecog"
                            env.WLVM_SCAN_OPT="${WLVM_TARGET_OPT}/genscan"
                            env.WLVM_TARGET_VAR='/var/fedex/genesis'
                            env.WLVM_CORE_VAR="${WLVM_TARGET_VAR}/gencore"
                            env.WLVM_DATAENTRY_VAR="${WLVM_TARGET_VAR}/gendataentry"
                            env.WLVM_RECOG_VAR="${WLVM_TARGET_VAR}/genrecog"
                            env.WLVM_SCAN_VAR="${WLVM_TARGET_VAR}/genscan"
                            env.WLVM_CORE_TMP="${WLVM_CORE_VAR}/tmp"
                            env.WLVM_DATAENTRY_TMP="${WLVM_DATAENTRY_VAR}/tmp"
                            env.WLVM_RECOG_TMP="${WLVM_RECOG_VAR}/tmp"
                            env.WLVM_SCAN_TMP="${WLVM_SCAN_VAR}/tmp"
                            env.WLVM_DOMAIN_NAME='genintl'
                            env.WLVM_CORE_DOMAIN_PARENT="${WLVM_CORE_OPT}/current"
                            env.WLVM_CORE_DOMAIN_HOME="${WLVM_CORE_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_DATAENTRY_DOMAIN_PARENT="${WLVM_DATAENTRY_OPT}/current"
                            env.WLVM_DATAENTRY_DOMAIN_HOME="${WLVM_DATAENTRY_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_RECOG_DOMAIN_PARENT="${WLVM_RECOG_OPT}/current"
                            env.WLVM_RECOG_DOMAIN_HOME="${WLVM_RECOG_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_SCAN_DOMAIN_PARENT="${WLVM_SCAN_OPT}/current"
                            env.WLVM_SCAN_DOMAIN_HOME="${WLVM_SCAN_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_SSH_AGENT='hermes-keyper_app28_devtest_gencore'
                            env.WLVM_SSH_AGENT_DATAENTRY='gendataentry_ssh_key'
                            env.WLVM_SSH_AGENT_GENRECOG='genrecog_ssh_key'
                            env.WLVM_SSH_AGENT_GENSCAN='genscan_ssh_key'
                            env.CORE_CLOUDOPS_HOSTS='u1051234.test.cloud.fedex.com,u1051185.test.cloud.fedex.com,u1051186.test.cloud.fedex.com,u1051187.test.cloud.fedex.com,u1059752.test.cloud.fedex.com,u1059753.test.cloud.fedex.com,u1059755.test.cloud.fedex.com'
                            env.DATAENTRY_CLOUDOPS_HOSTS='u1061897.test.cloud.fedex.com,u1061896.test.cloud.fedex.com'
                            env.RECOG_CLOUDOPS_HOSTS='u1051543.test.cloud.fedex.com,u1060036.test.cloud.fedex.com'
                            env.SCAN_CLOUDOPS_HOSTS='u1062263.test.cloud.fedex.com,u1062264.test.cloud.fedex.com'
                            env.WLVM_SSH_USER='gencore'
                            env.WLVM_SSH_USER_DATAENTRY='gendataentry'
                            env.WLVM_SSH_USER_RECOG='genrecog'
                            env.WLVM_SSH_USER_SCAN='genscan'
                            env.WLVM_TF_WORKSPACE='L3'
                            env.WLVM_SERVER_MANAGED_PORT=7261
                            env.WLVM_TARGET='L3'
                            env.WLVM_SERVER_APPD=true
                            env.WLVM_DOMAIN_USERNAME="${DOMAIN_CREDS_NONPROD_USR}"
                            env.WLVM_DOMAIN_PASSWORD="${DOMAIN_CREDS_NONPROD_PSW}"
                            env.WLVM_CORE_SERVER_MANAGED_PREFIX='gencore'
                            env.WLVM_DATAENTRY_SERVER_MANAGED_PREFIX='gendataentry'
                            env.WLVM_RECOG_SERVER_MANAGED_PREFIX='genrecog'
                            env.WLVM_SCAN_SERVER_MANAGED_PREFIX='genscan'
                            env.DB_PWD_STG="${L4_DB_CREDS_PSW}"
                            env.DB_URL_1="${L3_DB_URL_1}"
                            env.DB_URL_2="${L3_DB_URL_2}"
                        break

                        case 'L3DR' :
                            env.WLVM_TARGET_SERVERS='u1064019.test.cloud.fedex.com,u1062290.test.cloud.fedex.com,u1062291.test.cloud.fedex.com,u1062292.test.cloud.fedex.com,u1062293.test.cloud.fedex.com,u1062294.test.cloud.fedex.com,u1062295.test.cloud.fedex.com,u1062012.test.cloud.fedex.com,u1062015.test.cloud.fedex.com,u1064020.test.cloud.fedex.com,u1064021.test.cloud.fedex.com,u1061744.test.cloud.fedex.com,u1061746.test.cloud.fedex.com'
                            env.WLVM_ADMIN_HOST='u1064019.test.cloud.fedex.com'
                            env.WLVM_CORE_SERVERS='u1064019.test.cloud.fedex.com,u1062290.test.cloud.fedex.com,u1062291.test.cloud.fedex.com,u1062292.test.cloud.fedex.com,u1062293.test.cloud.fedex.com,u1062294.test.cloud.fedex.com,u1062295.test.cloud.fedex.com'
                            env.WLVM_DATAENTRY_SERVERS='u1062012.test.cloud.fedex.com,u1062015.test.cloud.fedex.com'
                            env.WLVM_RECOG_SERVERS='u1064020.test.cloud.fedex.com,u1064021.test.cloud.fedex.com'
                            env.WLVM_SCAN_SERVERS='u1061744.test.cloud.fedex.com,u1061746.test.cloud.fedex.com'
                            env.WLVM_TARGET_JRE='/opt/fedex/genesis/java8_current'
                            env.WLVM_TARGET_ORACLE='/opt/fedex/genesis/wl12214_current'
                            env.WLVM_TARGET_WLS="${WLVM_TARGET_ORACLE}/wlserver"
                            env.WLVM_TARGET_OPT='/opt/fedex/genesis'
                            env.WLVM_CORE_OPT="${WLVM_TARGET_OPT}/gencore"
                            env.WLVM_DATAENTRY_OPT="${WLVM_TARGET_OPT}/gendataentry"
                            env.WLVM_RECOG_OPT="${WLVM_TARGET_OPT}/genrecog"
                            env.WLVM_SCAN_OPT="${WLVM_TARGET_OPT}/genscan"
                            env.WLVM_TARGET_VAR='/var/fedex/genesis'
                            env.WLVM_CORE_VAR="${WLVM_TARGET_VAR}/gencore"
                            env.WLVM_DATAENTRY_VAR="${WLVM_TARGET_VAR}/gendataentry"
                            env.WLVM_RECOG_VAR="${WLVM_TARGET_VAR}/genrecog"
                            env.WLVM_SCAN_VAR="${WLVM_TARGET_VAR}/genscan"
                            env.WLVM_CORE_TMP="${WLVM_CORE_VAR}/tmp"
                            env.WLVM_DATAENTRY_TMP="${WLVM_DATAENTRY_VAR}/tmp"
                            env.WLVM_RECOG_TMP="${WLVM_RECOG_VAR}/tmp"
                            env.WLVM_SCAN_TMP="${WLVM_SCAN_VAR}/tmp"
                            env.WLVM_DOMAIN_NAME='genintl'
                            env.WLVM_CORE_DOMAIN_PARENT="${WLVM_CORE_OPT}/current"
                            env.WLVM_CORE_DOMAIN_HOME="${WLVM_CORE_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_DATAENTRY_DOMAIN_PARENT="${WLVM_DATAENTRY_OPT}/current"
                            env.WLVM_DATAENTRY_DOMAIN_HOME="${WLVM_DATAENTRY_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_RECOG_DOMAIN_PARENT="${WLVM_RECOG_OPT}/current"
                            env.WLVM_RECOG_DOMAIN_HOME="${WLVM_RECOG_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_SCAN_DOMAIN_PARENT="${WLVM_SCAN_OPT}/current"
                            env.WLVM_SCAN_DOMAIN_HOME="${WLVM_SCAN_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_SSH_AGENT='hermes-keyper_app28_devtest_gencore'
                            env.WLVM_SSH_AGENT_DATAENTRY='gendataentry_ssh_key'
                            env.WLVM_SSH_AGENT_GENRECOG='genrecog_ssh_key'
                            env.WLVM_SSH_AGENT_GENSCAN='genscan_ssh_key'
                            env.CORE_CLOUDOPS_HOSTS='u1064019.test.cloud.fedex.com,u1062290.test.cloud.fedex.com,u1062291.test.cloud.fedex.com,u1062292.test.cloud.fedex.com,u1062293.test.cloud.fedex.com,u1062294.test.cloud.fedex.com,u1062295.test.cloud.fedex.com'
                            env.DATAENTRY_CLOUDOPS_HOSTS='u1062012.test.cloud.fedex.com,u1062015.test.cloud.fedex.com'
                            env.RECOG_CLOUDOPS_HOSTS='u1064020.test.cloud.fedex.com,u1064021.test.cloud.fedex.com'
                            env.SCAN_CLOUDOPS_HOSTS='u1061744.test.cloud.fedex.com,u1061746.test.cloud.fedex.com'
                            env.WLVM_SSH_USER='gencore'
                            env.WLVM_SSH_USER_DATAENTRY='gendataentry'
                            env.WLVM_SSH_USER_RECOG='genrecog'
                            env.WLVM_SSH_USER_SCAN='genscan'
                            env.WLVM_TF_WORKSPACE='L3DR'
                            env.WLVM_SERVER_MANAGED_PORT=7261
                            env.WLVM_TARGET='L3DR'
                            env.WLVM_SERVER_APPD=false
                            env.WLVM_DOMAIN_USERNAME="${DOMAIN_CREDS_NONPROD_USR}"
                            env.WLVM_DOMAIN_PASSWORD="${DOMAIN_CREDS_NONPROD_PSW}"
                            env.WLVM_CORE_SERVER_MANAGED_PREFIX='gencore'
                            env.WLVM_DATAENTRY_SERVER_MANAGED_PREFIX='gendataentry'
                            env.WLVM_RECOG_SERVER_MANAGED_PREFIX='genrecog'
                            env.WLVM_SCAN_SERVER_MANAGED_PREFIX='genscan'
                            env.DB_PWD_STG="${L4_DB_CREDS_PSW}"
                        break

                        case 'L4' :
                            env.WLVM_TARGET_SERVERS='u1063962.test.cloud.fedex.com,u1063956.test.cloud.fedex.com,u1063414.test.cloud.fedex.com,u1063717.test.cloud.fedex.com,u1065001.test.cloud.fedex.com,u1064127.test.cloud.fedex.com,u1064128.test.cloud.fedex.com'
                            env.WLVM_CORE_SERVERS='u1063962.test.cloud.fedex.com,u1063956.test.cloud.fedex.com,u1063414.test.cloud.fedex.com,u1063717.test.cloud.fedex.com'
                            env.WLVM_ADMIN_HOST='u1063962.test.cloud.fedex.com'
                            env.WLVM_DATAENTRY_SERVERS='u1065001.test.cloud.fedex.com'
                            env.WLVM_RECOG_SERVERS='u1064127.test.cloud.fedex.com'
                            env.WLVM_SCAN_SERVERS='u1064128.test.cloud.fedex.com'
                            env.WLVM_TARGET_JRE='/opt/fedex/genesis/java8_current'
                            env.WLVM_TARGET_ORACLE='/opt/fedex/genesis/wl12214_current'
                            env.WLVM_TARGET_WLS="${WLVM_TARGET_ORACLE}/wlserver"
                            env.WLVM_TARGET_OPT='/opt/fedex/genesis'
                            env.WLVM_CORE_OPT="${WLVM_TARGET_OPT}/gencore"
                            env.WLVM_DATAENTRY_OPT="${WLVM_TARGET_OPT}/gendataentry"
                            env.WLVM_RECOG_OPT="${WLVM_TARGET_OPT}/genrecog"
                            env.WLVM_SCAN_OPT="${WLVM_TARGET_OPT}/genscan"
                            env.WLVM_TARGET_VAR='/var/fedex/genesis'
                            env.WLVM_CORE_VAR="${WLVM_TARGET_VAR}/gencore"
                            env.WLVM_DATAENTRY_VAR="${WLVM_TARGET_VAR}/gendataentry"
                            env.WLVM_RECOG_VAR="${WLVM_TARGET_VAR}/genrecog"
                            env.WLVM_SCAN_VAR="${WLVM_TARGET_VAR}/genscan"
                            env.WLVM_CORE_TMP="${WLVM_CORE_VAR}/tmp"
                            env.WLVM_DATAENTRY_TMP="${WLVM_DATAENTRY_VAR}/tmp"
                            env.WLVM_RECOG_TMP="${WLVM_RECOG_VAR}/tmp"
                            env.WLVM_SCAN_TMP="${WLVM_SCAN_VAR}/tmp"
                            env.WLVM_DOMAIN_NAME='genintl'
                            env.WLVM_CORE_DOMAIN_PARENT="${WLVM_CORE_OPT}/current"
                            env.WLVM_CORE_DOMAIN_HOME="${WLVM_CORE_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_DATAENTRY_DOMAIN_PARENT="${WLVM_DATAENTRY_OPT}/current"
                            env.WLVM_DATAENTRY_DOMAIN_HOME="${WLVM_DATAENTRY_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_RECOG_DOMAIN_PARENT="${WLVM_RECOG_OPT}/current"
                            env.WLVM_RECOG_DOMAIN_HOME="${WLVM_RECOG_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_SCAN_DOMAIN_PARENT="${WLVM_SCAN_OPT}/current"
                            env.WLVM_SCAN_DOMAIN_HOME="${WLVM_SCAN_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                            env.WLVM_SSH_AGENT='hermes-keyper_app28_devtest_gencore'
                            env.WLVM_SSH_AGENT_DATAENTRY='gendataentry_ssh_key'
                            env.WLVM_SSH_AGENT_GENRECOG='genrecog_ssh_key'
                            env.WLVM_SSH_AGENT_GENSCAN='genscan_ssh_key'
                            env.CORE_CLOUDOPS_HOSTS='u1063962.test.cloud.fedex.com,u1063956.test.cloud.fedex.com,u1063414.test.cloud.fedex.com,u1063717.test.cloud.fedex.com'
                            env.DATAENTRY_CLOUDOPS_HOSTS='u1065001.test.cloud.fedex.com'
                            env.RECOG_CLOUDOPS_HOSTS='u1064127.test.cloud.fedex.com'
                            env.SCAN_CLOUDOPS_HOSTS='u1064128.test.cloud.fedex.com'
                            env.WLVM_SSH_USER='gencore'
                            env.WLVM_SSH_USER_DATAENTRY='gendataentry'
                            env.WLVM_SSH_USER_RECOG='genrecog'
                            env.WLVM_SSH_USER_SCAN='genscan'
                            env.WLVM_TF_WORKSPACE='L4'
                            env.WLVM_SERVER_MANAGED_PORT=7261
                            env.WLVM_TARGET='L4'
                            env.WLVM_SERVER_APPD=false
                            env.WLVM_DOMAIN_USERNAME="${DOMAIN_CREDS_NONPROD_USR}"
                            env.WLVM_DOMAIN_PASSWORD="${DOMAIN_CREDS_NONPROD_PSW}"
                            env.WLVM_CORE_SERVER_MANAGED_PREFIX='gencore'
                            env.WLVM_DATAENTRY_SERVER_MANAGED_PREFIX='gendataentry'
                            env.WLVM_RECOG_SERVER_MANAGED_PREFIX='genrecog'
                            env.WLVM_SCAN_SERVER_MANAGED_PREFIX='genscan'
                            env.DB_PWD_STG="${L4_DB_CREDS_PSW}"
                            env.DB_URL_1="${L4_DB_URL_1}"
                            env.DB_URL_2="${L4_DB_URL_2}"
                        break
                    }
                    env.WLVM_ROOT="${WORKSPACE}"
                    env.WLVM_HOME="${WLVM_ROOT}/wlvm"
                    env.WLVM_PACKAGE="${WLVM_HOME}/package"
                    env.WLVM_PACKAGE_TOOL='wdt'
                    env.WLVM_PACKAGE_SECRET_WDT='mysupersecret'
                    env.WLVM_PACKAGE_SECRET_WLST="${WLVM_HOME}/etc/c2sSecretWlstgencoreain" 
                    env.POM_VERSION=2243
                    //env.WLVM_DOMAIN_PARENT="${WLVM_TARGET_OPT}/current"
                    //env.WLVM_DOMAIN_HOME="${WLVM_DOMAIN_PARENT}/${WLVM_DOMAIN_NAME}"
                    env.WLVM_DOMAIN_PRODUCTION=false
                    env.WLVM_DOMAIN_TARGET='gencore-alpha,gencore-bravo,gencore-charlie,gendataentry,genrecog,genscan' 
                    env.WLVM_SERVER_ADMIN_NAME='genadmin' 
                    env.WLVM_SERVER_ADMIN_PORT=9901
                    WLVM_SERVER_MANAGED_PORT=7260
                    env.WLVM_SERVER_LOG=true
                    env.WLVM_APP_EAI="${EAI_NUMBER}"
                    env.WLVM_APP_VERSION='0.0.1'
                    env.WLVM_CONTROL_KILL=30

                    println '======================= UPDATED ENVIRONMENT VARS  ======================='
                    sh 'env | sort'
                    println '^^^^^^^^^^^^^^^^^^^^^^^ UPDATED ENVIRONMENT VARS  ^^^^^^^^^^^^^^^^^^^^^^^'  
                    println '======================= UPDATING DIRECTORY PERMISSIONS  ======================='
                    sh 'chmod 775 *'
                    println '^^^^^^^^^^^^^^^^^^^^^^^UPDATING DIRECTORY PERMISSIONS  ^^^^^^^^^^^^^^^^^^^^^^^'
                }
            }
        }
        stage('Update Files with env Level') {
            when {
                anyOf {
                    environment name: 'ACTION', value: 'deploy weblogic'
                }
            }
            steps {
                script {
                    sh '''
                        if [ ${ENVIRONMENT} == L2 ] 
                        then
                            cp ./model/model_L2.yaml ./domain/wdt/model.yaml
                            cp ./config_py/config_l2.py ./domain/wlst/config.py
                            cp ./domain/bin/L2_package-wdt.sh ./wlvm/package-wdt.sh
                            
                        elif [ ${ENVIRONMENT} == L3 ]
                        then
                            cp ./model/model_L3.yaml ./domain/wdt/model.yaml
                            cp ./config_py/config_l3.py ./domain/wlst/config.py
                        elif [ ${ENVIRONMENT} == L3DR ]
                        then
                            cp ./model/model_L3DR.yaml ./domain/wdt/model.yaml
                            cp ./config_py/config_l3DR.py ./domain/wlst/config.py
			    cp ./domain/bin/L3DR_package-wdt.sh ./wlvm/package-wdt.sh
                        elif [ ${ENVIRONMENT} == L4 ]
                        then
                            cp ./model/model_L4.yaml ./domain/wdt/model.yaml
                            cp ./config_py/config_l4.py ./domain/wlst/config.py
                            cp ./domain/bin/L4_package-wdt.sh ./wlvm/package-wdt.sh
                        fi
                    '''
                }
            }
        }
        stage("Directory"){
            when {
                anyOf {        
                    environment name: 'ACTION', value: 'deploy weblogic'
                }
            }
            steps{
                println("===================Creating GenCore Directory structure ==================")
                gencoreDirectory("${WLVM_SSH_AGENT}", "${WLVM_SSH_USER}", "${SSH_OPTIONS}", "${CORE_CLOUDOPS_HOSTS}") 
                println("===================Creating GenDataentry Directory structure ==================")
                gendataentryDirectory("${WLVM_SSH_AGENT_DATAENTRY}", "${WLVM_SSH_USER_DATAENTRY}", "${SSH_OPTIONS}", "${DATAENTRY_CLOUDOPS_HOSTS}")
                println("===================Creating GenRecog Directory structure ==================")
                genrecogDirectory("${WLVM_SSH_AGENT_GENRECOG}", "${WLVM_SSH_USER_RECOG}", "${SSH_OPTIONS}", "${RECOG_CLOUDOPS_HOSTS}")
                println("===================Creating GenScan Directory structure ==================")
                genscanDirectory("${WLVM_SSH_AGENT_GENSCAN}", "${WLVM_SSH_USER_SCAN}", "${SSH_OPTIONS}", "${SCAN_CLOUDOPS_HOSTS}")
            }
        }
		
		stage('AddJmslibrary'){
      when {
        anyOf {
          environment name: 'ACTION', value: 'deploy weblogic'
        }
      }
      steps{
				println("===================Adding Gencore JMS Lib ==================")
        gencoreJMS("${WLVM_SSH_AGENT}", "${WLVM_SSH_USER}", "${SSH_OPTIONS}", "${CORE_CLOUDOPS_HOSTS}") 
        println("===================Adding Genscan JMS Lib  ==================")
        genscanJMS("${WLVM_SSH_AGENT_GENSCAN}", "${WLVM_SSH_USER_SCAN}", "${SSH_OPTIONS}", "${SCAN_CLOUDOPS_HOSTS}")
             
      }
    }
        stage('Package') {
            when {
                anyOf {
                    environment name: 'ACTION', value: 'deploy weblogic'
                }
            }
            steps {
                wlvmPackage(_wlvmGlobalConfig())
            }
        }
        stage('Load') {
            when {
                anyOf {
                    environment name: 'ACTION', value: 'deploy weblogic'
                }
            }
            steps {
                println("===================Loading GenCore ==================")
                wlvmGencoreLoad(_wlvmGlobalConfig(), "${WLVM_SSH_AGENT}", "${WLVM_SSH_USER}", "${SSH_OPTIONS}", "${CORE_CLOUDOPS_HOSTS}")
                println("===================Loading GenDataentry =============")
                wlvmDataentryLoad(_wlvmGlobalConfig(), "${WLVM_SSH_AGENT_DATAENTRY}", "${WLVM_SSH_USER_DATAENTRY}", "${SSH_OPTIONS}", "${DATAENTRY_CLOUDOPS_HOSTS}")
                println("===================Loading GenRecog =================")
                wlvmRecogLoad(_wlvmGlobalConfig(), "${WLVM_SSH_AGENT_GENRECOG}", "${WLVM_SSH_USER_RECOG}", "${SSH_OPTIONS}", "${RECOG_CLOUDOPS_HOSTS}")
                println("===================Loading GenScan ==================")
                wlvmScanLoad(_wlvmGlobalConfig(), "${WLVM_SSH_AGENT_GENSCAN}", "${WLVM_SSH_USER_SCAN}", "${SSH_OPTIONS}", "${SCAN_CLOUDOPS_HOSTS}")
            }
        }
        stage('Deploy') {
          when {
            anyOf {
              environment name: 'ACTION', value: 'deploy weblogic'
            }
          }
          steps {
            wlvmDeploy(_wlvmGlobalConfig())
          }
        }
        stage('Start') {
          when {
            anyOf {
              environment name: 'ACTION', value: 'deploy weblogic'
              environment name: 'ACTION', value: 'start weblogic'
            }
          }
          steps {
            wlvmStart(_wlvmGlobalConfig())
          }
        }
        stage('Updating Domain') {
          when {                
				    anyOf {
		  		    environment name: 'ACTION', value: 'deploy weblogic'
				    }
				  } 
          steps {
            Updating_domain(_wlvmGlobalConfig(), "${WLVM_SSH_AGENT}", "${WLVM_SSH_USER}", "${SSH_OPTIONS}", "${WLVM_ADMIN_HOST}")
          } 
			  }
        stage('Updating JMS') {
          when {                
				    anyOf {
		  		    environment name: 'ACTION', value: 'deploy weblogic'
              environment name: 'ACTION', value: 'domain update'
				    }
				  } 
          steps {
            deploy_JMS("${WLVM_SSH_AGENT}", "${WLVM_SSH_USER}", "${SSH_OPTIONS}", "${WLVM_ADMIN_HOST}")
          } 
			  }
        stage('Migration Data') {
          when {                
				    anyOf {
		  		    environment name: 'ACTION', value: 'migration data'
              environment name: 'ACTION', value: 'deploy weblogic'
				    }
				  } 
          steps {
            migration_data("${WLVM_SSH_AGENT}", "${WLVM_SSH_USER}", "${SSH_OPTIONS}", "${WLVM_ADMIN_HOST}")
          }
        }
        stage('NM Script Copy') {
          when {                
				    anyOf {
		  		    environment name: 'ACTION', value: 'NM Script'
				    }
				  } 
          steps {
            wlvmGencoreNM("${WLVM_SSH_AGENT}", "${WLVM_SSH_USER}", "${SSH_OPTIONS}", "${CORE_CLOUDOPS_HOSTS}")
            wlvmDataentryNM("${WLVM_SSH_AGENT_DATAENTRY}", "${WLVM_SSH_USER_DATAENTRY}", "${SSH_OPTIONS}", "${DATAENTRY_CLOUDOPS_HOSTS}")
            wlvmRecogNM("${WLVM_SSH_AGENT_GENRECOG}", "${WLVM_SSH_USER_RECOG}", "${SSH_OPTIONS}", "${RECOG_CLOUDOPS_HOSTS}")
            wlvmScanNM("${WLVM_SSH_AGENT_GENSCAN}", "${WLVM_SSH_USER_SCAN}", "${SSH_OPTIONS}", "${SCAN_CLOUDOPS_HOSTS}")
          }
        }
        stage('Stop') {
          when {
            anyOf {
              environment name: 'ACTION', value: 'stop weblogic'
              environment name: 'ACTION', value: 'undeploy weblogic'
            }
          }
          steps {
            wlvmStop(_wlvmGlobalConfig())
          }
        }
        stage('Kill') {
          when {
            anyOf {
              environment name: 'ACTION', value: 'kill weblogic'
            //  environment name: 'ACTION', value: 'undeploy weblogic'
              environment name: 'ACTION', value: 'deprovision'
            } 
          }
          steps{
            wlvmKill(_wlvmGlobalConfig())
          }
        }
        stage('Clean') {
          when {
            anyOf {
              environment name: 'ACTION', value: 'undeploy weblogic'
              environment name: 'ACTION', value: 'clean weblogic'
              environment name: 'ACTION', value: 'deprovision'
            } 
          }
          steps{
            wlvmClean(_wlvmGlobalConfig())
          }
        }
        stage('Restart') {
          when {
            anyOf {
              environment name: 'ACTION', value: 'restart weblogic'
            }
          }
          steps {
            wlvmRestart(_wlvmGlobalConfig())
          }
        }
    }
}

def _wlvmGlobalConfig() {
    println """============ _wlvmGlobalConfig ============
    ACTION: ${ACTION}
    WLVM_HOME: ${WLVM_HOME}
    WLVM_PACKAGE: ${WLVM_PACKAGE}
    WLVM_ADMIN_HOST: ${WLVM_ADMIN_HOST}
    WLVM_CORE_SERVERS: ${WLVM_CORE_SERVERS}
    WLVM_DATAENTRY_SERVERS: ${WLVM_DATAENTRY_SERVERS}
    WLVM_RECOG_SERVERS: ${WLVM_RECOG_SERVERS}
    WLVM_SCAN_SERVERS: ${WLVM_SCAN_SERVERS}
    WLVM_TARGET_OPT: ${WLVM_TARGET_OPT}
    WLVM_CORE_OPT: ${WLVM_CORE_OPT}
    WLVM_DATAENTRY_OPT: ${WLVM_DATAENTRY_OPT}
    WLVM_RECOG_OPT: ${WLVM_RECOG_OPT}
    WLVM_SCAN_OPT: ${WLVM_SCAN_OPT}
    WLVM_TARGET_VAR: ${WLVM_TARGET_VAR}
    WLVM_CORE_VAR: ${WLVM_CORE_VAR}
    WLVM_DATAENTRY_VAR: ${WLVM_DATAENTRY_VAR}
    WLVM_RECOG_VAR: ${WLVM_RECOG_VAR}
    WLVM_SCAN_VAR: ${WLVM_SCAN_VAR}
    WLVM_CORE_TMP: ${WLVM_CORE_TMP}
    WLVM_DATAENTRY_TMP: ${WLVM_DATAENTRY_TMP}
    WLVM_RECOG_TMP: ${WLVM_RECOG_TMP}
    WLVM_SCAN_TMP: ${WLVM_SCAN_TMP}
    WLVM_CORE_DOMAIN_PARENT: ${WLVM_CORE_DOMAIN_PARENT}
    WLVM_DATAENTRY_DOMAIN_PARENT: ${WLVM_DATAENTRY_DOMAIN_PARENT}
    WLVM_RECOG_DOMAIN_PARENT: ${WLVM_RECOG_DOMAIN_PARENT}
    WLVM_SCAN_DOMAIN_PARENT: ${WLVM_SCAN_DOMAIN_PARENT}
    WLVM_CORE_DOMAIN_HOME: ${WLVM_CORE_DOMAIN_HOME}
    WLVM_DATAENTRY_DOMAIN_HOME: ${WLVM_DATAENTRY_DOMAIN_HOME}
    WLVM_RECOG_DOMAIN_HOME: ${WLVM_RECOG_DOMAIN_HOME}
    WLVM_SCAN_DOMAIN_HOME: ${WLVM_SCAN_DOMAIN_HOME}
    WLVM_SERVER_ADMIN_NAME: ${WLVM_SERVER_ADMIN_NAME}
    WLVM_CONTROL_KILL: ${WLVM_CONTROL_KILL}
    WLVM_SSH_AGENT: ${WLVM_SSH_AGENT}
    WLVM_SSH_AGENT_DATAENTRY: ${WLVM_SSH_AGENT_DATAENTRY}
    WLVM_SSH_AGENT_GENRECOG: ${WLVM_SSH_AGENT_GENRECOG}
    WLVM_SSH_AGENT_GENSCAN: ${WLVM_SSH_AGENT_GENSCAN}
    SSH_OPTIONS: ${SSH_OPTIONS}
    WLVM_SSH_USER: ${WLVM_SSH_USER}
    WLVM_SSH_USER_DATAENTRY: ${WLVM_SSH_USER_DATAENTRY}
    WLVM_SSH_USER_RECOG: ${WLVM_SSH_USER_RECOG}
    WLVM_SSH_USER_SCAN: ${WLVM_SSH_USER_SCAN}
    WLVM_CORE_SERVER_MANAGED_PREFIX: ${WLVM_CORE_SERVER_MANAGED_PREFIX}
    WLVM_DATAENTRY_SERVER_MANAGED_PREFIX: ${WLVM_DATAENTRY_SERVER_MANAGED_PREFIX}
    WLVM_RECOG_SERVER_MANAGED_PREFIX: ${WLVM_RECOG_SERVER_MANAGED_PREFIX}
    WLVM_SCAN_SERVER_MANAGED_PREFIX: ${WLVM_SCAN_SERVER_MANAGED_PREFIX}
    WLVM_TARGET: ${WLVM_TARGET}"""

    return [
    cmd:[
      parameter:"${ACTION}"
    ],
    source:[
      home:"${WLVM_HOME}",
      tmp:"${WLVM_PACKAGE}"
    ],
    core_target:[
        hosts:"${WLVM_CORE_SERVERS}",
        opt:"${WLVM_CORE_OPT}",
        var:"${WLVM_CORE_VAR}",
        tmp:"${WLVM_CORE_TMP}"
    ],
    dataentry_target:[
        hosts:"${WLVM_DATAENTRY_SERVERS}",
        opt:"${WLVM_DATAENTRY_OPT}",
        var:"${WLVM_DATAENTRY_VAR}",
        tmp:"${WLVM_DATAENTRY_TMP}"
    ],
    recog_target:[
        hosts:"${WLVM_RECOG_SERVERS}",
        opt:"${WLVM_RECOG_OPT}",
        var:"${WLVM_RECOG_VAR}",
        tmp:"${WLVM_RECOG_TMP}"
    ],
    scan_target:[
        hosts:"${WLVM_SCAN_SERVERS}",
        opt:"${WLVM_SCAN_OPT}",
        var:"${WLVM_SCAN_VAR}",
        tmp:"${WLVM_SCAN_TMP}"
    ],
    domain:[
      core_home:"${WLVM_CORE_DOMAIN_HOME}",
      dataentry_home:"${WLVM_DATAENTRY_DOMAIN_HOME}",
      recog_home:"${WLVM_RECOG_DOMAIN_HOME}",
      scan_home:"${WLVM_SCAN_DOMAIN_HOME}"
    ],
    admin:[
      host: "${WLVM_ADMIN_HOST}",
      name:"${WLVM_SERVER_ADMIN_NAME}",
      opt:"${WLVM_CORE_OPT}",
      var:"${WLVM_CORE_VAR}",
      tmp:"${WLVM_CORE_TMP}"
    ],
    managed:[
      prefix1:"${WLVM_CORE_SERVER_MANAGED_PREFIX}",
      prefix2:"${WLVM_DATAENTRY_SERVER_MANAGED_PREFIX}",
      prefix3:"${WLVM_RECOG_SERVER_MANAGED_PREFIX}",
      prefix4:"${WLVM_SCAN_SERVER_MANAGED_PREFIX}"
    ],
    control:[
      kill:"${WLVM_CONTROL_KILL}"
    ],
    ssh:[
      envr:"${WLVM_TARGET}",
      agent:"${WLVM_SSH_AGENT}",
      dataentry_agent:"${WLVM_SSH_AGENT_DATAENTRY}",
      recog_agent:"${WLVM_SSH_AGENT_GENRECOG}",
      scan_agent:"${WLVM_SSH_AGENT_GENSCAN}",
      options:"${SSH_OPTIONS}",
      user1:"${WLVM_SSH_USER}",
      user2:"${WLVM_SSH_USER_DATAENTRY}",
      user3:"${WLVM_SSH_USER_RECOG}",
      user4:"${WLVM_SSH_USER_SCAN}"
    ]
  ]
}

def gencoreDirectory(sshAgent, sshUser, sshOptions, cloudOpsHosts) {    
    def cmd = """        pwd;        cd ~;        pwd;
      cd /opt/fedex/genesis/gencore
      mkdir current
	    mkdir -p servercfg/jms8.0.5
      pwd 
      cd /opt/fedex/genesis/gencore/current
      mkdir bin
      mkdir cfg
      """.stripIndent()
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd)
}

  def gendataentryDirectory(sshAgent, sshUser, sshOptions, cloudOpsHosts) {    
    def cmd = """        pwd;        cd ~;        pwd;
      cd /opt/fedex/genesis/gendataentry
      mkdir current
	    mkdir -p servercfg/jms8.0.5
      pwd 
      cd /opt/fedex/genesis/gendataentry/current
      mkdir bin
      mkdir cfg
      """.stripIndent()
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd)
}

  def genrecogDirectory(sshAgent, sshUser, sshOptions, cloudOpsHosts) {    
    def cmd = """        pwd;        cd ~;        pwd;
      cd /opt/fedex/genesis/genrecog
      mkdir current
	    mkdir -p servercfg/jms8.0.5
      pwd 
      cd /opt/fedex/genesis/genrecog/current
      mkdir bin
      mkdir cfg
      """.stripIndent()
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd)
}

  def genscanDirectory(sshAgent, sshUser, sshOptions, cloudOpsHosts) {    
    def cmd = """        pwd;        cd ~;        pwd;
      cd /opt/fedex/genesis/genscan
      mkdir current
	    mkdir -p servercfg/jms8.0.5
      pwd 
      cd /opt/fedex/genesis/genscan/current
      mkdir bin
      mkdir cfg
      """.stripIndent()
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd)
}

def gencoreJMS(sshAgent, sshUser, sshOptions, cloudOpsHosts){
    sshagent([sshAgent]) {
        cloudOpsHosts.split(',').each { cloudOpsHost -> 
          sh """#!/bin/bash
              scp ${sshOptions} ${WORKSPACE}/jmslib/jms8.0.5/* ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/gencore/servercfg/jms8.0.5			  
              ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'cd /opt/fedex/genesis/gencore/servercfg && chmod -R 775 *'
          """
        }
}
}

def genscanJMS(sshAgent, sshUser, sshOptions, cloudOpsHosts){
  sshagent([sshAgent]) {
    cloudOpsHosts.split(',').each { cloudOpsHost -> 
      sh """#!/bin/bash
        scp ${sshOptions} ${WORKSPACE}/jmslib/jms8.0.5/* ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/genscan/servercfg/jms8.0.5			  
        ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'cd /opt/fedex/genesis/genscan/servercfg && chmod -R 775 *'
      """
    }
  }
}

def wlvmPackage(Map config) {
  sh("mkdir -p ${config.source.tmp}")
  dir(config.source.home) {
      sh("chmod 775 *")
      sh("ls -ltr")
      sh("./package.sh")
  }
}

def wlvmGencoreLoad(Map config, sshAgent, sshUser, sshOptions, cloudOpsHosts) {
  dir(config.source.tmp) {
    sh('zip -r stage .')
  }
  //Load archive
  sshagent([sshAgent]) {
    cloudOpsHosts.split(',').each { cloudOpsHost -> 
      sh """#!/bin/bash
      if [ ! -d ${config.core_target.tmp} ];
      then
          echo "target tmp is: ${config.core_target.tmp}"
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'mkdir -p /var/fedex/genesis/gencore/tmp'
          scp ${sshOptions} ${WORKSPACE}/wlvm/package/stage.zip ${sshUser}@${cloudOpsHost}:/var/fedex/genesis/gencore/tmp
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'cd /var/fedex/genesis/gencore/tmp && unzip stage.zip && rm stage.zip && cd /var/fedex/genesis/gencore/tmp/stage && chmod 775 *'
      fi
      """
    }
  }
    //sh("rm ${config.source.tmp}/stage.zip")
}

def wlvmDataentryLoad(Map config, sshAgent, sshUser, sshOptions, cloudOpsHosts) {
  sshagent([sshAgent]) {
    cloudOpsHosts.split(',').each { cloudOpsHost -> 
      sh """#!/bin/bash
      if [ ! -d ${config.dataentry_target.tmp} ];
      then
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'mkdir -p /var/fedex/genesis/gendataentry/tmp'
          scp ${sshOptions} ${WORKSPACE}/wlvm/package/stage.zip ${sshUser}@${cloudOpsHost}:/var/fedex/genesis/gendataentry/tmp
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'cd /var/fedex/genesis/gendataentry/tmp && unzip stage.zip && rm stage.zip && cd /var/fedex/genesis/gendataentry/tmp/stage && chmod 775 *'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export WLVM_HOME=/var/fedex/genesis/gencore/tmp:export WLVM_HOME=/var/fedex/genesis/gendataentry/tmp:g" /var/fedex/genesis/gendataentry/tmp/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export WDT_HOME=/var/fedex/genesis/gencore/tmp/stage/weblogic-deploy:export WDT_HOME=/var/fedex/genesis/gendataentry/tmp/stage/weblogic-deploy:g" ${config.dataentry_target.tmp}/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_STAGE=/var/fedex/genesis/gencore/tmp/stage:export DOMAIN_STAGE=/var/fedex/genesis/gendataentry/tmp/stage:g" ${config.dataentry_target.tmp}/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_PARENT=/opt/fedex/genesis/gencore/current:export DOMAIN_PARENT=/opt/fedex/genesis/gendataentry/current:g" ${config.dataentry_target.tmp}/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_HOME=/opt/fedex/genesis/gencore/current/genintl:export DOMAIN_HOME=/opt/fedex/genesis/gendataentry/current/genintl:g" ${config.dataentry_target.tmp}/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_DEPLOY=/opt/fedex/genesis/gencore/current/genintl/wlsdeploy:export DOMAIN_DEPLOY=/opt/fedex/genesis/gendataentry/current/genintl/wlsdeploy:g" ${config.dataentry_target.tmp}/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_VAR=/var/fedex/genesis/gencore:export DOMAIN_VAR=/var/fedex/genesis/gendataentry:g" ${config.dataentry_target.tmp}/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export WDT_HOME=/var/fedex/genesis/gencore/tmp/stage/weblogic-deploy:export WDT_HOME=/var/fedex/genesis/gendataentry/tmp/stage/weblogic-deploy:g" ${config.dataentry_target.tmp}/stage/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_PARENT=/opt/fedex/genesis/gencore/current:export DOMAIN_PARENT=/opt/fedex/genesis/gendataentry/current:g" ${config.dataentry_target.tmp}/stage/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_HOME=/opt/fedex/genesis/gencore/current/genintl:export DOMAIN_HOME=/opt/fedex/genesis/gendataentry/current/genintl:g" ${config.dataentry_target.tmp}/stage/env.sh'
      fi
      """
    }
  }
    //sh("rm ${config.source.tmp}/stage.zip")
}

def wlvmRecogLoad(Map config, sshAgent, sshUser, sshOptions, cloudOpsHosts) {
    // dir(config.source.tmp) {
    //   sh('zip -r stage .')
    // }
    //Load archive
  sshagent([sshAgent]) {
    cloudOpsHosts.split(',').each { cloudOpsHost -> 
      sh """#!/bin/bash
      if [ ! -d ${config.recog_target.tmp} ];
      then
        echo "target tmp is: ${config.recog_target.tmp}"
        ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'mkdir -p /var/fedex/genesis/genrecog/tmp && ls -la'
        scp ${sshOptions} ${WORKSPACE}/wlvm/package/stage.zip ${sshUser}@${cloudOpsHost}:/var/fedex/genesis/genrecog/tmp
        ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'cd /var/fedex/genesis/genrecog/tmp && unzip stage.zip && rm stage.zip && cd /var/fedex/genesis/genrecog/tmp/stage && chmod 775 *'
        ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export WLVM_HOME=/var/fedex/genesis/gencore/tmp:export WLVM_HOME=/var/fedex/genesis/genrecog/tmp:g" ${config.recog_target.tmp}/env.sh'
        ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export WDT_HOME=/var/fedex/genesis/gencore/tmp/stage/weblogic-deploy:export WDT_HOME=/var/fedex/genesis/genrecog/tmp/stage/weblogic-deploy:g" ${config.recog_target.tmp}/env.sh'
        ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_STAGE=/var/fedex/genesis/gencore/tmp/stage:export DOMAIN_STAGE=/var/fedex/genesis/genrecog/tmp/stage:g" ${config.recog_target.tmp}/env.sh'
        ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_PARENT=/opt/fedex/genesis/gencore/current:export DOMAIN_PARENT=/opt/fedex/genesis/genrecog/current:g" ${config.recog_target.tmp}/env.sh'
        ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_HOME=/opt/fedex/genesis/gencore/current/genintl:export DOMAIN_HOME=/opt/fedex/genesis/genrecog/current/genintl:g" ${config.recog_target.tmp}/env.sh'
        ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_DEPLOY=/opt/fedex/genesis/gencore/current/genintl/wlsdeploy:export DOMAIN_DEPLOY=/opt/fedex/genesis/genrecog/current/genintl/wlsdeploy:g" ${config.recog_target.tmp}/env.sh'
        ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_VAR=/var/fedex/genesis/gencore:export DOMAIN_VAR=/var/fedex/genesis/genrecog:g" ${config.recog_target.tmp}/env.sh'
        ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export WDT_HOME=/var/fedex/genesis/gencore/tmp/stage/weblogic-deploy:export WDT_HOME=/var/fedex/genesis/genrecog/tmp/stage/weblogic-deploy:g" ${config.recog_target.tmp}/stage/env.sh'
        ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_PARENT=/opt/fedex/genesis/gencore/current:export DOMAIN_PARENT=/opt/fedex/genesis/genrecog/current:g" ${config.recog_target.tmp}/stage/env.sh'
        ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_HOME=/opt/fedex/genesis/gencore/current/genintl:export DOMAIN_HOME=/opt/fedex/genesis/genrecog/current/genintl:g" ${config.recog_target.tmp}/stage/env.sh'
    fi
    """
    }
  }
    //sh("rm ${config.source.tmp}/stage.zip")
}

def wlvmScanLoad(Map config, sshAgent, sshUser, sshOptions, cloudOpsHosts) {
  sshagent([sshAgent]) {
    cloudOpsHosts.split(',').each { cloudOpsHost -> 
      sh """#!/bin/bash
      if [ ! -d ${config.scan_target.tmp} ];
      then
          echo "target tmp is: ${config.scan_target.tmp}"
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'mkdir -p /var/fedex/genesis/genscan/tmp'
          scp ${sshOptions} ${WORKSPACE}/wlvm/package/stage.zip ${sshUser}@${cloudOpsHost}:/var/fedex/genesis/genscan/tmp
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'cd /var/fedex/genesis/genscan/tmp && unzip stage.zip && rm stage.zip && cd /var/fedex/genesis/genscan/tmp/stage && chmod 775 *'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export WLVM_HOME=/var/fedex/genesis/gencore/tmp:export WLVM_HOME=/var/fedex/genesis/genscan/tmp:g" ${config.scan_target.tmp}/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export WDT_HOME=/var/fedex/genesis/gencore/tmp/stage/weblogic-deploy:export WDT_HOME=/var/fedex/genesis/genscan/tmp/stage/weblogic-deploy:g" ${config.scan_target.tmp}/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_STAGE=/var/fedex/genesis/gencore/tmp/stage:export DOMAIN_STAGE=/var/fedex/genesis/genscan/tmp/stage:g" ${config.scan_target.tmp}/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_PARENT=/opt/fedex/genesis/gencore/current:export DOMAIN_PARENT=/opt/fedex/genesis/genscan/current:g" ${config.scan_target.tmp}/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_HOME=/opt/fedex/genesis/gencore/current/genintl:export DOMAIN_HOME=/opt/fedex/genesis/genscan/current/genintl:g" ${config.scan_target.tmp}/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_DEPLOY=/opt/fedex/genesis/gencore/current/genintl/wlsdeploy:export DOMAIN_DEPLOY=/opt/fedex/genesis/genscan/current/genintl/wlsdeploy:g" ${config.scan_target.tmp}/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_VAR=/var/fedex/genesis/gencore:export DOMAIN_VAR=/var/fedex/genesis/genscan:g" ${config.scan_target.tmp}/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export WDT_HOME=/var/fedex/genesis/gencore/tmp/stage/weblogic-deploy:export WDT_HOME=/var/fedex/genesis/genscan/tmp/stage/weblogic-deploy:g" ${config.scan_target.tmp}/stage/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_PARENT=/opt/fedex/genesis/gencore/current:export DOMAIN_PARENT=/opt/fedex/genesis/genscan/current:g" ${config.scan_target.tmp}/stage/env.sh'
          ssh ${sshOptions} ${sshUser}@${cloudOpsHost} 'sed -i -e "s:export DOMAIN_HOME=/opt/fedex/genesis/gencore/current/genintl:export DOMAIN_HOME=/opt/fedex/genesis/genscan/current/genintl:g" ${config.scan_target.tmp}/stage/env.sh'
      fi
    """
    }
  }
  sh("rm ${config.source.tmp}/stage.zip")
}

//
//Deploy
//

def wlvmDeploy(Map config) {
  String[] gencore_hosts=config.core_target.hosts.split(',')
  boolean hasManaged=(gencore_hosts.size()>1)
  if (gencore_hosts.size() == 1) {
   config.action=['host':gencore_hosts[0], 'admin':true, 'managed':0]
   _wlvmCoreHostDeploy(config)
  } else {
    gencore_hosts.eachWithIndex { host, index ->
      boolean isAdmin=(index==0)
      int managedIndex=index+1
      config.action=['host':gencore_hosts[index], 'admin':isAdmin, 'managed':managedIndex]
      _wlvmCoreHostDeploy(config)
    }
  }
  config.remove('action')
  String[] dataentry_hosts=config.dataentry_target.hosts.split(',')
  if (dataentry_hosts.size() >= 1) {
    dataentry_hosts.eachWithIndex { host, index ->
      boolean isAdmin=false
      int managedIndex=index+1
      config.action=['host':dataentry_hosts[index], 'admin':isAdmin, 'managed':managedIndex]
      _wlvmDataentryHostDeploy(config)
    }
  }
  config.remove('action')
  String[] genrecog_hosts=config.recog_target.hosts.split(',')
  if (genrecog_hosts.size() >= 1) {
    genrecog_hosts.eachWithIndex { host, index ->
      boolean isAdmin=false
      int managedIndex=index+1
      config.action=['host':genrecog_hosts[index], 'admin':isAdmin, 'managed':managedIndex]
      _wlvmRecogHostDeploy(config)
    }
  }
  config.remove('action')
  String[] genscan_hosts=config.scan_target.hosts.split(',')
  if (genscan_hosts.size() >= 1) {
    genscan_hosts.eachWithIndex { host, index ->
      boolean isAdmin=false
      int managedIndex=index+1
      config.action=['host':genscan_hosts[index], 'admin':isAdmin, 'managed':managedIndex]
      _wlvmScanHostDeploy(config)
    }
  }
  config.remove('action')
}

def _wlvmCoreHostDeploy(Map config) {
    if (!_wlvmCoreDomainDeployed(config)) {
      sshagent([config.ssh.agent]) {
        // Create domain
        sh(_wlvmCoreHostSsh(config, "'cd ${config.core_target.tmp} && . ./env.sh && ./create.sh'"))     
        
        // If domain has managed server...
        if (config.action.managed) {
          String domainSerialized="${config.domain.core_home}/security/SerializedSystemIni.dat"
          String adminBoot="${config.domain.core_home}/servers/${config.admin.name}/security/boot.properties"
          String managedSecurity="${config.domain.core_home}/servers/${config.managed.prefix1}${config.action.managed}/security"
          String managedBoot="${managedSecurity}/boot.properties"
          // Synchronize security files
          if (config.action.admin) {
            // Download from domain with admin server
            sh(_wlvmCoreHostScp(config, domainSerialized, "${config.source.tmp}/SerializedSystemIni.dat", true))
            sh(_wlvmCoreHostScp(config, "${WORKSPACE}/domain/wlst/boot.properties", adminBoot, false))
            sh(_wlvmCoreHostScp(config, "${WORKSPACE}/config_py/${config.ssh.envr}_DomainUpdate.py", "/var/fedex/genesis/gencore/tmp/", false))
            sh(_wlvmCoreHostScp(config, "${WORKSPACE}/config_py/JMS_Module/config-jms.properties", "/var/fedex/genesis/gencore/tmp/", false))
            sh(_wlvmCoreHostScp(config, "${WORKSPACE}/config_py/JMS_Module/gencore-BatchInitiate_JMS_Module.py", "/var/fedex/genesis/gencore/tmp/", false))
            sh(_wlvmCoreHostScp(config, "${WORKSPACE}/config_py/JMS_Module/JMSConfig", "/opt/fedex/genesis/gencore/current/genintl/", false))
            sh(_wlvmCoreHostScp(config, "${WORKSPACE}/config_py/JMS_Module/JMSSecret", "/opt/fedex/genesis/gencore/current/genintl/", false))
            sh(_wlvmCoreHostScp(config, "${WORKSPACE}/config_py/JMS_Module/gencore-BatchPrep_JMS_Module.py", "/var/fedex/genesis/gencore/tmp/", false))
            sh(_wlvmCoreHostScp(config, "${WORKSPACE}/config_py/JMS_Module/gencore-IntlEDE_JMS_Module.py", "/var/fedex/genesis/gencore/tmp/", false))
            sh(_wlvmCoreHostScp(config, "${WORKSPACE}/config_py/JMS_Module/gencore-Nafta_JMS_Module.py", "/var/fedex/genesis/gencore/tmp/", false))
            sh(_wlvmCoreHostScp(config, "${WORKSPACE}/config_py/JMS_Module/gencore-SOE_Jms_Module.py", "/var/fedex/genesis/gencore/tmp/", false))
            sh(_wlvmCoreHostScp(config, "${WORKSPACE}/config_py/JMS_Module/gencore-SoeComError_Jms_Module.py", "/var/fedex/genesis/gencore/tmp/", false))
			sh(_wlvmCoreHostScp(config, "${WORKSPACE}/config_py/JMS_Module/gencore-SoeCom_Jms_Module.py", "/var/fedex/genesis/gencore/tmp/", false))
			sh(_wlvmCoreHostScp(config, "${WORKSPACE}/config_py/JMS_Module/genscan-GenScanAgent_JMS_Module.py", "/var/fedex/genesis/gencore/tmp/", false))
            //sh(_wlvmCoreHostScp(config, adminBoot, "${WORKSPACE}/domain/wlst/boot.properties", true))
          } else {
            // Sync SerializedSystemIni.dat file to domain without admin server
            sh(_wlvmCoreHostScp(config, "${config.source.tmp}/SerializedSystemIni.dat", domainSerialized, false))
          }
          // Sync boot.properties file
          sh(_wlvmCoreHostSsh(config, "mkdir -p ${managedSecurity}"))
          // sh(_wlvmCoreHostScp(config, "${config.source.tmp}/boot.properties", managedBoot, false))
          sh(_wlvmCoreHostScp(config, "${WORKSPACE}/domain/wlst/boot.properties", managedBoot, false))
        }
   
        // Clean up domain packaging
        sh(_wlvmCoreHostSsh(config, "'cd ${config.core_target.tmp} && rm -r stage && rm create.sh'"))
        sh(_wlvmCoreHostScp(config, "${WORKSPACE}/domain/certs/gencore${config.ssh.envr}.jks", "/opt/fedex/genesis/gencore/current/cfg/", false))
        sh(_wlvmCoreHostScp(config, "${WORKSPACE}/domain/bin/${config.ssh.envr}_stopWebLogic.sh", "/opt/fedex/genesis/gencore/current/genintl/bin/stopWebLogic.sh", false))
        sh(_wlvmCoreHostScp(config, "${WORKSPACE}/domain/bin/startNM.sh", "/opt/fedex/genesis/gencore/current/genintl/bin/", false))
        sh(_wlvmCoreHostScp(config, "${WORKSPACE}/domain/bin/stopNM.sh", "/opt/fedex/genesis/gencore/current/genintl/bin/", false))
      }
    }
}

def _wlvmDataentryHostDeploy(Map config) {
  if (!_wlvmDataentryDomainDeployed(config)) {
    sshagent([config.ssh.dataentry_agent]) {
      sh(_wlvmDataentryHostScp(config, "${WORKSPACE}/domain/lib/CSMWebApp12.war", "/opt/fedex/genesis/gendataentry/servercfg/", false))
      // Create domain
      sh(_wlvmDataentryHostSsh(config, "'cd ${config.dataentry_target.tmp} && . ./env.sh && ./create.sh'"))     
      
      // If domain has managed server...
      if (config.action.managed) {
        String domainSerialized="${config.domain.dataentry_home}/security/SerializedSystemIni.dat"
        String adminBoot="${config.domain.dataentry_home}/servers/${config.admin.name}/security/boot.properties"
        String managedSecurity="${config.domain.dataentry_home}/servers/${config.managed.prefix2}${config.action.managed}/security"
        String managedBoot="${managedSecurity}/boot.properties"
        // Synchronize security files
        if (config.action.admin) {
          // Download from domain with admin server
          sh(_wlvmDataentryHostScp(config, domainSerialized, "${config.source.tmp}/SerializedSystemIni.dat", true))
          //sh(_wlvmDataentryHostScp(config, adminBoot, "${config.source.tmp}/boot.properties", true))
          sh(_wlvmDataentryHostScp(config, "${WORKSPACE}/domain/wlst/boot.properties", adminBoot, false))
        } else {
          // Sync SerializedSystemIni.dat file to domain without admin server
          sh(_wlvmDataentryHostScp(config, "${config.source.tmp}/SerializedSystemIni.dat", domainSerialized, false))
        }
        // Sync boot.properties file
        sh(_wlvmDataentryHostSsh(config, "mkdir -p ${managedSecurity}"))
        // sh(_wlvmDataentryHostScp(config, "${config.source.tmp}/boot.properties", managedBoot, false))
        sh(_wlvmDataentryHostScp(config, "${WORKSPACE}/domain/wlst/boot.properties", managedBoot, false))
      }
      // Clean up domain packaging
      sh(_wlvmDataentryHostSsh(config, "'cd ${config.dataentry_target.tmp} && rm -r stage && rm create.sh'"))
      sh(_wlvmDataentryHostScp(config, "${WORKSPACE}/domain/certs/gencore${config.ssh.envr}.jks", "/opt/fedex/genesis/gendataentry/current/cfg/", false))
      sh(_wlvmDataentryHostScp(config, "${WORKSPACE}/domain/bin/${config.ssh.envr}_stopWebLogic.sh", "/opt/fedex/genesis/gendataentry/current/genintl/bin/stopWebLogic.sh", false))
      sh(_wlvmDataentryHostScp(config, "${WORKSPACE}/domain/bin/startNM.sh", "/opt/fedex/genesis/gendataentry/current/genintl/bin/", false))
      sh(_wlvmDataentryHostScp(config, "${WORKSPACE}/domain/bin/stopNM.sh", "/opt/fedex/genesis/gendataentry/current/genintl/bin/", false))
    }
  }
}

def _wlvmRecogHostDeploy(Map config) {
    if (!_wlvmRecogDomainDeployed(config)) {
      sshagent([config.ssh.recog_agent]) {
        // Create domain
        sh(_wlvmRecogHostSsh(config, "'cd ${config.recog_target.tmp} && . ./env.sh && ./create.sh'"))     
        
        // If domain has managed server...
        if (config.action.managed) {
          String domainSerialized="${config.domain.recog_home}/security/SerializedSystemIni.dat"
          String adminBoot="${config.domain.recog_home}/servers/${config.admin.name}/security/boot.properties"
          String managedSecurity="${config.domain.recog_home}/servers/${config.managed.prefix3}${config.action.managed}/security"
          String managedBoot="${managedSecurity}/boot.properties"
          // Synchronize security files
          if (config.action.admin) {
            // Download from domain with admin server
            sh(_wlvmRecogHostScp(config, domainSerialized, "${config.source.tmp}/SerializedSystemIni.dat", true))
            sh(_wlvmRecogHostScp(config, adminBoot, "${config.source.tmp}/boot.properties", true))
          } else {
            // Sync SerializedSystemIni.dat file to domain without admin server
            sh(_wlvmRecogHostScp(config, "${config.source.tmp}/SerializedSystemIni.dat", domainSerialized, false))
          }
          // Sync boot.properties file
          sh(_wlvmRecogHostSsh(config, "mkdir -p ${managedSecurity}"))
          // sh(_wlvmRecogHostScp(config, "${config.source.tmp}/boot.properties", managedBoot, false))
          sh(_wlvmRecogHostScp(config, "${WORKSPACE}/domain/wlst/boot.properties", managedBoot, false))
        }
   
        // Clean up domain packaging
        sh(_wlvmRecogHostSsh(config, "'cd ${config.recog_target.tmp} && rm -r stage && rm create.sh'"))
        sh(_wlvmRecogHostScp(config, "${WORKSPACE}/domain/certs/gencore${config.ssh.envr}.jks", "/opt/fedex/genesis/genrecog/current/cfg/", false))
        sh(_wlvmRecogHostScp(config, "${WORKSPACE}/domain/bin/${config.ssh.envr}_stopWebLogic.sh", "/opt/fedex/genesis/genrecog/current/genintl/bin/stopWebLogic.sh", false))
        sh(_wlvmRecogHostScp(config, "${WORKSPACE}/domain/bin/startNM.sh", "/opt/fedex/genesis/genrecog/current/genintl/bin/", false))
        sh(_wlvmRecogHostScp(config, "${WORKSPACE}/domain/bin/stopNM.sh", "/opt/fedex/genesis/genrecog/current/genintl/bin/", false))
      }
    }
}

def _wlvmScanHostDeploy(Map config) {
    if (!_wlvmScanDomainDeployed(config)) {
      sshagent([config.ssh.scan_agent]) {
        sh(_wlvmScanHostScp(config, "${WORKSPACE}/domain/lib/CSMWebApp12.war", "/opt/fedex/genesis/genscan/servercfg/", false))
        // Create domain
        sh(_wlvmScanHostSsh(config, "'cd ${config.scan_target.tmp} && . ./env.sh && ./create.sh'"))     
        
        // If domain has managed server...
        if (config.action.managed) {
          String domainSerialized="${config.domain.scan_home}/security/SerializedSystemIni.dat"
          String adminBoot="${config.domain.scan_home}/servers/${config.admin.name}/security/boot.properties"
          String managedSecurity="${config.domain.scan_home}/servers/${config.managed.prefix4}${config.action.managed}/security"
          String managedBoot="${managedSecurity}/boot.properties"
          // Synchronize security files
          if (config.action.admin) {
            // Download from domain with admin server
            sh(_wlvmScanHostScp(config, domainSerialized, "${config.source.tmp}/SerializedSystemIni.dat", true))
            sh(_wlvmScanHostScp(config, adminBoot, "${config.source.tmp}/boot.properties", true))
          } else {
            // Sync SerializedSystemIni.dat file to domain without admin server
            sh(_wlvmScanHostScp(config, "${config.source.tmp}/SerializedSystemIni.dat", domainSerialized, false))
          }
          // Sync boot.properties file
          sh(_wlvmScanHostSsh(config, "mkdir -p ${managedSecurity}"))
          // sh(_wlvmScanHostScp(config, "${config.source.tmp}/boot.properties", managedBoot, false))
          sh(_wlvmScanHostScp(config, "${WORKSPACE}/domain/wlst/boot.properties", managedBoot, false))
        }
   
        // Clean up domain packaging
        sh(_wlvmScanHostSsh(config, "'cd ${config.scan_target.tmp} && rm -r stage && rm create.sh'"))
        sh(_wlvmScanHostScp(config, "${WORKSPACE}/domain/certs/gencore${config.ssh.envr}.jks", "/opt/fedex/genesis/genscan/current/cfg/", false))
        sh(_wlvmScanHostScp(config, "${WORKSPACE}/domain/bin/${config.ssh.envr}_stopWebLogic.sh", "/opt/fedex/genesis/genscan/current/genintl/bin/stopWebLogic.sh", false))
        sh(_wlvmScanHostScp(config, "${WORKSPACE}/domain/bin/startNM.sh", "/opt/fedex/genesis/genscan/current/genintl/bin/", false))
        sh(_wlvmScanHostScp(config, "${WORKSPACE}/domain/bin/stopNM.sh", "/opt/fedex/genesis/genscan/current/genintl/bin/", false))
      }
    }
}

//
//Start
//

def wlvmStart(Map config) {
  String[] gencore_hosts=config.core_target.hosts.split(',')
  for (host in gencore_hosts) {
      config.action=[host:host]
      _wlvmCoreServerStart(config)
  }
  config.remove('action')
  String[] dataentry_hosts=config.dataentry_target.hosts.split(',')
    // dataentry_hosts.eachWithIndex { host, index ->
  for (host in dataentry_hosts) {
    config.action=[host:host]
    _wlvmDataentryServerStart(config)
  }
  config.remove('action')
  String[] recog_hosts=config.recog_target.hosts.split(',')
  // Managed servers
  // if (recog_hosts.size() > 1) {
  for (host in recog_hosts) {
    config.action=[host:host]
    _wlvmRecogServerStart(config)
  }
  config.remove('action')
  String[] scan_hosts=config.scan_target.hosts.split(',')
  // Managed servers
  for (host in scan_hosts) {
    config.action=[host:host]
    _wlvmScanServerStart(config)
  }
  config.remove('action')
}

def _wlvmCoreServerStart(Map config) {
    String cmd
      cmd="'cd ${config.core_target.tmp} && . ./env.sh && ./start.sh'"
    sshagent([config.ssh.agent]) {
      sh(_wlvmCoreHostSsh(config, cmd))
    }
}

def _wlvmDataentryServerStart(Map config) {
    String cmd
    cmd="'cd ${config.dataentry_target.tmp} && . ./env.sh && ./start.sh'"
    sshagent([config.ssh.dataentry_agent]) {
      sh(_wlvmDataentryHostSsh(config, cmd))
    }
}

def _wlvmRecogServerStart(Map config) {
    String cmd
      cmd="'cd ${config.recog_target.tmp} && . ./env.sh && ./start.sh'"
    sshagent([config.ssh.recog_agent]) {
      sh(_wlvmRecogHostSsh(config, cmd))
    }
}

def _wlvmScanServerStart(Map config) {
    String cmd
      cmd="'cd ${config.scan_target.tmp} && . ./env.sh && ./start.sh'"
    sshagent([config.ssh.scan_agent]) {
      sh(_wlvmScanHostSsh(config, cmd))
    }
}

//
//Stop
//
def wlvmStop(Map config) {
  String[] gencore_hosts=config.core_target.hosts.split(',')
  for (host in gencore_hosts) {
      config.action=[host:host]
      _wlvmCoreServerStop(config)
  }
  config.remove('action')
  String[] dataentry_hosts=config.dataentry_target.hosts.split(',')
    // dataentry_hosts.eachWithIndex { host, index ->
  for (host in dataentry_hosts) {
    config.action=[host:host]
    _wlvmDataentryServerStop(config)
  }
  config.remove('action')
  String[] recog_hosts=config.recog_target.hosts.split(',')
  // Managed servers
  // if (recog_hosts.size() > 1) {
  for (host in recog_hosts) {
    config.action=[host:host]
    _wlvmRecogServerStop(config)
  }
  config.remove('action')
  String[] scan_hosts=config.scan_target.hosts.split(',')
  // Managed servers
  for (host in scan_hosts) {
    config.action=[host:host]
    _wlvmScanServerStop(config)
  }
  config.remove('action')
}

def _wlvmCoreServerStop(Map config) {
    String cmd
    cmd="'cd ${config.core_target.tmp} && . ./env.sh && ./stop.sh'"
    sshagent([config.ssh.agent]) {
      sh(_wlvmCoreHostSsh(config, cmd))
    }
}

def _wlvmDataentryServerStop(Map config) {
    String cmd
    cmd="'cd ${config.dataentry_target.tmp} && . ./env.sh && ./stop.sh'"
    sshagent([config.ssh.dataentry_agent]) {
      sh(_wlvmDataentryHostSsh(config, cmd))
    }
}

def _wlvmRecogServerStop(Map config) {
    String cmd
    cmd="'cd ${config.recog_target.tmp} && . ./env.sh && ./stop.sh'"
    sshagent([config.ssh.recog_agent]) {
      sh(_wlvmRecogHostSsh(config, cmd))
    }
}

def _wlvmScanServerStop(Map config) {
  String cmd
  cmd="'cd ${config.scan_target.tmp} && . ./env.sh && ./stop.sh'"
  sshagent([config.ssh.scan_agent]) {
    sh(_wlvmScanHostSsh(config, cmd))
  }
}

//
//Restart
//

def wlvmRestart(Map config) {
  String[] gencore_hosts=config.core_target.hosts.split(',')
  if (gencore_hosts.size() >= 1) {
    gencore_hosts.eachWithIndex { host, index ->
      config.action=[host:host, managed:index+1]
      _wlvmCoreServerRestart(config)
    }
  }
  config.remove('action')
  String[] dataentry_hosts=config.dataentry_target.hosts.split(',')
  if (dataentry_hosts.size() >= 1) {
    dataentry_hosts.eachWithIndex { host, index ->
      config.action=[host:host, managed:index+1]
      _wlvmDataentryServerRestart(config)
    }
  }
  config.remove('action')
  String[] recog_hosts=config.recog_target.hosts.split(',')
  if (recog_hosts.size() >= 1) {
    recog_hosts.eachWithIndex { host, index ->
      config.action=[host:host, managed:index+1]
      _wlvmRecogServerRestart(config)
    }
  }
  config.remove('action')
  String[] scan_hosts=config.scan_target.hosts.split(',')
  if (scan_hosts.size() >= 1) {
    scan_hosts.eachWithIndex { host, index ->
      config.action=[host:host, managed:index+1]
      _wlvmScanServerRestart(config)
    }
  }
  config.remove('action')
}

def _wlvmAdminServerRestart(Map config) {
  _wlvmAdminServerStop(config)
  _wlvmAdminServerStart(config)
}

def _wlvmCoreServerRestart(Map config) {
  _wlvmCoreServerStop(config)
  _wlvmCoreServerStart(config)
}

def _wlvmDataentryServerRestart(Map config) {
  _wlvmDataentryServerStop(config)
  _wlvmDataentryServerStart(config)
}

def _wlvmRecogServerRestart(Map config) {
  _wlvmRecogServerStop(config)
  _wlvmRecogServerStart(config)
}

def _wlvmScanServerRestart(Map config) {
  _wlvmScanServerStop(config)
  _wlvmScanServerStart(config)
}

//
//Kill
//

def wlvmKill(Map config) {
  String[] gencore_hosts=config.core_target.hosts.split(',')
  if (gencore_hosts.size() >= 1) {
    gencore_hosts.eachWithIndex { host, index ->
      config.action=[host:host, managed:index+1]
      _wlvmCoreServerKill(config)
    }
  }
  config.remove('action')
  String[] dataentry_hosts=config.dataentry_target.hosts.split(',')
  if (dataentry_hosts.size() >= 1) {
    dataentry_hosts.eachWithIndex { host, index ->
      config.action=[host:host, managed:index+1]
      _wlvmDataentryServerKill(config)
    }
  }
  config.remove('action')
  String[] recog_hosts=config.recog_target.hosts.split(',')
  if (recog_hosts.size() >= 1) {
    recog_hosts.eachWithIndex { host, index ->
      config.action=[host:host, managed:index+1]
      _wlvmRecogServerKill(config)
    }
  }
  config.remove('action')
  String[] scan_hosts=config.scan_target.hosts.split(',')
  if (scan_hosts.size() >= 1) {
    scan_hosts.eachWithIndex { host, index ->
      config.action=[host:host, managed:index+1]
      _wlvmScanServerKill(config)
    }
  }
  config.remove('action')
}

def _wlvmCoreServerKill(Map config) {
    String cmd
    cmd="'cd ${config.core_target.tmp} && . ./env.sh && ./kill.sh'"
    sshagent([config.ssh.agent]) {
      sh(_wlvmCoreHostSsh(config, cmd))
    }
}

def _wlvmDataentryServerKill(Map config) {
    String cmd
    cmd="'cd ${config.dataentry_target.tmp} && . ./env.sh && ./kill.sh'"
    sshagent([config.ssh.dataentry_agent]) {
      sh(_wlvmDataentryHostSsh(config, cmd))
    }
}

def _wlvmRecogServerKill(Map config) {
    String cmd
    cmd="'cd ${config.recog_target.tmp} && . ./env.sh && ./kill.sh'"
    sshagent([config.ssh.recog_agent]) {
      sh(_wlvmRecogHostSsh(config, cmd))
    }
}

def _wlvmScanServerKill(Map config) {
  String cmd
  cmd="'cd ${config.scan_target.tmp} && . ./env.sh && ./kill.sh'"
  sshagent([config.ssh.scan_agent]) {
    sh(_wlvmScanHostSsh(config, cmd))
  }
}

//
// Clean
//
def wlvmClean(Map config) {
  String[] gencore_hosts=config.core_target.hosts.split(',')
  for (host in gencore_hosts) {
    config.action=[host:host]
    _wlvmCoreHostClean(config)
  }
  config.remove('action')
  String[] dataentry_hosts=config.dataentry_target.hosts.split(',')
  for (host in dataentry_hosts) {
    config.action=[host:host]
    _wlvmDataentryHostClean(config)
  }
  config.remove('action')
  String[] recog_hosts=config.recog_target.hosts.split(',')
  for (host in recog_hosts) {
    config.action=[host:host]
    _wlvmRecogHostClean(config)
  }
  config.remove('action')
  String[] scan_hosts=config.scan_target.hosts.split(',')
  for (host in scan_hosts) {
    config.action=[host:host]
    _wlvmScanHostClean(config)
  }
  config.remove('action')
}

def _wlvmCoreHostClean(Map config) {
    sshagent([config.ssh.agent]) {
      if (_coredirExists(config, "${config.core_target.tmp}")){
        println "deleting ${config.core_target.tmp}"
        sh(_wlvmCoreHostSsh(config, "'cd ${config.core_target.tmp} && . ./env.sh && ./clean.sh'"))
        //sh(_wlvmCoreHostSsh(config, "'rm -r ${config.core_target.tmp}'"))
        sh(_wlvmCoreHostSsh(config, "'rm -r /var/fedex/genesis/gencore/tmp'"))
        
      } else {
        println "${config.core_target.tmp} does not exist"
      }
      sh(_wlvmCoreHostSsh(config, "'rm -r /opt/fedex/genesis/gencore/*'"))
    }
}

def _wlvmDataentryHostClean(Map config) {
    sshagent([config.ssh.dataentry_agent]) {
      if (_dataentrydirExists(config, "${config.dataentry_target.tmp}")){
        println "deleting ${config.dataentry_target.tmp}"
        sh(_wlvmDataentryHostSsh(config, "'cd ${config.dataentry_target.tmp} && . ./env.sh && ./clean.sh'"))
        sh(_wlvmDataentryHostSsh(config, "'rm -r /var/fedex/genesis/gendataentry/tmp'"))
      } else {
        println "${config.dataentry_target.tmp} does not exist"
      }
      sh(_wlvmDataentryHostSsh(config, "'rm -r /opt/fedex/genesis/gendataentry/*'"))
    }
}

def _wlvmRecogHostClean(Map config) {
    sshagent([config.ssh.recog_agent]) {
      if (_recogdirExists(config, "${config.recog_target.tmp}")){
        println "deleting ${config.recog_target.tmp}"
        sh(_wlvmRecogHostSsh(config, "'cd ${config.recog_target.tmp} && . ./env.sh && ./clean.sh'"))
        sh(_wlvmRecogHostSsh(config, "'rm -r /var/fedex/genesis/genrecog/tmp'"))
        sh(_wlvmRecogHostSsh(config, "'rm -r /opt/fedex/genesis/genrecog/*'"))
      } else {
        println "${config.recog_target.tmp} does not exist"
      }
    }
}

def _wlvmScanHostClean(Map config) {
    sshagent([config.ssh.scan_agent]) {

      if (_scandirExists(config, "${config.scan_target.tmp}")){
        println "deleting ${config.scan_target.tmp}"
        sh(_wlvmScanHostSsh(config, "'cd ${config.scan_target.tmp} && . ./env.sh && ./clean.sh'"))
        sh(_wlvmScanHostSsh(config, "'rm -r /var/fedex/genesis/genscan/tmp'"))
      } else {
        println "${config.scan_target.tmp} does not exist"
      }
      sh(_wlvmScanHostSsh(config, "'rm -r /opt/fedex/genesis/genscan/*'"))
    }
}

def sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd) {
    sshagent([sshAgent]) {
        cloudOpsHosts.split(',').each { cloudOpsHost ->
            sh """#!/bin/bash
            echo "========== in ssh: ${sshUser}@${cloudOpsHost}      >>>>>>>>>>"
            echo "ssh ${sshOptions} ${sshUser}@${cloudOpsHost} '${cmd}'"
            ssh ${sshOptions} ${sshUser}@${cloudOpsHost} '${cmd}'
            echo "<<<<<<<<<< exiting ssh: ${sshUser}@${cloudOpsHost} =========="
            """
        }
    }
}

//
//SCP
//

def _wlvmCoreHostScp(Map config, String from, String to, boolean isDownload) {
    String result
    if (isDownload) {
      result="scp ${config.ssh.options} ${config.ssh.user1}@${config.action.host}:${from} ${to}"
    } else {
      result="scp ${config.ssh.options} ${from} ${config.ssh.user1}@${config.action.host}:${to}"
    }
    return result
  } 

def _wlvmDataentryHostScp(Map config, String from, String to, boolean isDownload) {
    String result
    if (isDownload) {
      result="scp ${config.ssh.options} ${config.ssh.user2}@${config.action.host}:${from} ${to}"
    } else {
      result="scp ${config.ssh.options} ${from} ${config.ssh.user2}@${config.action.host}:${to}"
    }
    return result
  } 

def _wlvmRecogHostScp(Map config, String from, String to, boolean isDownload) {
    String result
    if (isDownload) {
      result="scp ${config.ssh.options} ${config.ssh.user3}@${config.action.host}:${from} ${to}"
    } else {
      result="scp ${config.ssh.options} ${from} ${config.ssh.user3}@${config.action.host}:${to}"
    }
    return result
  } 

def _wlvmScanHostScp(Map config, String from, String to, boolean isDownload) {
    String result
    if (isDownload) {
      result="scp ${config.ssh.options} ${config.ssh.user4}@${config.action.host}:${from} ${to}"
    } else {
      result="scp ${config.ssh.options} ${from} ${config.ssh.user4}@${config.action.host}:${to}"
    }
    return result
} 

//
//SSH
//

def _wlvmCoreHostSsh(Map config, String cmd) {
    return "ssh ${config.ssh.options} ${config.ssh.user1}@${config.action.host} ${cmd}"
}

def _wlvmDataentryHostSsh(Map config, String cmd) {
    return "ssh ${config.ssh.options} ${config.ssh.user2}@${config.action.host} ${cmd}"
}

def _wlvmRecogHostSsh(Map config, String cmd) {
    return "ssh ${config.ssh.options} ${config.ssh.user3}@${config.action.host} ${cmd}"
}

def _wlvmScanHostSsh(Map config, String cmd) {
    return "ssh ${config.ssh.options} ${config.ssh.user4}@${config.action.host} ${cmd}"
}

//
//Utility
//

def _wlvmCoreDomainDeployed(Map config) {
    boolean result
    String cmd="'[ -d ${config.domain.core_home} ]; echo \$?'"
    sshagent([config.ssh.agent]) {
      String value=sh(script:_wlvmCoreHostSsh(config, cmd), returnStdout:true).trim()
      result=value.equals("0")
    }
    return result
}

def _wlvmDataentryDomainDeployed(Map config) {
    boolean result
    String cmd="'[ -d ${config.domain.dataentry_home} ]; echo \$?'"
    sshagent([config.ssh.dataentry_agent]) {
      String value=sh(script:_wlvmDataentryHostSsh(config, cmd), returnStdout:true).trim()
      result=value.equals("0")
    }
    return result
}

def _wlvmRecogDomainDeployed(Map config) {
    boolean result
    String cmd="'[ -d ${config.domain.recog_home} ]; echo \$?'"
    sshagent([config.ssh.recog_agent]) {
      String value=sh(script:_wlvmRecogHostSsh(config, cmd), returnStdout:true).trim()
      result=value.equals("0")
    }
    return result
}

def _wlvmScanDomainDeployed(Map config) {
    boolean result
    String cmd="'[ -d ${config.domain.scan_home} ]; echo \$?'"
    sshagent([config.ssh.scan_agent]) {
      String value=sh(script:_wlvmScanHostSsh(config, cmd), returnStdout:true).trim()
      result=value.equals("0")
    }
    return result
}

def _coredirExists(Map config, dir) {
  boolean result
  String cmd="'[ -d ${dir} ]; echo \$?'"
  sshagent([config.ssh.agent]) {
    String value=sh(script:_wlvmCoreHostSsh(config, cmd), returnStdout:true).trim()
    result=value.equals("0")
  }
  return result
}

def _dataentrydirExists(Map config, dir) {
  boolean result
  String cmd="'[ -d ${dir} ]; echo \$?'"
  sshagent([config.ssh.dataentry_agent]) {
    String value=sh(script:_wlvmDataentryHostSsh(config, cmd), returnStdout:true).trim()
    result=value.equals("0")
  }
  return result
}

def _recogdirExists(Map config, dir) {
  boolean result
  String cmd="'[ -d ${dir} ]; echo \$?'"
  sshagent([config.ssh.recog_agent]) {
    String value=sh(script:_wlvmRecogHostSsh(config, cmd), returnStdout:true).trim()
    result=value.equals("0")
  }
  return result
}

def _scandirExists(Map config, dir) {
  boolean result
  String cmd="'[ -d ${dir} ]; echo \$?'"
  sshagent([config.ssh.scan_agent]) {
    String value=sh(script:_wlvmScanHostSsh(config, cmd), returnStdout:true).trim()
    result=value.equals("0")
  }
  return result
}

def Updating_domain(Map config, sshAgent, sshUser, sshOptions, cloudOpsHosts) {   
  println("<=================== Updating Domain ==================>")
  def cmd1 = """
		
    if [ ${ENVIRONMENT} == L2 ] 
      then
      /opt/fedex/genesis/java8_current/bin/java -cp .:/opt/fedex/genesis/wl12214_current/wlserver/server/lib/weblogic.jar weblogic.WLST /var/fedex/genesis/gencore/tmp/L2_DomainUpdate.py 
    elif [ ${ENVIRONMENT} == L3 ]
      then
      /opt/fedex/genesis/java8_current/bin/java -cp .:/opt/fedex/genesis/wl12214_current/wlserver/server/lib/weblogic.jar weblogic.WLST /var/fedex/genesis/gencore/tmp/L3_DomainUpdate.py
    elif [ ${ENVIRONMENT} == L4 ]
      then
      /opt/fedex/genesis/java8_current/bin/java -cp .:/opt/fedex/genesis/wl12214_current/wlserver/server/lib/weblogic.jar weblogic.WLST /var/fedex/genesis/gencore/tmp/L4_DomainUpdate.py
    elif [ ${ENVIRONMENT} == L3DR ]
      then
      /opt/fedex/genesis/java8_current/bin/java -cp .:/opt/fedex/genesis/wl12214_current/wlserver/server/lib/weblogic.jar weblogic.WLST /var/fedex/genesis/gencore/tmp/L3DR_DomainUpdate.py
    fi
		""".stripIndent()
sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd1)
wlvmRestart(config)

}

def deploy_JMS(sshAgent, sshUser, sshOptions, cloudOpsHosts){
    String adminUrl="http://${cloudOpsHosts}:${WLVM_SERVER_ADMIN_PORT}"
    String cmd1="cd /opt/fedex/genesis/gencore/current/genintl/ &&  /opt/fedex/genesis/java8_current/bin/java -cp .:/opt/fedex/genesis/wl12214_current/wlserver/server/lib/weblogic.jar weblogic.WLST /var/fedex/genesis/gencore/tmp/config-jms.properties -adminurl ${adminUrl} -user ${WLVM_DOMAIN_USERNAME} -password ${WLVM_DOMAIN_PASSWORD} -targets gencore-alpha,gencore-bravo,genscan,gencore-charlie"
    String cmd2="cd /opt/fedex/genesis/gencore/current/genintl/ && /opt/fedex/genesis/java8_current/bin/java -cp .:/opt/fedex/genesis/wl12214_current/wlserver/server/lib/weblogic.jar weblogic.WLST /var/fedex/genesis/gencore/tmp/gencore-IntlEDE_JMS_Module.py ${WLVM_TARGET} -adminurl ${adminUrl} -user ${WLVM_DOMAIN_USERNAME} -password ${WLVM_DOMAIN_PASSWORD} -targets gencore-alpha"
    String cmd3="cd /opt/fedex/genesis/gencore/current/genintl/ && /opt/fedex/genesis/java8_current/bin/java -cp \".:/opt/fedex/genesis/wl12214_current/wlserver/server/lib/weblogic.jar\" weblogic.WLST /var/fedex/genesis/gencore/tmp/gencore-Nafta_JMS_Module.py ${WLVM_TARGET} -adminurl ${adminUrl} -user ${WLVM_DOMAIN_USERNAME} -password ${WLVM_DOMAIN_PASSWORD} -targets gencore-bravo"
    String cmd4="cd /opt/fedex/genesis/gencore/current/genintl/ && /opt/fedex/genesis/java8_current/bin/java -cp \".:/opt/fedex/genesis/wl12214_current/wlserver/server/lib/weblogic.jar\" weblogic.WLST /var/fedex/genesis/gencore/tmp/gencore-SOE_Jms_Module.py ${WLVM_TARGET} -adminurl ${adminUrl} -user ${WLVM_DOMAIN_USERNAME} -password ${WLVM_DOMAIN_PASSWORD} -targets gencore-bravo"
    String cmd5="cd /opt/fedex/genesis/gencore/current/genintl/ && /opt/fedex/genesis/java8_current/bin/java -cp \".:/opt/fedex/genesis/wl12214_current/wlserver/server/lib/weblogic.jar\" weblogic.WLST /var/fedex/genesis/gencore/tmp/gencore-SoeComError_Jms_Module.py ${WLVM_TARGET} -adminurl ${adminUrl} -user ${WLVM_DOMAIN_USERNAME} -password ${WLVM_DOMAIN_PASSWORD} -targets gencore-bravo"
    String cmd6="cd /opt/fedex/genesis/gencore/current/genintl/ && /opt/fedex/genesis/java8_current/bin/java -cp \".:/opt/fedex/genesis/wl12214_current/wlserver/server/lib/weblogic.jar\" weblogic.WLST /var/fedex/genesis/gencore/tmp/gencore-SoeCom_Jms_Module.py ${WLVM_TARGET} -adminurl ${adminUrl} -user ${WLVM_DOMAIN_USERNAME} -password ${WLVM_DOMAIN_PASSWORD} -targets gencore-bravo"
    String cmd7="cd /opt/fedex/genesis/gencore/current/genintl/ && /opt/fedex/genesis/java8_current/bin/java -cp \".:/opt/fedex/genesis/wl12214_current/wlserver/server/lib/weblogic.jar\" weblogic.WLST /var/fedex/genesis/gencore/tmp/genscan-GenScanAgent_JMS_Module.py ${WLVM_TARGET} -adminurl ${adminUrl} -user ${WLVM_DOMAIN_USERNAME} -password ${WLVM_DOMAIN_PASSWORD} -targets genscan"
    String cmd8="cd /opt/fedex/genesis/gencore/current/genintl/ && /opt/fedex/genesis/java8_current/bin/java -cp \".:/opt/fedex/genesis/wl12214_current/wlserver/server/lib/weblogic.jar\" weblogic.WLST /var/fedex/genesis/gencore/tmp/gencore-BatchInitiate_JMS_Module.py ${WLVM_TARGET} -adminurl ${adminUrl} -user ${WLVM_DOMAIN_USERNAME} -password ${WLVM_DOMAIN_PASSWORD} -targets genscan"
    String cmd9="cd /opt/fedex/genesis/gencore/current/genintl/ && /opt/fedex/genesis/java8_current/bin/java -cp \".:/opt/fedex/genesis/wl12214_current/wlserver/server/lib/weblogic.jar\" weblogic.WLST /var/fedex/genesis/gencore/tmp/gencore-BatchPrep_JMS_Module.py ${WLVM_TARGET} -adminurl ${adminUrl} -user ${WLVM_DOMAIN_USERNAME} -password ${WLVM_DOMAIN_PASSWORD} -targets genscan"

    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd1)
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd2)
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd3)
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd4)
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd5)
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd6)
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd7)
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd8)
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd9)
}

def migration_data(sshAgent, sshUser, sshOptions, cloudOpsHosts) {
  String adminUrl="https://${cloudOpsHosts}:9902"
  String cmd1="cd /opt/fedex/genesis/gencore/servercfg/ && mkdir securityrealm"
  sshagent([sshAgent]) {
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHosts, cmd1)
    sh "scp ${sshOptions} -r ${WORKSPACE}/migration-data/* ${sshUser}@${cloudOpsHosts}:/opt/fedex/genesis/gencore/servercfg/securityrealm/"
  } 
}

def wlvmGencoreNM(sshAgent, sshUser, sshOptions, cloudOpsHosts){
  String cmd1="cd /opt/fedex/genesis/gencore/current/genintl/bin/ && chmod 777 startNM.sh stopNM.sh stop.sh start.sh stop.sh"
  sshagent([sshAgent]) {
    cloudOpsHosts.split(',').each { cloudOpsHost -> 
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/startNM.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/gencore/current/genintl/bin/"
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/stopNM.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/gencore/current/genintl/bin/"
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/stop.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/gencore/current/genintl/bin/"
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/start.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/gencore/current/genintl/bin/"
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHost, cmd1)
    }
  }
}

def wlvmDataentryNM(sshAgent, sshUser, sshOptions, cloudOpsHosts){
  String cmd1="cd /opt/fedex/genesis/gendataentry/current/genintl/bin/ && chmod 777 startNM.sh stopNM.sh start.sh stop.sh"
  sshagent([sshAgent]) {
    cloudOpsHosts.split(',').each { cloudOpsHost -> 
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/startNM.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/gendataentry/current/genintl/bin/"
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/stopNM.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/gendataentry/current/genintl/bin/"
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/start.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/gendataentry/current/genintl/bin/"
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/stop.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/gendataentry/current/genintl/bin/"
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHost, cmd1)
    }
  }
}

def wlvmRecogNM(sshAgent, sshUser, sshOptions, cloudOpsHosts){
  String cmd1="cd /opt/fedex/genesis/genrecog/current/genintl/bin/ && chmod 777 startNM.sh stopNM.sh start.sh stop.sh"
  sshagent([sshAgent]) {
    cloudOpsHosts.split(',').each { cloudOpsHost -> 
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/startNM.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/genrecog/current/genintl/bin/"
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/stopNM.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/genrecog/current/genintl/bin/"
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/start.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/genrecog/current/genintl/bin/"
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/stop.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/genrecog/current/genintl/bin/"
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHost, cmd1)
    }
  }
}

def wlvmScanNM(sshAgent, sshUser, sshOptions, cloudOpsHosts){
  String cmd1="cd /opt/fedex/genesis/genscan/current/genintl/bin/ && chmod 777 startNM.sh stopNM.sh start.sh stop.sh"
  sshagent([sshAgent]) {
    cloudOpsHosts.split(',').each { cloudOpsHost -> 
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/startNM.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/genscan/current/genintl/bin/"
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/stopNM.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/genscan/current/genintl/bin/"
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/start.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/genscan/current/genintl/bin/"
    sh "scp ${sshOptions} ${WORKSPACE}/domain/bin/stop.sh ${sshUser}@${cloudOpsHost}:/opt/fedex/genesis/genscan/current/genintl/bin/"
    sshIterator(sshAgent, sshUser, sshOptions, cloudOpsHost, cmd1)
    }
  }
}