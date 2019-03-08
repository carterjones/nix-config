{% from 'macros.sls' import user, group with context %}

# Get the latest and current version.
{% set latest_version = salt['cmd.run']('bash -c \'curl -s "https://www.packer.io/downloads.html" | grep darwin_amd64.zip | sed "s/.*packer_//;s/_darwin_amd64.*//"\'') %}
{% if grains['os'] == 'CentOS' %}
{% set current_version = salt['cmd.run']('bash -c \'packer.io --version 2>&1 | cut -d" " -f2\'') %}
{% else %}
{% set current_version = salt['cmd.run']('bash -c \'packer --version 2>&1 | cut -d" " -f2\'') %}
{% endif %}

# Set a variable to indicate if plugins should be installed.
{% set install_plugins = false %}

{% if latest_version != current_version %}

{% if grains['os'] == 'CentOS' %}

Install Packer:
    archive.extracted:
        - name: {{ salt['environ.get']('HOME') }}/bin
        - enforce_toplevel: False
        - source: https://releases.hashicorp.com/packer/{{ latest_version }}/packer_{{ latest_version }}_linux_amd64.zip
        {{ user() }}
        {{ group() }}
        - skip_verify: True
        - if_missing: {{ salt['environ.get']('HOME') }}/bin/packer.io

Rename packer to packer.io:
    cmd.run:
        - name: mv {{ salt['environ.get']('HOME') }}/bin/packer {{ salt['environ.get']('HOME') }}/bin/packer.io
        - onlyif: test -f {{ salt['environ.get']('HOME') }}/bin/packer

{% else %}

Install Packer:
    archive.extracted:
        - name: {{ salt['environ.get']('HOME') }}/bin
        - enforce_toplevel: False
{% if grains['kernel'] == 'Darwin' %}
        - source: https://releases.hashicorp.com/packer/{{ latest_version }}/packer_{{ latest_version }}_darwin_amd64.zip
{% elif grains['kernel'] == 'Linux' %}
        - source: https://releases.hashicorp.com/packer/{{ latest_version }}/packer_{{ latest_version }}_linux_amd64.zip
{% endif %}
        {{ user() }}
        {{ group() }}
        - skip_verify: True
        - if_missing: {{ salt['environ.get']('HOME') }}/bin/packer

{% endif %}

{% endif %}
