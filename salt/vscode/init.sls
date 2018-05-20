{% from 'macros.sls' import user, group with context %}

{% if grains['kernel'] == 'Darwin' %}

{% if not salt['file.directory_exists']('/Applications/Visual Studio Code.app') %}

Extract VSCode:
    archive.extracted:
        - name: /Applications
        - source: https://go.microsoft.com/fwlink/?LinkID=620882
        - archive_format: zip
        - skip_verify: True

{% endif %}

{{ salt['environ.get']('HOME') }}/Library/Application Support/Code/User/:
    file.recurse:
        - source: salt://vscode/configs
        {{ user() }}
        {{ group() }}

{% elif grains['kernel'] == 'Linux' %}

{{ salt['environ.get']('HOME') }}/.config/Code/User/:
    file.recurse:
        - source: salt://vscode/configs
        {{ user() }}
        {{ group() }}

{% endif %}
