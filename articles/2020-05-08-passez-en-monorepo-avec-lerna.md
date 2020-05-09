---
title: Comment passer au monorepo avec Lerna
description: Suivez-moi pas à pas dans la découverte du monde fantastique des monorepos
---

# Comment passer au monorepo avec Lerna

Suivez-moi pas à pas dans la découverte du **monde fantastique des monorepos** !

![Monorepos are magic](images/2020-05-08-passez-en-monorepo-avec-lerna/rainbow.gif)

Tout est parti de mon envie de **simplifier la maintenance** de mes quelques modules NPM qui ont chacun un dépôt Git dédié. Un des problèmes principaux que j'ai rencontrés, c'est que ces modules partagent beaucoup de dépendances communes, notamment dans les `devDependencies` (_Typescript, Prettier, Jest, Husky, ..._) ou les fichiers de config (_.prettierc, tsconfig.json, jest.config.js_). Les maintenir à jour un par un lors de la publication de patchs de sécurité devient rapidement **long et répétitif**. D'où l'idée de passer au monorepo et gérer toutes ces dépendances communes à un seul endroit à la racine du dépôt.

Mais avant toutes choses, reprenons avec les bases.

## C'est quoi un monorepo ?

Rien de tel que [l'ami Wikipedia](https://en.wikipedia.org/wiki/Monorepo) pour en savoir plus :

> Dans les systèmes de gestion de versions, un monorepo (mot valise de l'expression `monolithic repository`) est une stratégie de développement software où le code de plusieurs projets différents est hébergé dans le même dépôt.

### Les avantages

- **La réutilisation du code est simplifiée** : il est possible de créer des librairies partagées directement incluses dans les projets sans devoir utiliser un gestionnaire de librairie
- Les projets existant tous dans le même dépôt, **les dépendances sont gérées très simplement**. L'étape de build peut donc facilement être optimisée car il n'y a pas besoin de télécharger les dépendences à de multiples reprises comme dans le multi-repo.
- Il devient également très simple de **travailler sur plusieurs projets interdépendants en même temps** en faisant des [commits atomiques](http://adopteungit.fr/methodologie/2017/04/26/commits-atomiques-la-bonne-approche.html) sans se perdre dans la gestion des dépendances
- Le développeur ayant accès à l'entièreté d'un projet, **un refactoring global est possible** tout en s'assurant que le projet continue de fonctionner

### Les inconvénients

- Certains projets utilisent parfois un **numéro de version global identique pour tous les projets** du dépôt. Cela signifie que même si certains n'ont pas été modifiés, ils seront déployés avec un nouveau numéro de version, ce qui va à l'encontre du [versionnement sémantique](https://semver.org/lang/fr/).
- Etant donné que tout le code est contenu dans un seul dépôt, il n'est **pas possible de donner à un développeur un accès restreint** à un seul projet comme c'est le cas du multi-repo, ce qui peut poser quelques problèmes de sécurité.
- Suivant les systèmes de versionnement, télécharger l'entièreté du projet vous oblige également à **utiliser plus d'espace de stockage** par rapport au système multi-repo où vous ne téléchargez que les projets sur lesquels vous travaillez.

Maintenant que vous en savez plus sur le côté théorique, il est temps de passer aux choses concrètes !

## Un monorepo en pratique

Il existe différentes manières de gérer un monorepo, et dans cet article je me contenterai d'utiliser [Lerna](https://lerna.js.org/) qui est dédié aux **monorepos de projets JavaScript**. Il existe évidemment d'autres façons de gérer un monorepo : [Yarn worskpaces](https://classic.yarnpkg.com/en/docs/workspaces/), [Bit](https://github.com/teambit/bit), [Bazel](https://bazel.build/) et [bien d'autres](https://github.com/korfuri/awesome-monorepo)...

### Initialiser son premier monorepo

Avant toutes choses nous allons **installer Lerna** sur notre machine avec la commande suivate

    npm install --global lerna

Il est temps maintenant de **créer notre projet** `packages` qui contiendra nos différents modules NPM. Le nom du dossier importe peu, j'aurais pu utiliser `catlover` ou `unicorns`.

    git init packages && cd packages

Une fois dans le dossier `packages` il est temps d'**initaliser Lerna** en spécifiant le tag `--independant` car je ne souhaite pas utiliser un numéro de version global identique pour tous mes projets, ceux-ci n'étant pas vraiment liés entre eux (_au contraire de [Jest](https://github.com/facebook/jest/blob/master/lerna.json) ou [Babel](https://github.com/babel/babel/blob/master/lerna.json) qui utilisent cette méthode_).

    lerna init --independent

Cette commande va créer la structure de dossier suivante :

```
lerna.json
package.json
packages/
```

Comme vous pouvez vous en douter, le dossier `packages` contiendra vos différentes projets créés dans leurs sous-dossiers respectifs.

> ⚠️ Il est important de noter que Lerna utilise `npm` comme gestionnaire de dépendances par défaut. Si vous préférez utiliser `yarn` ajoutez simplement `"npmClient": "yarn",` dans votre fichier de configuration `lerna.json`

### Importer des projets existants

C'est bien beau tout ça, mais comment importer mes différents modules NPM déjà existants ? Grâce à la commande magique `lerna import`, pardi ! Mais avant toutes choses, et pour que cette commande puisse fonctionner correctement, il faut créer notre tout premier commit.

    git add -A
    git commit -m "🎉 Initial commit"

Il est désormais temps d'**importer nos projets un par un** avec la commande `import` de Lerna (_voir [la documentation](https://github.com/lerna/lerna/tree/master/commands/import#options) pour plus d'information sur les différents flags_), qui a l'énorme avantage de rapatrier également tout l'historique des commits afin que celui-ci ne soit pas perdu.

    lerna import <dossier/du/module> --flatten --preserve-commit

Et voici à quoi ressemble l'import réussi de mon très célèbre (vraiment pas) [module de validation de numéro de TVA](https://www.npmjs.com/package/@adriantombu/vat-number) :

![Import d'un dépôt Git dans un monorepo Lerna](images/2020-05-08-passez-en-monorepo-avec-lerna/monorepo-lerna-import-project.png)

Ci-dessous la structure finale du repo Lerna une fois que tous mes projets ont été importés. Vous pouvez également utiliser la commande `lerna list` pour **lister tous les projets existants** dans le dépôt.

```
.git/
lerna.json
package.json
packages/
  |__ ...
  |__ siret-to-vat
  |__ vat-number
```

Il est désormais temps de **nettoyer un peu tout ce qui est redondant**, à savoir les `devDependencies` et les fichiers de configuration des différents modules qui sont tous identiques, et les déplacer à la racine du projet ainsi que dans le `package.json` principal.

Une fois tous ces changements fait, on installe toutes les dépendances d'un coup avec la commande

    lerna bootstrap

Pour vous donner une idée de la structure finale du projet, vous pouvez accéder au monorepo à l'adresse suivante : [https://github.com/adriantombu/packages](https://github.com/adriantombu/packages)

### Déployer ses modules sur NPM

Avant toutes choses vérifiez bien que vos **étapes de builds** seront lancées si vous en avez. De mon côté j'utilise dans le `package.json` global les commandes `prepare` pour compiler le TypeScript vers JavaScript et `prepublishOnly` pour lancer les tests.

Une fois ces modifications effectuées, il ne reste plus qu'à **taguer les packages modifiés et les déployer sur NPM** avec les 2 commandes suivantes.

    lerna version
    lerna publish from-package

Pour en savoir plus sur les différentes options de ces commandes, n'hésitez pas à jeter un oeil à la doc de [version](https://github.com/lerna/lerna/tree/master/commands/version) et [publish](https://github.com/lerna/lerna/tree/master/commands/publish).

> Il est possible de n'utiliser que `lerna publish` sans option, qui lancera `lerna version` automatiquement, mais c'est un comportement qui n'existera plus dans la version 4 de Lerna, mieux vaut adopter cette pratique dès maintenant.

## Conclusion

L'objectif premier de cette mise en pratique du monorepo était pour moi de **simplifier la gestion de mes quelques modules NPM**. Il me reste encore à gérer quelques améliorations, comme instaurer le **déploiement automatisé** via les Github Actions comme c'était le cas dans mes projets multi-repos.

J'ai rencontré quelques problèmes lors de la mise en place de ce monorepo car la documentation de Lerna n'est pas forcément très bien faite. J'ai donc du faire de nombreuses recherches et éplucher beaucoup d'articles sur le sujet pour enfin arriver à un monorepo qui fonctionne comme je le souhaite.

L'un dans l'autre je trouve cet outil **plutôt pratique dans le cas précis de mutualiser** les `devDependencies` et les différents fichier de configuration. La gestion simplifiée de la modification de version des packages via `lerna version` est également un gros plus, tout comme le **déploiement de plusieurs modules en une seule commande**.

N'hésitez pas à **discuter de cet article** avec moi sur [Twitter](https://twitter.com/adriantombu) ou [Linkedin](https://www.linkedin.com/in/adriantombu/) si vous avez des astuces ou bonnes pratiques à partager sur la gestion des monorepos !

![Thanks for watching](images/2020-05-08-passez-en-monorepo-avec-lerna/thank-you-for-watching.gif)
