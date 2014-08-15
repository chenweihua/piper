include:
  - salt.cloud
  - salt.master

{% set ninstances = salt['pillar.get']('instances')['zookeeper']['number'] %}
{% for instance in range(ninstances) %}
ipengine-{{ instance + 1 }}:
  cloud.profile:
    - profile: zookeeper
    - require:
      - sls: salt.cloud
      - sls: salt.master
{% endfor %}

{% if ninstances > 0 %}
ipengines-bootstrap:
  salt.state:
    - tgt: 'ipengine-*'
    - highstate: True
    - require:
      {% for instance in range(ninstances) %}
      - cloud: ipengine-{{ instance + 1 }}
      {% endfor %}
{% endif %}
