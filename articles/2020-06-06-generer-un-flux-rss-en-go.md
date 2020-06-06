---
title: Générer un flux RSS en Go
description: Comment utiliser les bibliothèques standard Go pour générer un flux RSS valide
published_at: 2020-06-06
opengraph:
  image: https://blog.otso.fr/images/2020-06-06-generer-un-flux-rss-en-go/logo-rss.png
---

# Générer un flux RSS en Go

Il y a quelques mois j'ai entamé la création d'un [générateur de blog statique en Go](https://github.com/adriantombu/orion) pour me faire la main sur le langage et j'ai souhaité y **intégrer un flux RSS**. Pourquoi me direz-vous ? Ce format de donnée a beau dater du millénaire précédent (la [première version du RSS](https://fr.wikipedia.org/wiki/RSS) est sortie en 1999), il est encore largement répandu de nos jours sur les blogs et sites d'informations et j'en suis moi-même un fervent utilisateur grâce à Feedly.

La **création d'un flux RSS en Go** est somme toute assez simple et ne requiert que l'utilisation de la bibliothèque native `endoding/xml`.

![Un joli logo RSS](images/2020-06-06-generer-un-flux-rss-en-go/logo-rss.png)

## Étape 1 : créer les structures de données

La première chose a faire est d'aller faire un tour sur [les spécifications RSS 2.0](https://validator.w3.org/feed/docs/rss2.html) (le site est vraiment très beau) pour découvrir comment est structuré un fichier `rss.xml` ainsi que les éléments obligatoires à renseigner.

La structure est composée de deux parties distinctes :

### Le canal, ou `channel`

C'est la partie qui **décrit le flux RSS** et le site qui y est lié. Il n'y a que 3 éléments obligatoires à renseigner :

- `title` : qui représente le nom de votre site (_ex: Blob Trotter_)
- `link` : un lien vers le site correspondant au flux RSS (_ex: [https://blog.otso.fr](https://blog.otso.fr/)_)
- `description` : une petite description du contenu de votre site (_ex: Les pérégrinations d'un développeur dans le monde de Javascript et de Go_)

Il existe **d'autres éléments optionnels** que vous retrouverez dans les spécifications, tels que la langue ou le copyright par exemple.

### Les éléments, ou `items`

C'est **la liste des articles** que vous souhaitez partager dans votre flux RSS, sans que ceux-ci ne soient limités en nombre. Bien qu'il soit possible d'utiliser jusqu'à 10 éléments pour décrire un article, **la seule obligation** est de renseigner un titre ou une description.

Sur mon projet, je suis parti sur le titre, le lien, la description, une image et la date de publication, afin d'avoir un rendu plus plaisant visuellement dans un lecteur de flux RSS. Il est important de noter que le champ `description` peut comporter un texte simple mais également **tout l'article au format HTML** (c'est cette deuxième option que j'utilise sur mon blog).

Au final on se retrouve donc avec une structure de données plutôt simple :

<script src="https://gist.github.com/adriantombu/8553bc91c8a8b274efe610f88fb9381e.js"></script>

## Étape 2 : la génération du fichier RSS

Ici rien de bien sorcier, on va instancier une structure de type `rss`, et y intégrer tous les articles avant d'écrire le fichier `rss.xml` sur le disque.

Voici le code final de la partie où l'on **génère le flux RSS** :

<script src="https://gist.github.com/adriantombu/6d597a241096e204e01b45fc4e3b6d59.js"></script>

## Étape bonus : la date de publication de l'article

Je ne l'ai pas ajouté dans l'exemple ci-dessus mais il est possible d'ajouter une **date de publication** pour les articles : c'est le champ `pubDate` que j'utilise également sur [Orion](https://github.com/adriantombu/orion/blob/master/cmd/build/rss.go#L59) et qui a la particularité de devoir être spécifié au format [RFC-822](https://www.feedvalidator.org/docs/error/InvalidRFC2822Date.html) mais avec l'année sur 4 chiffres et non 2.

Heureusement pour nous il existe dans Go un format de date dans [les constantes de la bilbiothèque standard time](https://golang.org/pkg/time/#pkg-constants) qui correspond à ce que l'on recherche : `RFC1123Z`

Il suffit donc de mettre à jour votre structure en ajoutant l'élément `PubDate` :

<script src="https://gist.github.com/adriantombu/2442178216f524a536da77251376bee5.js"></script>

Dans mon générateur de blog, j'utilise le format de date `YYYY-MM-DD` pour les dates de publication de mes articles, voici donc comment la **transformer en un format RFC1123Z** compatible avec un flux RSS (_[plus d'infos sur time.Parse](https://gobyexample.com/time-formatting-parsing)_) :

<script src="https://gist.github.com/adriantombu/164feaf8c24940d592d6a446eff29efd.js"></script>

Dans le même style, vous pouvez générer automatiquement la **date de dernier build** de votre flux RSS en ajoutant `LastBuildDate` dans votre channel :

<script src="https://gist.github.com/adriantombu/9e312a263fedfb6fc8be20d79ec19380.js"></script>

J'espère que cet article vous aura permis de mieux comprendre **comment générer un flux RSS** en quelques lignes de Go, et de manière plus générale comment **créer un fichier XML** à partir d'une structure, en utilisant uniquement les bibliothèques standard du langage.

Vous pouvez retrouver la totalité du code de cet article sur Gist : [Un script de génération de flux RSS en go](https://gist.github.com/adriantombu/1d669358839b4559484dd2fc53cad732)

Envie de me **donner votre avis** sur cet article ou discuter de Go en général ? Venez me faire coucou sur [Twitter](https://twitter.com/adriantombu) !
