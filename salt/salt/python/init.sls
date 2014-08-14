include:
  - users
  - conda

base:
  conda.managed:
    - name: /home/ubuntu/.envs/base
    - requirements: salt://python/requirements.txt
    - user: ubuntu
    - require:
      - sls: conda
