ubuntu:
  user.present:
    - shell: /bin/bash

# Vagrant compat states
/home/ubuntu/.ssh:
  file.directory:
    - user: ubuntu
    - makedirs: True

insecure-key:
  cmd.run:
    - name: "wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -q -O - >> authorized_keys"
    - cwd: /home/ubuntu/.ssh
    - user: ubuntu
    - onlyif: "test -d /home/vagrant"
    - require:
      - user: ubuntu
      - file: /home/ubuntu/.ssh
