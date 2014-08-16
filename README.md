# piper

`vagrant up --provider=aws`

## Start zookeeper quorum

sudo salt-call state.sls salt.master
sudo salt-call state.sls salt.cloud

sudo salt-call state.sls instances.zookeeper
sudo salt 'zoo*' state.highstate
