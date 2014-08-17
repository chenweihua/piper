base:
  'piper-master':
    # - salt.master
    # - salt.cloud
    - sun-java
    - sun-java.env

  'roles:zookeeper':
    - match: grain
    - zookeeper.server

  'roles:kafka':
    - match: grain
    - kafka.server
