# Explications 
Il y a 2 fichiers de déploiement :
1. deploy.yml : Deploy the Morning News application in AWS Amplify
2. deploy1.yml : CI of tests


## Importance des variables d'environnement
Celles-ci sont présentes dans les settings > Secrets and variables.<br/>
Dans les secrets, sont enregistrées toutes les variables à ne pas communiquer. Dans les variables, toutes les données qui peuvent être partagées sans crainte.

## CI terraform amplify
Les étapes de construction de l'applcation AWS Amplify sont, via Terraform : 
1. Créer une application AWS Amplify (fichiers front.tf et deploy.yml)
2. Lancer le job qui permet de déployer les spécificités du front (fichiers front.tf et deploy.yml)
3. Obtenir l'url de l'application

## CI tests (deploy1)- spécificités de Github actions 

#### Absence des stages :
GitHub Actions n'utilise pas de stages. Les jobs s'exécutent indépendamment mais ils peuvent être gérer dans un ordre particulier avec des dépendances (needs).

#### Remplacement de image par container :
Pour utiliser une image Docker spécifique dans un job, utilise container au lieu de image.

#### Suppression de only :
GitHub Actions utilise les déclencheurs définis sous on au début du fichier.

#### Ajout de runs-on :
Chaque job nécessite runs-on pour spécifier le type de machine hôte (ici, ubuntu-latest).

#### Ajout des étapes Checkout Code :
La première étape de chaque job est de récupérer le code du repo avec actions/checkout@v4.

### Tests Cypress
* Lancer en local Cypress pour pouvoir récupérer les dossiers et fichiers créés et indispensables au bon fonctionnement de Cypress
* Ajouter les cas de tests dans le dossier Cypress/e2e
* Mettre à jour la partie scripts du fichier package.json avec : "cypress:run": "npx cypress run"

### Tests Jest
* Lancer local Jest pour obtenir les fichiers de configuration
* Créer un cas de test avec l'extention test.js
* Mettre à jour la partie scripts du fichier package.json avec : "test": "jest"

### Tests Eslint
* Mettre à jour la partie scripts du fichier package.json avec : "lint": "next lint"

### Tests SonarCloud
* Créer une organisation et un projet dans l'interface SonarCloud
* 