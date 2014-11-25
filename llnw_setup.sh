#!/bin/bash

GIT_CLONE_URL=
SCRIPT_LOCATION=/opt/llnw/bin/

SCRIPTS=(
    python/getjson.py
)

if [[ $(id -u) -ne 0 ]]; then
    echo "Script needs to be ran as sudo or root! - Exiting..."
    exit
fi

echo "Installing git"

sudo apt-get -qy install git

echo "Cloning git project"
git clone http://github.com/preludedrew/llnw_led.git

cd llnw_led/


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
