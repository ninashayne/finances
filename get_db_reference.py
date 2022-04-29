import yaml

profile = '/Users/ninafink/.dbt/profiles.yml'

with open(profile,'r') as stream:
    dbt_profile = (yaml.safe_load(stream))

with open('dbt_project.yml','r') as stream:
    dbt_project = yaml.safe_load(stream)

profile_name = dbt_project['profile']

target = dbt_profile[profile_name]['target']

db_name = dbt_profile[profile_name]['outputs'][target]['dbname']


print(db_name)