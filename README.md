# 4TC DIA TP Docker
TP de fonctionnement de Docker, le sujet peut être trouvé sur :

http://cours.sewatech.fr/docker/

On utilise la version 17.03-CE de Docker

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
On va commencer par créer un Docker file représentant l'image que l'on veux construire pour l'application.

```docker
FROM tomcat:8.5-alpine

COPY swmsg.war /usr/local/tomcat/webapps/swmsg.war
COPY swmsg.xml /usr/local/tomcat/webapps/swmsg.xml
```

On construit une image à partir de celle de Tomcat 8.5, le choix d'alpine permet
de réduire le poid de l'image.

Pour construire et lancer l'image :

```sh
docker build -t philippevienne/4tc-dia-docker .
docker container run -p 8080:8080 -d --name app philippevienne/4tc-dia-docker
```

On constate que sur http://localhost:8080/swmsg l'application doit être déployé

## 2° étape : base de données

Vous utiliserez une base de données Postgres 9.x.

La base de données doit être initialisée avec le script create-db.sql.

Evidemment, les données ne doivent pas disparaître quand on redémarre un nouveau conteneur.

Pour que l’application Java puisse se connecter à la base de données, il faut déployer la configuration de la datasource dans Tomcat. Pour ça, il faut adapter et copier le fichier xml dans le répertoire conf/Catalina/localhost de Tomcat, avec le même nom que le fichier war (hormis l’extension).

### Résolution

On va lancer un conteneur postgres avec un volume monté afin de conserver les
données:

```sh
docker container run -d -v $PWD/db:/data -e POSTGRES_PASSWORD=postgres -e PGDATA=/data --name db postgres
```

Postgres est ajouté avec un volume qui contient les données et ``PGDATA``
permet de désigner le point de montage du volume.

L'option ``-e POSTGRES_PASSWORD=postgres`` permet de mettre un mot de passe au
user postgres

On y injecte les données par defaut à l'aide de :

```sh
docker container exec -u postgres -i db psql postgres < create-db.sql
```

On crée un network pour assurer la connexion des container entre eux :

```sh
docker network create web
docker network connect web app
docker network connect web db
```
