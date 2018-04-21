{% from 'macros.sls' import user, group with context %}

nmap:
    pkg.installed

{{ salt['environ.get']('HOME') }}/.nmap/logs:
    file.directory:
        - makedirs: True
        {{ user() }}
        {{ group() }}
