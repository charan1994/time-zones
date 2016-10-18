#Jenkins docker image
##Description
This is the dockerfile and the shell scripts which are part of the jenkins docker image which can be found on the url . The docker is based on a debian base image and all the applications installe can be figured out from the apt-get commands. To view all the plugins already present check the plugins.txt file. 
##Usage
Pull the image from
To run the image give the command `docker run -p 8080[or your preferred port no]:8080`
To run the image and mount already present jenkins jobs use the command  `docker run -p 8080[or your preferred port no]:8080 -v [(your)jenkins_home]/config.xml:/var/lib/jenkins/config.xml -v [(your)jenkins_home]/jobs:/var/lib/jenkins/jobs`
##Adding new plugins
To add new plugins you can add the plugin name and version to the **plugins.txt** file in the same format [plugin_name]:version
