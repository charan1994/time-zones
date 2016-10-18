set -e
if [ -z "$1" ]
then
echo "
USAGE:
Parse a support-core plugin -style txt file as specification for jenkins plugins to be installed
in the reference directory, so user can define a derived Docker image with just :
FROM jenkins
COPY plugins.txt /plugins.txt
RUN /usr/local/bin/plugins.sh /plugins.txt
Note: Plugins already installed are skipped
"
exit 1
else
/etc/init.d/jenkins start
JENKINS_INPUT_JOB_LIST=$1
if [ ! -f "$JENKINS_INPUT_JOB_LIST" ]
then
echo "ERROR File not found: $JENKINS_INPUT_JOB_LIST"
exit 1
fi
fi
REF=/usr/share/jenkins/ref/plugins
mkdir -p $REF
COUNT_PLUGINS_INSTALLED=0
while read -r spec || [ -n "$spec" ]; do
plugin=(${spec//:/ });
[[ ${plugin[0]} =~ ^# ]] && continue
[[ ${plugin[0]} =~ ^[[:space:]]*$ ]] && continue
[[ -z ${plugin[1]} ]] && plugin[1]="latest"
if [ -z "$JENKINS_UC_DOWNLOAD" ]; then
JENKINS_UC_DOWNLOAD=$JENKINS_UC/download
fi
echo "Downloading ${plugin[0]}:${plugin[1]}"
curl --retry 3 --retry-delay 5 -sSL -f "${JENKINS_UC_DOWNLOAD}/plugins/${plugin[0]}/${plugin[1]}/${plugin[0]}.hpi" -o "$REF/${plugin[0]}.jpi"
unzip -qqt "$REF/${plugin[0]}.jpi"
(( COUNT_PLUGINS_INSTALLED += 1 ))
done < "$JENKINS_INPUT_JOB_LIST"
echo "---------------------------------------------------"
if (( "$COUNT_PLUGINS_INSTALLED" > 0 ))
then
echo "INFO: Successfully installed $COUNT_PLUGINS_INSTALLED plugins."
if [ -d $JENKINS_PLUGINS_DIR ]
then
echo "INFO: Please restart the container for changes to take effect!"
fi
else
echo "INFO: No changes, all plugins previously installed."
fi
echo "---------------------------------------------------"
#cleanup
cp /usr/share/jenkins/ref/plugins/* /var/lib/jenkins/plugins
chown jenkins.jenkins /var/lib/jenkins/plugins/*
/etc/init.d/jenkins stop
exit 0
