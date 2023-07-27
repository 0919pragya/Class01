#!/bin/bash
set -x
###########################################################################
## start Servers
###########################################################################
EAINUMBER=7353
export EAINUMBER

#user=`id | tr "=()" "   " | awk '{print $3}'`
#if [[ $user != gendom ]]
#then
#    echo "This application may only be run by the genesis account"
#    exit 1
#fi

# Sanity check mandatory environment specific variables are set
if [ -z ${JRE_LINK} ]; then
  echo 'Environment variable "JRE_LINK" not set'
  exit 1
fi
if [ -z ${PROJECT_DOMAIN_HOME} ]; then
  echo 'Environment variable "PROJECT_DOMAIN_HOME" not set'
  exit 1
fi
if [ -z ${PROJECT_ADMIN_URL} ]; then
  echo 'Environment variable "PROJECT_ADMIN_URL" not set'
  exit 1
fi
if [ -z ${PROJECT_JAR_HOME} ]; then
  echo 'Environment variable "PROJECT_JAR_HOME" not set'
  exit 1
fi
if [ -z ${EAINUMBER} ]; then
  echo 'Environment variable "EAINUMBER" not set'
  exit 1
fi

# Set project properties
#DOMAIN_HOME=/opt/fedex/genesis/gendom/current/usgendom/bin/

usgendom_PROPERTIES_SSL_IGNORE=-Dweblogic.security.SSL.ignoreHostnameVerification=true
usgendom_PROPERTIES_DATA_TRANSFER=-Dweblogic.data.canTransferAnyFile=true
usgendom_PROPERTIES_IP4STACK=-Djava.net.preferIP4Stack=true
usgendom_PROPERTIES_WSEE_WSTX_WSAT=-Dweblogic.wsee.wstx.wsat.deployed=false
usgendom_PROPERTIES_SSL_PROTOCOL=-Dweblogic.security.SSL.minimumProtocolVersion=TLSv1.2
usgendom_PROPERTIES_SECURITY_PROPS=-Djava.security.properties=/opt/security/java.security.override

# Set Java vendor
JAVA_VENDOR=Oracle
export JAVA_VENDOR

HOSTNAME=`hostname`
HOST_PREFIX=`echo $HOSTNAME | cut -c1-8`
case $HOST_PREFIX in
    
    'u1062546'|'u1064310'|'u1064309'|'u1064311'|'u1064312'|'u1064637'|'u1064638'|'u1059926'|'u1060169'|'u1060168'|'u1060414'|'u1059987'|'u1060171'|'u1059991'|'u1051550'|'u1051291'|'u1051292'|'u1051661'|'u1052262'|'u1061499'|'u1061498'|'u1061568')
  
