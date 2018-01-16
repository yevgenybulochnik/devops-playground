import os
from sys import argv
import boto3
from tabulate import tabulate

script, hostedzone_id = argv

r53 = boto3.client('route53')
response = r53.list_resource_record_sets(HostedZoneId=hostedzone_id)
records = response['ResourceRecordSets']

data = []
for record in records:
    if 'ResourceRecords' in record:
        values = []
        for item in record['ResourceRecords']:
            values.append(item['Value'])
        values = '\n'.join(values)

        data.append({
            'Name': record['Name'],
            'Type': record['Type'],
            'TTL': record['TTL'],
            'Value': values
        })
    else:
        data.append({
            'Name': record['Name'],
            'Type': record['Type'],
            'TTL': '----',
            'Value': 'Alias:' + record['AliasTarget']['DNSName']
        })
os.system('clear')
print(f'{hostedzone_id} Record Sets\n')
print(tabulate(data, headers='keys', tablefmt='simple'))
