include:
  - salt.cloud
  - salt.master

{% set ninstances = salt['pillar.get']('instances')['kafka']['number'] %}
{% for instance in range(ninstances) %}
kafka-{{ instance }}:
  cloud.profile:
    - profile: kafka
    - require:
      - sls: salt.cloud
      - sls: salt.master
{% endfor %}
