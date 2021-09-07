#!/bin/bash
mv ./ubuntu-fs/root/ustart.sh ./ustart.sh
mv ./start-ubuntu.sh ./ustart-root.sh

echo "run ./ustart.sh when running as user"
echo "run ./ustart-root.sh when running as root"