---
title: Ajout des catégories sur Orion
description: Une mise à jour importante pour mon générateur de site statique écrit en Rust
published_at: 2024-07-02 10:00:00
categories: [ opensource ]
---

# Ajout des catégories sur Orion

J'ai enfin pris un peu de temps pour travailler sur mon [générateur de site statique écrit en Rust](https://github.com/adriantombu/orion), Orion, que j'utilise pour [générer ce site](https://github.com/adriantombu/blog.otso.fr).

J'ai ajouté la possibilité de **définir des catégories pour les articles**, et de les afficher sur la page d'accueil sous forme de tags. Cela me permettra de mieux organiser mes articles sur ce blog, qui parlent de sujets parfois très différents (développement, opensource, aviation, etc.).

Cette fonctionnalité est disponible depuis la version `v1.1.6` et peut être installée via `cargo install orion`.

J'ai également prévu de travailler sur la gestion des assets prochainement: pour le moment les images se retrouvent dans le dossier `public`, et je les gère par sous-dossier avec le slug de l'article pour ne pas que ça devienne le bazar. Je n'aime pas trop ce fonctionnement, et l'idée serait de les placer dans un dossier `assets` au même niveau que le fichier markdown, le tout dans un sous-dossier.

Je compte aussi remplacer le crate `rss` par `quick-xml` que j'utilise déjà ailleurs, afin de réduire le nombre de dépendance, et chercher une alternative plus légère à `rouille` pour le serveur local qui sert à prévisualiser le site.
