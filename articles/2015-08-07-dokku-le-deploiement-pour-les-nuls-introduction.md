---
title: Dokku, le déploiement pour les nuls ! (introduction)
description: Le FTP c’est has been, ‘git push dokku master’ c’est l’avenir !
---

# Dokku, le déploiement pour les nuls ! (introduction)

> tl;dr Le FTP c’est has been, ‘git push dokku master’ c’est l’avenir !

## Le déploiement, avant

Dans un passé pas si lointain, les **mises en production** (_le vendredi soir_) étaient toujours le moment que toute l’équipe tech redoutait.

Après avoir effectué son glissé-déposé des fichiers dans son logiciel FTP, on serrait les fesses et on attendait que les 3000 fichiers soient mis en ligne. En général il fallait s’y reprendre à plusieurs reprises à cause des **erreurs de transfert**. Et puis des fois ça plantait, à cause d’une version PHP pas compatible avec certaines fonctions récentes utilisées, ou des extensions pas installées.

En bref, un **vrai cauchemar**, et énormément de temps perdu.

## Le déploiement, aujourd’hui

Oubliez ces **terribles moments** que vous avez certainement vécu (_j’en rêve encore la nuit_), car désormais le déploiement c’est devenu vraiment **pour les nuls** :

    git push dokku master

Vous voulez apprendre la **recette magique** pour arriver à ce résultat ? Suivez le guide !

![](images/2015-08-07-dokku-le-déploiement-pour-les-nuls-introduction/bob-eponge-arc-en-ciel.gif)

## Qu’est-ce que Dokku ?

Comme indiqué sur leur [dépôt Github](https://github.com/progrium/dokku), Dokku est un clone du célèbre [Heroku](https://www.heroku.com/), une plateforme de type Paas ([plateforme as a service](https://en.wikipedia.org/wiki/Platform_as_a_service)).

En utilisant Heroku pour vos déploiements, vous vous occupez uniquement de la partie **développement de votre application** : plus de prise de tête avec la gestion du serveur, les modules manquants, les mises à jour, etc. Le rêve !

Sauf que niveau tarif ça peut rapidement grimper. Il y a bien une instance gratuite, mais elle s’éteint automatiquement après 1h30 sans visites. L’offre suivante s’élève à 7\$ / mois / application.

C’est là qu’apparaît Dokku, qui fait la même chose, mais en **open-source** !

## La recette du déploiement parfait

### 1. Installer dokku sur votre serveur

Depuis plusieurs mois j’utilise [Digital Ocean](https://www.digitalocean.com/?refcode=8f4dbd7cf40b) (lien sponsorisé) comme **hébergeur de VPS**. Celui-ci offre, entre autres, des installations d’applications en un click. Il existe bien un [droplet Dokku](https://www.digitalocean.com/features/one-click-apps/dokku/), mais dans ce tutorial j’utiliserai sa version améliorée [dokku-alt](https://github.com/dokku-alt/dokku-alt) qui offre de nombreux plugins préinstallés.

Vous pouvez donc choisir une simple distribution Ubuntu 14.04, avec l’offre à 5\$ / mois.

Pour installer Dokku-alt, **connectez vous en SSH** sur votre serveur fraîchement installé, et lancez la commande suivante :

    sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/dokku-alt/dokku-alt/master/bootstrap.sh)"

A la fin de l’installation, il vous sera demandé de vous connecter à l’url suivante :

    http://<ip-du-serveur>:2000/

Vous pourrez ajouter votre **clé SSH** (_champ rempli automatiquement sur Digital Ocean_), ainsi que renseigner un **nom de domaine** que vous souhaitez utiliser à la place de l’adresse IP du serveur.

![Finalisation de l’installation](images/2015-08-07-dokku-le-déploiement-pour-les-nuls-introduction/dokku-setup.png)

Pour les besoin de cet article, nous partirons du principe que le serveur est accessible via l’url **dokku.me**

### 2. Déployer votre application

En tant que bon développeur, vous aurez versionné votre projet sous Git. Si vous ne connaissez pas cet **outil indispensable**, je vous conseille de [vous y mettre dès aujourd’hui](https://git-scm.com/documentation) !

Tout d’abord, **lancez votre terminal** et positionnez vous dans le dossier de votre application. Ajoutez ensuite un **dépot distant** qui pointera sur le serveur où vous avez installé Dokku.

    git remote add dokku [email protected]:my-app

Finalement, vous pouvez enfin sortir votre baguette magique et invoquer le fameux **push magique** !

    git push dokku master

Dokku va s’occuper automatiquement de toute la partie **déploiement de votre application**. Celui-ci détectera automatiquement le langage que vous utilisez et effectuera les **actions nécessaires** en conséquence (_installer les dépendances composer en PHP, builder son application Jekyll, …_) dans un [container Docker](https://www.docker.com/).

Une fois terminé, vous pourrez accéder à votre application fraîchement déployée à l’url suivante :

    http://my-app.dokku.me

Et voilà, le déploiement **en toute simplicité** !

## Coming some day

Aujourd’hui, je vous ai posé les bases de l’utilisation de Dokku. C’est bien, mais on peut faire beaucoup mieux ! Dans un prochain article, je vous expliquerai plein de choses **super chouettes** que l’on peut faire avec cet outil :

- créer une base de données
- utiliser un nom de domaine custom pour votre application déployée
- installer des extensions, choisir sa version de PHP, etc.
- mettre en place des volumes persistants entre les déploiements
- ajouter des variables d’environnement

A bientôt, pour un nouvel épisode !

![](images/2015-08-07-dokku-le-déploiement-pour-les-nuls-introduction/sheldon-content.gif)
