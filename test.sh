#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "--- Running Environment Tests ---"

# 1. Check if the Jumper service is accessible and requires authentication
echo -n "--> Checking if Jumper service is running and secured on https://localhost:6901..."
# We expect a 401 Unauthorized response, which proves the service is up and enforcing security.
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" --insecure https://localhost:6901)
if [ "$STATUS_CODE" -eq 401 ]; then
    echo " [SUCCESS]"
else
    echo " [FAILURE]"
    echo "    Error: Did not get a 401 Unauthorized status code. Instead, got $STATUS_CODE."
    echo "    This means the service is either down or not enforcing authentication as expected."
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
echo "1. Access the Jumper URL: https://localhost:6901 (Note: use https)"
echo "   Your browser will show a warning about a self-signed certificate. Please accept it to proceed."
echo "2. Enter the VNC password: password"
echo "3. The Airflow UI should load automatically."
echo "4. [Clipboard Test] Try to copy text from your local machine and paste it into the search bar in the Airflow UI. It should fail."
echo "5. [Upload/Download Test] Inspect the left-side menu in the Kasm interface. There should be no icons for file upload or download."
echo ""
echo "If all checks pass, the secure jumper is configured correctly."
