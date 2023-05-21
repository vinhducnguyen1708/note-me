# Huớng dẫn cài đặt SSL HTTPS cho APACHE

## Cài đặt module SSL

yum install -y  mod_ssl


## Khởi tạo file cấu hình ssl

cat <<EOF >>/etc/ssl/certs/vinh-test-https.cnf
[req]
prompt = no
distinguished_name = req_distinguished_name
#req_extensions = v3_req

[req_distinguished_name]
countryName                     = VN
stateOrProvinceName             = HaNoi
localityName                    = Hanoi
0.organizationName              = VNPT-IT
organizationalUnitName          = SI
commonName                      = 192.168.1.179
emailAddress                    = vinhducnguyen1708@gmail.com
EOF

## Khởi tạo cert và key 

openssl req -x509 -nodes -config /etc/ssl/certs/vinh-test-https.cnf -days 3650 -newkey rsa:2048 -keyout /etc/ssl/certs/vinh-test-https.key -out  /etc/ssl/certs/vinh-test-https.crt


## Cấu hình SSL cho apache
cat << EOF > /etc/httpd/conf.d/ssl.conf
Listen 443 https
SSLPassPhraseDialog exec:/usr/libexec/httpd-ssl-pass-dialog
SSLSessionCache         shmcb:/run/httpd/sslcache(512000)
SSLSessionCacheTimeout  300
SSLCryptoDevice builtin
<VirtualHost *:443>
ServerName c8-webex-6.novalocal:443
ErrorLog logs/ssl_error_log
TransferLog logs/ssl_access_log
LogLevel warn
SSLEngine on
SSLHonorCipherOrder on
SSLCipherSuite PROFILE=SYSTEM
SSLProxyCipherSuite PROFILE=SYSTEM
SSLCertificateFile /etc/ssl/certs/vinh-test-https.crt
SSLCertificateKeyFile /etc/ssl/certs/vinh-test-https.key
<FilesMatch "\.(cgi|shtml|phtml|php)$">
    SSLOptions +StdEnvVars
</FilesMatch>
<Directory "/var/www/cgi-bin">
    SSLOptions +StdEnvVars
</Directory>
BrowserMatch "MSIE [2-5]" \
         nokeepalive ssl-unclean-shutdown \
         downgrade-1.0 force-response-1.0
CustomLog logs/ssl_request_log \
          "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"
</VirtualHost>
EOF

## Khởi động lại dịch vụ httpd

systemctl restart httpd
