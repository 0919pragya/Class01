#!/bin/bash

###########################################################################
## stop Servers
###########################################################################
EAINUMBER=7353
export EAINUMBER
#DOMAIN_HOME=/opt/fedex/genesis/gendom/current/usgendom/bin/

HOSTNAME=`hostname`
HOST_PREFIX=`echo $HOSTNAME | cut -c1-8`
case $HOST_PREFIX in

	'u1051550'|'u1051291'|'u1051292'|'u1051661'|'u1062546'|'u1064310'|'u1064309'|'u1064311'|'u1064312'|'u1064637'|'u1064638'|'u1059926'|'u1060169'|'u1060168'|'u1060414'|'u1059987'|'u1060171'|'u1059991'|'u1052262'|'u1061499'|'u1061498'|'u1061568')
    
    	if [[ $HOST_PREFIX = u1051291 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L2"
          		 cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     ./stopManagedWebLogic.sh gendom11 t3s://u1051550.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			    PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer ..."
				  kill -9 $PID
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1051292 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L2"
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     ./stopManagedWebLogic.sh gendom12 t3s://u1051550.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer..."
				  kill -9 $PID
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1051661 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L2"
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     ./stopManagedWebLogic.sh gendom13 t3s://u1051550.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer..."
				  kill -9 $PID
			     fi
			fi
        fi

	if [[ $HOST_PREFIX = u1051550 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L2"
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     #./stopNodeManager.sh
			     ./stopWebLogic.sh
			      PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the AdminServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "Admin Server is Stopped"
			     else
			          echo "Admin server is still running with PID: $PID"
			          echo "Stopping AdminServer..."
				  kill -9 $PID
			fi
        fi
	fi		
		if [[ $HOST_PREFIX = u1064310 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L3"
 				#AppDynamics Script call:
 				echo "Stopping AppDynamics…"
 				if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
 				then
 				/opt/appd/current/scripts/machine_agent_appd.sh stop
 				fi
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     ./stopManagedWebLogic.sh gendom11 t3s://u1062546.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			    # PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			    # PID1=$(ps aux | grep [w]eblogic.NodeManager | awk '{print $2}')
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer ..."
				  kill -9 $PID 
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1064309 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L3"
				#AppDynamics Script call:
				echo "Stopping AppDynamics…"
				if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
				then
				/opt/appd/current/scripts/machine_agent_appd.sh stop
				fi
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     ./stopManagedWebLogic.sh gendom12 t3s://u1062546.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			    # PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			     #PID1=$(ps aux | grep [w]eblogic.NodeManager | awk '{print $2}')
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer..."
				  kill -9 $PID 
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1064311 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L3"
				#AppDynamics Script call:
				echo "Stopping AppDynamics…"
				if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
				then
				/opt/appd/current/scripts/machine_agent_appd.sh stop
				fi
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     ./stopManagedWebLogic.sh gendom13 t3s://u1062546.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			     #PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			     #PID1=$(ps aux | grep [w]eblogic.NodeManager | awk '{print $2}')
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer..."
				  #kill -9 $PID $PID1
				  kill -9 $PID
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1064312 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L3"
				#AppDynamics Script call:
				echo "Stopping AppDynamics…"
				if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
				then
				/opt/appd/current/scripts/machine_agent_appd.sh stop
				fi
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     ./stopManagedWebLogic.sh gendom14 t3s://u1062546.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			     #PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			     #PID1=$(ps aux | grep [w]eblogic.NodeManager | awk '{print $2}')
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer..."
				  kill -9 $PID 
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1064637 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L3"
				#AppDynamics Script call:
				echo "Stopping AppDynamics…"
				if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
				then
				/opt/appd/current/scripts/machine_agent_appd.sh stop
				fi
          		     cd /opt/fedex/genesis/genrecog/current/usgendom/bin/
			     ./stopManagedWebLogic.sh genrecog3 t3s://u1062546.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			     #PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			     #PID1=$(ps aux | grep [w]eblogic.NodeManager | awk '{print $2}')
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer..."
				  kill -9 $PID
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1064638 ]]
then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L3"
				#AppDynamics Script call:
				echo "Stopping AppDynamics…"
				if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
				then
				/opt/appd/current/scripts/machine_agent_appd.sh stop
				fi
          		     cd /opt/fedex/genesis/genrecog/current/usgendom/bin/
			     ./stopManagedWebLogic.sh genrecog4 t3s://u1062546.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer..."
				  kill -9 $PID 
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1062546 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L3"
				#AppDynamics Script call:
				echo "Stopping AppDynamics…"
				if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
				then
				/opt/appd/current/scripts/machine_agent_appd.sh stop
				fi
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     #./stopNodeManager.sh
			     ./stopWebLogic.sh
			      PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the AdminServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "Admin Server is Stopped"
			     else
			          echo "Admin server is still running with PID: $PID"
			          echo "Stopping AdminServer..."
				  kill -9 $PID
			fi
        fi
	fi
	   	if [[ $HOST_PREFIX = u1060169 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L3DR"
				#AppDynamics Script call:
				echo "Stopping AppDynamics…"
				if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
				then
				/opt/appd/current/scripts/machine_agent_appd.sh stop
				fi
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     ./stopManagedWebLogic.sh gendom11 t3s://u1059926.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			    PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer ..."
				  kill -9 $PID
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1060168 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L3DR"
				#AppDynamics Script call:
				echo "Stopping AppDynamics…"
				if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
				then
				/opt/appd/current/scripts/machine_agent_appd.sh stop
				fi
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     ./stopManagedWebLogic.sh gendom12 t3s://u1059926.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer..."
				  kill -9 $PID
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1060414 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L3DR"
				#AppDynamics Script call:
				echo "Stopping AppDynamics…"
				if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
				then
				/opt/appd/current/scripts/machine_agent_appd.sh stop
				fi
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     ./stopManagedWebLogic.sh gendom13 t3s://u1059926.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer..."
				  kill -9 $PID
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1059987 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L3DR"
				#AppDynamics Script call:
				echo "Stopping AppDynamics…"
				if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
				then
				/opt/appd/current/scripts/machine_agent_appd.sh stop
				fi
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     ./stopManagedWebLogic.sh gendom14 t3s://u1059926.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer..."
				  kill -9 $PID
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1060171 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L3DR"
				#AppDynamics Script call:
				echo "Stopping AppDynamics…"
				if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
				then
				/opt/appd/current/scripts/machine_agent_appd.sh stop
				fi
          		     cd /opt/fedex/genesis/genrecog/current/usgendom/bin/
			     ./stopManagedWebLogic.sh genrecog3 t3s://u1059926.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer..."
				  kill -9 $PID
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1059991 ]]
then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L3DR"
				#AppDynamics Script call:
				echo "Stopping AppDynamics…"
				if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
				then
				/opt/appd/current/scripts/machine_agent_appd.sh stop
				fi
          		     cd /opt/fedex/genesis/genrecog/current/usgendom/bin/
			     ./stopManagedWebLogic.sh genrecog4 t3s://u1059926.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer..."
				  kill -9 $PID
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1059926 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L3DR"
				#AppDynamics Script call:
				echo "Stopping AppDynamics…"
				if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
				then
				/opt/appd/current/scripts/machine_agent_appd.sh stop
				fi
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     #./stopNodeManager.sh
			     ./stopWebLogic.sh
			      PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the AdminServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "Admin Server is Stopped"
			     else
			          echo "Admin server is still running with PID: $PID"
			          echo "Stopping AdminServer..."
				  kill -9 $PID
			fi
        fi
	fi
		if [[ $HOST_PREFIX = u1061499 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L4"
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     ./stopManagedWebLogic.sh gendom11 t3s://u1052262.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			    PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer ..."
				  kill -9 $PID
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1061498 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L4"
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     ./stopManagedWebLogic.sh gendom12 t3s://u1052262.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer..."
				  kill -9 $PID
			     fi
			fi
        fi
	if [[ $HOST_PREFIX = u1061568 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L4"
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     ./stopManagedWebLogic.sh gendom13 t3s://u1052262.test.cloud.fedex.com:9902/
			     ./stopNodeManager.sh
			     PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the ManagedServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "ManagedServer is Stopped"
			     else
			          echo "ManagedServer is still running with PID: $PID"
			          echo "Stopping ManagedServer..."
				  kill -9 $PID
			     fi
			fi
        fi

	if [[ $HOST_PREFIX = u1052262 ]]
	then
			PID=$(ps aux | grep [w]eblogic.Server | awk '{print $2}')
			#Check if the PID is empty
			if [[ -z "$PID" ]]; then
			     echo "Weblogic is not running!"
			else
			     echo "Weblogic is running with PID: $PID"
			     export GENDOMENV="L4"
          		     cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			     #./stopNodeManager.sh
			     ./stopWebLogic.sh
			      PID=$(ps aux | grep [j]ava | awk '{print $2}')
			     #Check if the AdminServer is stopped, else kill it
			     if [[ -z "$PID" ]]; then
			          echo "Admin Server is Stopped"
			     else
			          echo "Admin server is still running with PID: $PID"
			          echo "Stopping AdminServer..."
				  kill -9 $PID
			fi
        fi
	fi
    ;;     
    *)
        echo "Unknown network address - Exiting"
        exit 1
    ;;
esac
