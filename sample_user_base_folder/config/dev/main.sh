#!/bin/bash
date

echo "Executing script '${0} to configure 'dev' container"
echo "Working directory: $(pwd)"

export HOME="/home"

CONF_SCRIPTS=$(find . -regex '.*/[0-9]+-.*\.sh' -print | sort)
for f in ${CONF_SCRIPTS} 
do 
	echo "Running configuration script '$f'" 
	bash "$f"
	echo "Configuration script '$f' completed" 
done