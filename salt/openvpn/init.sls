{% if not (grains['os'] == 'Ubuntu' and grains['osrelease'] == '14.04') %}

openvpn-repo:
    pkgrepo.managed:
        - humanname: OpenVPN
        - name: deb http://build.openvpn.net/debian/openvpn/stable {{ grains['oscodename'] }} main
        - dist: {{ grains['oscodename'] }}
        - file: /etc/apt/sources.list.d/openvpn.list
        - gpgcheck: 1
        - key_url: https://swupdate.openvpn.net/repos/repo-public.gpg

openvpn:
    pkg.installed:
        - require:
            - pkgrepo: openvpn-repo

{% endif %}
