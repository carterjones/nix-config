{% if grains['kernel'] == 'Darwin' %}

{% if not salt['file.directory_exists']('/Applications/Docker.app') %}

Download the Docker app:
    file.managed:
        - name: /tmp/docker.dmg
        - source: https://download.docker.com/mac/stable/Docker.dmg
        - skip_verify: True
        - require_in: Install Docker app

Install Docker app:
    macpackage.installed:
        - name: /tmp/docker.dmg
        - dmg: True
        - app: True
        - target: /Applications/Docker.app

{% endif %}

# TODO: check for cosmic under https://download.docker.com/linux/ubuntu/dists/
#       Once that is available, we can remove the check for 18.10.
{% elif grains['os'] == 'Ubuntu' and grains['osrelease'] != '18.10' %}

docker-repo:
    pkgrepo.managed:
        - humanname: Docker
        - name: deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ grains['oscodename'] }} stable
        - dist: {{ grains['oscodename'] }}
        - file: /etc/apt/sources.list.d/docker.list
        - gpgcheck: 1
        - key_url: https://download.docker.com/linux/ubuntu/gpg
    pkg.latest:
        - name: docker-ce
        - refresh: True

{% elif grains['os'] == 'Arch' %}

Install docker:
    pkg.installed:
        - name: docker

Install docker-compose:
    pkg.installed:
        - name: docker-compose

{% endif %}
