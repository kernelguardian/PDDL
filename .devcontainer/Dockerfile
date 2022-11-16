# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.245.2/containers/alpine/.devcontainer/base.Dockerfile

# [Choice] Alpine version: 3.16, 3.15, 3.14, 3.13
ARG VARIANT="3.16"
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu
# FROM mcr.microsoft.com/vscode/devcontainers/base:0-ubuntu

# docker pull mcr.microsoft.com/azureml/inference-base-2004:latest
USER root

RUN sudo apt-get update && \
    sudo apt install python3 -y && \
    sudo apt install python3-pip -y && \
    sudo apt-get install ffmpeg libsm6 libxext6  -y && \
    sudo apt-get install -y x11vnc xvfb 
RUN mkdir ~/.vnc
# Setup a password
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd


# ** [Optional] Uncomment this section to install additional packages. **
# RUN apk update \
#     && apk add --no-cache <your-package-list-here>
