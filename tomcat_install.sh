#!bin/bash
cd /opt
#download  the java 
wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm
# istall the java with 
rpm -ivh jdk-8u131-linux-x64.rpm
# install tomcat
wget https://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.50/bin/apache-tomcat-9.0.50-windows-x64.zip
#unzip the tomcat
unzip apache-tomcat-9.0.50-windows-x64.zip

#rename tomcat
mv apache-tomcat-9.0.50 tomcat9
# change the permissions
chmod -R 700 tomcat9
# remove the zip file
rm -f apache-tomcat-9.0.50-windows-x64.zip
#change the path
cd /opt/tomcat9/bin
# start the apache  pre req is the java for the tomacat
./startup.sh