---
title: Une introduction rapide à la sécurité web
description: Cet article vous expliquera la signification des acronymes les plus utilisés dans la sécurité web de manière simple et compréhensible
published_at: 2018-08-15
opengraph:
  image: https://blog.otso.fr/images/2018-08-15-une-introduction-rapide-a-la-securite-web/cadenas.jpg
---

# Une introduction rapide à la sécurité web

![Photo de Jose Fontano sur Unsplash](images/2018-08-15-une-introduction-rapide-a-la-securite-web/cadenas.jpg)

> Ce texte est une traduction de l’article [A quick introduction to web security](https://medium.freecodecamp.org/a-quick-introduction-to-web-security-f90beaf4dd41) avec l’aimable autorisation de son auteur [Augustin Tackaberry](https://medium.freecodecamp.org/@austintackaberry)

Voici certaines des nombreuses raisons qui peuvent vous pousser à en apprendre un peu plus sur la sécurité web :

- Vous êtes un utilisateur concerné qui est inquiet que ses données personnelles puissent être divulguées
- Vous êtes un développeur web consciencieux qui veut rendre ses applications plus sécurisées
- Vous êtes en recherche d’un emploi de développeur web et souhaitez être prêt dans le cas où un recruteur vous poserait des questions sur la sécurité web

Cet article vous expliquera la signification des acronymes les plus utilisés dans la sécurité web, de manière facile à comprendre et tout en restant précis.

Mais avant toute chose, faisons en sorte que nous comprenions quelques concepts de base de la sécurité.

## Les deux concepts de base de la sécurité

### Rien n’est jamais 100% sécurisé.

Il n’existe aucune notion de protection à 100% contre le piratage. Si une personne vous a déjà affirmé le contraire un jour, sachez qu’elle a tort.

### Une couche de protection n’est pas suffisante.

Vous ne pouvez pas dire...

> Oh mais je suis protégé, j’ai implémenté une CSP ! Je peux retirer les scripts cross-domains de ma liste de vulnérabilités, ça ne peut plus arriver maintenant.

C’est peut-être une évidence pour certains, mais il est très facile de se retrouver en train de réfléchir de cette manière. Je pense que la raison principale pour laquelle les développeurs peuvent si facilement se retrouver à réfléchir ainsi tient du fait que le développement se limite souvent à noir ou blanc, 0 ou 1, vrai ou faux. La sécurité n’est pas si simple.

Nous allons démarrer par un acronyme sur lequel tout le monde tombe très rapidement lors de son parcours de développement web. Et vous vous retrouvez ensuite sur StackOverflow pour trouver plein de réponses vous expliquant comment passer outre.

## Cross-Origin Resource Sharing (CORS)

Avez-vous déjà rencontré une erreur qui ressemble à quelque chose comme ça ?

    No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'null' is therefore not allowed access.

Vous n’êtes clairement pas le seul. Après une recherche sur Google, vous trouverez quelqu’un qui vous dira de télécharger telle extension qui fera disparaître tous vos problèmes !

> Super, non ?

![](images/2018-08-15-une-introduction-rapide-a-la-securite-web/no-please-no.gif)

**Le CORS est là pour vous protéger, pas pour vous faire du mal !**

Pour pouvoir vous expliquer comment le CORS vous aide, nous allons d’abord parler des cookies, et plus particulièrement des **cookies d’authentification**. Les cookies d’authentification sont utilisés pour indiquer à un serveur que vous êtes connecté, et sont automatiquement envoyées à chaque requête que vous faites sur ce serveur.

Imaginons que vous êtes connecté sur Facebook et qu’ils utilisent des cookies d’authentification. Vous cliquez sur `bit.ly/r43nugm` qui vous redirige ensuite sur `superevilwebsite.rocks`. Un script sur le site `superevilwebsite.rocks` lance une requête du côté client vers facebook.com qui renvoie votre cookie d’authentification !

Dans un monde sans CORS, ils feraient des modifications sur votre compte sans même que vous vous en rendiez compte. Jusqu’à ce qu’ils postent `bit.ly/r43nugm` sur votre timeline, que tous vos amis cliquent dessus, et qu’ils postent à leur tour `bit.ly/r43nugm` sur toutes les timelines de leur amis et que le cycle continue dans une boucle infernale machiavélique de tous les utilisateurs de Facebook et que le monde entier soit dévoré par `superevilwebsite.rocks`. 😆

Dans un monde avec CORS, toutefois, seules les requêtes ayant comme origine `facebook.com` auraient l’authorisation de Facebook pour modifier des données sur leur serveur. En d’autres termes, ils limiteraient le partage des resources multi-origines. Mais vous pourriez vous demander…

> Est-ce que superevilwebsite.rocks ne pourrait simplement pas changer son en-tête d’origine dans la requête pour faire comme si elle provenait de facebook.com ?

Ils peuvent essayer, mais cela ne fonctionnera pas car le navigateur les ignorera tout simplement et utilisera la véritable origine.

> D’accord, mais que se passe-t’il si superevilwebsite.rocks effectue la requête du côté serveur ?

Dans ce cas, ils pourront contourner le CORS, mais il ne pourront pas gagner car ils ne peuvent pas envoyer votre cookie d’authentification dans la requête. En effet, le script doit obligatoirement être exécuté côté client pour avoir accès à vos cookies côté client.

## Content Security Policy (CSP)

Pour comprendre la CSP (Politique de sécurité du contenu), nous devons d’abord parler d’une des vulnérabilités les plus communes dans le monde du web: le XSS, qui signifie cross-site scripting (youhou — encore un autre acronyme).

Le XSS se manifeste lorsqu’une personne mal intentionnée injecte du Javascript dans votre code côté client. Vous pourriez vous demander…

> Que vont-ils bien pouvoir faire ? Changer une couleur du rouge vers le bleu ?

Imaginons que l’ont ait réussi à injecter du javascript côté client dans le code d’un site que vous visitez.

Que pourraient-ils faire de malveillant ?

- Ils pourraient faire des requêtes HTTP vers un autre site en se faisant passer pour vous
- Ils pourraient ajouter un lien qui vous renvoie vers un site qui semble identique à celui sur lequel vous êtes, à quelques légers changements malveillants prêt.
- Ils pourraient ajouter une balise script avec du Javascript inline.
- Ils pourraient ajouter une balise script qui va récupérer un fichier Javascript quelque part.
- Ils pourraient ajouter une iframe qui recouvre la page et ressemble à une partie du site qui vous demande d’insérer votre mot de passe.

Les possibilités sont infinies.

![](images/2018-08-15-une-introduction-rapide-a-la-securite-web/old-guy-nodding.gif)

La CSP tente d’éviter que cela arrive en limitant :

- ce qui peut être ouvert dans une iframe
- quelles feuilles de styles peuvent être chargées
- vers où les requêtes peuvent être effectuée, etc.

Alors, comment ça marche ?

Lorsque vous cliquez sur un lien ou que vous écrivez l’url d’un site dans la barre d’adresse de votre navigateur, celui-ci lance une requête de type GET. Celle-ci finit par atteindre un serveur qui lui sert du HTML en même temps que des en-tête HTTP. Si vous êtes curieux de savoir ce que vous recevez comme en-tête, ouvrez l’onglet “Réseau” de votre console et visitez quelques sites.

Vous pourriez voire un en-tête de réponse qui ressemble à ça :

    content-security-policy: default-src * data: blob:;script-src *.facebook.com *.fbcdn.net *.facebook.net *.google-analytics.com *.virtualearth.net *.google.com 127.0.0.1:* *.spotilocal.com:* 'unsafe-inline' 'unsafe-eval' *.atlassolutions.com blob: data: 'self';style-src data: blob: 'unsafe-inline' *;connect-src *.facebook.com facebook.com *.fbcdn.net *.facebook.net *.spotilocal.com:* wss://*.facebook.com:* https://fb.scanandcleanlocal.com:* *.atlassolutions.com attachment.fbsbx.com ws://localhost:* blob: *.cdninstagram.com 'self' chrome-extension://boadgeojelhgndaghljhdicfkmllpafd chrome-extension://dliochdbjfkdbacpmhlcpmleaejidimm;

Cela représente la politique de sécurité du contenu de `facebook.com`. Voici à quoi cela ressemble une fois formaté pour rendre le tout plus lisible :

    content-security-policy:

    default-src * data: blob:;

    script-src *.facebook.com *.fbcdn.net *.facebook.net *.google-analytics.com *.virtualearth.net *.google.com 127.0.0.1:* *.spotilocal.com:* 'unsafe-inline' 'unsafe-eval' *.atlassolutions.com blob: data: 'self';

    style-src data: blob: 'unsafe-inline' *;

    connect-src *.facebook.com facebook.com *.fbcdn.net *.facebook.net *.spotilocal.com:* wss://*.facebook.com:* https://fb.scanandcleanlocal.com:* *.atlassolutions.com attachment.fbsbx.com ws://localhost:* blob: *.cdninstagram.com 'self' chrome-extension://boadgeojelhgndaghljhdicfkmllpafd chrome-extension://dliochdbjfkdbacpmhlcpmleaejidimm;

Séparons maintenant chacune des directives :

- **default-src** limite toute les autres directives CSP qui ne sont pas explicitement listées.
- **script-src** limite les scripts qui peuvent être chargés.
- **style-src** limite les feuilles de style qui peuvent être chargées.
- **connect-src** limite les URLs qui peuvent être chargées à partir des scripts, tels que fetch, XHR, ajax, etc.

Notez qu’il existe beaucoup d’autres directives CSP que les quatre listées ci-dessus. Le navigateur va lire les en-tête CSP et appliquer ces directives à tout ce qui est inclus dans la page HTML qui est affichée. Si les directives sont correctement renseignées, elles n’autoriseront que ce qui est nécessaire.

S’il n’y a pas d’en-tête CSP, alors tout passe et rien n’est limité. Partout où vous voyez `*`, c’est une wildcard (ou joker en français). Vous pouvez remplacer `*` par tout ce que vous voulez, et cela sera autorisé.

## HTTPS ou HTTP Secure

Vous avez certainement entendu parler du HTTPS. Peut-être avez-vous entendu certaines personnes dire...

> Pourquoi est-ce que je me soucierais d’utiliser du HTTPS si je suis juste en train de jouer sur un site web ?

Ou alors vous avez entendu l’autre partie...

> Vous êtes fous si vous votre site n’utilise pas HTTPS. On est en 2018 ! Ne croyez personne qui vous dirait le contraire.

Vous avez peut-être entendu que Chrome allait désormais marquer votre site comme non sécurisé s’il n’utilise pas le HTTPS.

À la base, le HTTPS est assez simple. HTTPS est chiffré, et HTTP ne l’est pas.

Alors pourquoi est-ce si important si vous n’envoyez pas de données sensibles ?

Préparez vous pour un nouvel acronyme… MITM, qui signifie Man in the Middle (Homme du Milieu).

Si vous utilisez un Wi-Fi public sans mot de passe dans un café, il est très simple pour quelqu’un de se substituer à votre routeur, de telle sorte que toutes les requêtes et réponses passent par lui. Si vos données ne sont pas chiffrées, il peut en faire ce qu’il veut. Il peut modifier le HTML, CSS, ou encore le Javascript avant même qu’ils n’atteignent votre navigateur. En considérant ce que nous savons sur le XSS, vous pouvez donc imaginer à quel point cela peut devenir dangereux.

> D’accord, mais comment est-ce que mon ordinateur et le serveur peuvent savoir comment chiffrer/déchiffrer mais ce MITM ne le sait pas ?

C’est là que le SSL (Secure Sockets Layer) et, plus récemment, le TLS (Transport Layer Security) font leur apparition. TLS a pris la place du SSL en 1999 en tant que technologie de chiffrement utilisée dans le HTTPS. Nous n’expliquerons pas ici comment fonctionne le TLS, ce n’est pas le but de cet article.

## HTTP Strict-Transport-Security (HSTS)

Celui-ci est assez simple. Utilisons à nouveau un en-tête Facebook comme exemple :

    strict-transport-security: max-age=15552000; preload

- **max-age** indique au navigateur pendant combien de temps les utilisateurs sont forcés d’accéder au site en HTTPS.
- **preload** n’est pas important dans le cadre de cet article. C’est un service hébergé par Google qui ne fait pas partie de la spécification HSTS.

Cet en-tête n’est appliqué que lorsque vous accédez au site en HTTPS. Si vous y accédez en HTTP, l’en-tête est ignoré. La raison est plutôt simple : HTTP est tellement non sécurisé que l’on ne peut pas lui faire confiance.

Utilisons à nouveau l’exemple Facebook pour illustrer à quel point c’est utile en pratique. Vous accédez à `facebook.com` pour la première fois et comme vous savez que le HTTPS est plus sûr que le HTTP, vous y accédez en HTTPS, [https://facebook.com](https://facebook.com). Lorsque votre navigateur reçoit le HTML, il reçoit l’en-tête ci-dessus qui indique à votre navigateur de vous rediriger automatiquement en HTTPS pour les requêtes futures. Un mois plus tard, quelqu’un vous envoie un lien vers Facebook en utilisant le HTTP, [http://facebook.com](http://facebook.com), et vous cliquez dessus. Étant donné qu’un mois est plus court que les 15552000 secondes spécifiées dans la directive `max-age`, votre navigateur enverra la requête en HTTPS, vous protégeant d’une éventuelle attaque de l’homme du milieu (MITM).

## En conclusion

La sécurité web est importante à n’importe quel moment de votre parcours dans le développement web. Plus tôt vous vous y exposez, meilleures seront vos chances de vous protéger. La sécurité est un sujet qui devrait être important pour tout le monde, et pas juste pour les personnes dont c’est le métier ! 👮

![](images/2018-08-15-une-introduction-rapide-a-la-securite-web/cops-are-looking-at-you.gif)

> Ce texte est une traduction de l’article [A quick introduction to web security](https://medium.freecodecamp.org/a-quick-introduction-to-web-security-f90beaf4dd41) avec l’aimable autorisation de son auteur [Augustin Tackaberry](https://medium.freecodecamp.org/@austintackaberry)
