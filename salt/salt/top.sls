base:
  'piper-master':
    - salt.master
    - salt.cloud

  'roles:zookeeper':
    - match: grain
    - sun-java
    - zookeeper.server
