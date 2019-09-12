# Proxmox Notes

https://192.168.254.42:8006/  password "prox<reg>"

## Create a container
`pct` is container managment utility
`pveam` is... template management?

I'm going with CentOS just because that's what we use at work, I'm more familiar with ubuntu/debian.

- `pveam available` to list premade templates.
- `pveam download local centos-7-default_20171212_amd64.tar.xz` downloads the template. TODO what is local storage vs other storages?
- `pveam list local` shows local with storage name and stuff

Going through the UI now to create the container since the docs don't spell out how to do all the configs and I'm in a hurry.

TODO figure out how to set all this with `pct set` or just having a json file I can commit to this repo.

- right click on host in left column
- Create CT
- hostname: shinobi
- password: <reg>
- storage: local, template: thing we just downloaded
- 16GB disk for now (running on 30GB spinning rust HDDs, lol)
- 3072 GB of RAM
- accept defaults
- create

- `pct enter 100` to get root shell.
- Install shinobi https://shinobi.video/docs/start
- `yum update -y`
- Requires git and curl, the installer installs everything else: `yum install git curl -y`
- Set up yum repos for node (I'm assuming) `curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -`
- `yum install nodejs npm -y`

