{% if pillar.go is defined and pillar.go.version is defined %}
go_binary:
  archive.extracted:
    - name: /usr/local/go_{{ pillar.go.version }}
    - source: https://go.dev/dl/go{{ pillar.go.version }}.linux-amd64.tar.gz
    - skip_verify: true
    - user: root
    - group: root

/usr/bin/go_{{ pillar.go.version }}:
  file.symlink:
    - target: /usr/local/go_{{ pillar.go.version }}/go/bin/go

{% endif %}
