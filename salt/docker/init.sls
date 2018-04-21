{% if not (grains['os'] == 'Ubuntu' and grains['osrelease'] == '14.04') %}

include:
    - .install
    - .service

{% endif %}
