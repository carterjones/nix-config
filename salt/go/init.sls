{% from 'macros.sls' import user, group with context %}

{% set golang_version = "go1.11" %}
{% set current_version = salt['cmd.run']('bash -c \'command -v go &> /dev/null && (go version | cut -d" " -f3) || true\'') %}

{% if golang_version != current_version %}

Download Go package:
    file.managed:
{% if grains['kernel'] == 'Darwin' %}
        - name: /tmp/go_package.pkg
        - source: https://dl.google.com/go/{{ golang_version }}.darwin-amd64.pkg
        - show_changes: False # workaround: https://github.com/saltstack/salt/issues/47042#issuecomment-381433025
{% elif grains['kernel'] == 'Linux' %}
        - name: /tmp/go_package.tar.gz
        - source: https://dl.google.com/go/{{ golang_version }}.linux-amd64.tar.gz
{% endif %}
        - skip_verify: True

{% if grains['kernel'] == 'Darwin' %}

/tmp/go_package.pkg:
    macpackage.installed:
        - target: /
        - force: True

{% elif grains['kernel'] == 'Linux' %}

/usr/local/go:
    file.directory:
        - clean: True

/usr/local:
    archive.extracted:
        - source: /tmp/go_package.tar.gz
        - archive_format: tar

{% if grains['os'] == 'Ubuntu' %}

Update alternatives:
    cmd.run:
        - name: |
            update-alternatives --install "/usr/bin/go" "go" "/usr/local/go/bin/go" 0
            update-alternatives --set go /usr/local/go/bin/go

{% elif grains['os'] == 'Arch' %}

/usr/local/bin/go:
    file.symlink:
        - target: /usr/local/go/bin/go

{% endif %}

{% endif %}

{% endif %}

go get -u github.com/golang/dep/cmd/dep:
    cmd.run:
        - runas: {{ salt['user.current']() }}
        - env:
            - GOPATH: {{ salt['environ.get']('HOME') }}
        - stateful: True

/tmp/fakehome:
    file.directory:
        {{ user() }}
        {{ group() }}

go get -u github.com/carterjones/awsinfo/cmd/...:
    cmd.run:
        - runas: {{ salt['user.current']() }}
        - env:
            - GOPATH: {{ salt['environ.get']('HOME') }}
            - HOME: /tmp/fakehome
        - stateful: True
