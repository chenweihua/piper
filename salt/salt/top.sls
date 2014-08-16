base:
  'piper-master':
    # - users
    - salt.master
    - salt.cloud
    # - sun-java
    # - sun-java.env

  'roles:zookeeper':
    - match: grain
    - zookeeper.server
