# 3.9. Элементы безопасности информационных систем

#### 1. 
```bash
vagrant@Client:~$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
OK

vagrant@Client:~$ sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
Hit:1 http://archive.ubuntu.com/ubuntu focal InRelease
Hit:2 http://archive.ubuntu.com/ubuntu focal-updates InRelease
Get:3 https://apt.releases.hashicorp.com focal InRelease [4,419 B]
Hit:4 http://archive.ubuntu.com/ubuntu focal-backports InRelease
Hit:5 http://security.ubuntu.com/ubuntu focal-security InRelease
Get:6 https://apt.releases.hashicorp.com focal/main amd64 Packages [27.2 kB]
Fetched 31.6 kB in 1s (33.4 kB/s)
Reading package lists... Done

vagrant@Client:~$ sudo apt-get update && sudo apt-get install vault
...
Selecting previously unselected package vault.
(Reading database ... 41895 files and directories currently installed.)
Preparing to unpack .../archives/vault_1.7.3_amd64.deb ...
Unpacking vault (1.7.3) ...
Setting up vault (1.7.3) ...
Generating Vault TLS key and self-signed certificate...
Generating a RSA private key
.....++++
......................................................................................................................................................++++
writing new private key to 'tls.key'
-----
Vault TLS key and self-signed certificate have been generated in '/opt/vault/tls'.

vagrant@Client:~$ vault -v
Vault v1.7.3 (5d517c864c8f10385bf65627891bc7ef55f5e827)
```
#### 2. 
```bash
vagrant@Client:~$ vault server -dev -dev-listen-address="0.0.0.0:8200" &
[1] 22507
vagrant@Client:~$ ==> Vault server configuration:

             Api Address: http://0.0.0.0:8200
                     Cgo: disabled
         Cluster Address: https://0.0.0.0:8201
              Go Version: go1.15.13
              Listener 1: tcp (addr: "0.0.0.0:8200", cluster address: "0.0.0.0:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
           Recovery Mode: false
                 Storage: inmem
                 Version: Vault v1.7.3
             Version Sha: 5d517c864c8f10385bf65627891bc7ef55f5e827
vagrant@Client:~$ export VAULT_ADDR='http://127.0.0.1:8200'
vagrant@Client:~$ export VAULT_TOKEN="s.XmpNPoi9sRhYtdKHaQhkHP6x"
```
#### 3. 
```bash
vagrant@Client:~$ vault secrets enable pki
Success! Enabled the pki secrets engine at: pki/

vagrant@Client:~$ vault secrets tune -max-lease-ttl=8760h pki
Success! Tuned the secrets engine at: pki/

vagrant@Client:~$ vault write -field=certificate pki/root/generate/internal \
>         common_name="example.com" \
>         ttl=87600h > CA_cert.crt

vagrant@Client:~$ vault write pki/config/urls \
>         issuing_certificates="$VAULT_ADDR/v1/pki/ca" \
>         crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
Success! Data written to: pki/config/urls

vagrant@Client:~$ vault secrets enable -path=pki_int pki
Success! Enabled the pki secrets engine at: pki_int/

vagrant@Client:~$ vault secrets tune -max-lease-ttl=43800h pki_int
Success! Tuned the secrets engine at: pki_int/

vagrant@Client:~$ vault write -format=json pki_int/intermediate/generate/internal \
>         common_name="example.com Intermediate Authority" \
>         | jq -r '.data.csr' > pki_intermediate.csr

vagrant@Client:~$ ll
...
-rw-rw-r-- 1 vagrant vagrant 1171 Jul  3 10:10 CA_cert.crt
-rw-rw-r-- 1 vagrant vagrant  924 Jul  3 10:14 pki_intermediate.csr
...
vagrant@Client:~$ vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \
>         format=pem_bundle ttl="43800h" \
>         | jq -r '.data.certificate' > intermediate.cert.pem

vagrant@Client:~$ vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem
Success! Data written to: pki_int/intermediate/set-signed
```
#### 4.
```bash
vagrant@Client:~$ vault write pki_int/roles/example-dot-com \
>         allowed_domains="example.com" \
>         allow_subdomains=true \
>         max_ttl="720h"
Success! Data written to: pki_int/roles/example-dot-com

vagrant@Client:~$ vault write pki_int/issue/example-dot-com common_name="netology.example.com" ttl="72h" > netology.cert.pem

```
#### 5.
```bash
vagrant@vagrant:~$ sudo cat /etc/nginx/sites-available/default
##
# You should look at the following URL's in order to grasp a solid understanding
# of Nginx configuration files in order to fully unleash the power of Nginx.
# https://www.nginx.com/resources/wiki/start/
# https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/
# https://wiki.debian.org/Nginx/DirectoryStructure
#
# In most cases, administrators will remove this file from sites-enabled/ and
# leave it as reference inside of sites-available where it will continue to be
# updated by the nginx packaging team.
#
# This file will automatically load configuration files provided by other
# applications, such as Drupal or Wordpress. These applications will be made
# available underneath a path with that package name, such as /drupal8.
#
# Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
##

# Default server configuration
#
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        # SSL configuration
        #
         listen 443 ssl default_server;
         listen [::]:443 ssl default_server;

        ssl_certificate netology.cert.pem;
        ssl_certificate_key netology.cert.pem;
        #
        # Note: You should disable gzip for SSL traffic.
        # See: https://bugs.debian.org/773332
        #
        # Read up on ssl_ciphers to ensure a secure configuration.
        # See: https://bugs.debian.org/765782
        #
        # Self signed certs generated by the ssl-cert package
        # Don't use them in a production server!
        #
        # include snippets/snakeoil.conf;

        root /var/www/html;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
        }

        # pass PHP scripts to FastCGI server
        #
        #location ~ \.php$ {
        #       include snippets/fastcgi-php.conf;
        #
        #       # With php-fpm (or other unix sockets):
        #       fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        #       # With php-cgi (or other tcp sockets):
        #       fastcgi_pass 127.0.0.1:9000;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #       deny all;
        #}
}


# Virtual Host configuration for example.com
#
# You can move that to a different file under sites-available/ and symlink that
# to sites-enabled/ to enable it.
#
#server {
#       listen 80;
#       listen [::]:80;
#
#       server_name example.com;
#
#       root /var/www/example.com;
#       index index.html;
#
#       location / {
#               try_files $uri $uri/ =404;
#       }
#}
vagrant@vagrant:~$ sudo nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful

vagrant@vagrant:~$ sudo systemctl restart nginx

vagrant@vagrant:~$ curl -I http://localhost
HTTP/1.1 200 OK
Server: nginx/1.18.0 (Ubuntu)
Date: Mon, 05 Jul 2021 12:47:43 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Sat, 03 Jul 2021 09:36:11 GMT
Connection: keep-alive
ETag: "60e02f8b-264"
Accept-Ranges: bytes

vagrant@vagrant:~$ curl -I https://localhost:443
curl: (60) SSL: no alternative certificate subject name matches target host name 'localhost'
More details here: https://curl.haxx.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.
```

