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
* Créer une organisation et un projet dans l'interface SonarCloud. 
* Les deux premièress lignes se trouvent dans SonarCloud : organization et projectkey
* La troisième ligne indique à SonarCloud où trouver le rapport de couverture de code au format LCOV.


# Le choix d'AWS Amplify

AWS Amplify permet de déployer des applications ayant des front-end statiques pour lesquelles il est :
- facile de se connecter à une source de données (ici, le backend qui est lui-même connecté à la base de données)
- simple de de gérer l'authentification des utilisateurs
Le déploiement d'un frontend via AWS Amplify se base sur un dépôt Git et bénificie du réseau de diffusion de contenu (CDN) de AWS disponible dans le monde entier, donc au plus proches des utilisateurs.
Le nom de domaine de l'application peut-être configuré et sécurisé via l'outil AWS Route 53. Ainsi le monitoring de l'application AWS Amplify se fera via AWS CloudWatch.
De plus, Amplify est une solution PaaS. Dans le cadre de la gratuité, cette solution est gratuite pendant 12 mois puis la facturation se fera en fonction de son utilisation.

![image](/Fonctionnement_AWS_Amplify.png "Fonctionnement AWS Amplify")
