#!/bin/bash
set -x
###########################################################################
## start NodeManagers
###########################################################################
EAINUMBER=7353
export EAINUMBER
HOSTNAME=`hostname`
HOST_PREFIX=`echo $HOSTNAME | cut -c1-8`
case $HOST_PREFIX in
    
    'u1064310'|'u1064309'|'u1064311'|'u1064312'|'u1064637'|'u1064638'|'u1060169'|'u1060168'|'u1060414'|'u1059987'|'u1060171'|'u1059991'|'u1051291'|'u1051292'|'u1051661'|'u1061499'|'u1061498'|'u1061568')
  
#------------------------- L3 env ------------------------------ 
       if [[ $HOST_PREFIX = u1064310 ]]
       then
       		export GENDOMENV="L3"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
			
			APPD_SERVER_NAME=gen-lvl3-us-gendom-las01
			export APPD_SERVER_NAME
        		if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
        		then
            		. /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
        		fi
        		if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        		then
            		/opt/appd/current/scripts/machine_agent_appd.sh start
        		fi
       fi
      
	  if [[ $HOST_PREFIX = u1064309 ]]
       then
		export GENDOMENV="L3"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
			
			APPD_SERVER_NAME=gen-lvl3-us-gendom-las02
			export APPD_SERVER_NAME
        		if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
        		then
            		. /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
        		fi
        		if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        		then
            		/opt/appd/current/scripts/machine_agent_appd.sh start
        		fi
        fi
       
	     if [[ $HOST_PREFIX = u1064311 ]]
        then
            export GENDOMENV="L3"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
			
			APPD_SERVER_NAME=gen-lvl3-us-gendom-las03
			export APPD_SERVER_NAME
        		if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
        		then
            		. /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
        		fi
        		if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        		then
            		/opt/appd/current/scripts/machine_agent_appd.sh start
        		fi
        fi	
       
	   if [[ $HOST_PREFIX = u1064312 ]]
        then
        	export GENDOMENV="L3"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
			
			APPD_SERVER_NAME=gen-lvl3-us-gendom-las04
			export APPD_SERVER_NAME
        		if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
        		then
            		. /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
        		fi
        		if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        		then
            		/opt/appd/current/scripts/machine_agent_appd.sh start
        		fi
        fi
       
	   if [[ $HOST_PREFIX = u1064637 ]]
        then
        	export GENDOMENV="L3"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
			
			APPD_SERVER_NAME=gen-lvl3-us-recog-las01
			export APPD_SERVER_NAME
        		if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
        		then
            		. /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
        		fi
        		if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        		then
            		/opt/appd/current/scripts/machine_agent_appd.sh start
        		fi
        fi
       
	   if [[ $HOST_PREFIX = u1064638 ]]
        then
        	export GENDOMENV="L3"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
			
			APPD_SERVER_NAME=gen-lvl3-us-recog-las02
			export APPD_SERVER_NAME
        		if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
        		then
            		. /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
        		fi
        		if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        		then
            		/opt/appd/current/scripts/machine_agent_appd.sh start
        		fi
        fi
	
#----------------------------- L3DR -------------------------------------	
	if [[ $HOST_PREFIX = u1060169 ]]
	then
        	export GENDOMENV="L3DR"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
			
			APPD_SERVER_NAME=gen-lvl3-us-dr-gendom-atl01
			export APPD_SERVER_NAME
        		if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
        		then
            		. /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
        		fi
        		if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        		then
            		/opt/appd/current/scripts/machine_agent_appd.sh start
        		fi
		fi
	if [[ $HOST_PREFIX = u1060168 ]]
	then
        	export GENDOMENV="L3DR"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
			
			APPD_SERVER_NAME=gen-lvl3-us-dr-gendom-atl02
			export APPD_SERVER_NAME
        		if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
        		then
            		. /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
        		fi
        		if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        		then
            		/opt/appd/current/scripts/machine_agent_appd.sh start
        		fi
        fi
        if [[ $HOST_PREFIX = u1060414 ]]
        then
        	export GENDOMENV="L3DR"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
			
			APPD_SERVER_NAME=gen-lvl3-us-dr-gendom-atl03
			export APPD_SERVER_NAME
        		if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
        		then
            		. /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
        		fi
        		if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        		then
            		/opt/appd/current/scripts/machine_agent_appd.sh start
        		fi
        fi	
        if [[ $HOST_PREFIX = u1059987 ]]
        then
        	export GENDOMENV="L3DR"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
			
			APPD_SERVER_NAME=gen-lvl3-us-dr-gendom-atl04
			export APPD_SERVER_NAME
        		if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
        		then
            		. /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
        		fi
        		if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        		then
            		/opt/appd/current/scripts/machine_agent_appd.sh start
        		fi
        fi
        if [[ $HOST_PREFIX = u1060171 ]]
        then
        	export GENDOMENV="L3DR"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
			
			APPD_SERVER_NAME=gen-lvl3-us-dr-recog-atl01
			export APPD_SERVER_NAME
        		if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
        		then
            		. /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
        		fi
        		if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        		then
            		/opt/appd/current/scripts/machine_agent_appd.sh start
        		fi
        fi
        if [[ $HOST_PREFIX = u1059991 ]]
        then
        	export GENDOMENV="L3DR"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
			
			APPD_SERVER_NAME=gen-lvl3-us-dr-recog-atl02
			export APPD_SERVER_NAME
        		if [[ -e /opt/appd/current/appagent/javaagent.jar ]]
        		then
            		. /opt/appd/current/scripts/app_agent_appd.sh ${EAINUMBER}
        		fi
        		if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        		then
            		/opt/appd/current/scripts/machine_agent_appd.sh start
        		fi
        fi
		
#------------------------------------------------ L2 env --------------------------------		
		if [[ $HOST_PREFIX = u1051291 ]]
		then
			export GENDOMENV="L2"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
		fi
		if [[ $HOST_PREFIX = u1051292 ]]
		then
			export GENDOMENV="L2"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
        fi
      
        if [[ $HOST_PREFIX = u1051661 ]]
        then
			export GENDOMENV="L2"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
        fi
		
#----------------------------------- L4 env -----------------------------------

		if [[ $HOST_PREFIX = u1061499 ]]
		then
			export GENDOMENV="L4"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
		fi
		if [[ $HOST_PREFIX = u1061498 ]]
		then
        export GENDOMENV="L4"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
        fi
      
        if [[ $HOST_PREFIX = u1061568 ]]
        then
        export GENDOMENV="L4"
			cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			nohup ./startNodeManager.sh noderby 1>/dev/null 2>&1 & 
			ps -ef | grep java
			sleep 5
        fi
    ;;     
    *)
        echo "Unknown network address - Exiting"
        exit 1
    ;;
esac
