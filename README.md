# 4TC DIA TP Docker
TP de fonctionnement de Docker, le sujet peut être trouvé sur :

http://cours.sewatech.fr/docker/

## Licence
Le travail de rédaction de ce document est sous Creative Commons BY-SA
&copy; 2017 Philippe VIENNE

Le sujet d'origine est l'oeuvre de Alexis Hassler.

## 1° étape : application Java

Une partie de l’application fournie peut fonctionner en autonome, sans base de données. C’est l’objectif de cette première étape.

Préparez une image personnalisée avec le contenu suivant :

- Java 8
- Tomcat 8.5

Pour démarrer Tomcat, il faut appeler le script "bin/catalina.sh run".

Pour le déployer un war, il doit être déposé dans le répertoire webapps de Tomcat. Vous peuvez le renommer pour modifier l’URL d’accès.

Pour accéder à l’application, une fois Tomcat démarré : ``http://localhost:<port>/<war-name>;``.

### Résolution
