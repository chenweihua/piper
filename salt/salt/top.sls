base:
  'piper-master':
    - salt.master
    - salt.cloud

  'roles:zookeeper':
    - match: grain
    - zookeeper.server

  'roles:kafka':
    - match: grain
    - kafka.server
