---
title: Seafile, le Dropbox open-source auto-hébergé
description: Libérez vos données dans le cloud et lancez-vous dans l’auto-hébergement
published_at: 2015-09-18
opengraph:
  image: https://blog.otso.fr/images/2015-09-18-seafile-le-dropbox-open-source-auto-heberge/sorry-but-no.gif
---

# Seafile, le Dropbox open-source auto-hébergé

> tl;dr Libérez vos données dans le cloud et lancez-vous dans l’auto-hébergement

Récemment, j’ai eu dans l’idée de migrer un maximum d’outils que j’utilise vers des **solutions open-source auto-hébergées**, ou plus **respectueuses de la vie privée**. C’est donc dans cette optique que j’ai cherché en premier à me **débarasser de Dropbox**, que j’utilise de façon intensive tous les jours.

## Au commencement, il y avait OwnCloud

Mon premier réflexe a été de me tourner vers [OwnCloud](http://owncloud.org/), la **solution tout-en-un** qui propose un package complet d’outils (synchronisation, calendrier, lecteur rss, …) pour gérer ses données sur son serveur. J’ai déjà eu l’occasion de le tester il y a quelques années, mais je n’avais pas été convaincu, que ce soit niveau stabilité, vitesse de transfert, ou **sécurité des données** (beaucoup de fichiers disparus sans crier gare à l’époque).

Ma nouvelle expérience n’a pas été beaucoup plus fructueuse, malheureusement. Il y a du mieux, par exemple le client Mac qui est bien plus léger et stable, mais les **vitesses d’upload sont absolument ridicules**, principalement sur les dossiers comprenants beaucoup de petits fichiers. Toutes les optimisations testées n’ayant apporté aucun gain de performance, j’ai donc laissé tomber rapidement.

![Sorry, but no.](images/2015-09-18-seafile-le-dropbox-open-source-auto-heberge/sorry-but-no.gif)

## Au deuxième jour apparut Seafile

Après quelques recherches, je suis tombé sur [Seafile](https://www.seafile.com/en/home/), que l’on peut comparer à un **clone de Dropbox**, version open-source. L’outil se concentre uniquement sur la **synchronisation et le partage de fichiers** (au contraire d’OwnCloud qui propose plusieurs applications différentes), avec des options permettant de créer des utilisateurs et groupes d’utilisateurs ayant accès à différents dossiers.

Une fonctionnalité que je trouve très utile est la possibilité de fournir un **[lien d’upload](http://wiki.kogite.fr/index.php/Seafile_:_pr%C3%A9sentation#Lien_de_t.C3.A9l.C3.A9chargement_et_lien_d.27envoi)** à une personne non identifiée dans le système, afin qu’elle nous envoie des fichiers très simplement, à la manière d’un WeTransfer, mais directement sur son serveur. C’est extrêmement utile pour la **récupération des fichiers d’un client**, par exemple.

## Au troisième jour, j’étais content

J’utilise Seafile depuis plusieurs semaines désormais, et suis vraiment satisfait de cet outil, qui est simple à installer ([la doc](http://manual.seafile.com/) est très bien fournie) et à utiliser au jour le jour.

Il m’est arrivé une seule fois un **petit soucis** de synchronisation qui ne s’effectuait plus, à cause d’un hard reboot de mon serveur sans clôturer proprement le service Seafile sur le serveur. Heureusement aucun fichier n’a été perdu !

Pas besoin d’avoir une serveur de fou, j’utilise une [Dedibox SC GEN2](http://www.online.net/en/dedicated-server/dedibox-scg2) de chez Online qui me coûte au final **moins cher** que mon abonnement Dropbox !

## Demain est un autre jour

Un de ces quatre je vous raconterai la suite de mes aventures vers un monde plus **respectueux de la vie privée** !
