base:
  'piper-master':
    # - users
    # - zsh
    - salt.master
    - salt.cloud
    # - sun-java
    # - sun-java.env
    # - python

  'roles:zookeeper':
    - match: grain
    - zookeeper.server
