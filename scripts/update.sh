#!/bin/bash -eux

# yum update -y

# update root certs
wget -O/etc/pki/tls/certs/ca-bundle.crt http://curl.haxx.se/ca/cacert.pem