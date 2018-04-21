{% from 'macros.sls' import user, group with context %}

{% if not salt['file.file_exists'](salt['environ.get']('HOME') + '/bin/bgrep') %}

Create a temporary directory to build bgrep:
    file.recurse:
        - name: /tmp/bgrep
        - source: salt://bgrep/bgrep

gcc -O2 -x c -o /tmp/bgrep/bgrep /tmp/bgrep/bgrep.c:
    cmd.run

{{ salt['environ.get']('HOME') }}/bin/bgrep:
    file.managed:
        - source: /tmp/bgrep/bgrep
        - mkdirs: True
        - mode: 755
        {{ user() }}
        {{ group() }}

Delete temporary build directory:
    file.absent:
        - name: /tmp/bgrep

{% endif %}
