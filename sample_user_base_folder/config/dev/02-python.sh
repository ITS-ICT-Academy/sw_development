#!/bin/bash

# Python installation and configuration
    
# Install all dependencies to configure Python
apt install -y --no-install-recommends \
	python3 \
	python3-dev \
	python3-pip \
	python-is-python3

ROOT_HOME="/root"
pushd "${ROOT_HOME}"

# Download and install pyenv
git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv

RC_FILE="${ROOT_HOME}/.bashrc"

# Append the following code to the RC_FILE
cat << EOF >> "${RC_FILE}"
	export PYTHONPATH='/home'
	PYENV_ROOT="${ROOT_HOME}/.pyenv"
	export PATH="\${PYENV_ROOT}/shims:\${PYENV_ROOT}/bin:\${PATH}"
	eval "\$(pyenv init --path)"
	eval "\$(pyenv init -)"
EOF

export PYENV_ROOT="${ROOT_HOME}/.pyenv"
export PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"

# Install, via pyenv, the specific Python version stated in variable PYTHON_VERSION 
# and set it as global default
export PYTHON_VERSION=3.13.5
pyenv install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}

# Load bashrc config
source "${RC_FILE}"

# Go back to the previous working directory
popd

# Install requirements
PYTHON_REQUIREMENTS="./python_requirements.txt"
echo "Installing python packages from file $(realpath "${PYTHON_REQUIREMENTS}")"
pip install -r "${PYTHON_REQUIREMENTS}"

