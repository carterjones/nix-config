This install script is designed to fully cofigure a Debian-based system to my
personal liking. Rather than downloading, installing, creating config files,
and other activities related to getting a freshly installed system customized,
I run this install script.

To download, extract, and run the installer, run the following command:

    pushd /tmp && \
        rm -rf debian-config-master && \
        wget "https://github.com/carterjones/debian-config/archive/master.tar.gz" && \
        tar -xvf master.tar.gz && \
        rm master.tar.gz && \
        pushd debian-config-master/ && \
        ./install
