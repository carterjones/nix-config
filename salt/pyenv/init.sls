{% from 'macros.sls' import user, group with context %}

Prepare pyenv installer:
    file.managed:
        - name: /tmp/pyenv-installer
        - source: salt://pyenv/pyenv/pyenv-installer
        {{ user() }}
        {{ group() }}

su {{ salt['user.current']() }} -c 'bash /tmp/pyenv-installer':
    cmd.run:
        - stateful: True
        {{ user() }}

https://github.com/yyuu/pyenv-virtualenvwrapper:
    git.latest:
        - target: {{ salt['environ.get']('HOME') }}/.pyenv/plugins/pyenv-virtualenvwrapper
        {{ user() }}

Prepare pyenv/Python updater:
    file.managed:
        - name: /tmp/pyenv-updater.sh
        - source: salt://pyenv/update.sh
        - template: jinja
        {{ user() }}
        {{ group() }}

su {{ salt['user.current']() }} -c 'bash /tmp/pyenv-updater.sh':
    cmd.run:
        - stateful: True
        {{ user() }}
