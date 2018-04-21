{% from 'macros.sls' import user, group with context %}

{{ salt['environ.get']('HOME') }}/.nanorc:
    file.managed:
        - template: jinja
        - source: salt://nano/.nanorc
        {{ user() }}
        {{ group() }}
