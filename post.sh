#!/bin/bash
[[ -f ./ustart.sh ]] && rm ./ustart.sh
mv ./ubuntu-fs/root/ustart.sh ./ustart.sh
chmod 700 ./ustart.sh

echo "run ./ustart.sh when running as user"
