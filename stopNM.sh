#!/bin/bash

###########################################################################
## stop NodeManagers
###########################################################################
EAINUMBER=7353
export EAINUMBER
HOSTNAME=`hostname`
HOST_PREFIX=`echo $HOSTNAME | cut -c1-8`
case $HOST_PREFIX in

  'u1051291'|'u1051292'|'u1051661'|'u1064310'|'u1064309'|'u1064311'|'u1064312'|'u1064637'|'u1064638'|'u1060169'|'u1060168'|'u1060414'|'u1059987'|'u1060171'|'u1059991'|'u1061499'|'u1061498'|'u1061568')
    
    	if [[ $HOST_PREFIX = u1051291 ]]
	then
		export GENDOMENV="L2"
          	 cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			 ./stopNodeManager.sh
        fi
	if [[ $HOST_PREFIX = u1051292 ]]
	then
		export GENDOMENV="L2"
          	 cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			 ./stopNodeManager.sh
        fi
	if [[ $HOST_PREFIX = u1051661 ]]
	then
		export GENDOMENV="L2"
          	 cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			 ./stopNodeManager.sh
        fi

################################# L3 #######################################################3	
	if [[ $HOST_PREFIX = u1064310 ]]
	then
		export GENDOMENV="L3"
		cd /opt/fedex/genesis/gendom/current/usgendom/bin/
		./stopNodeManager.sh
		#AppDynamics Script call:
        	echo "Stopping AppDynamics…"
        	if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        	then
            	/opt/appd/current/scripts/machine_agent_appd.sh stop
        	fi
          	
        fi
	if [[ $HOST_PREFIX = u1064309 ]]
	then
		export GENDOMENV="L3"
		cd /opt/fedex/genesis/gendom/current/usgendom/bin/
		./stopNodeManager.sh
		#AppDynamics Script call:
        	echo "Stopping AppDynamics…"
        	if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        	then
            	/opt/appd/current/scripts/machine_agent_appd.sh stop
        	fi
          	
        fi
	if [[ $HOST_PREFIX = u1064311 ]]
	then
		export GENDOMENV="L3"
		cd /opt/fedex/genesis/gendom/current/usgendom/bin/
		./stopNodeManager.sh
		#AppDynamics Script call:
        	echo "Stopping AppDynamics…"
        	if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        	then
            	/opt/appd/current/scripts/machine_agent_appd.sh stop
        	fi
          	
        fi
	if [[ $HOST_PREFIX = u1064312 ]]
	then
		export GENDOMENV="L3"
		cd /opt/fedex/genesis/gendom/current/usgendom/bin/
		./stopNodeManager.sh
		#AppDynamics Script call:
        	echo "Stopping AppDynamics…"
        	if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        	then
            	/opt/appd/current/scripts/machine_agent_appd.sh stop
        	fi
          	
        fi
	if [[ $HOST_PREFIX = u1064637 ]]
   	then
		export GENDOMENV="L3"
		cd /opt/fedex/genesis/gendom/current/usgendom/bin/
		./stopNodeManager.sh
		#AppDynamics Script call:
        	echo "Stopping AppDynamics…"
        	if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        	then
            	/opt/appd/current/scripts/machine_agent_appd.sh stop
        	fi
          	
        fi
     	if [[ $HOST_PREFIX = u1064638 ]]
    	then
		export GENDOMENV="L3"
		cd /opt/fedex/genesis/gendom/current/usgendom/bin/
		./stopNodeManager.sh
		#AppDynamics Script call:
        	echo "Stopping AppDynamics…"
        	if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        	then
            	/opt/appd/current/scripts/machine_agent_appd.sh stop
        	fi
          	
        fi

#################################### L3DR ##########################################
	if [[ $HOST_PREFIX = u1060169 ]]
	then
		export GENDOMENV="L3DR"
		cd /opt/fedex/genesis/gendom/current/usgendom/bin/
		./stopNodeManager.sh
		#AppDynamics Script call:
        	echo "Stopping AppDynamics…"
        	if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        	then
            	/opt/appd/current/scripts/machine_agent_appd.sh stop
        	fi
          	
        fi
	if [[ $HOST_PREFIX = u1060168 ]]
		then
		export GENDOMENV="L3DR"
		cd /opt/fedex/genesis/gendom/current/usgendom/bin/
		 ./stopNodeManager.sh
		#AppDynamics Script call:
        	echo "Stopping AppDynamics…"
        	if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        	then
            	/opt/appd/current/scripts/machine_agent_appd.sh stop
        	fi
          	
        fi
	if [[ $HOST_PREFIX = u1060414 ]]
		then
		export GENDOMENV="L3DR"
		cd /opt/fedex/genesis/gendom/current/usgendom/bin/
		./stopNodeManager.sh
		#AppDynamics Script call:
        	echo "Stopping AppDynamics…"
        	if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        	then
            	/opt/appd/current/scripts/machine_agent_appd.sh stop
        	fi
          	
        fi
	if [[ $HOST_PREFIX = u1059987 ]]
		then
		export GENDOMENV="L3DR"
		cd /opt/fedex/genesis/gendom/current/usgendom/bin/
		./stopNodeManager.sh
		#AppDynamics Script call:
        	echo "Stopping AppDynamics…"
        	if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        	then
            	/opt/appd/current/scripts/machine_agent_appd.sh stop
        	fi
          	
        fi
	if [[ $HOST_PREFIX = u1060171 ]]
		then
		export GENDOMENV="L3DR"
		cd /opt/fedex/genesis/gendom/current/usgendom/bin/
		./stopNodeManager.sh
		#AppDynamics Script call:
        	echo "Stopping AppDynamics…"
        	if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        	then
            	/opt/appd/current/scripts/machine_agent_appd.sh stop
        	fi
          	
        fi
	if [[ $HOST_PREFIX = u1059991 ]]
	then
		export GENDOMENV="L3DR"
		cd /opt/fedex/genesis/gendom/current/usgendom/bin/
		./stopNodeManager.sh
		#AppDynamics Script call:
        	echo "Stopping AppDynamics…"
        	if [[ -e /opt/appd/current/machineagent/machineagent.jar ]]
        	then
            	/opt/appd/current/scripts/machine_agent_appd.sh stop
        	fi
          	
        fi
############################################## L4 ###########################################333
		if [[ $HOST_PREFIX = u1061499 ]]
		then
		export GENDOMENV="L4"
          	 cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			 ./stopNodeManager.sh
        fi
	if [[ $HOST_PREFIX = u1061498 ]]
	then
		export GENDOMENV="L4"
          	 cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			 ./stopNodeManager.sh
        fi
	if [[ $HOST_PREFIX = u1061568 ]]
	then
		export GENDOMENV="L4"
          	 cd /opt/fedex/genesis/gendom/current/usgendom/bin/
			 ./stopNodeManager.sh
        fi
    ;;     
    *)
        echo "Unknown network address - Exiting"
        exit 1
    ;;
esac
