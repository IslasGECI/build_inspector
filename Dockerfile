FROM ubuntu:20.04
WORKDIR /workdir
COPY . .
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/ciencia_datos
ENV PATH="/root/.local/lib/shellspec:$PATH"
ENV TZ=America/Los_Angeles
ENV USER=ciencia_datos
RUN useradd --create-home ${USER}
RUN apt update && apt install --yes \
    cron \
    curl \
    docker.io \
    jq \
    make \
    shellcheck \
    tzdata \
    vim
RUN echo $TZ > /etc/timezone && \
    ln --force --no-dereference --symbolic /usr/share/zoneinfo/$TZ /etc/localtime && \ 
    dpkg-reconfigure --frontend noninteractive tzdata
RUN curl --fail --location https://git.io/shellspec --show-error --silent | sh -s -- --yes
RUN shellspec --init
RUN crontab /workdir/src/Cronfile
CMD ["cron", "-f"]
