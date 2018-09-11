#!/bin/sh
#

CONFIG=$1
PEER=$2

if [ -n "${PEER}" ] && [ -n "${CONFIG}" ]
then

	CRYPTOMAP=`pcregrep --only-matching=1 "^crypto\s+map\s+(\S+\s+\S+).+\s+${PEER}" ${CONFIG}`
	ACL=`pcregrep --only-matching=1 "^crypto\s+map\s+${CRYPTOMAP}\s+match\s+address\s+(\S+)" ${CONFIG}`

	if [ -n "${CRYPTOMAP}" ] && [ -n "${ACL}" ] 
		then
			echo '###########################################'
			pcregrep "^access-list\s+$ACL\s.+" ${CONFIG}
			pcregrep -M "^tunnel-group\s${PEER}(.|\n\s)+" ${CONFIG}
			pcregrep "^crypto\s+map\s+${CRYPTOMAP}.+" ${CONFIG}
			echo '###########################################'
		else
			echo "${PEER} - not found"
		fi
else
	echo "Get ipcec config part from file"
	echo "asa_get_peer_cfg.sh [file] [peer]"
fi
