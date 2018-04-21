{% from 'macros.sls' import user, group with context %}

{{ salt['environ.get']('HOME') }}/bin/ramdisk:
    file.managed:
{% if grains['kernel'] == 'Darwin' %}
        - source: salt://ramdisk/ramdisk.mac
{% elif grains['kernel'] == 'Linux' %}
        - source: salt://ramdisk/ramdisk.linux
{% endif %}
        - makedirs: True
        - mode: 755
        {{ user() }}
        {{ group() }}
