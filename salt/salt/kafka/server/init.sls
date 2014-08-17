{%- if 'kafka' in salt['grains.get']('roles', []) %}
{%- from 'kafka/settings.sls' import kafka with context %}

include:
  - kafka
  - sun-java

server.properties:
  file.managed:
    - name: {{ kafka.alt_home }}/config/server.properties
    - source: salt://kafka/server/server.properties
    - template: jinja
    - context:
      id: {{ kafka.myid }}
      zookeeper_host: {{ kafka.zookeeper_host }}
    - require:
      - sls: kafka
      - sls: sun-java

kafka.conf:
  pkg.installed:
    - name: supervisor
  file.managed:
    - name: /etc/supervisor/conf.d/kafka.conf
    - source: salt://kafka/server/supervisord.conf
    - template: jinja
    - makedirs: True
    - context:
      java_home: {{ kafka.java_home }}
      kafka_home: {{ kafka.alt_home }}
    - require:
      - pkg: kafka.conf

update-supervisor:
  module.run:
    - name: supervisord.update
    - watch:
      - file: kafka.conf

kafka:
  supervisord.running:
    - conf_file: /etc/supervisor/supervisord.conf
    - restart: False
    - require:
      - file: server.properties
      - file: kafka.conf
      - module: update-supervisor

{% endif %}
