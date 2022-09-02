# Usage

## Start the pod

```bash
podman-compose up -d --abort-on-container-exit
```

This creates a wordpress container and a mysql container.
It also gives the wordpress container access to alfredciii_wp_theme by mounting it in the the containers wp-content/themes

if it's the first time you run it a volume for each container to persist changes to files and the database
if it's not the first time those volumes will be re-attached

deleting the volumes with `podman volume prune` when the container is not running gives you a fresh start next time


## Importing data

If you're starting a new project from scratch you don't need to do this.

If you want to work on a site with a snapshot of it's current data you'll have to export the data with the built in wordpress export tool.
Put the downloaded xml file in the data_snapshots folder

The following command will start and enter a container using the wordpress:cli image and let it share volumes and networks with the running wordpress container so it can change the running containers.
It also gives it access to the folder data_snapshots.


```bash
podman run -it --rm --mount=type=bind,src=./data_snapshots,dst=/home/www-data/data_snapshots --volumes-from=alfredciii_containers_wordpress_1:rw --network=container:alfredciii_containers_wordpress_1 --env-file=wp.env wordpress:cli bash
```

From within the wordpress:cli container run the following command:

```bash
	wp theme activate alfredciii_wp_theme
	wp plugin install wordpress-importer --activate
	wp import /home/www-data/data_snapshots/WXR-file-to-import.xml --authors=create
```

### TODO
- give wp_cli container write access to install plugins
	- There's some issue with mapping UIDs. running bash in the wp_cli container with --user=33 (the UID of www-data from the wordpress container) gives it write access but this seems janky
	- looks like maybe using the --uidmap flag is what I need
- maybe change permalink settings as well

#### Thoughts about the database

Instead of manually importing the data, or even automating it with Gitlab we should include default/dummy/test_fixture data for this particular app in the actual db image 
By using build stages we can run the above commands in the build phase and the imported data will become part of the container image.
when we eventually have our own container registry we can spin up images we've already built that are basically snapshots at a particular feature that we can spin up without any importing.
*we think we can avoid mounting any containers to transfer the db data while in the build stage with the dockerfile's ADD command*


# Git Structure

This repo has everything related to the containers/infrastructure required for alfred's site. I guess because containers are so awesome that just means a container file and that env file.

The wordpress theme is a git submodule of this one.

next thing to do here is make branches for dev and production and probably other stuff.

# Other Goals
* tests
* use gitlab to automate everything based on git activity
* linting
