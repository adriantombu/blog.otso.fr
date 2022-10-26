---
title: Et si on passait de master à main dans nos repos Git ?
description: Ca prend 2 minutes et 4 lignes de code, foncez !
published_at: 2020-06-18 10:00:00
image: https://blog.otso.fr/images/2020-06-18-git-remplacer-master-main/changer-branche-principale-github.png
---

# Et si on passait de master à main dans nos repos Git ?

> ⚠️ un article plus engagé que d'habitude, passez votre chemin si ce débat ne vous intéresse pas

En informatique, le débat sur les **termes à connotation raciste** a lieu depuis plusieurs années, bien avant la résurgence du **mouvement BlackLiveMatters** de ces dernières semaines et j'avoue ne jamais y être vraiment attardé. Pour être honnête, quand on a recommencé à en parler il y a quelques jours, j'ai levé les yeux aux ciel en me disant que ça devenait vraiment n'importe quoi.

Et puis j'ai vu les débats enflammés sur les réseaux sociaux... sur les dépôts de différents projets open-source... et c'est là que j'ai tilté. Tous ces trolls, tous ces gens qui hurlent à la fin du monde tel qu'on le connait, tous **ces réfractaires au changement**... tous ont un point commun : ils parlent de ce qui ne les concerne pas. Et pour cause, l'écrasante majorité de ces gens sont des mecs qui ne sont pas issus de minorités.

Et si, pour une fois, on arrêtait de dire non ? Et qu'on écoutait les gens qui sont vraiment concernés ? Et si on dégagait ces notions de **maître et d'esclave**, de liste noire et liste blanche ?

> Oui mais le blanc c'est symbole de pureté, c'est positif, on a toujours utilisé ça, ...

Tu savais qu'en Inde le blanc c'est la couleur qu'on porte **pour le deuil** ? Tu crois que parce qu'en Occident le blanc c'est symbole de pureté c'est le cas partout ailleurs dans le monde ? Des termes comme `blocklist` ou `allowlist` sont tellement **plus explicites**, pour tout le monde, partout, pourquoi ne pas simplement commencer à les utiliser dès maintenant ? C'est juste du bon sens au final.

> Ok, t'as pas tout à fait tort... On fait quoi maintenant ?

D'abord on commence par faire un petit **find & replace** dans son code pour modifier ce genre de terme pour les remplacer par des mots plus explicites. C'est pas trop difficile, on fait ça tous les jours pour renommer des noms de variables pourris qu'on a laissé traîner un peu trop longtemps. Et ensuite, il est temps de commit tout ça, mais avant... on va **dégager cette vilaine branche** `master` une bonne fois pour toutes et la remplacer par `main` (qui semble obtenir la majorité des voix).

Voici comment procéder en 4 lignes de code :

```git
# on switch sur la branche master si on n'est pas encore dessus
git checkout master

# on renomme la branche locale
git branch -m main

# on push la nouvelle branche locale
git push origin -u main

# on supprime la branche distante master
git push origin --delete master
```

⛔ Si comme beaucoup vous utilisez Github (mais ça s'applique sûrement à d'autres comme Gitlab) vous aurez une erreur sur la dernière commande. Pas de stress, **ça se répare en quelques clics** : dans votre repo sur Github, allez dans Settings > Branches et dans `Default branch` remplacez `master` par `main` avant de valider.

![Changer la branche principale sur Github](/images/2020-06-18-git-remplacer-master-main/changer-branche-principale-github.png)

Vous pouvez relancer la commande `git push origin --delete master` et c'est fini, il ne reste plus qu'à **modifier vos scripts de déploiement** pour vous baser sur votre branche `main`.

Vous avez vu, **c'est pas si horrible que ça** finalement ! Alors oui, vous me direz qu'on ne sauvera pas les gens des discriminations en changeant des mots dans du code. Mais c'est pas en réagissant comme des cons qu'on avancera non plus.

Peace ✊🏿
