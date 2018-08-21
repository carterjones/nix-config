{%- if grains['os'] == 'Ubuntu' %}

{%- if grains['osrelease'] == '16.04' %}

Install OpenVPN client:
    pkgrepo.managed:
        - humanname: OpenVPN
        - name: deb http://build.openvpn.net/debian/openvpn/stable {{ grains['oscodename'] }} main
        - dist: {{ grains['oscodename'] }}
        - file: /etc/apt/sources.list.d/openvpn.list
        - gpgcheck: 1
        - key_url: https://swupdate.openvpn.net/repos/repo-public.gpg
    pkg.latest:
        - name: openvpn
        - refresh: True

{%- elif grains['osrelease'] == '18.04' %}

Install OpenVPN client:
    pkg.installed:
        - name: openvpn

{%- endif %}

{%- endif %}
