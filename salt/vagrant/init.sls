# Get the latest and current version.
{% set latest_version = salt['cmd.run']('bash -c \'curl -s "https://www.vagrantup.com/downloads.html" | grep dmg | sed "s/.*vagrant_//;s/_x86_64.dmg.*//"\'') %}
{% set current_version = salt['cmd.run']('bash -c \'vagrant --version 2>&1 | cut -d" " -f2\'') %}

# Set a variable to indicate if plugins should be installed.
{% set install_plugins = false %}

{% if latest_version != current_version %}

{% if grains['os'] == 'MacOS' or grains['os'] == 'Ubuntu' %}

Download Vagrant:
    file.managed:
        - name: /tmp/vagrant_installer
{% if grains['os'] == 'MacOS' %}
        - source: https://releases.hashicorp.com/vagrant/{{ latest_version }}/vagrant_{{ latest_version }}_x86_64.dmg
{% elif grains['os'] == 'Ubuntu' %}
        - source: https://releases.hashicorp.com/vagrant/{{ latest_version }}/vagrant_{{ latest_version }}_x86_64.deb
{% endif %}
        - skip_verify: True
        - require_in: Install Vagrant app

Install Vagrant:
{% if grains['os'] == 'MacOS' %}
    macpackage.installed:
        - name: /tmp/vagrant_installer
        - dmg: True
        - target: /
{% elif grains['os'] == 'Ubuntu' %}
    pkg.installed:
        - sources:
            - vagrant: /tmp/vagrant_installer
{% endif %}

{% elif grains['os'] == 'Arch' %}

vagrant:
    pkg.installed

{% endif %}

{% endif %}

{% if install_plugins %}

Install Vagrant plugins:
    cmd.run:
        - name: |
            vagrant plugin install vagrant-share
            vagrant plugin install vagrant-s3auth
            vagrant plugin install vagrant-vbguest
        - runas: {{ salt['user.current']() }}
        - stateful: True

{% endif %}
