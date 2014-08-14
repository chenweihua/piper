include:
  - python

luigi:
  conda.installed:
    - env: /home/ubuntu/.envs/base
    - user: ubuntu
    - require:
      - sls: python

/etc/luigi/client.cfg:
  file.managed:
    - source: salt://luigi/conf.cfg
    - template: jinja
    - makedirs: True
    - mode: 0777
    - user: ubuntu
