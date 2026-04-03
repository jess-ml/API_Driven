import boto3
import json
import os

def lambda_handler(event, context):
    # Configuration pour que la Lambda trouve ton LocalStack interne
    localstack_host = os.environ.get('LOCALSTACK_HOSTNAME', 'localhost')
    ec2 = boto3.client('ec2', endpoint_url=f"http://{localstack_host}:4566", region_name='us-east-1')
    
    # L'ID de TON instance cobaye
    instance_id = 'i-303d76271a94b4012'
    
    # On cherche l'action voulue dans l'URL (ex: ?action=start ou ?action=stop)
    action = "status"
    if event.get('queryStringParameters') and 'action' in event['queryStringParameters']:
        action = event['queryStringParameters']['action']
        
    try:
        if action == 'start':
            ec2.start_instances(InstanceIds=[instance_id])
            msg = f"MISSION ACCOMPLIE : Demarrage de l'instance {instance_id}"
        elif action == 'stop':
            ec2.stop_instances(InstanceIds=[instance_id])
            msg = f"MISSION ACCOMPLIE : Arret de l'instance {instance_id}"
        else:
            # Le bonus demandé par le prof : Voir le statut !
            response = ec2.describe_instances(InstanceIds=[instance_id])
            state = response['Reservations'][0]['Instances'][0]['State']['Name']
            msg = f"INFO : L'instance {instance_id} est actuellement à l'état '{state}'"
            
        return {
            "statusCode": 200,
            "body": json.dumps({"message": msg})
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"erreur": str(e)})
        }
