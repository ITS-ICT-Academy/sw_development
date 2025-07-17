#!/bin/bash

# This file is executed every time docker compose up -d is lauched
REACT_FOLDER=/home/reactjs
APP_NAME=app-react

# Read .bashrc to load npx and npm command
source /root/.bashrc

# Create react folder
mkdir -p ${REACT_FOLDER}

# Move to react folder
pushd ${REACT_FOLDER}

# Create a react webapp if not exists 
if [[ ! -d ${APP_NAME} ]]; then
	npx --yes create-react-app ${APP_NAME}
fi 

# Start web application
cd ${APP_NAME}
npm start

popd