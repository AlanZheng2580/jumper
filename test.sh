#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "--- Running Environment Tests ---"

# 1. Check if the Jumper service is accessible
echo -n "--> Checking if Jumper service is running on http://localhost:6901..."
if curl -s --fail http://localhost:6901 > /dev/null; then
    echo " [SUCCESS]"
else
    echo " [FAILURE]"
    echo "    Error: Jumper service is not accessible on port 6901."
    exit 1
fi

# 2. Check if the Airflow webserver container is up and running
echo -n "--> Checking if Airflow webserver container is running..."
if docker-compose ps airflow-webserver | grep -q "Up"; then
    echo " [SUCCESS]"
else
    echo " [FAILURE]"
    echo "    Error: Airflow webserver container is not in a running state."
    exit 1
fi

echo ""
echo "--- Automated Checks Passed! ---"
echo ""
echo "--- Manual Verification Steps ---"
echo "Please perform the following checks to ensure security restrictions are in place:"
echo "1. Access the Jumper URL: http://localhost:6901"
echo "2. Enter the VNC password: password"
echo "3. The Airflow UI should load automatically."
echo "4. [Clipboard Test] Try to copy text from your local machine and paste it into the search bar in the Airflow UI. It should fail."
echo "5. [Upload/Download Test] Inspect the left-side menu in the Kasm interface. There should be no icons for file upload or download."
echo ""
echo "If all checks pass, the secure jumper is configured correctly."
