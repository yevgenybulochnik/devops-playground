import boto3
import datetime

exc_time = datetime.datetime.now().strftime('%m/%d/%y-%H:%M:%S')
print(f'Script start time {exc_time}')

ec2 = boto3.resource('ec2', region_name='us-west-2')

# Security Group Setup
mysg = ec2.create_security_group(
    GroupName='devbox',
    Description='Open to home and cell'
)
mysg.authorize_ingress(
    IpPermissions=[
        {
            'FromPort': 80,
            'IpProtocol': 'tcp',
            'IpRanges': [
                {
                    'CidrIp': '0.0.0.0/0'
                }
            ],
            'ToPort': 80,
            'Ipv6Ranges': [
                {
                    'CidrIpv6': '::/0'
                }
            ]
        },
        {
            'FromPort': 443,
            'IpProtocol': 'tcp',
            'IpRanges': [
                {
                    'CidrIp': '0.0.0.0/0'
                }
            ],
            'ToPort': 443,
            'Ipv6Ranges': [
                {
                    'CidrIpv6': '::/0'
                }
            ]
        },
        {
            'FromPort': 22,
            'IpProtocol': 'tcp',
            'IpRanges': [
                {
                    'CidrIp': '24.22.29.161/32'
                }
            ],
            'ToPort': 22,
        },
        {
            'FromPort': 22,
            'IpProtocol': 'tcp',
            'IpRanges': [
                {
                    'CidrIp': '66.87.113.231/32'
                }
            ],
            'ToPort': 22,
        },
    ]
)
print('Security Group Created')

# Ec2 launch instance
username = ''
password = ''
domain = ''

user_data = f"""#!/bin/bash
git clone https://github.com/yevgenybulochnik/ttyjs-provisioner.git /tmp/tp
./tmp/tp/ttyjs_provisioner.sh {username} {password} {domain}
"""

instances = ec2.create_instances(
        ImageId='ami-0def3275',
        MinCount=1,
        MaxCount=1,
        KeyName='id_rsa',
        InstanceType='t2.micro',
        SecurityGroups=['devbox'],
        TagSpecifications=[
            {
                'ResourceType': 'instance',
                'Tags': [
                    {
                        'Key': 'Name',
                        'Value': 'devbox'
                    }
                ]
            }
        ],
        UserData=user_data
    )
print('Ec2 Launch')

instance = instances[0]
print('Waiting for instance IP Address')
instance.wait_until_running()
instance.load()
instance_ip = instance.public_ip_address
print(instance_ip)

# Route53 setup
r53 = boto3.client('route53')
response = r53.create_hosted_zone(
    Name=f'{domain}.com',
    CallerReference=exc_time
)

zone_id = response['HostedZone']['Id']
nameservers = response['DelegationSet']['NameServers']

r53.change_resource_record_sets(
    HostedZoneId=zone_id,
    ChangeBatch={
        'Changes': [
            {
                'Action': 'CREATE',
                'ResourceRecordSet': {
                    'Name': f'www.{domain}.com',
                    'Type': 'A',
                    'TTL': 300,
                    'ResourceRecords': [
                        {
                            'Value': instance_ip
                        }
                    ]
                }
            },
            {
                'Action': 'CREATE',
                'ResourceRecordSet': {
                    'Name': f'{domain}.com',
                    'Type': 'A',
                    'AliasTarget': {
                        'HostedZoneId': zone_id[12:],
                        'DNSName': f'www.{domain}.com',
                        'EvaluateTargetHealth': False
                    }
                }
            },
            {
                'Action': 'CREATE',
                'ResourceRecordSet': {
                    'Name': f'*.{domain}.com',
                    'Type': 'CNAME',
                    'TTL': 300,
                    'ResourceRecords': [
                        {
                            'Value': f'www.{domain}.com'
                        }
                    ]
                }
            },
        ]
    }
)

# Domain nameservers update
r53domains = boto3.client('route53domains')
r53domains.update_domain_nameservers(
    DomainName=f'{domain}.com',
    Nameservers=[dict(Name=pn) for pn in nameservers]
)
