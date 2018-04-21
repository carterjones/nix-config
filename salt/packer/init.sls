{% from 'macros.sls' import user, group with context %}

# Get the latest and current version.
{% set latest_version = salt['cmd.run']('bash -c \'curl -s "https://www.packer.io/downloads.html" | grep darwin_amd64.zip | sed "s/.*packer_//;s/_darwin_amd64.*//"\'') %}
{% set current_version = salt['cmd.run']('bash -c \'packer --version 2>&1 | cut -d" " -f2\'') %}

# Set a variable to indicate if plugins should be installed.
{% set install_plugins = false %}

{% if latest_version != current_version %}

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
