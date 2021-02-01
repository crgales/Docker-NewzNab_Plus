# NewzNab Plus - http://www.newznab.com
NewzNab plus as Docker - Encapsulates both Newznab and MySQL in a Docker compose file

Prerequisites:
  A system configured for Docker - docker, docker-compose
  Several system utilities - unzip, subversion

Step 1:
  Get the GIT repository:

git clone https://github.com/cgales/Docker-NewzNab_Plus.git

Step 1:
  Get Newznab plus. You can either use an existing .zip file or clone the SVN repository.
  Edit the script 'get_newznab.sh' and add the SVN username/password you received. Comment/uncomment the extraction method you want.
  Run './get_newznab.sh' and a 'newznab' directory will be created.

Step 2:
  Build the docker container:

docker build -t newznab_plus .

  This will download/build the Docker container on your system. The container will be named "newznab_plus"

Step 3:
  Run the docker container:

docker-compose up -d

  This will download the MySQL docker container (standard) and run both docker containers

Step 4:

For the first run go to http://yourserver/install and step through the installer - This forces a Build of the Database in MYSQL and creates a user.
The default database type/host/port/user/password should work as is.

Notes:

Don't forget to go to Site Settings in Newznab and add your Newznab user id or you wont get Regex downloads and releases wont build

All NZBs will be available in the newznab/nzbfiles directory. You will typically access them through the site, but this is an alternative method.

You can add any site customization per the Newznab docs in the newznab directory.

