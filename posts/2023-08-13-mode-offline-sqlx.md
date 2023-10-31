---
title: Comment activer le mode offline de la librairie Rust sqlx
description: Voici un moyen simple de se passer d'une base de donnée active pour compiler son programme Rust avec sqlx
published_at: 2023-08-13 10:00:00
---

# Comment activer le mode offline de la librairie Rust sqlx

[sqlx](https://crates.io/crates/sqlx) est une librairie Rust qui permet de s'interfacer avec une base de données et de **vérifier à la compilation les schémas et requêtes SQL** écrites dans notre code grâce aux macros `sqlx::query!` ou `sqlx::query_as!` (*il faut activer la feature `"macros"` pour les rendre disponibles*). C'est un outil très puissant, qui supporte également les [migrations](https://github.com/launchbadge/sqlx/tree/main/sqlx-cli#create-and-run-migrations).

Mais pour que cela fonctionne, la base de données doit être accessible au moment de la compilation, ce qui n'est pas forcément utile tout le temps. Heureusement, les développeurs ont pensé à tout en nous permettant de **générer les métadatas de nos schémas et requêtes**, ce qui nous permet de compiler le code à n'importe quel moment plus tard.

### Les étapes en détail

- Lancer la commande `cargo sqlx prepare --database-url <DB_URL>` pour générer les metadatas
- Commiter le dossier `.sqlx` au dépôt Git
- Et... c'est tout !

Ne faites par la même erreur que moi en utilisant la variable d'environnement `DATABASE_URL` dans votre projet car `sqlx` se bornera à chercher une base de données active au lieu d'utiliser le dossier `.sqlx`. La [documentation](https://github.com/launchbadge/sqlx/tree/main/sqlx-cli#force-building-in-offline-mode) indique qu'on peut pourtant mettre la variable `SQLX_OFFLINE` à `true` mais ça n'a jamais fonctionné malgré de nombreux essais. 

> **Bonus**
> 
> On peut également utiliser l'option `--check` dans notre CI pour vérifier que les métadatas présentes dans le dossier `.sqlx` sont à jour avec notre schéma de bdd et les requêtes écrites dans le code :
> 
> `cargo sqlx prepare --check --database-url <DB_URL>`

### Liens utiles

- [La documentation de sqlx](https://docs.rs/sqlx/0.7.2/sqlx/)
- [La documentation de sqxl-cli](https://github.com/launchbadge/sqlx/tree/main/sqlx-cli)
