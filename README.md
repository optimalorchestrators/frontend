# Explications 

## CI terraform amplify


## CI tests (deploy1)- spéicifictés de Github actions 

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
