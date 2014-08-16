include:
  - salt.cloud
  - salt.master

{% set ninstances = salt['pillar.get']('instances')['zookeeper']['number'] %}
{% for instance in range(ninstances) %}
zookeeper-{{ instance }}:
  cloud.profile:
    - profile: zookeeper
    - require:
      - sls: salt.cloud
      - sls: salt.master
{% endfor %}
