#!/bin/bash

# This script will either download Newznab Plus from the SVN repository
# or extract it from an existing .zip archive
#
# It will then fix the permissions and copy over a pre-defined configuration
#
# Comment/uncomment the extraction method desired
#
# Add the SVN username/password from the Newznab site
#

# SVN
nn_user=<nn_user>
nn_pass=<nn_pass>

svn co --username $nn_user --password $nn_pass svn://svn.newznab.com/nn/branches/nnplus newznab

# From zip file
#unzip newznab-023_4146.zip -d newznab

chmod 777 ./newznab/www/lib/smarty/templates_c
chmod 777 ./newznab/www/covers/movies
chmod 777 ./newznab/www/covers/anime
chmod 777 ./newznab/www/covers/music
chmod 777 ./newznab/www/covers/tv
chmod 777 ./newznab/www
chmod 777 ./newznab/www/install
chmod 777 ./newznab/nzbfiles

# add predefined configuration file
cp ./config.php ./newznab/www/config.php
chmod 777 ./newznab/www/config.php

