#!/bin/sh

PROMPTFLOW_VERSION="${VERSION:-"latest"}"
PROMPTFLOW_TOOLS_VERION="${TOOLS_VERSION:-"latest"}"
PROMPTFLOW_VECTORDB_VERSION="${VECTORDB_VERSION:-"latest"}"
PROMPTFLOW_EXTRA_PACKAGES="${EXTRA:-""}"
WITH_VECTORDB="${WITH_VECTORDB:-"false"}"

set -e

# Clean up
rm -rf /var/lib/apt/lists/*

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

get_latest_version_pip()
{
    local package_name=$1
    echo $(python3 -c "import requests; print(requests.get('https://pypi.org/pypi/${package_name}/json').json()['info']['version'])")
}

# Check if python version is greater than 3.8
if [ "$(python3 -c 'import sys; print(sys.version_info >= (3, 8))')" = "False" ]; then
    echo 'Error: python3 version must be greater than 3.8.' >&2
    exit 1
fi

# Get version of promptflow if set to latest
if [ "$PROMPTFLOW_VERSION" = "latest" ]; then
    PROMPTFLOW_VERSION=$(get_latest_version_pip "promptflow")
fi

# Get version of promptflow-tools if set to latest
if [ "$PROMPTFLOW_TOOLS_VERION" = "latest" ]; then
    PROMPTFLOW_TOOLS_VERION=$(get_latest_version_pip "promptflow-tools")
fi

# Get version of vectordb if set to latest
if [ "$WITH_VECTORDB" = "true" ] && [ "$PROMPTFLOW_VECTORDB_VERSION" = "latest" ]; then
    PROMPTFLOW_VECTORDB_VERSION=$(get_latest_version_pip "vectordb")
fi

# Install promptflow
if [ "$PROMPTFLOW_EXTRA_PACKAGES" = "" || "$PROMPTFLOW_EXTRA_PACKAGES" = "none" ]; then
    python3 -m pip install promptflow==$PROMPTFLOW_VERSION
else
    python3 -m pip install promptflow[$PROMPTFLOW_EXTRA_PACKAGES]==$PROMPTFLOW_VERSION
fi

# Install promptflow-tools
python3 -m pip install promptflow-tools==$PROMPTFLOW_TOOLS_VERION

# Install vectordb
if [ "$WITH_VECTORDB" = "true" ]; then
    if [ "$PROMPTFLOW_EXTRA_PACKAGES" = "azure"]; then
        python3 -m pip install vectordb[azure]==$PROMPTFLOW_VECTORDB_VERSION
    else
        python3 -m pip install vectordb==$PROMPTFLOW_VECTORDB_VERSION
    fi
    python3 -m pip install vectordb==$PROMPTFLOW_VECTORDB_VERSION
fi

# Clean up
rm -rf /var/lib/apt/lists/*