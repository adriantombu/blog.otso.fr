---
title: Comment créer un service systemd pour une application Rust sur Linux  
description: Découvrez comment utiliser le cache dans Github Actions pour accélérer votre workflow 
published_at: 2023-09-29 10:00:00
---

# Comment créer un service systemd pour une application Rust sur Linux

Après avoir utilisé le cloud pendant des années, notamment pour les clients de mon activitié de **développeur freelance Rust**, j'opère petit à petit un retour aux sources afin de remettre un peu les mains dans la gestion de serveurs Linux.

J'ai récemment mis en place un **déploiement automatisé d'une application Rust** sur un serveur dédié avec GitHub Actions, et je me suis donc questionné sur la meilleure façon de relancer automatiquement le programme lors d'une mise à jour, même après un redémarrage du serveur.

Après quelques rapides recherches, j'ai décidé d'utiliser `systemd`, qui est présent nativement sur Debian et inclut toutes les fonctionnalités dont j'ai besoin.


### La création du fichier de configuration

Les fichiers de configuration de systemd se trouvent dans le dossier `/etc/systemd/system/`. Vous pouvez donc créer votre fichier avec la commande suivante : `sudo nano /etc/systemd/system/website.service` (un jour je placerai un petit `vim` pour le troll).

```shell
[Unit]
Description=A beautiful Rust API
After=postgresql.service

[Service]
Type=simple
Restart=always
RestartSec=1
User=github_runner
Group=users

Environment="DATABASE_URL=redacted"
Environment="ENV=prod"
Environment="PORT=8080"

ExecStart=/home/github_runner/website/bin

[Install]
WantedBy=multi-user.target
```

#### Quelques petites explications 

- `After=postgresql.service` spécifie que le programme ne peut être lancé qu'une fois qu'une instance PostgreSQL est active sur le serveur
- `User/Group` donnent l'information sur l'utilisateur / groupe qui va lancer le programme
- `Environment` permet de lister toutes les variables d'environnement utilisées par le programme (pas besoin de fichier `.env`)
- `ExecStart` indique l'emplacement du binaire qui sera lancé

> **Note importante**
> 
> Dans ce cas particulier, j'ai utilisé un [runner auto-hébergé](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners) pour lancer les GitHub Actions et l'utilisateur `github_runner` n'aura pas les autorisations nécessaires de base pour gérer ce service `systemd`. Si vous n'utilisez pas l'utilisateur `root`, il faudra donc ajouter une étape en plus en ajoutant cette ligne dans le fichier `etc/sudoers`
>
> `github_runner ALL=(ALL) NOPASSWD: /usr/bin/systemctl stop|start|restart website`

### Activer son service systemd

Une fois que l'on a créé et enregistré le fichier de configuration, il suffit de relancer `systemd` pour l'activer : `sudo systemctl daemon-reload`.

> Il est important de noter qu'il faudra relancer cette commande à chaque modification du fichier de configuration.

### Commandes utiles

Quand on est connecté au serveur, voici quelques commandes utiles pour gérer son service `systemd` :

- `systemctl status website` : permet de voir si le programme tourne correctement
- `systemctl restart website` : relance le programme
- `journalctl -e -u website` : affiche les derniers logs du programme

### Bonus

En bonus, voici le job utilisé dans le script de déploiement GitHub Actions avec un runner autho-hébergé après que les différents jobs aient été validés (build, tests, clippy, formatting) :

```yaml
  deploy:
    runs-on: self-hosted
    needs: [build, test, clippy, fmt]
    steps:
      - name: Deploy
        run: |
          sudo systemctl stop website
          cp ~/runners/actions-runner/_work/website/website/target/release/website ~/website/bin
          sudo systemctl start website
```
