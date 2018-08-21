{% if grains['kernel'] == 'Darwin' %}

Make sure Docker is running:
    cmd.run:
        - name: nohup /Applications/Docker.app/Contents/MacOS/Docker > /dev/null & disown
        - runas: {{ salt['user.current']() }}
        - stateful: True
        - unless: ps -A | grep '[/]Applications/Docker.app/Contents/MacOS/Docker'

{% elif grains['os'] == 'Arch' %}

Make sure Docker is running:
    cmd.run:
        - name: systemctl start docker
        - stateful: True
        - unless: systemctl is-active --quiet docker
        - onlyif: "[ -f /sbin/init ] || exit 1"

{% endif %}
