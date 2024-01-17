---
title: Migration de shell de zsh à fish  
description: Un tutoriel pas à pas pour passer du shell zsh à fish
published_at: 2024-01-17 10:00:00
---

# Migration de shell de zsh à fish

J'aime beaucoup passer du temps à tester de nouveaux outils pour essayer d'**améliorer mon environnement de développement**, et à force de voir beaucoup de gens parler du [shell fish](https://fishshell.com/) je me suis enfin décidé à sauter le pas.

Voici donc un petit tuto pour remplacer `zsh` par `fish` sur MacOS.

## Installer fish et l'utiliser comme shell par défaut

Pour installer fish, il suffit d'utiliser homebrew avec la commande suivante :

```shell
brew install fish
```

> Note: Si vous ne connaissez pas encore [Homebrew](https://brew.sh/), c'est l'outil de gestion de dépendance de référence sur MacOS. C'est donc le moment où jamais de l'installer si ce n'est pas encore le cas !

Une fois l'installation terminée, vous pouvez **tester le shell** en tapant la commande suivante : `fish`. Mais ce qui nous intéresse ici, c'est de remplacer entièrement `zsh` et de faire de `fish` notre shell par défaut.

Pour cela il faut d'abord modifier le fichier `/etc/shells/` avec les droits sudo en ajoutant la ligne `/opt/homebrew/bin/fish` en dessous de la liste de shells existants afin d'autoriser l'utilisation de `fish` pour le changement de shell.

```shell
# List of acceptable shells for chpass(1).
# Ftpd will not allow users to connect who are not using
# one of these shells.

/bin/bash
/bin/csh
/bin/dash
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
/opt/homebrew/bin/fish
```

Une fois que vous avez enregistré le fichier, il vous suffit ensuite d'activer `fish` par défaut avec la commande ci-dessous, puis de relancer votre terminal.

```shell
chsh -s /opt/homebrew/bin/fish
```

Vous voilà désormais avec le shell `fish` par défaut !

## Migrer ses configurations zsh vers shell

`fish` fonctionne différemment de `zsh`, notamment pour l'**export des variables d'environnement** et la création d'alias. Pour se faire, nous allons créer de nouveaux fichiers de configuration dans les dossiers dédiés que l'on retrouve ici : `~/.config/fish`. 

### Déclarer une variable d'environnement

Dans `zsh`, voici un exemple de variable d'environnement existant dans ma configuration.

```shell
export RUSTC_WRAPPER=/opt/homebrew/bin/sccache
```

Et voici son équivalent sur `fish`, que j'ai placé dans un nouveau fichier `~/.config/fish/conf.d/env.fish` qui contient toutes mes variables d'environnement :

```shell
set -gx RUSTC_WRAPPER /opt/homebrew/bin/sccache
```

A noter qu'il existe également une méthode dédiée pour mettre à jour son `$PATH`, qui est plus pratique et évite également les doublons.

```shell
fish_add_path $HOME/.cargo/bin
```

### Créer un nouvel alias

Il y a deux manières de créer un alias : via `abbr` ou via une nouvelle function. Je préfère personnellement la deuxième solution, car elle évite une étape d'autocomplétion inutile, mais il est intéressant de connaître les deux solutions.

Admettons que dans ma configuration `zsh`, j'utilise l'alias suivant ([eza](https://github.com/eza-community/eza****) est une alternative moderne à la commande `ls`) :

```shell
alias ll='eza -alFBh'
```

Son équivalent sous `fish`, ajouté dans un nouveau fichier `~/.config/fish/conf.d/abbr.fish` (_pas obligatoire mais j'aime garder les choses organisées_), ressemblera à cela :

```shell
abbr ll "eza -alFBh"
```

Mais on peut également créer une fonction à la place, en ajoutant le fichier `~/.config/fish/functions/ll.fish` (_une fonction par fichier_) :

```shell
function ll
  eza -alFBh $argv
end
```

Si vous avez des scripts bash à migrer, vous pouvez faire un tour sur [la documentation](https://fishshell.com/docs/current/index.html) du projet pour voir les différences qui existent.

## Aller plus loin avec Fisher

Fisher est un gestionnaire de dépendances pour étendre l'utilisation de `fish`. Bien qu'il en existe d'autres ([oh-my-fish](https://github.com/oh-my-fish/oh-my-fish) par exemple), celui-ci semble être le seul qui soit encore maintenu régulièrement. Pour l'installer, il suffit de lancer la commande suivante :

```shell
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

J'ai utilisé Fisher pour pouvoir [installer `nvm`](https://github.com/nvm-sh/nvm#fish) facilement, car cela requiert la dépendence [bass](https://github.com/edc/bass).

### Installer le prompt Tide

J'ai profité de mes recherches à propos de `fish` et `tide` pour installer le prompt [Tide](https://github.com/IlanCosman/tide) qui a un rendu vraiment agréable tout en restant sobre.

```shell
fisher install IlanCosman/tide@v6
```

## Conclusion

Il me reste encore énormément de chose à découvrir sur `fish` et ses libraires associées, mais pour le moment je suis déjà conquis : il y a beaucoup de choses incluses "out of the box" et le fait que les mainteneurs soient en train de [finaliser la réécriture du projet en Rust](https://github.com/fish-shell/fish-shell/blob/master/doc_internal/fish-riir-plan.md) n'est pas pour me déplaire non plus !

Et vous, vous connaissez `fish` ? Vous l'utiliser ? Quelles sont vos libraires favorites ?