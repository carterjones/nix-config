This install script is designed to fully cofigure a *nix-based system to my
personal liking. Rather than downloading, installing, creating config files,
and other activities related to getting a freshly installed system customized,
I run this install script.

To download, extract, and run the installer, run the following command:

    pushd /tmp && \
        rm -rf nix-config-master && \
        wget "https://github.com/carterjones/nix-config/archive/master.tar.gz" && \
        tar -xvf master.tar.gz && \
        rm master.tar.gz && \
        cd nix-config-master/ && \
        ./install && \
        popd
