.PHONY: \
	build \
	run

build:
	docker build --tag islasgeci/weak_inspector:latest .

run:
	docker run \
    --detach \
    --name weak_inspector \
    --rm \
    --volume ${HOME}/.vault/.secrets:/.vault/.secrets \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    islasgeci/weak_inspector:latest
