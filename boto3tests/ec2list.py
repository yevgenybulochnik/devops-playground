import os
import boto3
from tabulate import tabulate

reg_name = 'us-west-2'
ec2 = boto3.resource('ec2', region_name=reg_name)

data = []
header = ['Name', 'State', 'Sec_Gr', 'ID', 'Type', 'Pub IP']
for instance in ec2.instances.filter():
    tags = instance.tags
    security_groups = instance.security_groups
    instance_sec_group = security_groups[0]['GroupName']
    instance_id = instance.id
    instance_type = instance.instance_type
    instance_name = tags[0]['Value']
    instance_state = instance.state
    instance_pub_ip = instance.public_ip_address
    data.append([
        instance_name,
        instance_state['Name'],
        instance_sec_group,
        instance_id,
        instance_type,
        instance_pub_ip])

os.system('clear')
print(f'AWS Console  --{reg_name}--\n')
print(tabulate(data, headers=header))
print()
