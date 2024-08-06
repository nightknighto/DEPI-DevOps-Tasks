# Nginx basics & Installing docker through bash script

## Nginx basics

### Commands

1- Install Nginx

```bash
sudo apt update
sudo apt install nginx
```

2- Put static web files in `/var/www/asueng.com/` folder.

3- Create a new configuration file in `/etc/nginx/conf.d/` folder called `asueng-website.conf` and add the following content:

```nginx
server {

    listen 82;
    listen [::]:82;
    server_name asueng.com www.asueng.com;

    root /var/www/asueng.com;

    location / {
        try_files $uri $uri/ /index.html =404;
    }
}
```

4- Test the configuration file

```bash
nginx -t
```

5- Reload Nginx

```bash
nginx -s reload
```
### Screenshot

![Screenshot](screenshot.png)

## Installing docker through bash script

### Commands

1- Create a new bash script called `install_docker.sh` and add the following content:

```bash
#!/bin/bash
sudo snap install docker
```

2- Change the script's permissions

```bash
chmod +x install_docker.sh
```

3- Run the script

```bash
./install_docker.sh
```
