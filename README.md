# piper

`vagrant up --provider=aws`

## salt-master and salt-cloud

This states should be installed on the instance by default

1. `sudo salt-call state.sls salt.master`
2. `sudo salt-call state.sls salt.cloud`

## zookeeper quorum

**Requires**:

1. salt-master
2. salt-cloud

Change settings under: `salt/pillar/instances` and `/salt/pillar/salt/cloud.sls`
a template for the latter is provided as `salt/pillar/salt/cloud.sls.template`

1. `sudo salt-call state.sls instances.zookeeper`
2. `sudo salt 'zoo*' state.highstate`

## kafka cluster

**Requires**:

1. zookeeper quorun

Change settings under: `salt/pillar/instances` and `/salt/pillar/salt/cloud.sls`
a template for the latter is provided as `salt/pillar/salt/cloud.sls.template`

1. `sudo salt-call state.sls instances.kafka`
2. `sudo salt 'kafka*' state.highstate`
