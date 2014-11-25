#!/bin/bash

GIT_CLONE_URL="https://github.llnw.net/aboren/llnw_incident_sign.git"
SCRIPT_LOCATION=/opt/llnw/bin/

SCRIPTS=(
    python/getjson.py
)

if [[ $(id -u) -ne 0 ]]; then
    echo "Script needs to be ran as root! - Exiting..."
    exit
fi

echo "Cloning git project"
git clone "${GIT_CLONE_URL}"

cd llnw_incident_sign/


echo "Running make...."
make -j2 install
exit_code=$?

if [[ exit_code -ne 0 ]]; then
    echo "Make failed for some reason, quitting setup script. Code [${exit_code}] - Exiting..."
    exit
fi

for script in ${SCRIPTS}; do
    echo "Copying ${script} to: ${SCRIPT_LOCATION}"
    cp "${script}" "${SCRIPT_LOCATION}"
done
