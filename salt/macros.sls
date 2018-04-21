{%- macro user() %}
        - user: {{ salt['user.current']() }}
{%- endmacro %}

{%- macro group() %}
        - group: {{ salt['user.group']() }}
{%- endmacro %}
