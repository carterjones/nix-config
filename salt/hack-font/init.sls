{%- if not salt['file.file_exists']('/usr/share/fonts/TTF/Hack-Regular.ttf') and not salt['file.file_exists']('/Library/Fonts/Hack-Regular.ttf') %}

/tmp/hack-font:
    archive.extracted:
        - source: https://github.com/chrissimpkins/Hack/releases/download/v2.020/Hack-v2_020-ttf.zip
        - enforce_toplevel: False
        - skip_verify: True

{%- for file in ['Hack-Bold.ttf', 'Hack-BoldItalic.ttf', 'Hack-Italic.ttf', 'Hack-Regular.ttf'] %}

Extract Hack {{ file }} font:
    file.copy:
{%- if grains['kernel'] == 'Darwin' %}
        - name: /Library/Fonts/{{ file }}
{%- elif grains['kernel'] == 'Linux' %}
        - name: /usr/share/fonts/TTF/{{ file }}
{%- endif %}
        - source: /tmp/hack-font/{{ file }}
        - makedirs: True

{%- endfor %}

{%- if grains['kernel'] == 'Linux' %}

Update the font cache:
    cmd.run:
        - name: bash -c "fc-cache -f -v 1> /dev/null"
        - stateful: True

{%- endif %}

{%- endif %}