#------------------------- L3 env ------------------------------ 
        if [[ $HOST_PREFIX = u1062546 ]]
        then
			export GENDOMENV="L3"
			
			 usgendom_PROPERTIES="${usgendom_PROPERTIES_SSL_IGNORE} ${usgendom_PROPERTIES_DATA_TRANSFER} ${usgendom_PROPERTIES_IP4STACK} ${usgendom_PROPERTIES_WSEE_WSTX_WSAT} ${usgendom_PROPERTIES_SSL_PROTOCOL} ${usgendom_PROPERTIES_SECURITY_PROPS}"
        
        export usgendom_PROPERTIES
        APPD_SERVER_NAME=gen-lvl3-us-admin-las01
        export APPD_SERVER_NAME
		
 			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
             sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            
 			#AppDynamics Script call:
             if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
             then
                 . /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
             fi
             if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
             then
                 /opt/appd/current/scripts/machine_agent_appd.sh start
             fi
			
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			./startWebLogic.sh noderby 1>/dev/null 2>&1 &
			sleep 30
			chmod -R 777 *
			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			cd /opt/fedex/genesis/gendom/current/usgendom/config/nodemanager/
			chmod -R 777 *

        fi

       if [[ $HOST_PREFIX = u1064310 ]]
       then
			export GENDOMENV="L3"
			
			USER_MEM_ARGS="-Xms3072m -Xmx3072m"
			export USER_MEM_ARGS
			APPD_SERVER_NAME=gen-lvl3-us-gendom-las01
      		 	export APPD_SERVER_NAME

			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL3.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityAlias=genusdoml3" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
 			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
             sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties

			cd /opt/fedex/genesis/gendom/current/usgendom/servers/gendom11/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/gendom/current/usgendom/servers/gendom11/security/boot.properties
		   cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			#./startNodeManager.sh &
			sleep 10
			            
 			#AppDynamics Script call:
             if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
             then
                 . /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
             fi
             if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
             then
                 /opt/appd/current/scripts/machine_agent_appd.sh start
             fi
			
			#nohup ./startManagedWebLogic.sh gendom11 t3s://u1062546.test.cloud.fedex.com:9902/ -Dweblogic.management.server=https://u1062546.test.cloud.fedex.com:9902 noderby 1>/dev/null 2>&1 &
			nohup ./startManagedWebLogic.sh gendom11 t3s://u1062546.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 \ noderby 1>/dev/null 2>&1 &
			sleep 10
			ps -ef | grep java
       fi
      
	  if [[ $HOST_PREFIX = u1064309 ]]
       then
			export GENDOMENV="L3"
			USER_MEM_ARGS="-Xms3072m -Xmx3072m"
			export USER_MEM_ARGS
			#MEM_ARGS="${USER_MEM_ARGS}"
			#export MEM_ARGS
			APPD_SERVER_NAME=gen-lvl3-us-gendom-las02
            export APPD_SERVER_NAME

			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL3.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityAlias=genusdoml3" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
          
			cd /opt/fedex/genesis/gendom/current/usgendom/servers/gendom12/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/gendom/current/usgendom/servers/gendom12/security/boot.properties
		   cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			#./startNodeManager.sh &
			sleep 10
			 
 		#AppDynamics Script call:
             if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
             then
                 . /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
             fi
             if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
             then
                 /opt/appd/current/scripts/machine_agent_appd.sh start
             fi

			#nohup ./startManagedWebLogic.sh gendom12 t3s://u1062546.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			nohup ./startManagedWebLogic.sh gendom12 t3s://u1062546.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 \ noderby 1>/dev/null 2>&1 &
			sleep 10
			ps -ef | grep java
        fi
       
	   if [[ $HOST_PREFIX = u1064311 ]]
        then
			export GENDOMENV="L3"
			USER_MEM_ARGS="-Xms3072m -Xmx3072m"
			export USER_MEM_ARGS
			APPD_SERVER_NAME=gen-lvl3-us-gendom-las03
            export APPD_SERVER_NAME

			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL3.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityAlias=genusdoml3" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
 			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
             sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
           
			cd /opt/fedex/genesis/gendom/current/usgendom/servers/gendom13/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/gendom/current/usgendom/servers/gendom13/security/boot.properties
		   cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			#./startNodeManager.sh &
			sleep 10
			 
 		#AppDynamics Script call:
             if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
             then
                 . /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
             fi
             if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
             then
                 /opt/appd/current/scripts/machine_agent_appd.sh start
             fi
			
			#nohup ./startManagedWebLogic.sh gendom13 t3s://u1062546.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			nohup ./startManagedWebLogic.sh gendom13 t3s://u1062546.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 \ noderby 1>/dev/null 2>&1 &
			sleep 10
			ps -ef | grep java
        fi	
       
	   if [[ $HOST_PREFIX = u1064312 ]]
        then
			export GENDOMENV="L3"
			USER_MEM_ARGS="-Xms3072m -Xmx3072m"
			export USER_MEM_ARGS
			APPD_SERVER_NAME=gen-lvl3-us-gendom-las04
            export APPD_SERVER_NAME

			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL3.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityAlias=genusdoml3" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
 			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
          
		  cd /opt/fedex/genesis/gendom/current/usgendom/servers/gendom14/security/
			rm -rf boot.propertie
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/gendom/current/usgendom/servers/gendom14/security/boot.properties
		   cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			#./startNodeManager.sh &
			sleep 10
			 
 		  #AppDynamics Script call:
             if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
             then
                 . /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
             fi
             if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
             then
                 /opt/appd/current/scripts/machine_agent_appd.sh start
             fi

			#nohup ./startManagedWebLogic.sh gendom14 t3s://u1062546.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			nohup ./startManagedWebLogic.sh gendom14 t3s://u1062546.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 \ noderby 1>/dev/null 2>&1 &
			sleep 10
			ps -ef | grep java
        fi
       
	   if [[ $HOST_PREFIX = u1064637 ]]
        then
			export GENDOMENV="L3"
			
			USER_MEM_ARGS="-Xms1024m -Xmx1024m"
			export USER_MEM_ARGS
			APPD_SERVER_NAME=gen-lvl3-us-recog-las01
            export APPD_SERVER_NAME

			cd /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/genrecog/current/cfg/genusdomL3.jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityAlias=genusdoml3" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
 			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
             sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
          
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			cd /opt/fedex/genesis/genrecog/current/usgendom/servers/genrecog3/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/genrecog/current/usgendom/servers/genrecog3/security/boot.properties
		   cd /opt/fedex/genesis/genrecog/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			#./startNodeManager.sh &
			sleep 10
			 
 		#AppDynamics Script call:
             if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
             then
                 . /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
             fi
             if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
             then
                 /opt/appd/current/scripts/machine_agent_appd.sh start
             fi
			
			#nohup ./startManagedWebLogic.sh genrecog3 t3s://u1062546.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			nohup ./startManagedWebLogic.sh genrecog3 t3s://u1062546.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 \ noderby 1>/dev/null 2>&1 &
			sleep 10
			ps -ef | grep java
        fi
       
	   if [[ $HOST_PREFIX = u1064638 ]]
        then
			export GENDOMENV="L3"
			USER_MEM_ARGS="-Xms1024m -Xmx1024m"
			export USER_MEM_ARGS
			APPD_SERVER_NAME=gen-lvl3-us-recog-las02
            export APPD_SERVER_NAME

			cd /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/genrecog/current/cfg/genusdomL3.jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityAlias=genusdoml3" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
             sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
         
			cd /opt/fedex/genesis/genrecog/current/usgendom/servers/genrecog4/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/genrecog/current/usgendom/servers/genrecog4/security/boot.properties
		   cd /opt/fedex/genesis/genrecog/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			#./startNodeManager.sh &
			sleep 10
			 
 		#AppDynamics Script call:
             if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
             then
                 . /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
             fi
             if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
             then
                 /opt/appd/current/scripts/machine_agent_appd.sh start
             fi
			
			#nohup ./startManagedWebLogic.sh genrecog4 t3s://u1062546.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			nohup ./startManagedWebLogic.sh genrecog4 t3s://u1062546.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 \ noderby 1>/dev/null 2>&1 &
			sleep 10
			ps -ef | grep java
        fi
	
