# syntax=docker/dockerfile:1
# Pull base image.
FROM ubuntu:22.04

# Set shell to bash.
SHELL ["/bin/bash", "-c"]

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Create nvm folder.
RUN mkdir /root/.nvm
ENV NVM_DIR=/root/.nvm
ENV DEBIAN_FRONTEND noninteractive

# Install.
RUN cp /etc/skel/.bashrc /root && \
apt-get update && \
apt-get -y upgrade && \
apt-get install -y build-essential && \
apt-get install -y software-properties-common && \
apt-get install -y make byobu curl git htop man unzip vim wget \
libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev openssl && \
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash && \
wget -O- https://aka.ms/install-vscode-server/setup.sh | sh && \
source ~/.bashrc && \
source ~/.nvm/nvm.sh && \
nvm install node && \
git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
exec "$SHELL" && \
pyenv install 3.11 && \
pyenv global 3.11

# Define default command.
CMD ["/bin/bash", "-c"]
