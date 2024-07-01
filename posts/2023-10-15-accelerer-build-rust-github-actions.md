---
title: Accélérer le temps de build dans Github Actions pour un programme Rust  
description: Découvrez comment utiliser le cache dans Github Actions pour accélérer votre workflow 
published_at: 2023-10-15 10:00:00
categories: [ rust ]
---

# Accélérer le temps de build dans Github Actions pour un programme Rust

**Rust** est un langage génial, mais il est connu pour ses temps de build assez lents. Sur des programmes assez complexes, cela peut devenir rapidement problématique pour votre workflow d'intégration continue.

Heureusement, GithHub propose un [système de cache](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows) qui permet de **sauvegarder tout les artefacts indispensables** pour **accélérer vos temps de compilation** entre chaque workflow. Il vous suffit d'ajouter les lignes suivantes dans votre job pour que cela soit géré automatiquement :

```yaml
    - uses: actions/cache@v3
      with:
        path: |
          ~/.cargo/bin/
          ~/.cargo/registry/index/
          ~/.cargo/registry/cache/
          ~/.cargo/git/db/
          target/
        key: ${{ runner.os }}-cargo-${{ hashFiles('**/Cargo.lock') }}
```

Tant que vous ne changerez pas les dépendances de votre package (la clé du cache est basée sur un hash du `Cargo.lock`), GitHub se basera sur **le cache qui aura été précédemment généré**, vous faisant gagner un temps précieux !
