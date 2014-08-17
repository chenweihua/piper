{% set p  = salt['pillar.get']('zookeeper', {}) %}
{% set pc = p.get('config', {}) %}
{% set g  = salt['grains.get']('zookeeper', {}) %}
{% set gc = g.get('config', {}) %}

{%- set prefix       = p.get('prefix', '/usr/lib/kafka') %}
{%- set java_home    = salt['pillar.get']('java_home', '/usr/lib/java') %}

{%- set version       = g.get('version', p.get('version', '0.8.1.1')) %}
{%- set scala_version = g.get('scala_version', p.get('scala_version', '2.9.2')) %}
{%- set version_name  = 'kafka' + '_' + scala_version + '-' + version %}
{%- set default_url   = 'http://apache.osuosl.org/kafka/' + version + '/' + version_name + '.tgz' %}
{%- set source_url    = g.get('source_url', p.get('source_url', default_url)) %}

{%- set alt_home     = prefix %}
{%- set real_home    = alt_home + '_' + scala_version + '-' + version %}

{%- set force_mine_update = salt['mine.send']('network.get_hostname') %}
{%- set kafkas_host_dict = salt['mine.get']('roles:kafka', 'network.get_hostname', 'grain') %}
{%- set kafkas_ids = kafkas_host_dict.keys() %}
{%- set kafkas_hosts = kafkas_host_dict.values() %}
{%- set node_count = kafkas_ids | length() %}

# yes, this is not pretty, but produces sth like:
# {'node1': '0+node1', 'node2': '1+node2', 'node3': '2+node2'}
{%- set kafkas_with_ids = {} %}
{%- for i in range(node_count) %}
{%- do kafkas_with_ids.update({kafkas_ids[i] : '{0:d}'.format(i) + '+' + kafkas_hosts[i] })  %}
{%- endfor %}

{%- set myid = kafkas_with_ids.get(grains.id, '').split('+') | first() %}

{%- from 'zookeeper/settings.sls' import zk with context %}
{%- set zookeeper_host = zk.zookeeper_host %}

{%- set kafka = {} %}
{%- do kafka.update({ 'java_home': java_home,
                      'source_url': source_url,
                      'alt_home' : alt_home,
                      'real_home' : real_home,
                      'myid' : myid,
                      'zookeeper_host' : zookeeper_host
                     }) %}
