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

{% elif grains['os'] == 'Arch' %}

Install docker:
    pkg.installed:
        - name: docker

Install docker-compose:
    pkg.installed:
        - name: docker-compose

{% endif %}
