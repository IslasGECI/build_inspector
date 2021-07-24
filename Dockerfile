FROM python:3
WORKDIR /workdir
COPY . .
RUN pip install \
    black \
    codecov \
    flake8 \
    mutmut \
    mypy \
    pylint \
    pytest \
    pytest-cov
RUN curl --fail --location https://git.io/shellspec --show-error --silent | sh -s -- --yes
ENV PATH="/root/.local/lib/shellspec:$PATH"
RUN shellspec --init
