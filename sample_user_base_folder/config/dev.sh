#!/bin/bash
date

echo "Executing script '${0} to configure 'dev' container"
echo "Working directory: $(pwd)"

PYTHON_REQUIREMENTS="./python_requirements.txt"
echo "Installing python packages from file $(realpath "${PYTHON_REQUIREMENTS}")"
pip install -r "./python_requirements.txt"
