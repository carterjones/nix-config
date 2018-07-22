{% from 'macros.sls' import user, group with context %}

Prepare pyenv installer:
    file.managed:
        - name: /tmp/pyenv-installer
        - source: salt://pyenv/pyenv/pyenv-installer
        {{ user() }}
        {{ group() }}

Make sure the pyenv git repo exists and is up to date:
    git.latest:
        - name: https://github.com/pyenv/pyenv
        - target: {{ salt['environ.get']('HOME') }}/.pyenv
        - force_clone: True
        {{ user () }}

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
