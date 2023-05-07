tools:
  pkg.installed:
    - pkgs:
      - less
      - procps
      - net-tools
      - tree
      {% if grains['os'] == 'CentOS' %}
      - iproute
      {% else %}
      - iproute2
      - inetutils-ping
      {% endif %}

