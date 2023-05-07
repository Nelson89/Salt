go:
{% if 'Web' in grains.host %}
  version: 1.20.4
{% else %}
  version: 1.20.3
{% endif %}
