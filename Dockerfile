FROM python:3
WORKDIR /workdir
COPY . .
RUN apt update && apt install --yes \
    binutils-dev \
    cmake \
    jq \
    libcurl4-openssl-dev \
    libdw-dev \
    libiberty-dev \
    shellcheck \
    zlib1g-dev
# Install ShellSpec
RUN curl --fail --location https://git.io/shellspec --show-error --silent | sh -s -- --yes
ENV PATH="/root/.local/lib/shellspec:$PATH"
RUN shellspec --init
# Install kcov
RUN git clone https://github.com/SimonKagstrom/kcov.git && \
    cd kcov && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install
