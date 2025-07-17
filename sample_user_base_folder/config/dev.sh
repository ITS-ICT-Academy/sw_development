#!/bin/bash
date

echo "Executing script '${0} to configure 'dev' container"
echo "Working directory: $(pwd)"

##### Python configuration #####
PYTHON_REQUIREMENTS="./python_requirements.txt"
echo "Installing python packages from file $(realpath "${PYTHON_REQUIREMENTS}")"
pip install -r "./python_requirements.txt"


##### NodeJS & React #####
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh" # in lieu of restarting the shell
nvm install 22 # Download and install Node.js:
node -v # Print Node.js version: should print "v22.17.0".
nvm current # Should print "v22.17.0".
npm -v # Print npm version: should print "10.9.2".

