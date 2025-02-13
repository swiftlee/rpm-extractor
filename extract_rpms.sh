#!/bin/bash
# Script to fetch Python 3.12, python3.12-pip, python3.12-devel, and dependencies
# from a RHEL 8.10 host (offline, using local repositories).

# List the target packages.
PACKAGES=(
    "python3.12"
    "python3.12-pip"
    "python3.12-devel"
)

# Define the output directory for RPMs.
OUTPUT_DIR="./python3.12_offline_rpms"
mkdir -p "${OUTPUT_DIR}"

# Check if dnf command exists.
if ! command -v dnf &> /dev/null; then
    echo "Error: dnf is not installed on this system."
    exit 1
fi

# Ensure 'dnf download' supports the '--resolve' flag.
if ! dnf download --help | grep -q "\-\-resolve"; then
    echo "Error: 'dnf download' does not support '--resolve'."
    echo "Please install dnf-plugins-core from your local repository."
    exit 1
fi

# Loop through each package and download it along with its dependencies.
for PACKAGE in "${PACKAGES[@]}"; do
    echo "Downloading ${PACKAGE} and its dependencies..."
    dnf download --resolve --destdir="${OUTPUT_DIR}" "${PACKAGE}"
    if [ $? -ne 0 ]; then
        echo "Error downloading ${PACKAGE}. Please check your repositories."
        exit 1
    fi
done

echo "All packages have been successfully downloaded to ${OUTPUT_DIR}."
echo "Transfer this directory to your UBI 8.10 build context for offline installation."
