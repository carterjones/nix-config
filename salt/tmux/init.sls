{% from 'macros.sls' import user, group with context %}

{{ salt['environ.get']('HOME') }}/.tmux.conf:
    file.managed:
        - template: jinja
        - source: salt://tmux/.tmux.conf
        {{ user() }}
        {{ group() }}

{{ salt['environ.get']('HOME') }}/src/github.com/tmux-plugins/tmux-resurrect:
    file.directory:
        - makedirs: True
        {{ user() }}
        {{ group() }}
        - recurse:
            - user
            - group

https://github.com/tmux-plugins/tmux-resurrect:
    git.latest:
        - target: {{ salt['environ.get']('HOME') }}/src/github.com/tmux-plugins/tmux-resurrect
        {{ user() }}
