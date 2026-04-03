------------------------------------------------------------------------------------------------------
ATELIER API-DRIVEN INFRASTRUCTURE
------------------------------------------------------------------------------------------------------
L’idée en 30 secondes : **Orchestration de services AWS via API Gateway et Lambda dans un environnement émulé**.  
Cet atelier propose de concevoir une architecture **API-driven** dans laquelle une requête HTTP déclenche, via **API Gateway** et une **fonction Lambda**, des actions d’infrastructure sur des **instances EC2**, le tout dans un **environnement AWS simulé avec LocalStack** et exécuté dans **GitHub Codespaces**. L’objectif est de comprendre comment des services cloud serverless peuvent piloter dynamiquement des ressources d’infrastructure, indépendamment de toute console graphique.Cet atelier propose de concevoir une architecture API-driven dans laquelle une requête HTTP déclenche, via API Gateway et une fonction Lambda, des actions d’infrastructure sur des instances EC2, le tout dans un environnement AWS simulé avec LocalStack et exécuté dans GitHub Codespaces. L’objectif est de comprendre comment des services cloud serverless peuvent piloter dynamiquement des ressources d’infrastructure, indépendamment de toute console graphique.
  
-------------------------------------------------------------------------------------------------------
Séquence 1 : Codespace de Github
-------------------------------------------------------------------------------------------------------
Objectif : Création d'un Codespace Github  
Difficulté : Très facile (~5 minutes)
-------------------------------------------------------------------------------------------------------
RDV sur Codespace de Github : <a href="https://github.com/features/codespaces" target="_blank">Codespace</a> **(click droit ouvrir dans un nouvel onglet)** puis créer un nouveau Codespace qui sera connecté à votre Repository API-Driven.
  
---------------------------------------------------
Séquence 2 : Création de l'environnement AWS (LocalStack)
---------------------------------------------------
Objectif : Créer l'environnement AWS simulé avec LocalStack  
Difficulté : Simple (~5 minutes)
---------------------------------------------------

Dans le terminal du Codespace copier/coller les codes ci-dessous etape par étape :  

**Installation de l'émulateur LocalStack**  
```
sudo -i mkdir rep_localstack
```
```
sudo -i python3 -m venv ./rep_localstack
```
```
sudo -i pip install --upgrade pip && python3 -m pip install localstack && export S3_SKIP_SIGNATURE_VALIDATION=0
```
```
localstack start -d
```
**vérification des services disponibles**  
```
localstack status services
```
**Réccupération de l'API AWS Localstack** 
Votre environnement AWS (LocalStack) est prêt. Pour obtenir votre AWS_ENDPOINT cliquez sur l'onglet **[PORTS]** dans votre Codespace et rendez public votre port **4566** (Visibilité du port).
Réccupérer l'URL de ce port dans votre navigateur qui sera votre ENDPOINT AWS (c'est à dire votre environnement AWS).
Conservez bien cette URL car vous en aurez besoin par la suite.  

Pour information : IL n'y a rien dans votre navigateur et c'est normal car il s'agit d'une API AWS (Pas un développement Web type UX).

