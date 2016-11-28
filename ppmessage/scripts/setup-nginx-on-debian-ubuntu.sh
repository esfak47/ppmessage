NGINX_VERSION=1.8.0
apt-get install -y libpcre3 libpcre3-dev 
cd /tmp \
&& wget http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz \
&& git clone https://github.com/vkholodkov/nginx-upload-module.git \
&& cd nginx-upload-module && git checkout 2.2 && cd ../ \
&& tar -xzvf nginx-$NGINX_VERSION.tar.gz \
&& cd nginx-$NGINX_VERSION \
&& ./configure --with-http_ssl_module \
--add-module=../nginx-upload-module \
&& make && make install
