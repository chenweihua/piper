{%- from 'kafka/settings.sls' import kafka with context %}

install-kafka-dist:
  cmd.run:
    - name: curl -L '{{ kafka.source_url }}' | tar xz
    - cwd: /usr/lib
    - unless: test -d {{ kafka.real_home }}/bin
  alternatives.install:
    - name: kafka-home-link
    - link: {{ kafka.alt_home }}
    - path: {{ kafka.real_home }}
    - priority: 30
    - require:
      - cmd: install-kafka-dist
