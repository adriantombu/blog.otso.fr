---
title: Déployer avec Git sur un hébergement FTP
description: L’utilisation de git-ftp simplifie grandement la mise en ligne de fichiers en FTP
published_at: 2015-12-02 10:00:00
image: https://blog.otso.fr/images/2015-12-02-deployer-avec-git-sur-un-hebergement-ftp/old-star-wars-guy.jpg
categories: [ devops ]
---

# Déployer avec Git sur un hébergement FTP

> tl;dr L’utilisation de git-ftp simplifie grandement la mise en ligne de fichiers en FTP

Parfois, suivant le projet, il n’est pas possible de récupérer des accès SSH pour procéder à des **mises en lignes facile via Git**, ou d’utiliser des **outils de déploiement automatisée** tels que Heroku ou [Dokku](http://blog.otso.fr/2015-12-02-deployer-avec-git-sur-un-hebergement-ftp.html). Jusqu’à présent, je rongeais mon frein et faisais donc des glisser-déplacer à l’ancienne dans mon logiciel FTP.

![](images/2015-12-02-deployer-avec-git-sur-un-hebergement-ftp/old-star-wars-guy.jpg)

C’est en faisant quelques recherches pour **améliorer ce process de déploiement** que je suis tombé sur le **dépôt [git-ftp](https://github.com/git-ftp/git-ftp)**, un script shell qui combine la **puissance de Git** avec la mise en ligne via FTP.

Toute l’efficacité de cet outil réside dans le fait qu’il ne met en ligne que les **fichiers qui ont été modifiés**, à l’aide d’une simple commande dans le terminal. Je l’utilise actuellement sur un projet important pour faire les **mises en pré-production** sur le serveur du client, ce qui m’offre un réel gain de productivité.

L’installation et la configuration sont assez simples, et tout est clairement détaillé dans [le fichier INSTALL.md](https://github.com/git-ftp/git-ftp/blob/master/INSTALL.md) du dépôt. Etant utilisateur Mac OSX, j’ai simplement utilisé Homebrew.

```bash
brew install git brew install curl --with-ssl --with-libssh2 brew install git-ftp
```

Ensuite, il vous suffira de vous rendre dans votre projet Git, et d’initialiser git-ftp.

```bash
git ftp init -u <user> -p <password> ftp://host.example.com/public_html
```

Un petit git ftp push vous permettra ensuite de lancer le déploiement vers votre FTP.

```bash
git ftp push -u <user> -p <password> ftp://host.example.com/public_html
```

Afin d’éviter de renseigner à chaque fois les infos de connexion et le host, vous pouvez enregistrer ces informations en **variable de configuration de votre dépôt Git**.

```bash
git config git-ftp.user john git config git-ftp.url ftp.example.com
git config git-ftp.password secr3t git config git-ftp.syncroot path/dir
```

Si vous voulez aller plus loin, vous trouverez toute la documentation et plus d’exemples [dans le manuel utilisateur](https://github.com/git-ftp/git-ftp/blob/master/man/git-ftp.1.md).
