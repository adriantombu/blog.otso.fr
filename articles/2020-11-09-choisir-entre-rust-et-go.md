---
title: Que choisir entre Rust et Go
description: Cet article est une traduction du dépôt Github Standard Go Project Layout
published_at: 2020-10-11
opengraph:
  image: https://blog.otso.fr/images/2020-11-09-choisir-entre-rust-et-go/golang-ou-rust.png
---

> Ce texte est une traduction de l’article [Rust vs Go](https://bitfieldconsulting.com/golang/rust-vs-go) avec l’aimable autorisation de son auteur [John Arundel](https://twitter.com/bitfield)

# Que choisir entre Rust et Go

![Mascottes des languages Go et Rust](images/2020-11-09-choisir-entre-rust-et-go/golang-ou-rust.png)

Rust ou Go, quel est le meilleur ? Lequel de ces langages devriez vous choisir pour votre prochain projet, et pourquoi ? Comment pouvons nous les comparer au niveau des performances, de la simplicité, de la sécurité, des fonctionnalités, de la scalabilité et de la concurrence ? Qu'ont ils en commun, et où sont ils fondamentalement différents ? Nous allons le découvrir dans cette comparaison amicale et impartiale entre Rust et Go, par l'auteur de la série de livres [For the Love of Go](https://bitfieldconsulting.com/books/).

## Rust et Go sont tous les deux fantastiques

Premièrement, il est vraiment important de dire qu'autant Go que Rust sont d'excellents langages de programmation. Ils sont modernes, puissant, adoptés en masse et offrent d'excellentes performances. Vous avez probablement lu des articles assayant de vous convaincre que Go est meilleur que Rust, ou vice-versa. Mais cela ne fait aucun sens : tous les langages de programmation offrent un ensemble de compromis. Chaque langage est optimisé pour des choses différentes, et donc votre choix devrait être déterminé par ce qui convient le mieux à vous et aux problèmes que vous souhaitez résoudre avec ce langage.

Dans cet article, j'essaie de vous donner un petit aperçu de quand je pense que Go est le choix idéal, et quand Rust est une alternative plus intéressante. Dans l'idéal, vous devriez avoir des familiarités pour travailler dans ces deux langages. Bien qu'ils soient très différents en syntaxe et style, autant Rust que Go sont des outils de première classe pour développer des logiciels. Ceci étant dit, regardons de plus près ces deux langages.

## Les similarités

Rust et Go ont beaucoup de choses en commun, c'est pourquoi vous les entendez souvent mentionnés ensemble. Quels sont les buts communs à ces deux langages ?

> *Rust est un langage de programmation multi-paradigme, bas niveau, typé statiquement qui se concentre sur la sécurité et les performances.*
>
> —[Gints Dreimanis](https://serokell.io/blog/rust-guide)

<div />

> *Go est un langage de programmation open source qui permet de développer rapidement des logiciels simples, fiables et efficaces.*
>
> —[Golang.org](https://golang.org/)

### La sécurité de la mémoire

Go et Rust appartiennent au groupe des langages de programmation modernes dont la priorité est la sécurité de la mémoire. Il est devenu évident durant ces dernières décennies d'utilisation de langages plus anciens tels que C et C++ que l'une des causes principales de bugs et de vulnérabilité est l'accès peu sûr ou incorrect à la mémoire. Rust et Go gèrent ce problème différement, mais tous deux essaient d'être plus élégants et sûr que les autres langages vis à vis de la gestion de la mémoire, et de la manière d'écrire des programmes pertinents et performants.

### Des exécutables rapides et compacts

Ce sont tous deux des langages compilés, ce qui signifie que vos programmes sont traduits directement en code machine afin que vous puissiez déployer votre programme en un seul fichier binaire. Contrairement aux langages interprétés tels que [Python](https://bitfieldconsulting.com/golang/golang/go-vs-python) et Ruby, vous ne devez pas distribuer un interpréteur et tous les paquets et dépendances en même temps que votre programme, ce qui est un avantage certain. C'est également ce qui rend les programmes Rust et Go extrêmement rapides par rapport aux langages interprétés.

### Des langages généralistes

Rust et Go sont des langages puissants, scalables et généralistes avec lesquels vous pouvez développer tous types de logiciels modernes, de l'application web aux microservices distribués, en passant par les microcontrolleurs embarqués et les applications mobiles. Tous deux ont des libraires standard de qualité, un écosystème prospère, un support commercial important et une base utilisateur étendue. Ils existent depuis de nombreuses années, et continueront à être largement utilisés dans les années à venir. Apprendre Go ou Rust aujourd'hui est un investissement intelligent de votre temps et vos efforts.

### Un style de programmation pragmatique

Aucun n'est principalement un langage fonctionnel (comme Scala ou Elixir par exemple), et aucun n'est exclusivement orienté objet (comme Java et C#). Bien que Go et Rust possèdent des fonctionnalités associées à la programmation fonctionnelle et orientée objet, ce sont des langages pragmatiques qui tentent de régler les problèmes de la manière la plus appropriée possible, plutôt que de vous forcer à le faire d'une certaine manière. (Si vous aimez la programmation fonctionnelle, vous retrouverez néanmoins beaucoup plus ce paradigme dans Rust que dans Go)

> *Nous pouvons débattre de ce qu'est un langage 'orienté objet', mais il est honnête de dire que le style de programmation orienté objet que les utilisateurs de C++, Java ou C# connaissent n'est pas présent dans Go ou Rust.*
>
> —Jack Mott

### Le développement à grande échelle

Rust et Go contiennent des fonctionnalités très utiles qui les rendent adaptés pour la programmation à grande échelle, que ce soit dans des équipes de grande taille, des codebases importantes, ou les deux.

Par exemple, quand les développeurs C ont débattu pendant des années pour savoir où mettre leurs parenthèses, ou si leur code devrait être indenté avec des espaces ou des tabs, autant Rust que Go éliminent ces problèmes entièrement en utilisant un outil standard de formattage (`gofmt` pour Go, `rustfmt` pour Rust) qui réécrit automatiquement votre code en utilisant le style normatif. Ce n'est pas tant que ce style en particulier soit extraordinaire en soit : c'est cette standardisation que les développeurs Rust et Go apprécient.

> *Le style de `gofmt` n'est le favori de personne, et pourtant `gofmt` est le favori de tout le monde.*
>
> —Rob Pike

Un autre domaine dans lequel ces deux langages sortent du lot est leur pipeline de build. Tous deux ont des outils de build et de gestion de dépendances excellents, intégrés et de haute performance; plus besoin de se battre avec un système de build tiers complexe et devoir en apprendre un nouveau tous les 2 ans.

> *Ayant un background Java et Ruby au début de ma carrière, développer du code Rust et Go c'était comme si on m'avait enlevé un énorme poids des épaules. Lorsque j'étais chez Google, c'était un soulagement de tomber sur un service dévelopé en Go, car je savais que ça serait facile à builder et lancer. C'était également le cas pour Rust, bien que je n'ai travaillé dessus qu'à une moindre échelle. J'espère que les jours des systèmes de builds configurables à l'infini sont terminés, et que dans le futur les langages livreront tous leurs propres outils de build qui fonctionnent sans configuration.*
>
> —Sam Rose


## Mais du coup, c'est qui le meilleur alors ?

Avec tout cela en tête, vous pourriez vous demander (et moi aussi) pourquoi il y a autant de guerre autour de ces deux langages, alors qu'ils sont tous deux très bien pensés et puissants. Pourquoi les gens font ils autant de vacarme avec "Go ou Rust", partent dans de longues diatribes sur les réseaux sociaux et écrivent des articles de blogs sans fin expliquant pourquoi seul un idiot utiliserait Rust, ou que Go n'est pas un véritable langage de programmation, ou que sais-je encore. Peut-être qu'ils se sentent mieux après ça, mais cela ne vous aide pas vraiment à décider quel langage utiliser pour votre projet, ou lequel des deux vous devriez apprendre pour faire décoller votre carrière de développeur. Une personne prudente ne se base pas sur celui qui crie le plus fort pour faire des choix importants.

Continuons donc cette discussion entre adultes en regardant dans quels domaines une personne raisonnable pourrait préférer un langage par rapport à l'autre.

### Performance

Nous avons déjà dit que Go et Rust produisent des programmes extrêmement rapides car ils sont compilés en code machine, sans avoir besoin d'un interpréteur ou d'une machine virtuelle. Néanmoins, les performances de Rust sont particulièrement impressionnantes. Elles sont comparable à C et C++, qui sont régulièrement acceptés comme étant les langages compilés les plus performants. Mais contrairement à ces langages plus anciens, Rust propose la sécurité de la mémoire et de la concurrence sans que cela impacte la vitesse d'exécution. Rust vous permet également de créer des abstractions complexes sans en payer les conséquences.

En comparaison, et bien que les programmes Go performent également très bien, Go est principalement pensé pour la vitesse de développement (compilation incluse), plutôt que la vitesse d'exécution. Le compilateur Go ne passe pas beaucoup de temps à essayer de générer le code machine le plus efficace, mais plutôt de compiler beaucoup de code rapidement. C'est pourquoi Rust bat généralement Go dans les benchmarks de performance.

Les performances de Rust sont également consistantes et prévisibles, car Rust n'utilise pas de garbage collector. Le garbage collector de Go est très efficace, et optimisé pour rendre ses pauses les plus courtes possibles (et de plus en plus courtes au fil des nouvelles versions de Go). Mais le garbage collector introduit inévitablement de l'incertitude dans la manière dont le programme se comporte, ce qui peut être un problème sérieux dans certaines applications telles que les systèmes embarqués.

Il est possible d'optimiser les programmes Rust pour être le plus près possible des performances maximales théoriques de la machine car Rust tente de donner au développeur le contrôle complet du hardware sous-jacent. Cela fait de Rust un choix excellent dans des domaines où la vitesse d'exécution est plus importante que tout le reste, comme dans la programmation de jeux vidéo, de noyaux de systèmes d'opération, des composants de navigateurs web et de systèmes controllés en temps-réel.

### Simplicité

Il n'y a pas d'intérêt à avoir un langage extrêmement rapide si personne ne sait comment l'utiliser. Go a été conçu délibérément comme une réaction à la complexité grandissante de langages tels que le C++ : il comporte très peu de syntaxe, peu de mots clés et, de ce fait, peu de fonctionnalités. Cela implique qu'il ne faut pas beaucoup de temps pour être assez à l'aise en Go et écrire des programmes utiles avec.

> *Go est vraiment très simple à apprendre. Je sais que c'est un de ses avantages les plus connus, mais j'ai été vraiment surpris de comment j'ai pu être productif très rapidement. Grâce au langage, à la documentation et aux outils, j'ai pu écrire du code intéressant et commitable après littéralement deux jours.*
>
> —[Early Impressions of Go From a Rust Programmer](https://medium.com/better-programming/early-impressions-of-go-from-a-rust-programmer-f4fd1074c410)

Le mot clé ici est la *simplicité*. La simplicité ne signifie pas la facilité, mais un langage simple est toujours plus facile à apprendre qu'un complexe. Comme il n'y a pas énorméments de manières de faire les choses, la majorité d'un code Go bien écrit a tendance à ressembler à la même chose. Il est facile de se plonger dans un service inconnu et de comprendre ce qu'il fait.

```go
    fmt.Println("Gopher's Diner Breakfast Menu")
    
    for dish, price := range menu {
        fmt.Println(dish, price)
    }
```

Bien que le noyau du langage soit plutôt petit, la libraire standard Go est très puissante. Cela signifie que votre courbe d'apprentissage devra également inclure les parties de la libraire standard dont vous avez besoin, et pas uniquement la syntaxe Go. D'un autre côté, le fait de déplacer des fonctionnalités en dehors du langage vers une librairie standard signifie que vous pouvez vous concentrer uniquement sur les librairies qui vous intéressent actuellement.

Go est également pensé pour le développement de logiciels à grande échelle, avec de grandes bases de code et des équipes étendues. Dans ces situations, il est important que les nouveaux développeurs puissent être productifs aussi vite que possible.

> *Avec Go, vous faites rapidement les choses. Go est l'un des langages les plus productifs avec lesquels je n'ai jamais travaillé. Le mantra est le suivant : résolvez de véritables problèmes aujourd'hui.*
>
> —[Matthias Endler](https://endler.dev/2017/go-vs-rust/)

### Fonctionnalités

> *Rust supporte plus de complexité que beaucoup d'autres langages de programmation, vous pouvez donc réaliser plus de chose avec. Par exemple, il supporte les génériques.*
>
> —[Devathon](https://devathon.com/blog/rust-vs-go-which-programming-language-to-choose/)

Rust est pensé spécifiquement pour inclure beaucoup de fonctionnalités puissantes et utiles pour aider les développeur à faire un maximum avec le moins de code possible. Par exemple, la fonctionnalité `match` de Rust vous permet d'écrire une logique flexible et expressive de manière concise :

```rust
fn is_prime(n: u64) -> bool {
    match n {
        0...1 => false,
        _ => !(2..n).any(|d| n % d == 0),
    }
}
```

Etant donné que Rust propose beaucoup de choses, cela veut dire qu'il y a beaucoup à apprendre, surtout au début. Mais ce n'est pas un problème : il y a aussi beaucoup de choses à apprendre en C++ ou Java, et vous n'avez même pas accès à des fonctionnalités avancées qui sont livrées avec Rust, telle que la sécurité de la mémoire. Critiquer Rust car c'est un langage complexe c'est passer à côté de ce qui fait sa force : il est pensé pour être expressif, ce qui signifie qu'il y a beaucoup de fonctionnalités, et dans la majorité des cas c'est ce que vous attendez d'un langage de programmation. La courbe d'apprentissage est indéniablement importante, mais vous n'aurez plus de problème une fois celle-ci passée.

> *Rust est en compétition avec C++ et D pour les développeurs qui sont prêts à accepter une syntaxe et une sémantique plus complexes (cela a probablement un coût au niveau lisibilité) avec en retour la performance maximale possible.*
>
> —[Dave Cheney](https://dave.cheney.net/2015/07/02/why-go-and-rust-are-not-competitors)

### Concurrence

La majorité des langages comporte une sorte de support pour la programmation concurrente (faire plusieurs choses en même temps), mais Go a été developpé dès le début avec cette idée en tête. Plutôt que d'utiliser les threads des systèmes d'opération, Go propose une alternative légère : les *goroutines*. Chaque goroutine est une fonction Go exécutée de manière indépendante que le planificateur de Go assignera à l'un des thread sous son contrôle. Cela signifie que le planificateur peut gérer très efficacement un nombre important de goroutines en utilisant seulement un nombre limité de threads.

De ce fait, vous pouvez lancer des millions de goroutines concurrentes dans un unique programme sans rencontrer de problèmes importants de performances. Cela rend Go le choix parfait pour des applications concurrentes à grande échelle, telles que des serveurs web ou des microservices.

Go propose également les `channels` pour permettre aux goroutines de communiquer et partager des données de manière rapide, sûre et efficace. Le support de la concurrence en Go est bien pensé et est un plaisir à utiliser. Raisonner en programmes concurrents est complexe habituellement, et construire un programme fiable est un challenge dans n'importe quel langage. Mais comme cette fonctionnalité a été pensée dès le début dans Go, plutôt qu'ajoutée plus tard, la programmation concurrente est quelque chose d'aussi simple et intégré que l'ont pourrait raisonnablement s'y attendre.

> *Il est très facile d'utiliser Go pour développer une application qui tire pleinement partie de la concurrence tout en étant déployée comme un set de microservices. Rust peut également faire cela, mais c'est clairement plus complexe. L'obsession de Rust à prévenir toute vulnérabilité de sécurité liée à la mémoire signifie que les développeurs sont obligés de faire les choses différement pour exécuter une tâche qui serait bien plus simple dans d'autres langages, Go inclus.*
>
> —[Sonya Koptyev](https://sdtimes.com/softwaredev/the-developers-dilemma-choosing-between-go-and-rust/)

L'apparition de la concurrence dans Rust est plutôt récente en comparaison, et est en phase de stabilisation, mais son développement est très actif donc gardez un oeil dessus. La librairie Rust [rayon](https://github.com/rayon-rs/rayon), par exemple, offre une solution élégante et légère pour transformer des opérations séquentielles en opérations parallèles.

> *Le fait d'avoir une syntaxe légère pour créer des routines Go et utiliser les channels est quelque chose d'appréciable. Cela montre vraiment la puissance de la syntaxe quand de si petits détails rendent la programmation concurrente tellement plus agréable que dans d'autres langages.*
>
> —[Early Impressions of Go From a Rust Programmer](https://medium.com/better-programming/early-impressions-of-go-from-a-rust-programmer-f4fd1074c410)

Bien qu'il soit moins facile d'implémenter la concurrence dans des programmes en Rust, cela reste possible, et ces programmes peuvent prendre avantage des garanties de Rust sur la sécurité. Un bon exemple est la classe `Mutex` de la libraire standard : en Go vous pouvez omettre l'obtention d'un verouillage mutex avant d'accéder à quelque chose, ce que Rust ne vous permettra pas.

> *Go se concentre sur la concurrence en tant que concept de première classe. Cela ne signifie pas que vous ne pouvez pas retrouver certains aspects de la concurrence Go dans Rust, mais sa mise en place est laissée à l'appréciation du développeur.*
>
> —[Dave Cheney](https://dave.cheney.net/2015/07/02/why-go-and-rust-are-not-competitors)

### Sécurité

Nous avons vu plus tôt que Go et Rust tentent de manière différente d'éviter une grande variété d'erreurs de programmation communes liées à la gestion de la mémoire. Mais Rust va particulièrement plus loin pour s'assurer que vous ne faites pas quelque chose de risqué sans vous en rendre compte.

> *Le compilateur très strict et pédant de Rust vérifie chaque variable que vous utilisez et chaque adresse mémoire que vous référencez. Il évite les éventuelles situations de compétition sur les données, et vous informe de tout comportement indéfini. Les problèmes de concurrence et de sécurité mémoire sont fondamentalement impossibles en Rust.*
>
> —[Why Rust?](https://bitbucket.org/blog/why-rust)

Cela rend l'expérience de la programmation en Rust différente de pratiquement tous les autres langages, ce qui peut être difficile au début. Mais pour beaucoup, le jeu en vaut la chandelle.

> *Pour moi, l'avantage principal de Rust est cette sensation que le compilateur ne me laissera pas tomber en refusant de laisser passer un bug qu'il aura détecté (cela ressemble sérieusement à de la magie parfois).*
>
> —Grzegorz Nosek

Beaucoup de langages, Go inclus, aident les développeurs à éviter certaines erreurs, mais Rust va bien plus loin en interdisant à un programme potentiellement incorrect de compiler.

> *Avec Rust, un développeur de librairie a beaucoup d'outils pour éviter à ses utilisateurs de faire des erreurs. Rust permet de dire avec certitude que l'on a accès à un morceau spécifique de donnée : il est impossible pour quoi que ce soit d'autre d'en récupérer la possession, nous sommes donc certains que rien ne peut modifier cette donnée. C'est la première fois que j'ai autant d'outils qui me permettent d'éviter une mauvaise utilisation accidentelle. C'est une sensation extraordinaire.*
>
> —[Sam Rose](https://samwho.dev/)

"Se battre avec le borrow checker" est un syndrome commun à tous les nouveaux développeurs Rust, mais la majorité du temps les problèmes soulevés sont de réels bugs (ou des bugs potentiels) dans votre code. Il peut vous forcer à réarchitecturer entièrement votre programme pour éviter à nouveau ces problèmes mais c'est une bonne chose d'avoir l'exactitude et la fiabilité au top de vos priorités. Quel est l'intérêt d'un langage qui ne vous oblige pas à changer votre manière de développer ? Les leçons tirées de la sécurité dans Rust seront également utiles lorsque vous travaillerez avec d'autres langages.

> *Si vous choisissez Rust, c'est généralement pour les garanties que le langage vous donne : la sécurité contre les pointeurs null et les situations de compétition, une exécution prévisible, et un contrôle total sur le matériel. Si vous n'avez pas besoin de ces fonctionnalités, Rust n'est peut être pas le meilleur choix pour votre prochain projet. Cela est principalement dû au fait que la montée en puissance est difficile. Vous devrez désapprendre de mauvaises habitudes et apprendre de nouveaux concepts. Il est fort possible que vous vous battrez énormément avec le borrow checker lorsque vous commencerez.*
>
> —[Matthias Endler](https://endler.dev/2017/go-vs-rust/)

Votre expérience des autres langages définira votre notion de difficulté du modèle de développement Rust. Python ou Ruby pourraient le trouver très restrictif quand d'autres en seraient ravis.

> *Si vous êtes un développeur C ou C++ qui a perdu des semaines à chercher un bug de sécurité mémoire dans ces langages, vous allez vraiment apprécier Rust. "Se battre contre le borrow checker" devient rapidement "Le compilateur peut détecter ça ? Cool !"*
>
> —Grzegorz Nosek

### Développement à grande échelle

> *Les logiciels serveur actuels sont composés de millions de lignes de codes développées par des centaines, voire des milliers, de développeurs et sont mis à jours en permanence. Go a été pensé et développé pour être plus productif dans ce type d'environnement. Les considérations sur la conception de Go incluent une gestion rigoureuse des dépendances, l'adaptabilité de l'architecture du logiciel au fur et à mesure qu'il s'étend, et la robustesse à travers les limites entre les composants.*
>
> —[Rob Pike](https://talks.golang.org/2012/splash.article)

Lorsque vous travaillez sur un problème seul ou dans une équipe réduite, le choix d'un langage simple ou riche est plus une préférence personnelle. Mais les différences finissent vraiment par se sentir au fur et à mesure que le logiciel devient de plus en plus gros et complexe et que les équipes se développent. Pour de grosses applications et des systèmes distribués, la vitesse d'exécution est moins importante que la vitesse de développement : un langage délibérement minimal tel que Go réduit le temps d'adaptation des nouveaux développeurs et les aide à travailler sur des bases de code importantes.

> *Avec Go, il est plus simple pour un développeur junior d'être plus productif, et plus complexe pour un développeur expérimenté d'introduire des abstractions qui finiront par causer des problèmes. C'est pour ces raisons que Rust est moins irrésistible que Go pour le développement de logiciels d'entreprise.*
>
> —[Loris Cro](https://kristoff.it/blog/why-go-and-not-rust/)

Lorsque l'on parle d'industrialisation du développement logiciel, la clarté est plus importante que l'élégance. Les limitations de Go rendent le langage plus adapté pour les sociétés et les organisations de grande taille qu'un langage plus puissant et complexe tel que Rust.

## Les différences

Bien que Rust et Go soient populaires, modernes et largement utilisés, ils ne sont pas vraiment en compétition, dans le sens qu'ils visent des cas d'utilisation plutôt différents. L'approche de programmation de Go est radicalement différente de celle de Rust, et chaque langage conviendra à certains tout en irritant d'autres. C'est tout à fait normal, et si Rust et Go faisaient plus ou moins la même chose d'une manière similaire, nous n'aurions pas vraiment besoin de deux langages différents.

Nous allons développer quelles sont les natures respectives de Rust et Go en trouvant des problèmes sur lesquels ils adoptent des approches radicalement différentes.

### Garbage collector

"Faut il ou pas utiliser le garbage collector ?" est l'une de ces questions qui n'a pas vraiment de réponse correcte. La gestion automatisée de la mémoire permet généralement de développer rapidement et facilement des programmes sûr et efficaces, et c'est tout ce qui importe pour certains. Mais d'autres vous diront que cela génère des problèmes de performances et rend l'exécution moins prévisible tout en ajoutant des temps de latence inacceptables. C'est un débat sans fin.

> *Go est un langage très différent de Rust. Bien que les deux soit vaguement décrits en tant que langages systèmes ou successeurs de C, ils ont des buts et applications, des styles de langage et des priorités différents. Le garbage collector en est l'un des plus grands différenciateur. L'utilisation du GC dans Go rend le langage plus simple, plus petit, et plus facile à gérer.*
>
> *Ne pas avoir de GC dans Rust rend le langage vraiment très rapide (surtout si vous avez besoin d'une latence garantie, et pas uniquement un débit élevé) et permet l'utilisation de fonctionnalités et de modèles de développement qui ne sont pas possibles en Go (ou tout du moins sans sacrifier en performance)*
>
> —[PingCAP](https://medium.com/better-programming/early-impressions-of-go-from-a-rust-programmer-f4fd1074c410)

### Proche du matériel

L'histoire de la programmation est une suite d'abstractions de plus en plus sophistiquées qui permettent au développeur de résoudre des problèmes sans se préoccuper du fonctionnement de la machine sous-jacente. Cela rend les programmes plus faciles à écrire et potentiellement plus portables. Mais pour beaucoup de programmes, l'accès au hardware et le contrôle précis de la façon dont le programme est exécuté est très important. Rust tente d'aider les développeurs à être proches du hardware mais Go fait abstraction des détails architecturaux pour permettre aux développeurs de se rapprocher du problème.

> *Les deux langages ont un but différent. Golang brille lorsqu'il faut écrire des microservices ou des tâches typiquement "DevOps", mais ce n'est pas un langage de programmation système. Rust est plus robuste pour les tâches où la concurrence, la sécurité et/ou les performances sont importantes, mais il a une courbe d'apprentissage plus difficile que Go.*
>
> —[Matthias Endler](https://endler.dev/2017/go-vs-rust/)

### La rapidité avant tout

J'ai écrit dans un autre article que [la performance est moins importante que la lisibilité](https://bitfieldconsulting.com/golang/slower) pour la majorité des programmes. Mais lorsqu'on recherche la performance, cela a une véritable importance. Rust fait un certain nombre de compris pour arriver à la meilleur vitesse d'exécution possible. Par contraste, Go est plus concerné par la simplicité, et est prêt à sacrifier un peu de performance d'exécution à cet effet. Mais la vitesse d'exécution d'un build Go est imbattable, et c'est ce qui importe le plus sur des codebases de grande taille.

> *Rust est plus rapide que Go. Dans les benchmarks ci-dessus, Rust était plus rapide, et dans certains cas d'un ordre de grandeur plus rapide. Mais avant de tout balancer pour écrire tout en Rust, n'obuliez pas que Go n'était pas si loin que ça dans la majorité des benchmarks, et qu'il reste bien plus rapide que des langages tels que Java, C#, JavaScript, Python et autres.*
>
> *S'il vous faut absolument les meilleures performances, vous serez devant tout le monde en utilisant l'un de ces langages. Si vous développez un web service qui doit gérer une charge élevée, et que vous souhaitez pouvoir scaler verticalement et horizontalement, ces deux langages conviendront parfaitement.*
>
> —[Andrew Lader](https://codeburst.io/should-i-rust-or-should-i-go-59a298e00ea9)

### Exactitude

D'un autre côté, un programme peut être arbitrairement rapide s'il n'est pas forcé de fonctionner comme il faut. La majorité du code n'est pas écrite pour du long terme, mais il est parfois surprenant de voir à quel point certains programmes peuvent rester longtemps à tourner en production : plusieurs décennies dans certains cas. C'est dans ces situations que cela vaut le coup de prendre un peu plus de temps de développement pour être certain que le programme est correct, fiable et ne nécessitera pas beaucoup de maintenance dans le futur.

> *Mon avis: utiliser Go pour le code qui doit être déployé demain, Rust pour le code qui devra rester en production tel quel pour les 5 prochaines années*
>
> —Grzegorz Nosek

Bien que Go et Rust soient tous deux d'excellents choix pour n'importe quel projet sérieux, cela reste une bonne idée de rester le plus à jour possible par rapport à chacun de ces langages et de ses caractéristiques. Au final, peu importe ce que pensent les autres : il n'y a que vous qui pouvez décider de ce qui convient pour vous et votre équipe.

> *Si vous souhaitez développer rapidement, peut-être parce que vous avez différents services à écrire, ou que vous avez une équipe importante de développeurs, alors Go est votre langage de choix. Go vous offre la concurrence et ne tolère pas les accès risqués à la mémoire (Rust non plus), mais sans vous obliger à gérer chaque petit détail. Go est rapide et puissant, tout en évitant de ralentir le développeur, grâce à sa simplicitié et son uniformité. Dans le cas contraire, Rust devrait être votre choix si vous souhaitez absolument atteindre le maximum de performances.*
>
> —[Andrew Lader](https://codeburst.io/should-i-rust-or-should-i-go-59a298e00ea9https://codeburst.io/should-i-rust-or-should-i-go-59a298e00ea9)

### Conclusion

J'espère que cet article vous aura convaincu qu'autant Rust que Go méritent d'être considérés sérieusement. Dans les limites du possible vous devriez tenter d'avoir un minimum d'expérience dans ces deux langages car ils vous seront incroyablement utiles dans n'importe quelle carrière tech, ou plus simplement si vous aimez la programmation en tant que hobby. Si vous n'avez le temps de vous investir que dans un seul langage, ne prenez pas de décision avant d'avoir utilisé Go et Rust pour développer différents types de programmes, qu'ils soient petits ou importants.

La connaissance d'un langage de programmation n'est vraiment qu'une toute petit part de la vie d'un développeur accompli. Les compétences les plus importantes, et de loin, restent le design, l'ingénierie, l'architecture, la communication et la collaboration. Si vous excellez dans ces compétences, vous serez un très bon développeur quel que soit votre choix de langage. Bon apprentissage !


## Quelques sources pour débuter

Si vous êtes intéressés pour apprendre à développer en Rust et Go, voici quelques resources qui pourraient vous aider.

### Go

- [Install Go](https://golang.org/dl/)
- [Go tutorials by Bitfield](https://bitfieldconsulting.com/golang)
- [For the Love of Go](https://bitfieldconsulting.com/books)
- [A Tour of Go](https://tour.golang.org/welcome/1)
- [Go By Example](https://gobyexample.com/)
- [The Go Playground](https://play.golang.org/)
- [Awesome Go](https://github.com/avelino/awesome-go)

### Rust

- [Install Rust](https://www.rust-lang.org/tools/install)
- [A Gentle Introduction to Rust](https://stevedonovan.github.io/rust-gentle-intro/)
- [The Rust Programming Language](https://doc.rust-lang.org/book/index.html)
- [Rust books](https://github.com/sger/RustBooks)
- [Rust By Example](https://doc.rust-lang.org/rust-by-example/)
- [The Rust Playground](https://play.rust-lang.org/)
- [One Hundred Rust Binaries](https://www.wezm.net/v2/posts/2020/100-rust-binaries/)

## Remerciements

Je ne suis pas assez jeune pour tout connaître, comme le dit le dicton, je suis donc très reconnaissant pour l'aide de nombreux Gophers et Rustacés qui ont pris le temps de faire une revue et une correction de cet article, ainsi que me transmettre des suggestions très utiles. Mes remerciements vont vers Bill Kennedy, Grzegorz Nosek, Sam Rose, Jack Mott, Steve Klabnik, MN Mark, Ola Nordstrom, Levi Lovelock, Emile Pels, Sebastian Lauwers, Carl Lerche et tous les autres contributeurs. Vous pourriez avoir l'impression en lisant des articles que les communautés Rust et Go ne s'entendent pas du tout. Mais d'expérience cela est vraiment très éloigné de la vérité : nous avons pu avoir des discussions civilisées et productives lors de l'écriture de cet article, et cela a fait une très grande différence au final. Encore merci.
