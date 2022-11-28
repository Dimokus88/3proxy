#!/bin bash
apt-get install -y sudo make build-essential git tmate runit
runsvdir -P /etc/service &
mkdir /root/tmate && mkdir /root/tmate/log
cat > /root/tmate/run <<EOF 
#!/bin/bash
exec 2>&1
exec tmate -F
EOF
cat > /root/tmate/log/run <<EOF 
#!/bin/bash
mkdir /var/log/tmate
exec svlogd -tt /var/log/tmate
EOF
chmod +x /root/tmate/run
chmod +x /root/tmate/log/run
ln -s /root/tmate /etc/service


git clone https://github.com/3proxy/3proxy.git
cd 3proxy
sudo make -f Makefile.Linux
cp ./bin/3proxy /usr/bin

cat > /usr/bin/3proxy.cfg << EOF
auth none
log
tcppm 80 websrv 80
allow * * * 80-88,8080-8088 HTTP
proxy -p80
EOF

3proxy /usr/bin/3proxy.cfg
