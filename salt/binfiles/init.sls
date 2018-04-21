{% from 'macros.sls' import user, group with context %}

Copy shared bin files:
    file.recurse:
        - name: {{ salt['environ.get']('HOME') }}/bin
        - source: salt://binfiles/shared
        {{ user() }}
        {{ group() }}

{% if grains['kernel'] == 'Linux' %}

Copy Linuxs bin files:
    file.recurse:
        - name: {{ salt['environ.get']('HOME') }}/bin
        - source: salt://binfiles/linux
        {{ user() }}
        {{ group() }}

{% endif %}