#### 6.
```bash
vagrant@vagrant:~$ sudo ln /usr/local/share/ca-certificates/intermediate.cert.pem /etc/ssl/certs/
vagrant@vagrant:~$ sudo update-ca-certificates
Updating certificates in /etc/ssl/certs...
0 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done.

root@vagrant:/home/vagrant# cat /etc/hosts
127.0.0.1       localhost       netology.example.com
127.0.1.1       vagrant.vm      vagrant

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

root@vagrant:/home/vagrant# curl -I https://netology.example.com:443
HTTP/1.1 200 OK
Server: nginx/1.18.0 (Ubuntu)
Date: Mon, 05 Jul 2021 13:13:18 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Sat, 03 Jul 2021 09:36:11 GMT
Connection: keep-alive
ETag: "60e02f8b-264"
Accept-Ranges: bytes
```
#### 7.
```bash
root@vagrant:/home/vagrant# apt install snapd
Reading package lists... Done
Building dependency tree
Reading state information... Done
...

root@vagrant:/home/vagrant# sudo snap install core; sudo snap refresh core
2021-07-05T13:21:50Z INFO Waiting for automatic snapd restart...
core 16-2.51.1 from Canonical✓ installed
snap "core" has no updates available

root@vagrant:/home/vagrant# sudo apt-get remove certbot
Reading package lists... Done
Building dependency tree
Reading state information... Done
Package 'certbot' is not installed, so not removed

root@vagrant:/home/vagrant# sudo snap install --classic certbot
certbot 1.16.0 from Certbot Project (certbot-eff✓) installed

root@vagrant:/home/vagrant# sudo ln -s /snap/bin/certbot /usr/bin/certbot

root@vagrant:/home/vagrant# certbot --nginx
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Please enter the domain name(s) you would like on your certificate (comma and/or
space separated) (Enter 'c' to cancel): example.com
Requesting a certificate for example.com

Certbot failed to authenticate some domains (authenticator: nginx). The Certificate Authority reported these problems:
  Domain: example.com
  Type:   unauthorized
  Detail: Invalid response from http://example.com/.well-known/acme-challenge/gP65rHRegSioJJqeXmY2APRTuuTviqw5ryUQBqaIm-s [2606:2800:220:1:248:1893:25c8:1946]: "<!doctype html>\n<html>\n<head>\n    <title>Example Domain</title>\n\n    <meta charset=\"utf-8\" />\n    <meta http-equiv=\"Content-type"

Hint: The Certificate Authority failed to verify the temporary nginx configuration changes made by Certbot. Ensure the listed domains point to this nginx server and that it is accessible from the internet.

Some challenges have failed.
Ask for help or search for solutions at https://community.letsencrypt.org. See the logfile /var/log/letsencrypt/letsencrypt.log or re-run Certbot with -v for more details.
```