#----------------------------- L3DR -------------------------------------	
	if [[ $HOST_PREFIX = u1059926 ]]
        then
			export GENDOMENV="L3DR"
			usgendom_PROPERTIES="${usgendom_PROPERTIES_SSL_IGNORE} ${usgendom_PROPERTIES_DATA_TRANSFER} ${usgendom_PROPERTIES_IP4STACK} ${usgendom_PROPERTIES_WSEE_WSTX_WSAT} ${usgendom_PROPERTIES_SSL_PROTOCOL} ${usgendom_PROPERTIES_SECURITY_PROPS}"
        
        export usgendom_PROPERTIES
        APPD_SERVER_NAME=gen-lvl3-us-dr-admin-atl01
        export APPD_SERVER_NAME

		
 			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
             sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            
 			#AppDynamics Script call:
             if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
             then
                 . /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
             fi
             if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
             then
                 /opt/appd/current/scripts/machine_agent_appd.sh start
             fi
			
            cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			./startWebLogic.sh noderby 1>/dev/null 2>&1 &
			sleep 30
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdoml3DR" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL3DR.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			chmod -R 777 *
			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			sed -i -e "s/ListenAddress=localhost/ListenAddress=gen-lvl3-us-dr-admin-atl01.test.cloud.fedex.com/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties

        fi
		if [[ $HOST_PREFIX = u1060169 ]]
		then
			export GENDOMENV="L3DR"
			USER_MEM_ARGS="-Xms1024m -Xmx1024m"
			export USER_MEM_ARGS
			APPD_SERVER_NAME=gen-lvl3-us-dr-gendom-atl01
            export APPD_SERVER_NAME

			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdoml3DR" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL3DR.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
 			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
             sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
           
			cd /opt/fedex/genesis/gendom/current/usgendom/servers/gendom11/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/gendom/current/usgendom/servers/gendom11/security/boot.properties
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			chmod 777 /opt/fedex/genesis/gendom/current/usgendom/bin/L3-DR_gendom_node.py
			/opt/weblogic/wl12214_230117/wlserver/common/bin/wlst.sh /opt/fedex/genesis/gendom/current/usgendom/bin/L3-DR_gendom_node.py
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			#./startNodeManager.sh &
			sleep 10
			 
 			#AppDynamics Script call:
             if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
             then
                 . /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
             fi
             if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
             then
                 /opt/appd/current/scripts/machine_agent_appd.sh start
             fi
			
			#nohup ./startManagedWebLogic.sh gendom11 t3s://u1059926.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			nohup ./startManagedWebLogic.sh gendom11 t3s://gen-lvl3-us-dr-admin-atl01.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 \ noderby 1>/dev/null 2>&1 &
			sleep 10
			ps -ef | grep java
			
		fi
		if [[ $HOST_PREFIX = u1060168 ]]
		then
			export GENDOMENV="L3DR"
			USER_MEM_ARGS="-Xms1024m -Xmx1024m"
			export USER_MEM_ARGS
			APPD_SERVER_NAME=gen-lvl3-us-dr-gendom-atl02
            export APPD_SERVER_NAME

			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdoml3DR" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL3DR.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
 			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            
			cd /opt/fedex/genesis/gendom/current/usgendom/servers/gendom12/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/gendom/current/usgendom/servers/gendom12/security/boot.properties
			#cd /opt/fedex/genesis/gendom/current/usgendom/config
			#chmod 775 /opt/fedex/genesis/gendom/current/usgendom/config/config.xml
			#sed -i -e "s/{AES256}17kz5e4Lea7OZ3gBqWvrTiSklA2/TrFaeCMK/KtvxrI=/genusdom@7353/g" /opt/fedex/genesis/gendom/current/usgendom/config/config.xml  
			
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			chmod 777 /opt/fedex/genesis/gendom/current/usgendom/bin/L3-DR_gendom_node.py
			/opt/weblogic/wl12214_230117/wlserver/common/bin/wlst.sh /opt/fedex/genesis/gendom/current/usgendom/bin/L3-DR_gendom_node.py
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 &
			# ./startNodeManager.sh &
			sleep 5
			
 			#AppDynamics Script call:
             if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
             then
                 . /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
             fi
             if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
             then
                 /opt/appd/current/scripts/machine_agent_appd.sh start
             fi
			
			# ./startManagedWebLogic.sh gendom12 t3s://u1059926.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			nohup ./startManagedWebLogic.sh gendom12 t3s://u1059926.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353\ noderby 1>/dev/null 2>&1 &
			 sleep 10
			 
        fi
        if [[ $HOST_PREFIX = u1060414 ]]
        then
			export GENDOMENV="L3DR"
			USER_MEM_ARGS="-Xms1024m -Xmx1024m"
			export USER_MEM_ARGS
			APPD_SERVER_NAME=gen-lvl3-us-dr-gendom-atl03
            export APPD_SERVER_NAME

			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdoml3DR" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL3DR.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
 			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
             sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			
			cd /opt/fedex/genesis/gendom/current/usgendom/servers/gendom13/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/gendom/current/usgendom/servers/gendom13/security/boot.properties
            cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			chmod 777 /opt/fedex/genesis/gendom/current/usgendom/bin/L3-DR_gendom_node.py
			/opt/weblogic/wl12214_230117/wlserver/common/bin/wlst.sh /opt/fedex/genesis/gendom/current/usgendom/bin/L3-DR_gendom_node.py
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 &
			# ./startNodeManager.sh &
			sleep 5
			
 			#AppDynamics Script call:
             if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
             then
                 . /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
             fi
             if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
             then
                 /opt/appd/current/scripts/machine_agent_appd.sh start
             fi
            nohup ./startManagedWebLogic.sh gendom13 t3s://u1059926.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 \ noderby 1>/dev/null 2>&1 &
	    sleep 10
			
        fi	
        if [[ $HOST_PREFIX = u1059987 ]]
        then
			export GENDOMENV="L3DR"
			USER_MEM_ARGS="-Xms1024m -Xmx1024m"
			export USER_MEM_ARGS
			APPD_SERVER_NAME=gen-lvl3-us-dr-gendom-atl04
            export APPD_SERVER_NAME

			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdoml3DR" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL3DR.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
 			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
          
			cd /opt/fedex/genesis/gendom/current/usgendom/servers/gendom14/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/gendom/current/usgendom/servers/gendom14/security/boot.properties
            cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			chmod 777 /opt/fedex/genesis/gendom/current/usgendom/bin/L3-DR_gendom_node.py
			/opt/weblogic/wl12214_230117/wlserver/common/bin/wlst.sh /opt/fedex/genesis/gendom/current/usgendom/bin/L3-DR_gendom_node.py
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 &
			# ./startNodeManager.sh &
			sleep 5
			
 		 	#AppDynamics Script call:
             if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
             then
                 . /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
             fi
             if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
             then
                 /opt/appd/current/scripts/machine_agent_appd.sh start
             fi
			
			nohup ./startManagedWebLogic.sh gendom14 t3s://u1059926.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 \ noderby 1>/dev/null 2>&1 &
			sleep 10
			
        fi
        if [[ $HOST_PREFIX = u1060171 ]]
        then
			export GENDOMENV="L3DR"
			USER_MEM_ARGS="-Xms1024m -Xmx1024m"
			export USER_MEM_ARGS
			APPD_SERVER_NAME=gen-lvl3-us-dr-recog-atl01
            export APPD_SERVER_NAME

			cd /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdoml3DR" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/genrecog/current/cfg/genusdomL3DR.jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			cd /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/
			chmod -R 777 *
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
 			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
             sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            
			cd /opt/fedex/genesis/genrecog/current/usgendom/servers/genrecog3/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/genrecog/current/usgendom/servers/genrecog3/security/boot.properties
            cd /opt/fedex/genesis/genrecog/current/usgendom/bin/
			chmod 777 /opt/fedex/genesis/genrecog/current/usgendom/bin/L3-DR_genrecog_node.py
			/opt/weblogic/wl12214_230117/wlserver/common/bin/wlst.sh /opt/fedex/genesis/genrecog/current/usgendom/bin/L3-DR_genrecog_node.py
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 &
			# ./startNodeManager.sh &
			sleep 5
			
 			#AppDynamics Script call:
             if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
             then
                 . /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
             fi
             if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
             then
                 /opt/appd/current/scripts/machine_agent_appd.sh start
             fi
			
			nohup ./startManagedWebLogic.sh genrecog3 t3s://u1059926.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 \ noderby 1>/dev/null 2>&1 &
			sleep 10
			
        fi
        if [[ $HOST_PREFIX = u1059991 ]]
        then
			export GENDOMENV="L3DR"
			USER_MEM_ARGS="-Xms1024m -Xmx1024m"
			export USER_MEM_ARGS
			APPD_SERVER_NAME=gen-lvl3-us-dr-recog-atl02
            export APPD_SERVER_NAME

			cd /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdoml3DR" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/genrecog/current/cfg/genusdomL3DR.jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
 			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
             sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
	
			cd /opt/fedex/genesis/genrecog/current/usgendom/servers/genrecog4/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/genrecog/current/usgendom/servers/genrecog4/security/boot.properties
            cd /opt/fedex/genesis/genrecog/current/usgendom/bin/
			chmod 777 /opt/fedex/genesis/genrecog/current/usgendom/bin/L3-DR_genrecog_node.py
			#/opt/weblogic/wl12214_230117/wlserver/common/bin/wlst.sh /opt/fedex/genesis/genrecog/current/usgendom/bin/L3-DR_genrecog_node.py
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 &
			# ./startNodeManager.sh &
			sleep 5
			
 			#AppDynamics Script call:
             if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
             then
                 . /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
             fi
             if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
             then
                 /opt/appd/current/scripts/machine_agent_appd.sh start
             fi
           nohup  ./startManagedWebLogic.sh genrecog4 t3s://u1059926.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 \ noderby 1>/dev/null 2>&1 &
	   sleep 10
        fi
		
