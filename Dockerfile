# Use the official UBI 8.10 image as the base.
FROM registry.access.redhat.com/ubi8/ubi:8.10

# Copy offline RPM packages into the container.
# Ensure the "python3.12_offline_rpms" folder is in the same directory as this Dockerfile.
COPY python3.12_offline_rpms/ /tmp/python3.12_offline_rpms/

# Install Python 3.12, pip, devel package, and other dependencies from the offline RPMs.
RUN dnf install -y /tmp/python3.12_offline_rpms/*.rpm && \
  dnf clean all && \
  rm -rf /var/cache/dnf /tmp/python3.12_offline_rpms

# Create symbolic links for various Python and pip commands.
# This ensures that python, python3, and python3.12 all point to the same binary.
RUN ln -sf /usr/bin/python3.12 /usr/bin/python && \
  ln -sf /usr/bin/python3.12 /usr/bin/python3 && \
  # Assuming pip3.12 is installed as /usr/bin/pip3.12, create links for pip commands.
  ln -sf /usr/bin/pip3.12 /usr/bin/pip && \
  ln -sf /usr/bin/pip3.12 /usr/bin/pip3

# Set the default command to verify installations.
CMD ["python3.12", "--version"]
