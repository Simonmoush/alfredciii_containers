## What we have so far
Not much... but here's how I'm starting the pod right now

```bash
podman-compose up -d --abort-on-container-exit
```

so there's the basic pod for wordpress deveopment with the alfredciii theme folder mounted in the wp containers themes folder

## In Progress: import data

start and enter a container using the wordpress:cli image and let it share volumes and networks with the running wordpress container. Also give it access to the folder data_snapshots. 

put the exported xml file in this data_snapshots folder

```bash
podman run -it --rm --mount=type=bind,src=./data_snapshots,dst=/home/www-data/data_snapshots --volumes-from wordpress-container-id --network container:wordpress-container-id --env-file=wp.env wordpress:cli bash
```

From within the wordpress:cli container run the following command:

```bash
	wp import WXR-file-to-import.xml --authors=create --path=/var/www/html/
```

## Kinda Done
### Basic Git Structure

This repo has everything related to the containers/infrastructure required for alfred's site. I guess because containers are so awesome that just means a container file and that env file.

The wordpress theme is a git submodule of this one.

next thing to do here is make branches for dev and production and probably other stuff.

## Other Goals
* tests
* use gitlab to automate everything based on git activity
* linting using pre-commit and eslint