#------------------------------------------------ L2 env --------------------------------		
		if [[ $HOST_PREFIX = u1051550 ]]
        then
			export GENDOMENV="L2"
			usgendom_PROPERTIES="${usgendom_PROPERTIES_SSL_IGNORE} ${usgendom_PROPERTIES_DATA_TRANSFER} ${usgendom_PROPERTIES_IP4STACK} ${usgendom_PROPERTIES_WSEE_WSTX_WSAT} ${usgendom_PROPERTIES_SSL_PROTOCOL} ${usgendom_PROPERTIES_SECURITY_PROPS}"
        
        export usgendom_PROPERTIES
		
			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			./startWebLogic.sh noderby 1>/dev/null 2>&1 &
			sleep 30
	#		echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
         #   echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
         #  echo "CustomIdentityAlias=genusdomL2" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
         #   echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
         #   echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL2.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
         #   echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
         #   echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			chmod -R 777 *
			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			sed -i -e "s/ListenAddress=localhost/ListenAddress=gen-lvl2-us-admin-las01.test.cloud.fedex.com/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties

        fi
		if [[ $HOST_PREFIX = u1051291 ]]
		then
			export GENDOMENV="L2"
			USER_MEM_ARGS="-Xms768m -Xmx768m"
			export USER_MEM_ARGS
			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdomL2" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL2.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			cd /opt/fedex/genesis/gendom/current/usgendom/servers/gendom11/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/gendom/current/usgendom/servers/gendom11/security/boot.properties
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			#./startNodeManager.sh &
			sleep 10
			#nohup ./startManagedWebLogic.sh gendom11 t3s://u1051550.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			nohup ./startManagedWebLogic.sh gendom11 t3s://u1051550.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts  -Dweblogic.security.SSL.trustedCAKeyStoreType=JKS  -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 noderby 1>/dev/null 2>&1 &
			sleep 10
			ps -ef | grep java
			
		fi
		if [[ $HOST_PREFIX = u1051292 ]]
		then
			export GENDOMENV="L2"
			USER_MEM_ARGS="-Xms768m -Xmx768m"
			export USER_MEM_ARGS
			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdomL2" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL2.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			cd /opt/fedex/genesis/gendom/current/usgendom/servers/gendom12/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/gendom/current/usgendom/servers/gendom12/security/boot.properties
			#cd /opt/fedex/genesis/gendom/current/usgendom/config
			#chmod 775 /opt/fedex/genesis/gendom/current/usgendom/config/config.xml
			#sed -i -e "s/{AES256}17kz5e4Lea7OZ3gBqWvrTiSklA2/TrFaeCMK/KtvxrI=/genusdom@7353/g" /opt/fedex/genesis/gendom/current/usgendom/config/config.xml  
			
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 &
			# ./startNodeManager.sh &
			sleep 5
			# ./startManagedWebLogic.sh gendom12 t3s://u1051550.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			nohup ./startManagedWebLogic.sh gendom12 t3s://u1051550.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts  -Dweblogic.security.SSL.trustedCAKeyStoreType=JKS  -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 noderby 1>/dev/null 2>&1 &
			 sleep 10
			 
        fi
      
        if [[ $HOST_PREFIX = u1051661 ]]
        then
			export GENDOMENV="L2"
			USER_MEM_ARGS="-Xms768m -Xmx768m"
			export USER_MEM_ARGS
			cd /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdomL2" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/genrecog/current/cfg/genusdomL2.jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			cd /opt/fedex/genesis/genrecog/current/usgendom/servers/genrecog4/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/genrecog/current/usgendom/servers/genrecog4/security/boot.properties
            cd /opt/fedex/genesis/genrecog/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 &
			# ./startNodeManager.sh &
			sleep 5
           nohup  ./startManagedWebLogic.sh genrecog4 t3s://u1051550.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts  -Dweblogic.security.SSL.trustedCAKeyStoreType=JKS  -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353  noderby 1>/dev/null 2>&1 &
	   sleep 10
        fi
		
