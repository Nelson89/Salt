vim:
  pkg.installed:
    - pkgs:
      - vim

/root/.vimrc:
  file.managed:
    - source: salt://vim/files/.vimrc
    - user: root
    - group: root
    - mode: 600

