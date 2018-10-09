{% from 'macros.sls' import user, group with context %}

{% if grains['kernel'] == 'Darwin' %}

{% if not salt['file.directory_exists'](salt['environ.get']('HOME') + '/Applications/Emacs.app') %}

Download the Emacs app:
    file.managed:
        - name: /tmp/emacs.dmg
        - source: https://emacsformacosx.com/emacs-builds/Emacs-26.1-2-universal.dmg
        - source_hash: 9be6c895fbb61a0fc0f29248fae1d677b3af4f4edb66328c05158d3bf0c1fc8be841012dbb5c6c4d8609f8a2bbf9159ea3651740de655fb5015ff44e428a12d7
        - require_in: Install Emacs app

{{ salt['environ.get']('HOME') }}/Applications:
    file.directory:
        - user: {{ user() }}
        - group: staff
        - mode: 700
        - makedirs: True

Install Emacs app:
    macpackage.installed:
        - name: /tmp/emacs.dmg
        - dmg: True
        - app: True
        - target: {{ salt['environ.get']('HOME') }}/Applications/Emacs.app

{% endif %}

{% endif %}

{{ salt['environ.get']('HOME') }}/.emacs.d/:
    file.recurse:
        - source: salt://emacs/.emacs.d
        {{ user() }}
        {{ group() }}
