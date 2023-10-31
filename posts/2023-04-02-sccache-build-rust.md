---
title: Utiliser sccache avec Rust pour optimiser ses temps de compilation sur MacOS
description: Une astuce simple et rapide à mettre en place qui va vous faire gagner énormement de temps !
published_at: 2023-04-02 10:00:00
---

# Utiliser sccache avec Rust pour optimiser ses temps de compilation

`sccache` est un [outil développé par Mozilla](https://github.com/mozilla/sccache) dont le but est d'**accélérer les temps de compilation de différents languages** (notamment C, C++, ou encore Rust).

Sur Mac, la manière la plus simple d'installer le binaire est d'utiliser [Homebrew](https://brew.sh/) via la commande `brew install sccache`.

Ensuite, il ne reste plus qu'à activer `sccache` de manière globale sur votre machine. Il existe deux façon de le faire, à vous de choisir celle que vous préférez.

### Le fichier config.toml

La première est de mettre à jour le fichier `$HOME/.cargo/config.toml` en ajoutant les lignes suivantes (*il vous faudra au minimum la version 1.40 de `cargo`*) :

```yaml
[build]
rustc-wrapper = "/opt/homebrew/bin/sccache"
```

### Une variable d'environnement

La seconde solution, et celle que j'utilise, est de simplement exporter la variable d'environnement `RUSTC_WRAPPER`, par exemple dans votre fichier `.profile` (ou `.zprofile` si vous utilisez zsh) : 

```bash
export RUSTC_WRAPPER=/opt/homebrew/bin/sccache
```

Il ne vous reste plus qu'à profiter de temps de compilations drastiquement améliorés dès le second build avec `sccache` !