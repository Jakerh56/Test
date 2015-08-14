FROM debian:wheezy 

# Use APT (Advanced Packaging Tool) built in the Linux distro to download Java, a dependency 
# to run Minecraft. 
RUN \
	apt-get -y update && \
	apt-get -y install openjdk-7-jre-headless wget && \
	apt-get -y install zip

# Download Minecraft Server components 
RUN \
	wget -q http://ftb.cursecdn.com/FTB2/modpacks/FTBInfinity/1_10_1/FTBInfinityServer.zip && \
	unzip FTBInfinityServer.zip

# Sets working directory for the CMD instruction (also works for RUN, ENTRYPOINT commands) 
# Create mount point, and mark it as holding externally mounted volume 
WORKDIR /data
VOLUME /data

# Expose the container's network port: 25565 during runtime. 
EXPOSE 25565 

#Automatically accept Minecraft EULA, and start Minecraft server 
CMD echo eula=true > /data/eula.txt && java -jar /FTBServer-1.7.10-1448.jar