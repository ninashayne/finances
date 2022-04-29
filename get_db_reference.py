import yaml

profile = '/Users/ninafink/.dbt/profiles.yml'

with open(profile,'r') as stream:
    x = (yaml.safe_load(stream))

profile_name = 'nina_personal'

target = x[profile_name]['target']

db_name = x[profile_name]['outputs'][target]['dbname']


print(db_name)