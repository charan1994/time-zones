FROM debian:jessie
USER root
RUN apt-get update && apt-get dist-upgrade && apt-get install -y git maven python openssh-server mysql-client python-pip wget && pip install awscli && wget -q -O - http://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add - && echo "deb http://pkg.jenkins.io/debian-stable binary/">>/etc/apt/sources.list && apt-get update && apt-get install -y jenkins && ln -s /usr/bin/nodejs /usr/bin/node
RUN apt-get install -y supervisor curl openjdk-7-jdk nodejs npm
ENV JENKINS_UC https://updates.jenkins-ci.org
ENV JENKINS_HOME /var/lib/jenkins
ADD plugins.sh /usr/local/bin/plugins.sh
ADD plugins.txt /plugins.txt
RUN chmod +x /usr/local/bin/plugins.sh
RUN bash /usr/local/bin/plugins.sh /plugins.txt
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ch_perm.sh /usr/local/bin/ch_perm.sh
RUN chmod +x /usr/local/bin/ch_perm.sh
CMD echo "Enter the below password" && cat /var/lib/jenkins/secrets/initialAdminPassword && /usr/local/bin/ch_perm.sh && /usr/bin/supervisord
EXPOSE 8080
