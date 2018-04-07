import json

def lambda_handler(event, context):
    data = {
        'message': 'looks good'
    }
    
    return {
        'statusCode': 200,
        'headers': { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' },
        'body': json.dumps(data)
    }
