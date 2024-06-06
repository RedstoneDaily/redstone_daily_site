#!/bin/bash

AEGIS_ENABLED=false

# Check if any arguments were provided
if [ "$#" -ne 0 ]; then
    for arg in "$@"; do
        case $arg in
            --aegis-enabled)
                AEGIS_ENABLED=true
                ;;
            *)
                echo "Unknown argument: $arg"
                ;;
        esac
    done
fi

if [ $AEGIS_ENABLED == true ]; then
  # Insert the script snippet into index.html
  echo "AEGIS is enabled, inserting script snippet into index.html"
  AEGIS_SCRIPT=$(cat web/aegis-script.html)
else
  AEGIS_SCRIPT=""
fi

export AEGIS_SCRIPT
# effectly whitelisted it, prevented it to be replaced by envsubst
export FLUTTER_BASE_HREF="\$FLUTTER_BASE_HREF"
envsubst < web/template.html > web/index.html

exit 0