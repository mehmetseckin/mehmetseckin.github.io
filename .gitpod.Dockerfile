FROM gitpod/workspace-full

# Install fswatch
RUN sudo apt-get update \
 && sudo apt-get install -y \
    fswatch \
 && sudo rm -rf /var/lib/apt/lists/*

# Use Python 3 and install ruamel.yaml
RUN pyenv local 3.7.6 \
    && pip3 install ruamel.yaml