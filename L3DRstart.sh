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

# Set Java vendor
JAVA_VENDOR=Oracle
export JAVA_VENDOR

HOSTNAME=`hostname`
HOST_PREFIX=`echo $HOSTNAME | cut -c1-8`
case $HOST_PREFIX in
    
    'u1059926'|'u1060169'|'u1060168'|'u1060414'|'u1059987'|'u1060171'|'u1059991')
	
if [[ $HOST_PREFIX = u1060169 ]]
		then
			export GENDOMENV="L3DR"
			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdoml3DR" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL3DR.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/java/hotspot/8/64_bit/jdk1.8.0_361/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
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
			sleep 20
			#cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			#chmod 777 /opt/fedex/genesis/gendom/current/usgendom/bin/L3DR_MSstart11.py
			#sleep 20
			#/opt/weblogic/wl12214_230117/wlserver/common/bin/wlst.sh #/opt/fedex/genesis/gendom/current/usgendom/bin/L3DR_MSstart11.py
			ps -ef | grep java
			nohup ./startManagedWebLogic.sh gendom11 t3s://u1059926.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			sleep 5
			ps -ef | grep java
			
		fi
		if [[ $HOST_PREFIX = u1060168 ]]
		then
			export GENDOMENV="L3DR"
			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdoml3DR" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL3DR.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/java/hotspot/8/64_bit/jdk1.8.0_361/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			cd /opt/fedex/genesis/gendom/current/usgendom/servers/gendom12/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/gendom/current/usgendom/servers/gendom12/security/boot.properties
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			chmod 777 /opt/fedex/genesis/gendom/current/usgendom/bin/L3-DR_gendom_node.py
			/opt/weblogic/wl12214_230117/wlserver/common/bin/wlst.sh /opt/fedex/genesis/gendom/current/usgendom/bin/L3-DR_gendom_node.py
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 &
			# ./startNodeManager.sh &
			sleep 5
			# ./startManagedWebLogic.sh gendom12 t3s://u1059926.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			nohup ./startManagedWebLogic.sh gendom12 t3s://u1059926.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			 sleep 10
			 
        fi
        if [[ $HOST_PREFIX = u1060414 ]]
        then
			export GENDOMENV="L3DR"
			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdoml3DR" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL3DR.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/java/hotspot/8/64_bit/jdk1.8.0_361/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
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
            nohup ./startManagedWebLogic.sh gendom13 t3s://u1060414.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
	    sleep 10
			
        fi	
        if [[ $HOST_PREFIX = u1059987 ]]
        then
			export GENDOMENV="L3DR"
			cd /opt/fedex/genesis/gendom/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdoml3DR" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/gendom/current/cfg/genusdomL3DR.jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/java/hotspot/8/64_bit/jdk1.8.0_361/jre/lib/security/cacerts" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/gendom/current/usgendom/nodemanager/nodemanager.properties
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
			nohup ./startManagedWebLogic.sh gendom14 t3s://u1059926.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			sleep 10
			
        fi
        if [[ $HOST_PREFIX = u1060171 ]]
        then
			export GENDOMENV="L3DR"
			cd /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdoml3DR" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/genrecog/current/cfg/genusdomL3DR.jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/java/hotspot/8/64_bit/jdk1.8.0_361/jre/lib/security/cacerts" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			cd /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/
			chmod -R 777 *
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
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
			nohup ./startManagedWebLogic.sh genrecog3 t3s://u1059926.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
			sleep 10
			
        fi
        if [[ $HOST_PREFIX = u1059991 ]]
        then
			export GENDOMENV="L3DR"
			cd /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/
			chmod -R 777 *
			echo "KeyStores=CustomIdentityAndJavaStandardTrust" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreType=JKS" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityAlias=genusdoml3DR" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityPrivateKeyPassPhrase=genusdom@7353" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "CustomIdentityKeyStoreFileName=/opt/fedex/genesis/genrecog/current/cfg/genusdomL3DR.jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystore=/opt/java/hotspot/8/64_bit/jdk1.8.0_361/jre/lib/security/cacerts" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
            echo "JavaStandardTrustKeystoreType=jks" >> /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			
			#sed -i -e "s/SecureListener=true/SecureListener=false/g" /opt/fedex/genesis/genrecog/current/usgendom/nodemanager/nodemanager.properties
			cd /opt/fedex/genesis/genrecog/current/usgendom/servers/genrecog4/security/
			rm -rf boot.properties
			echo "username=weblogic" > boot.properties
			echo "password=WebLog1c$" >> boot.properties
			chmod 775 /opt/fedex/genesis/genrecog/current/usgendom/servers/genrecog4/security/boot.properties
            cd /opt/fedex/genesis/genrecog/current/usgendom/bin/
			chmod 777 /opt/fedex/genesis/genrecog/current/usgendom/bin/L3-DR_genrecog_node.py
			/opt/weblogic/wl12214_230117/wlserver/common/bin/wlst.sh /opt/fedex/genesis/genrecog/current/usgendom/bin/L3-DR_genrecog_node.py
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 &
			# ./startNodeManager.sh &
			sleep 5
           nohup  ./startManagedWebLogic.sh genrecog4 t3s://u1059926.test.cloud.fedex.com:9902/ noderby 1>/dev/null 2>&1 &
	   sleep 10
        fi
		    ;;     
    *)
        echo "Unknown network address - Exiting"
        exit 1
    ;;
esac
