FROM ubuntu:20.04
WORKDIR /workdir
COPY . .
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/ciencia_datos
ENV PATH="/home/ciencia_datos/.local/lib/shellspec:$PATH"
ENV TZ=America/Los_Angeles
ENV USER=ciencia_datos
RUN useradd --create-home ${USER}
RUN apt update && apt install --yes \
    binutils-dev \
    build-essential \
    cmake \
    cron \
    curl \
    docker.io \
    jq \
    libcurl4-openssl-dev \
    libdw-dev \
    libiberty-dev \
    libssl-dev \
    make \
    shellcheck \
    tzdata \
    zlib1g-dev
RUN echo $TZ > /etc/timezone && \
    ln --force --no-dereference --symbolic /usr/share/zoneinfo/$TZ /etc/localtime && \ 
    dpkg-reconfigure --frontend noninteractive tzdata
# Install ShellSpec
RUN curl --fail --location https://git.io/shellspec --show-error --silent | sh -s -- --yes
RUN shellspec --init
# Install kcov
RUN git clone https://github.com/SimonKagstrom/kcov.git && \
    cd kcov && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install
RUN crontab /workdir/src/Cronfile
CMD ["cron", "-f"]