#----------------------------------- L4 env -----------------------------------

		if [[ $HOST_PREFIX = u1052262 ]]
        then
			export GENDOMENV="L4"
			usgendom_PROPERTIES="${usgendom_PROPERTIES_SSL_IGNORE} ${usgendom_PROPERTIES_DATA_TRANSFER} ${usgendom_PROPERTIES_IP4STACK} ${usgendom_PROPERTIES_WSEE_WSTX_WSAT} ${usgendom_PROPERTIES_SSL_PROTOCOL} ${usgendom_PROPERTIES_SECURITY_PROPS}"
        
        export usgendom_PROPERTIES
			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			./startWebLogic.sh noderby 1>/dev/null 2>&1 &
			sleep 30
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdomL4" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL4.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			chmod -R 777 *
			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			sed -i -e "s/ListenAddress=localhost/ListenAddress=gen-lvl4-us-admin-las01.test.cloud.fedex.com/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties

        fi
		if [[ $HOST_PREFIX = u1061499 ]]
		then
			export GENDOMENV="L4"
			USER_MEM_ARGS="-Xms768m -Xmx768m"
			export USER_MEM_ARGS
			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdomL4" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL4.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			cd /opt/fedex/genesis/gendom/current/usgendom/servers/gendom11/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/gendom/current/usgendom/servers/gendom11/security/boot.properties
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			#./startNodeManager.sh &
			sleep 10
			#nohup ./startManagedWebLogic.sh gendom11 t3s://u1052262.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			nohup ./startManagedWebLogic.sh gendom11 t3s://u1052262.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 \ noderby 1>/dev/null 2>&1 &
			sleep 10
			ps -ef | grep java
			
		fi
		if [[ $HOST_PREFIX = u1061498 ]]
		then
			export GENDOMENV="L4"
			USER_MEM_ARGS="-Xms768m -Xmx768m"
			export USER_MEM_ARGS
			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdomL4" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL4.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			cd /opt/fedex/genesis/gendom/current/usgendom/servers/gendom12/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/gendom/current/usgendom/servers/gendom12/security/boot.properties
			#cd /opt/fedex/genesis/gendom/current/usgendom/config
			#chmod 775 /opt/fedex/genesis/gendom/current/usgendom/config/config.xml
			#sed -i -e "s/{AES256}17kz5e4Lea7OZ3gBqWvrTiSklA2/TrFaeCMK/KtvxrI=/genusdom@7353/g" /opt/fedex/genesis/gendom/current/usgendom/config/config.xml  
			
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 &
			# ./startNodeManager.sh &
			sleep 5
			# ./startManagedWebLogic.sh gendom12 t3s://u1052262.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			nohup ./startManagedWebLogic.sh gendom12 t3s://u1052262.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353\ noderby 1>/dev/null 2>&1 &
			 sleep 10
			 
        fi
      
        if [[ $HOST_PREFIX = u1061568 ]]
        then
			export GENDOMENV="L4"
			USER_MEM_ARGS="-Xms768m -Xmx768m"
			export USER_MEM_ARGS
			cd /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdomL4" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/genrecog/current/cfg/genusdomL4.jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			sed -i '$ a\weblogic.StopScriptName=stopWebLogic.sh' /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            sed -i '/^weblogic.StopScriptEnabled=/d' /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties && echo "weblogic.StopScriptEnabled=true" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			cd /opt/fedex/genesis/genrecog/current/usgendom/servers/genrecog4/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/genrecog/current/usgendom/servers/genrecog4/security/boot.properties
            cd /opt/fedex/genesis/genrecog/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 &
			# ./startNodeManager.sh &
			sleep 5
           nohup  ./startManagedWebLogic.sh genrecog4 t3s://u1052262.test.cloud.fedex.com:9902/ -Dweblogic.security.SSL.trustedCAKeyStore=/opt/fedex/genesis/java8_current/jre/lib/security/cacerts \
-Dweblogic.security.SSL.trustedCAKeyStoreType=JKS \ -Dweblogic.security.SSL.trustedCAKeyStorePassword=genusdom@7353 \ noderby 1>/dev/null 2>&1 &
	   sleep 10
        fi
    ;;     
    *)
        echo "Unknown network address - Exiting"
        exit 1
    ;;
esac
