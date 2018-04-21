{% from 'macros.sls' import user, group with context %}

zsh:
    pkg.installed

https://github.com/robbyrussell/oh-my-zsh:
    git.latest:
        - target: {{ salt['environ.get']('HOME') }}/src/github.com/robbyrussell/oh-my-zsh
        - force_reset: True
        {{ user() }}

https://github.com/zsh-users/antigen:
    git.latest:
        - target: {{ salt['environ.get']('HOME') }}/src/github.com/zsh-users/antigen
        {{ user() }}

{{ salt['environ.get']('HOME') }}/.use_zsh:
    file.managed:
        - contents: Delete this file if you want to use bash.
        {{ user() }}
        {{ group() }}
