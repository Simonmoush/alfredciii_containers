# What we have so far
Not much... but here's how i'm starting the pod right now

```bash
podman-compose up -d --abort-on-container-exit
```

so there's the basic pod for wordpress deveopment with the alfredciii theme folder mounted in the wp containers themes folder

## In Progress
Trying to figure out how to import (and eventually export) a wordpress database.
We're thinking to use WP_CLI tools. There is a docker image with those tools which we can run in a container that shares volumes and network with the pod. Those scripts can do the db importing and then the container can exit... I think.

## Kinda Done
### Basic Git Structure

This repo has everything related to the containers/infrastructure required for alfred's site. I guess because containers are so awesome that just means a container file and that env file.

The wordpress theme is a git submodule of this one.

next thing to do here is make branches for dev and production and probably other stuff.

## Other Goals
* tests
* use gitlab to automate everything based on git activity
