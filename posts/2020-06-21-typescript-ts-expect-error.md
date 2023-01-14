---
title: A quoi sert @ts-expect-error dans Typescript ?
description: Quelle est la différence entre @ts-ignore et @ts-expect-error
published_at: 2020-06-21 10:00:00
image: https://blog.otso.fr/images/2020-06-21-typescript-ts-expect-error/ts-expect-error-pull-request.png
---

# A quoi sert @ts-expect-error dans Typescript ?

Lorsque l'on développe des tests, on est régulièrement amenés à **vérifier des comportements occasionnant des erreurs**. C'est évidemment à ce moment là que le compilateur Typescript vient nous taper sur les doigts (_logique après tout_) et on se retrouve donc à utiliser **@ts-ignore** pour être tranquille.

Voici un **exemple typique de test** tout simple où le compilateur va nous ressortir une erreur dans un test où l'on veut vérifier le comportement de la dite... erreur :

```typescript
function doStuff(abc: string) {
  assert(typeof abc === "string");
  // do some stuff
}

expect(() => {
  doStuff(123);
  //      ~~~
  // error: Type 'number' is not assignable to type 'string'.
}).toThrow();
```

Heureusement Typescript 3.9 nous apporte une nouveauté bienvenue avec **@ts-expect-error**, qui est pensée pour ce genre de cas. La différence par rapport à **@ts-ignore** étant qu'il **retournera une erreur à la compilation** si la ligne que l'on souhaite supprimer ne comporte pas d'erreur.

Concrètement ce morceau de code compilera sans soucis :

```typescript
// @ts-expect-error
doStuff(123);
```

Alors que celui-ci renverra une erreur de compilation, car le code ne comporte pas d'erreur :

```typescript
// @ts-expect-error
doStuff("abc");

// Unused '@ts-expect-error' directive.
```

Voilà, vous savez désormais comment utiliser **@ts-expect-error** ! Vous pouvez trouver **plus de détails** sur l'article de blog annonçant la [version 3.9 de Typescript](https://devblogs.microsoft.com/typescript/announcing-typescript-3-9-beta/#ts-expect-error-comments) ainsi que sur la [pull request dédiée](https://github.com/microsoft/TypeScript/pull/36014).