---------------------------------------------------
Séquence 3 : Exercice
---------------------------------------------------
Objectif : Piloter une instance EC2 via API Gateway
Difficulté : Moyen/Difficile (~2h)
---------------------------------------------------  
Votre mission (si vous l'acceptez) : Concevoir une architecture **API-driven** dans laquelle une requête HTTP déclenche, via **API Gateway** et une **fonction Lambda**, lancera ou stopera une **instance EC2** déposée dans **environnement AWS simulé avec LocalStack** et qui sera exécuté dans **GitHub Codespaces**. [Option] Remplacez l'instance EC2 par l'arrêt ou le lancement d'un Docker.  

**Architecture cible :** Ci-dessous, l'architecture cible souhaitée.   
  
![Screenshot Actions](API_Driven.png)   
  
---------------------------------------------------  
## Processus de travail (résumé)

1. Installation de l'environnement Localstack (Séquence 2)
2. Création de l'instance EC2
3. Création des API (+ fonction Lambda)
4. Ouverture des ports et vérification du fonctionnement

---------------------------------------------------
Séquence 4 : Documentation  
Difficulté : Facile (~30 minutes)
---------------------------------------------------
**Complétez et documentez ce fichier README.md** pour nous expliquer comment utiliser votre solution.  
Faites preuve de pédagogie et soyez clair dans vos expliquations et processus de travail.  
   
---------------------------------------------------
Evaluation
---------------------------------------------------
Cet atelier, **noté sur 20 points**, est évalué sur la base du barème suivant :  
- Repository exécutable sans erreur majeure (4 points)
- Fonctionnement conforme au scénario annoncé (4 points)
- Degré d'automatisation du projet (utilisation de Makefile ? script ? ...) (4 points)
- Qualité du Readme (lisibilité, erreur, ...) (4 points)
- Processus travail (quantité de commits, cohérence globale, interventions externes, ...) (4 points) 


### Mes URLs d'API (Objectif final)

Voici les URLs permettant de piloter mon instance EC2 (ID: i-303d76271a94b4012) via API Gateway et Lambda :


Démarrer : https://fantastic-space-palm-tree-r44gp5ww4696fxv75-4566.app.github.dev/restapis/npnsvopcxu/prod/_user_request_/ec2?action=start

Stopper : https://fantastic-space-palm-tree-r44gp5ww4696fxv75-4566.app.github.dev/restapis/npnsvopcxu/prod/_user_request_/ec2?action=stop

Statut : https://fantastic-space-palm-tree-r44gp5ww4696fxv75-4566.app.github.dev/restapis/npnsvopcxu/prod/_user_request_/ec2?action=status

<img width="1267" height="348" alt="image" src="https://github.com/user-attachments/assets/2b9826f7-7e8b-4517-a39c-9ae36d0a00ad" />

<img width="1655" height="417" alt="image" src="https://github.com/user-attachments/assets/ed86dc5c-9595-4bf0-b847-891023668f6c" />

<img width="1751" height="361" alt="image" src="https://github.com/user-attachments/assets/a3278fd4-f217-4e46-aca3-97181ded0c7d" />




**Processus :**
1. Création de l'instance EC2 sur l'émulateur LocalStack.
2. Déploiement d'une fonction Lambda en Python capable d'interagir avec Boto3.
3. Création et automatisation d'une API Gateway pour lier des requêtes HTTP GET à la fonction Lambda.


////DOCS

## Séquence 4 : Documentation et Processus de l'Architecture API-Driven

### 🎯 1. Objectif du projet
L'objectif de ce laboratoire est de concevoir une architecture **Serverless** permettant de piloter des ressources d'infrastructure (ici, une machine virtuelle EC2) via de simples requêtes HTTP. Au lieu d'utiliser l'interface graphique d'AWS ou des lignes de commande manuelles, nous utilisons **API Gateway** pour recevoir les requêtes web, et une **fonction Lambda** pour exécuter les actions sur l'EC2. Tout ceci est émulé localement grâce à **LocalStack** dans un environnement **GitHub Codespaces**.

---

### 🚀 2. Résultat Final : Endpoints de l'API
Voici les URLs publiques créées pour piloter mon instance EC2 (ID : `i-303d76271a94b4012`) :

* ** Démarrer l'instance :** `https://fantastic-space-palm-tree-r44gp5ww4696fxv75-4566.app.github.dev/restapis/sbqpq4unqy/prod/_user_request_/ec2?action=start`
* ** Stopper l'instance :** `https://fantastic-space-palm-tree-r44gp5ww4696fxv75-4566.app.github.dev/restapis/sbqpq4unqy/prod/_user_request_/ec2?action=stop`
* ** Voir le statut (Bonus) :** `https://fantastic-space-palm-tree-r44gp5ww4696fxv75-4566.app.github.dev/restapis/sbqpq4unqy/prod/_user_request_/ec2?action=status`

---

### 🛠️ 3. Processus détaillé et Codes sources

Pour arriver à ce résultat, voici l'ensemble des étapes et scripts utilisés :

#### Étape A : Préparation de l'environnement LocalStack
Création d'un environnement virtuel Python isolé et installation des outils nécessaires (LocalStack et AWS CLI).

```bash
# Création et activation de l'environnement virtuel
python3 -m venv rep_localstack
source rep_localstack/bin/activate

# Installation des paquets
pip install --upgrade pip
pip install localstack awscli

# Configuration de la licence Pro et démarrage de l'émulateur
export S3_SKIP_SIGNATURE_VALIDATION=0 
export LOCALSTACK_AUTH_TOKEN="<MON_TOKEN_LOCALSTACK>"
localstack start -d
```
Étape B : Création de la ressource EC2 "Cobaye"
Une fois l'émulateur lancé, j'ai configuré de faux identifiants AWS (aws configure) puis déployé une instance EC2 qui servira de cible pour notre API.

```# Création de l'instance EC2 (en utilisant l'AMI Ubuntu interne de LocalStack)
aws --endpoint-url=http://localhost:4566 ec2 run-instances \
    --image-id ami-df5de72bdb3b \
    --instance-type t2.micro
```
L'instance créée a reçu l'ID : i-303d76271a94b4012.

Étape C : Création de la fonction AWS Lambda (Le cerveau)
La fonction Lambda est chargée de traduire la requête web en action AWS. J'ai écrit un script Python utilisant boto3 pour interagir avec le service EC2.

Code de la fonction (lambda_function.py) :
```
import boto3
import json
import os

def lambda_handler(event, context):
    localstack_host = os.environ.get('LOCALSTACK_HOSTNAME', 'localhost')
    ec2 = boto3.client('ec2', endpoint_url=f"http://{localstack_host}:4566", region_name='us-east-1')
    
    # ID de l'instance cible
    instance_id = 'i-303d76271a94b4012'
    
    # Récupération du paramètre dans l'URL (?action=...)
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
            # Récupération de l'état actuel (Bonus)
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

```
Déploiement de la Lambda :
```
# Compression du code Python
zip function.zip lambda_function.py

# Création d'un rôle IAM factice
aws --endpoint-url=http://localhost:4566 iam create-role \
    --role-name lambda-role \
    --assume-role-policy-document '{"Version": "2012-10-17","Statement": [{"Action": "sts:AssumeRole","Principal": {"Service": "lambda.amazonaws.com"},"Effect": "Allow"}]}'

# Déploiement de la fonction sur LocalStack
aws --endpoint-url=http://localhost:4566 lambda create-function \
    --function-name EC2Controller \
    --zip-file fileb://function.zip \
    --handler lambda_function.lambda_handler \
    --runtime python3.9 \
    --role arn:aws:iam::000000000000:role/lambda-role
```
Étape D : Automatisation de l'API Gateway
Afin de maximiser l'automatisation du projet et d'éviter les erreurs manuelles lors de la création complexe des routes HTTP, j'ai écrit un script d'automatisation Bash. Ce script crée l'API, configure la route /ec2, relie cette route à la fonction Lambda, et déploie l'API en production.

Script d'automatisation (deploy_api.sh) :
```
#!/bin/bash
ENDPOINT="http://localhost:4566"
REGION="us-east-1"
LAMBDA_ARN="arn:aws:lambda:us-east-1:000000000000:function:EC2Controller"

echo "1. Création de l'API Gateway..."
API_ID=$(aws --endpoint-url=$ENDPOINT apigateway create-rest-api --name EC2ControlAPI --region $REGION --query 'id' --output text)

echo "2. Récupération de la racine de l'API..."
PARENT_ID=$(aws --endpoint-url=$ENDPOINT apigateway get-resources --rest-api-id $API_ID --region $REGION --query 'items[0].id' --output text)

echo "3. Création de la route /ec2..."
RESOURCE_ID=$(aws --endpoint-url=$ENDPOINT apigateway create-resource --rest-api-id $API_ID --parent-id $PARENT_ID --path-part ec2 --region $REGION --query 'id' --output text)

echo "4. Création de la méthode GET..."
aws --endpoint-url=$ENDPOINT apigateway put-method --rest-api-id $API_ID --resource-id $RESOURCE_ID --http-method GET --authorization-type "NONE" --region $REGION > /dev/null

echo "5. Liaison (Intégration) avec AWS Lambda..."
aws --endpoint-url=$ENDPOINT apigateway put-integration \
    --rest-api-id $API_ID \
    --resource-id $RESOURCE_ID \
    --http-method GET \
    --type AWS_PROXY \
    --integration-http-method POST \
    --uri arn:aws:apigateway:$REGION:lambda:path/2015-03-31/functions/$LAMBDA_ARN/invocations \
    --region $REGION > /dev/null

echo "6. Déploiement en production..."
aws --endpoint-url=$ENDPOINT apigateway create-deployment --rest-api-id $API_ID --stage-name prod --region $REGION > /dev/null

echo "Chemin de l'API généré : /restapis/$API_ID/prod/_user_request_/ec2"
```
L'exécution de ce script m'a retourné l'ID d'API sbqpq4unqy, que j'ai ensuite concaténé avec l'URL publique de mon port 4566 pour obtenir les liens finaux.
