
if [ -z "$(command -v node)" ]; then
    sudo apt-get install -y nodejs npm
    sudo npm install n -g
    sudo n stable
    sudo apt-get purge -y nodejs npm
fi

