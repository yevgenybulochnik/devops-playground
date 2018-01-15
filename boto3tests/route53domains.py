import os
import boto3
from tabulate import tabulate

r53 = boto3.client('route53')
response = r53.list_hosted_zones()
hosted_zones = response['HostedZones']

data = []

for zone in hosted_zones:
    data.append({
        'Domain Name': zone['Name'][:-1],
        'ID': zone['Id'][12:],
        'Rec Sets': zone['ResourceRecordSetCount']
    })

os.system('clear')
print(f'AWS Route53 Hosted Zones\n')
print(tabulate(data, headers='keys', tablefmt='simple'))
print()
