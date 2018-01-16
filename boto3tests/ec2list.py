import os
import boto3
from tabulate import tabulate

reg_name = 'us-west-2'
ec2 = boto3.resource('ec2', region_name=reg_name)

data = []
for instance in ec2.instances.filter():
    try:
        security_group = instance.security_groups[0]['GroupName']
    except IndexError:
        security_group = '----'

    try:
        name = instance.tags[0]['Value']
    except TypeError:
        name = '----'

    data.append({
        'Name': name,
        'State': instance.state['Name'],
        'Sec_Gr': security_group,
        'Id': instance.id,
        'Type': instance.instance_type,
        'Pub IP': instance.public_ip_address
    })

os.system('clear')
print(f'AWS Console  --{reg_name}--\n')
print(tabulate(data, headers='keys', tablefmt='simple'))
print()
