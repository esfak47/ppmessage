#!/bin/bash
/usr/bin/supervisord


PY_SITE="`python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`"

# start msyql
service mysql start

# start redis-server
service redis-server start


# start nginx
nginx

/bin/bash

cd /message

if [ -f "$PY_SITE/ppmessage.pth" ]
then
    echo "starting db2cache"
    # db2cache
    python /message/ppmessage/scripts/db2cache.py

    # start ppmessage
    ./dist.sh start
else
    # add ppmessage to python path
    ./dist.sh dev

    # set mysql password, check nginx conf path
    python /message/ppmessage/scripts/before_bootstrap_in_docker.py

    # update nginx conf, init database, db2cache,
    ./dist.sh bootstrap

    # start ppmessage
    ./dist.sh start

    echo "reload nginx conf"
    # reload nginx conf
    nginx -s reload
fi

echo "start ppmessage done!"
