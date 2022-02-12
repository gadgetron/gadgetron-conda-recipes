FROM mcr.microsoft.com/vscode/devcontainers/base:0.201.8-focal AS devcontainerbase

# Install needed packages and setup non-root user.
ARG USERNAME="vscode"
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG CONDA_GID=900
ARG HOME=/home/$USERNAME
ARG CONDA_ENVIRONMENT_NAME=gadgetron-conda-recipes

# The version of conda to use
ARG CONDA_VERSION=4.11.0

# Based on https://github.com/ContinuumIO/docker-images/blob/master/miniconda3/debian/Dockerfile.
# We also install conda-lock.
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
    && mkdir -p /opt \
    && sh miniconda.sh -b -p /opt/conda \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && [ -z "$CONDA_VERSION" ] || /opt/conda/bin/conda install -n base conda=$CONDA_VERSION \
    && /opt/conda/bin/conda clean -afy \
    && groupadd -r conda --gid ${CONDA_GID} \
    && usermod -aG conda ${USERNAME} \
    && chown -R :conda /opt/conda \
    && chmod -R g+w /opt/conda \
    && find /opt -type d | xargs -n 1 chmod g+s

# Add a section to /etc/bash.bashrc that ensures that a section is present at the end of ~/.bashrc.
# We can't just write to .bashrc from here because it will be overwritten if the vscode user has
# opted to use their own dotfiles repo. The dotfiles repo is cloned after the postCreateCommand
# in the devcontainer.json file is executed.
RUN echo "\n\
if ! grep -q \"^source /opt/conda/etc/profile.d/conda.sh\" ${HOME}/.bashrc; then\n\
	echo \"source /opt/conda/etc/profile.d/conda.sh\" >> ${HOME}/.bashrc\n\
	echo \"conda activate ${CONDA_ENVIRONMENT_NAME}\" >> ${HOME}/.bashrc\n\
fi\n" >> /etc/bash.bashrc

# Create a conda environment from the environment file in the repo root.
COPY --chown=$USER_UID:conda environment.yml /tmp/build/
RUN umask 0002 && /opt/conda/bin/conda env create -f /tmp/build/environment.yml \
    && sudo chown -R :conda /opt/conda/envs \
    && sudo chown -R :conda ${HOME}/.conda
