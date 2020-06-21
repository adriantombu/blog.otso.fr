---
title: A quoi sert @ts-expect-error dans Typescript ?
description: Quelle est la différence entre @ts-ignore et @ts-expect-error
published_at: 2020-06-21
opengraph:
  image: https://blog.otso.fr/images/2020-06-21-typescript-ts-expect-error/ts-expect-error-pull-request.png
---

# A quoi sert @ts-expect-error dans Typescript ?

Lorsque l'on développe des tests, on est régulièrement amenés à **vérifier des comportements occasionnant des erreurs**. C'est évidemment à ce moment là que le compilateur Typescript vient nous taper sur les doigts (_logique après tout_) et on se retrouve donc à utiliser **@ts-ignore** pour être tranquille.

Voici un **exemple typique de test** tout simple où le compilateur va nous ressortir une erreur dans un test où l'on veut vérifier le comportement de la dite... erreur :

<script src="https://gist.github.com/adriantombu/470302bb630ed03f325dda6aec900fcf.js"></script>

Heureusement Typescript 3.9 nous apporte une nouveauté bienvenue avec **@ts-expect-error**, qui est pensée pour ce genre de cas. La différence par rapport à **@ts-ignore** étant qu'il **retournera une erreur à la compilation** si la ligne que l'on souhaite supprimer ne comporte pas d'erreur.

Concrètement ce morceau de code compilera sans soucis :

<script src="https://gist.github.com/adriantombu/ceb3c31f09d60e28688f16f9397ece33.js"></script>

Alors que celui-ci renverra une erreur de compilation, car le code ne comporte pas d'erreur :

<script src="https://gist.github.com/adriantombu/b89c658691c9af0f55581af09c556b99.js"></script>

Voilà, vous savez désormais comment utiliser **@ts-expect-error** ! Vous pouvez trouver **plus de détails** sur l'article de blog annonçant la [version 3.9 de Typescript](https://devblogs.microsoft.com/typescript/announcing-typescript-3-9-beta/#ts-expect-error-comments) ainsi que sur la [pull request dédiée](https://github.com/microsoft/TypeScript/pull/36014).
