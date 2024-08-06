# Linux Permissions

## Script

```bash
mkdir test
chown user:user test
cd test
touch script.sh
chmod u+x,o+x script.sh
chmod 764 script.sh
useradd test_usr
chown test_usr:test_usr script.sh
gzip script.sh
```

## Commands

1- Create a new folder

```bash
mkdir test
```

2- Change the directory's owner

```bash
chown user:user test
```

3- Change the directory to the new folder

```bash
cd test
```

4- Create a new file

```bash
touch script.sh
```

5- Change the file's permissions

```bash
chmod u+x,o+x script.sh
```

6- Change the file's permissions with a different method

```bash
chmod 764 script.sh
```

7- Create a new user

```bash
useradd test_usr
```

8- Change the file's owner

```bash
chown test_usr:test_usr script.sh
```

9- Compress the file

```bash
gzip script.sh
```