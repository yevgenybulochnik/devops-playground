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
        tag_dict = {}
        for tag in instance.tags:
            tag_dict[tag['Key']] = tag['Value']
        if 'Name' in tag_dict:
            name = tag_dict['Name']
        if 'Domain' in tag_dict:
            domain = tag_dict['Domain']
    except:
        name = '----'
        domain = '----'

    data.append({
        'Name': name,
        'Domain': domain,
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
