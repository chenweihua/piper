{% import_yaml "luigi.yml" as settings %}

luigi:
  access_key: {{ settings.luigi.access_key }}
  secret_key: {{ settings.luigi.secret_key }}
