---
title: Comment lancer un workflow Github Actions quand le contenu d'un dossier change
description: Ou comment éviter de run des workflows qui ne servent à rien
published_at: 2024-09-25 10:00:00
categories: [ devops ]
---

# Comment lancer un workflow Github Actions quand le contenu d'un dossier change

Sur un de mes projets actuels, j'ai créé un dossier dédié au devops pour l'architecture Terraform et Kubernetes avec un workflow Github Actions dédié qui est lancé sur chaque commit sur la branche `main`.

Suite à une PR mergée par un autre développeur, nous avons ajouté d'autres fichiers sans aucun rapport avec les process de déploiement et modification de l'infrastructure. Le problème étant que chaque modification de ces fichiers lançait l'action Github pour rien.

Après quelques recherches rapides, j'ai trouvé dans [la documentation Github](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions#onpushpull_requestpull_request_targetpathspaths-ignore) une manière simple de définir un workflow qui ne sera lancé que si le contenu d'un dossier spécifique change.

Voici un aperçu du workflow modifié :

```yaml
on:
  push:
    branches:
      - main
    paths:
      - 'terraform/**'
      - 'kubernetes/**'
```

Cette configuration permet de lancer le workflow sur chaque commit sur la branche `main` et seulement si le contenu des dossiers `/terraform` ou `/kubernetes` change.

Pratique pour éviter de dépenser inutilement de précieuses resources sur les runners Github !
