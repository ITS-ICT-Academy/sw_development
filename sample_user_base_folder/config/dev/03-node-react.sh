#!/bin/bash

# NodeJS & React installation and configuration

# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh" # in lieu of restarting the shell
nvm install 22 # Download and install Node.js:
node -v # Print Node.js version: should print "v22.17.0".
nvm current # Should print "v22.17.0".
npm -v # Print npm version: should print "10.9.2".
