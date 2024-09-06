# install_red5.sh

# Update the system
sudo apt-get update -y

# Install Java (required for Red5)
sudo apt-get install -y openjdk-11-jdk unzip libva2 libva-drm2 libva-x11-2 libvdpau1 jsvc ntp

# Download Red5
wget https://account.red5.net/download-server/red5pro-server-us-e0af5294-3a0e-4987-9dfb-a154c39d649d.zip

# Extract and Install Red5
sudo apt-get install tar -y
tar -xvzf red5-server-1.0.10-M11.tar.gz
sudo mv red5-server /usr/local/red5

# Start Red5
cd /usr/local/red5
sudo ./red5.sh &
