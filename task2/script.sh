mkdir test
chown user:user test
cd test
touch script.sh
chmod u+x,o+x script.sh
chmod 764 script.sh
useradd test_usr
chown test_usr:test_usr script.sh
gzip script.sh
