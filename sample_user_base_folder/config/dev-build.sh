#!/bin/bash
date

echo "Executing script '${0} to configure 'dev' container"
echo "Working directory: $(pwd)"

PYTHON_REQUIREMENTS="./python_requirements.txt"
echo "Installing python packages from file $(realpath "${PYTHON_REQUIREMENTS}")"
pip install -r "./python_requirements.txt"


##### NodeJS
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 22

# Verify the Node.js version:
node -v # Should print "v22.17.0".
nvm current # Should print "v22.17.0".

# Verify npm version:
npm -v # Should print "10.9.2".

