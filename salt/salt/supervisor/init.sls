include:
  - user.ubuntu

/home/ubuntu/log:
  file.directory:
    - makedirs: True
    - user: ubuntu

/home/ubuntu/supervisord:
  file.directory:
    - makedirs: True
    - user: ubuntu

supervisor:
  pkg.installed

supervisord-conf:
  file.managed:
    - name: /home/ubuntu/supervisord/supervisord.conf
    - source: salt://supervisord/supervisord.conf
    - makedirs: True
    - user: ubuntu

supervisord:
  cmd.run:
    - name: supervisord -c /home/ubuntu/supervisord/supervisord.conf
    - unless: test -e /home/ubuntu/supervisord/supervisord.pid
    - user: ubuntu
    - require:
      - pkg: supervisor
      - file: supervisord-conf
      - file: /home/ubuntu/log
      - file: /home/ubuntu/supervisord
