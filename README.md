# Time-Zones
##Description
This is the source code for a webapp built upon __dropwizard__ framework.
You can read more about __dropwizard__ at http://www.dropwizard.io/1.0.0/docs/ .
##Usage
To use the webapp you first need to download the yml file.
It is the file which helps configure how the webapp works and how it displays output. More info on that later.

Steps to run the webapp on your machine 
  1. Download the yml file from the base directory of this project. Its named time.yml .
  2. Pull the docker image to run the webapp using the commmand `sudo docker pull charan1994/timezone-1`
  3. Run the docker file using the command `sudo docker run -v [path to the downloaded yml file]:/opt/myapp/yml -p 8080:8080 -p 8081:8081 charan1994/timezone-1`

You can now access the webapp thorugh your browser with the link http://localhost:8080/time .
You can send the timezone as a parameter to get timezones of different places using http://localhost:8080/time?time=[enter any valid timezone here].
All the valid timezones can be found in this link http://joda-time.sourceforge.net/timezones.html  
