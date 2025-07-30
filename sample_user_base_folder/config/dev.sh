#!/bin/bash
date

echo "Executing script '${0} to configure 'dev' container"
echo "Working directory: $(pwd)"


# Update the system
apt update && apt upgrade -y 


##### Python configuration #####
# Install all dependencies to configure Python
apt install -y --no-install-recommends make \
                                       build-essential \
                                       libssl-dev \
                                       zlib1g-dev \
                                       libbz2-dev \
                                       libreadline-dev \
                                       libsqlite3-dev \
                                       wget \
                                       curl \
                                       llvm \
                                       libncursesw5-dev \
                                       xz-utils \
                                       tk-dev \
                                       libxml2-dev \
                                       libxmlsec1-dev \
                                       libffi-dev \
                                       liblzma-dev \
                                       python3 \
                                       python3-dev \
                                       python3-pip \
                                       python-is-python3 \
                                       git   

# Set home variable
export HOME="/root"
pushd ${HOME}

# Download and install pyenv
git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv

# Configure pyenv on the bash script and the .bashrc file
echo -e 'export PYENV_ROOT="$HOME/.pyenv"\nexport PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'eval "$(pyenv init --path)"\neval "$(pyenv init -)"' >> ~/.bashrc

export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"


# Install Python 3.13.5 and set it as default
export PYTHON_VERSION=3.13.5
pyenv install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}

# Load bashrc config
source ~/.bashrc

# Go back to the previous working directory
popd

# Install requirements
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


