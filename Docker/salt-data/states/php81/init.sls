php81_dependency:
  pkg.installed:
    - pkgs:
      - lsb-release 
      - ca-certificates
      - apt-transport-https
      - software-properties-common
      - gnupg2 

php81_repository:
  pkgrepo.managed:
    - name: deb https://packages.sury.org/php/ bullseye main
    - file: /etc/apt/sources.list.d/sury-php.list
    - key_url: https://packages.sury.org/php/apt.gpg


php81_packages:
  pkg.installed:
    - pkgs:
      - php8.1
      - php8.1-fpm
