---
title: Il est temps d’abandonner le “RTFM”
description: Qu'est-ce que le RTFM (Read The Fucking Manual) et pourquoi il faut tout faire pour ne plus l'utiliser
---

# Il est temps d’abandonner le “RTFM”

> Ce texte est une traduction de l’article _[It’s time to retire “RTFM”](https://medium.com/compassionate-coding/its-time-to-retire-rtfm-31acdfef654f)_ avec l’aimable autorisation de son auteure [April Wensel](https://medium.com/@Aprilw)

![Pourquoi parler à des humains quand vous pouvez passer des journées entières plongé dans ces manuels ?](images/2018-04-25-il-est-temps-dabandonner-le-rtfm/grosse-pile-de-livres.jpg)

La culture des développeurs et autres technologues est pourrie par un [élitisme toxique](https://blog.techinclusion.co/tech-has-a-toxic-tone-problem-lets-fix-it-37bb3517ab97). Une des manifestations de cet élitisme est l’hostilité permanente envers les personnes dites “non-techniques” ([une autre discrimination que l’on peut également abandonner](https://medium.com/compassionate-coding/if-you-can-use-a-fork-youre-technical-352e21d92c87)), les débutants, et finalement toute personne demandant de l’aide.

Si vous n’êtes pas convaincus, prenez le temps de naviguer quelques minutes sur le site populaire¹ de questions/réponses, [StackOverflow](https://medium.com/@Aprilw/suffering-on-stack-overflow-c46414a34a52)² ([assurez-vous de vous préparer émotionnellement avant](https://medium.com/@Aprilw/suffering-on-stack-overflow-c46414a34a52)).

Un exemple de cette hostilité est le célèbre acronyme “RTFM”. Si vous n’avez jamais entendu le terme RTFM, considérez-vous comme chanceux. Il signifie “Read the Fucking Manual”³ (_Lis le putain de manuel_).

Charmant, non ? Il est régulièrement utilisé pour répondre aux questions lorsque la personne qui répond est persuadée que la personne qui a posé la question aurait pu “facilement” trouver la réponse dans un manuel technique ou, plus généralement, en effectuant une recherche.

Lorsque vous utilisez le RTFM, vous dites : “Non seulement je ne vais pas t’aider, mais je vais m’assurer que tu ressentes de la honte face à ton impuissance à t’en sortir tout seul.”

**Si nous voulons créer des équipes plus efficaces et une industrie tech plus inclusive, nous devons abandonner le RTFM et son sentiment associé de notre culture.**

J’aimerais que cela soit évident pour tout le monde que cet acronyme est désagréable et contre-productif, mais lorsque [j’ai tweeté à ce sujet](https://twitter.com/compassioncode/status/901174707134709760), j’ai reçu certaines objections qui m’ont indiqué qu’une exploration plus en profondeur pourrait être utile.

[![](images/2018-04-25-il-est-temps-dabandonner-le-rtfm/twitter-compassionate-coding.png)](https://twitter.com/compassioncode/status/901174707134709760)

La bienveillance sera notre guide au fur et à mesure que nous soulevons les problèmes engendrés par le RTFM, les raisons pour lesquelles vous pourriez penser que vous avez besoin de l’utiliser, et ce que vous pouvez faire à la place pour créer une industrie tech plus inclusive et généreuse.

## Notes sur la terminologie

### Cela va plus loin que le RTFM

RTFM est l’un des exemples les plus manifestes d’hostilité envers les personnes qui demandent de l’aide, mais ce n’est clairement pas le seul. “Tu n’as qu’à chercher” et “Va sur Google” sont des exemples de variations plus polies mais néanmoins problématiques. Il y a également l’intégralité du site letmegooglethatforyou.com. Dans cet article, j’utiliserai RTFM comme raccourci pour toutes les variations de cette expression.

### La bienveillance n’est pas la politesse

J’ai indiqué plus haut que la bienveillance sera notre guide, je veux donc clarifier sa signification: **la bienveillance n’est pas la même chose que la politesse ou les bonnes manières; la bienveillance implique de comprendre la souffrance que nous avons en nous et chez les autres, et de tout faire pour la soulager**.

Une autre manière de se le représenter, est de s’imaginer que la bienveillance n’est qu’un simple problème d’optimisation : minimiser la souffrance. Si nous ne créons pas la technologie en faisant attention à minimiser la souffrance, à quoi bon ?

**La bienveillance demande souvent une communication sincère et directe, faire “semblant d’être gentil” ne représente donc pas cela.**

## Quel est donc le problème avec le RTFM?

### Problème n°1 : Il est dépourvu d’empathie.

Quand une personne vient vers vous avec une question, cet être humain expérimente une sorte de souffrance. Peut-être est-ce une souffrance importante sous la forme de frustration, confusion, ou peur. Peut-être est-ce une souffrance légère provenant du désir de satisfaire sa curiosité. Dans tous les cas, il y a un certain niveau de souffrance.

Le RTFM ne prend pas en compte cette souffrance. C’est donc une réponse plutôt impitoyable pour les personnes qui viennent vers vous et exposent leur vulnérabilité en posant une question.

### Problème n°2 : Il suppose une intention négative.

Quand une personne vous pose une question, comment pouvez-vous être certain que cette personne n’a pas déjà lu le manuel (ou tout autre documentation) ? Comment pouvez-vous savoir que cette personne n’a pas déjà effectué une recherche approfondie avant de se rapprocher de vous pour demander de l’aide ?

Vous pourriez dire : “Je sais que cette réponse peut être facilement trouvée sur le web, il n’y a donc aucune chance qu’elle ait fait cette recherche”. Que se passe-t’il si la documentation a changé depuis votre dernière visite, ou que la page web à laquelle vous pensez n’est plus disponible ?

De plus, comment pouvez-vous savoir que la personne sait elle-même ce qu’il faut rechercher ? Rappelez-vous que vous êtes une personne différente, avec une formation et des expériences différentes de cette personne.

Comme le soulevait Brittany Storoz dans [sa conférence sur la gestion des erreurs lors de Rocky Mountain Ruby](https://www.youtube.com/watch?v=9gSC0Dl50D4), **“Comprendre comment rechercher des informations sur Google est en fait vraiment difficile”**. Elle a pris comme exemple cette erreur provenant d’une application Ruby on Rails.

![undefined method posts for nil:NilClass](images/2018-04-25-il-est-temps-dabandonner-le-rtfm/undefined-method-posts.png)

Elle expliquait qu’il peut être difficile pour un développeur junior de savoir quelles parties sont pertinentes pour faire une recherche web, et quelles sont celles qui sont spécifiques à notre application.

Un jour un interne m’a demandé : “Comment puis-je récupérer tout le texte de ces pages web ?”. Pendant un instant, je me suis demandé : “Il y a une tonne d’infos sur les scrapers web en ligne. Pourquoi me pose-t’il une question aussi basique ?”. Est-ce que j’ai répondu par un “RTFM” ou un lien vers Let Me Google That For You ? Non !

Je lui ai demandé : “Est-ce qu’un scraper web pourrait t’être utile ?”

Et il m’a répondu : “Oh ! C’est donc comme ça que ça s’appelle ?”. Il a ensuite réussi à se débrouiller tout seul. Quand il est venu vers moi, il n’était pas fainéant; il ne savait simplement pas ce qu’il fallait rechercher. Peut-être aurait-il pu trouver la réponse à travers d’autres recherches, mais il lui a suffit d’un discussion de 2 minutes avec moi pour le mener dans la bonne direction.⁴

> Le RTFM part du principe que cette personne est motivée par la paresse ou même par un désir de vous faire perdre votre temps. Il ne laisse aucune place pour comprendre les véritables motivations de cette personne à venir vous demander de l’aide ou même ce qu’elle a essayé jusqu’à présent.

### Problème n°3: Il favorise la honte.

Le RTFM sous-entend que la personne aurait pu trouver la réponse sans même poser la question, et que par conséquent elle a brisé une convention sociale en demandant. Cela peut facilement susciter un sentiment de honte chez le demandeur.

La honte est un sentiment très douloureux; il est cruel de l’encourager sciemment chez les autres.

De plus, les émotions négatives telles que la honte sont distrayantes, et restreignent notre capacité créative à résoudre des problèmes.

### Problème n°4: Il décourage l’apprentissage.

L’usage du RTFM décourage l’apprentissage de plusieurs manières différentes.

Premièrement, cela donne peur à la personne qui veut poser une question. La peur peut l’empêcher de poser d’autres questions dans le futur, même des questions que vous trouveriez appropriées de demander. Etant donné que poser des questions est une excellente façon d’apprendre, votre utilisation du RTFM peut tout à fait entraver les capacités d’apprentissage de cette personne.

Deuxièmement, étant donné que vous ne prenez pas le temps de montrer à quelqu’un comment il peut bénéficier d’une lecture d’un manuel ou d’une recherche sur le web, cette personne ne s’améliorera pas dans cette compétence transverse de recherche non plus, ce qui signifie qu’elle continuera à ne pas s’en sortir dans le futur.

Enfin, cela vous prive de tout apprentissage également. Le RTFM coupe toute communication, ce qui vous empêche de réfléchir à d’éventuels manques dans votre documentation par exemple.

Cela vous prive également de toute opportunité d’expliquer un concept ou une méthode de recherche à quelqu’un, ce qui pourrait améliorer vos compétences d’éducation et de mentorat.

Comme [je l’ai déjà écrit précédemment](https://blog.techinclusion.co/tech-has-a-toxic-tone-problem-lets-fix-it-37bb3517ab97): “L’évidence ultime de la véritable maîtrise d’un concept est de pouvoir l’expliquer dans des termes assez simples pour être compris par une personne moins expérimentée”. Aider les autres vous aide à développer cette maîtrise.

### Problème n°5: Il est contreproductif.

Jusqu’il y a quelques années, j’avais intégré si profondément l’idée du “RTFM” que j’étais terrifiée à l’idée de demander de l’aide. Je pouvais passer des heures — voire des jours — à faire des recherches de mon côté pour résoudre un problème.

J’avais tellement peur de passer pour quelqu’un de faible que j’étais prête à tout faire pour éviter de devoir demander de l’aide. En tant que femme dans la tech, je me suis sentie particulièrement obligée de ne pas confirmer [les stéréotypes négatifs sur mon genre](https://xkcd.com/385/).

![Wow, t’es nul en math ! — Wow, les femmes sont toutes nulles en math !](images/2018-04-25-il-est-temps-dabandonner-le-rtfm/all-girls-suck-at-math.png)

Mon insistance obstinée à essayer de tout comprendre par moi-même était terriblement contreproductive ! Il y a eu tellement d’occasions, lorsque je débutais dans un nouveau boulot ou que j’essayais de terminer un tuto en ligne, où j’aurais gagné énormément de temps en demandant simplement de l’aide à une autre personne.

Comme l’écrit Marie Kondo dans son livre _[The Life-Changing Magic of Tidying Up](https://www.goodreads.com/book/show/22318578-the-life-changing-magic-of-tidying-up) :_

> “Il est bien plus rapide de demander une réponse à un professionnel, que de passer du temps à trouver la réponse soi-même dans un manuel.”

J’espère donc que nous pouvons créer des environnements où _tout le monde_ peut se sentir assez à l’aise pour demander de l’aide.

## OK, OK, mais qu’en est-il de... ?

Espérons qu’arrivés à ce stade, vous êtes prêts à admettre que l’usage du RTFM peut être néfaste. Mais vous continuez de penser qu’il peut être acceptable dans _certains_ cas. Faisons la liste des excuses les plus habituelles pour utiliser le RFTM, et les alternatives bienveillantes pour chaque.

### Défense n°1: “Les ingénieurs devraient pouvoir s’en sortir tout seuls.”

Peut-être utilisez-vous le RTFM car vous êtes persuadé que les ingénieurs doivent être capables de s’en sortir tout seuls. Après tout, vous arrivez à résoudre vos problèmes par vous-même, les autres devraient donc être capables d’en faire de même.

Cette position est consistante avec [ce message](https://twitter.com/JamesWidman/status/901269679355949057) tweeté en défense du RTFM (j’ai ajouté la mise en gras):

> “Les développeurs **doivent** apprendre...”
> “Votre _première_ demande **devrait** indiquer...”
> “Tout le monde **doit**...”

“Devoir” et “devrait” représente typiquement une déclaration biaisée et agressive. Comme l’indique Marshall Rosenberg dans _[Nonviolent Communication](https://www.goodreads.com/book/show/71730.Nonviolent_Communication)_, ces mots sont étroitement liés au sentiment de “culpabilité, devoir ou obligation”. L’utilisation de ces mots dans une justification est une raison suffisante pour la reconsidérer.

Si c’est votre justification pour utiliser le RTFM, posez-vous la question suivante : **_En quoi suis-je dans une position où je pourrais décider ce que les autres “devraient” faire ?_** Chaque personne est responsable de ses propres actions. Vos attentes vis-à-vis de la manière dont une personne devrait se comporter ne sont pas une justification suffisante pour répondre agressivement.

_L’alternative bienveillante_

Si votre unique motivation est de défendre votre idée de ce à quoi le monde “devrait” ressembler, alors vous pouvez envisager de ne rien répondre du tout à la personne qui pose une question. C’est particulièrement approprié si la question a été posée à un groupe de personnes. Vous n’êtes pas forcé d’imposer votre point de vue.

Si le silence n’est pas une option, **expliquez simplement que vous n’êtes pas la personne la plus qualifiée pour l’aider à résoudre son problème. C’est une réponse honnête, car votre attitude n’est clairement pas favorable à cette situation.**

Il est beaucoup plus bienveillant de ne rien dire ou admettre son incapacité à aider que de répondre par un “RTFM”, qui ne ferait que provoquer plus de souffrance à cette personne, qui se sentirait certainement rejetée et honteuse.

### Défense n°2: “Je veux que cet ingénieur développe sa capacité à résoudre les problèmes.”

Supposons maintenant que vous vous considérez comme un mentor pour cette personne, et pensez sincèrement qu‘il est dans son intérêt d’apprendre à rechercher l’information et résoudre ses problèmes de manière autonome.

Cette position est parfaitement illustrée par [cette réponse](https://twitter.com/kaoudis/status/901177775251312640) suite à la suggestion d’arrêter le RTFM:

> “la meilleure façon de savoir comment corriger quelque chose dans le futur c’est de le faire soi-même, pas que l’on nous dise comment le faire :/“

Cette défense du RTFM est l’exemple type d’un pseudo-dilemme (c’est-à-dire qu’il n’y a que deux options) : une certaine version du RTFM, et que l’on nous explique comment corriger quelque chose.

Fort heureusement, ce n’est pas le cas !

**Je suis entièrement d’accord que la capacité à résoudre des problèmes par soi-même est une chose très importante, et en tant que mentor vous êtes dans une excellente position pour aider un mentoré à développer cette compétence.**

Fondamentalement, chaque personne est motivée par le désir d’éviter de souffrir. Si une personne vient chercher de l’aide auprès de vous, elle espère clairement que cela conduira à moins de souffrance que de continuer à travailler sur le problème tout seule.

Une option possible est d’arriver à convaincre la personne que vous demander de l’aide est tellement pénible qu’elle tentera absolument tout, y compris la poursuite inutile de recherches dans son coin. Vous pouvez y arriver avec le “RTFM” ou n’importe laquelle de ses variations, ce qui conduira la personne à ressentir une honte extrême d’avoir posé une question.

_L’alternative bienveillante_

**Elle consiste à rendre le processus de recherche de résolution du problème par soi-même moins pénible.** La meilleur façon d’y arriver est d’aider cette personne à développer des compétences pertinentes.

Vous pourriez protester : “C’est pourtant ce que je fais en disant RTFM !”. Néanmoins, réfléchissez à la manière dont les professeurs enseignent aux élèves de nouvelles compétences.

> Est-ce qu’un professeur répond aux question avec un “Lis ton p\*\*\*ain de manuel” ? J’ose espérer que non.

**Au lieu de laisser cette personne se démener toute seule à apprendre comment améliorer ses capacités de recherche et de résolution de problèmes, pourquoi ne pas lui expliquer le raisonnement directement ?** “Je comprends que tu sois frustré par ce problème. Je ne souhaite pas te donner la réponse directement parce que je me suis rendu compte que les gens apprennent mieux lorsqu’ils arrivent à résoudre leurs problèmes par eux-mêmes. Dans ce cas précis, si j’étais toi, je commencerais peut-être par aller voir la documentation de X. Je tenterais peut-être aussi une recherche sur le terme Y.”

Vous pouvez également demander :

> “Qu’as-tu essayé jusqu’à présent ?”
> “As-tu pensé à X ?”
> “Qu’y a-t’il d’écrit dans les docs sur Y ?”

Vous voyez la différence ? Vous fournissez des pistes pour aider la personne à développer des compétences qui lui permettront plus tard de résoudre ses problèmes de façon autonome et moins laborieuse, sans utiliser la grossièreté ou la manipulation.

### Défense n°3 : “Ce n’est pas mon boulot d’aider cette personne.”

vous pouvez penser que ce n’est pas votre boulot d’aider la personne qui vous pose une question. Dans ce cas, le RTFM vous semble tout à fait approprié.

_L’alternative bienveillante_

Votre responsabilité envers une personne dépend de votre relation avec cette personne et votre système de valeurs.

Si cette personne est un collègue, alors il semble plutôt raisonnable de penser qu’aider cette personne fait partie de votre job. Considérons le point soulevé par Ron Jeffries dans _[The Nature of Software Development](https://www.goodreads.com/book/show/23016056-the-nature-of-software-development)_ :

> “Un expert très bien payé ne devrait pas être très bien payé simplement parce que c’est un expert. Il devrait être très bien payé parce qu’il aide les autres à devenir des experts.”

**Mentorer et aider font partie intégrante de votre job.** De plus, des sessions de partage de connaissances en face à face peuvent être un moyen remarquable pour améliorer la cohésion d’équipe. Considérez les étapes de l’alternative bienveillante détaillées dans la défense n°2.

Que se passe-t’il si la personne n’est pas un collègue ? C’est peut-être quelqu’un dans une salle de discussion ou une autre communauté. Dans ce cas, votre responsabilité pour aider cette personne dépend de vos propres valeurs. Trouvez-vous important de créer une industrie tech bienveillante et inclusive qui accueille les nouveaux venus ? Si c’est le cas, alors peut-être que votre système de valeurs va vous amener à aider cette personne, et vous pourrez en tirer également avantage en suivant les étapes de l’alternative bienveillante de la défense n°2.

Si vous restez fidèle à vos valeurs et continuez d’affirmer que ce n’est pas votre boulot d’aider cette personne, le RTFM ne constitue toujours pas une réponse appropriée. Tout comme dans la défense n°1, l’alternative bienveillante est de ne pas répondre, ou d’expliquer que vous n’êtes pas la personne appropriée pour aider.

### Défense n°4 : “La personne ne montre pas assez d’empathie”

Vous pourriez être persuadé que certaines questions démontrent un manque d’empathie de la part de la personne qui les pose. Par exemple, vous pouvez être amené à penser que cette personne ne respecte pas votre temps si précieux.

Pour certaines raisons, il existe un parti pris vers la protection des membres les plus seniors de la communauté tech, “l’élite”. Je vois régulièrement des références à “[How To Ask Questions The Smart Way](http://www.catb.org/esr/faqs/smart-questions.html)”, un document rempli d’un langage humiliant qui partage des exemples de “questions stupides”, de justifications pour avoir un comportement désagréable, et donne le sentiment que “le RTFM est justifié lorsque vous répondez à quelqu’un qui n’est qu’un gros fainéant…”

Un article récent, soi-disant à propos de “[Engineering Empathy](https://bravenewgeek.com/engineering-empathy/)”, fait référence à cet article et ajoute :

> Ma première bête noire, ce sont les “Help Vampires”. Ce sont des personnes qui refusent de prendre le temps de poser des questions cohérentes et spécifiques et souhaitent que quelqu’un d’autre fasse le boulot à leur place plutôt qu’on réponde à leurs questions. Ils posent encore et encore les mêmes questions fatigantes, et ce sans jamais vraiment retenir la moindre information ou avoir une once d’esprit critique. C’est question, réponse, question, réponse, question, réponse, à l’infini.

> C’est souvent une leçon difficilement acquise par les ingénieurs débutants, mais elle est importante : lorsque vous posez une question, vous ne gagnez pas le droit d’avoir une réponse, vous devez la mériter. Des questions posées à la va-vite recevront des réponses à la va-vite. En tant qu’ingénieur, nous ne devrions pas opérer comme une assistance téléphonique que Mémé appelle lorsque sa connexion internet cesse de fonctionner. Nous devons fournir un niveau d’effort plus important. En tant qu’ingénieurs, nous devons appliquer nos capacités techniques et notre aptitude à la résolution de problèmes.

Analysons tout cela. **Traiter des gens de “vampires” n’est pas la meilleur façon de construire de l’empathie.** Cette attitude implique une intention négative. Des mots tels que “devrait” ou “devoir” sont des rappels de la défense n°1.

Je ne peux inclure cette citation sans indiquer que le fait d’utiliser “Mémé” pour représenter une personne qui n’est pas à l’aise avec la technologie indique un sérieux manque d’empathie pour les femmes et les aînés, ce qui est particulièrement alarmant dans une industrie en proie au sexisme et au jeunisme.

J’ai de la compassion pour les technologues qui souhaiteraient ressentir plus d’empathie envers les personnes qui demandent de l’aide. Ce sont des êtres humains qui veulent être respectés. Ils méritent tout autant d’empathie que les personnes qui demandent de l’aide.

Néanmoins, la méchanceté n’est toujours pas une réponse appropriée.

_L’alternative bienveillante_

Tout d’abord, il peut être utile de considérer la dynamique des pouvoirs en place.

> Bien qu’il soit important de montrer de l’empathie à tout le monde, lorsqu’une personne demande de l’aide, elle est pratiquement tout le temps dans une position d’infériorité. Cette personne peut être moins expérimentée, ou nouvellement arrivée dans la société, ou encore sans emploi. Elle est donc très souvent dans une position plus vulnérable. De ce fait, \*\*bien qu’il soit important pour cette personne d’avoir de l’empathie envers le répondant, il est au minimum aussi important que ce dernier, qui a plus de pouvoir et souvent plus de liberté, fasse preuve d’empathie envers cette personne.

Néanmoins, cela ne signifie pas non plus que l’on doit tolérer un comportement qui pourrait être irrespectueux. Sur une communauté Slack, j’ai aidé une fois une inconnue sur une question Ruby car elle semblait désespérée et j’avais un peu de temps devant moi. Elle a ensuite commencé à me poser plein de questions, et je me suis rendu compte qu’il n’était pas réaliste pour moi de poursuivre cette relation. Je lui ai donc simplement dit : “Je n’ai pas le temps nécessaire actuellement, mais voici des communautés où tu pourras trouver de l’aide.”

Je connaissais mes limites et j’ai donc instauré ces limites, clairement mais avec bienveillance.

Je me rends compte que j‘ai besoin de faire cela régulièrement. Je fais beaucoup de mentoring pro bono pour les femmes, des personnes d’autres groupes sous-représentés dans la tech, ou encore ayant de gros problèmes financiers. Je ne réprimande pas les gens qui me demandent de l’aide; je fixe juste des limites sur quand et combien de fois je peux les aider afin de ne pas tomber dans le surmenage.

Il arrive parfois que des personnes qui maintiennent des projets open source ou répondent aux questions sur Stack Overflow utilisent le fait d’être bénévoles pour excuser un comportement inapproprié.

Il est important de se rappeler que nous somme toujours maîtres de nos choix. **Si vous ne pouvez pas cacher votre animosité lorsque vous faites du bénévolat, rappelez-vous que vous pouvez toujours arrêter de faire du bénévolat, ou instaurer clairement et calmement certaines limites.**

Le RTFM n’est pas du tout une façon d’indiquer ces limites, et rabaisser les gens en les traitant de “vampires” encore moins.

Instaurer des limites pourrait plutôt ressembler à :

> “Je suis volontaire pour donner de mon temps ici, et pour que je me sente à l’aise avec cela, je dois comprendre que vous avez passé un certain nombre de temps à essayer de résoudre le problème par vous-même.”

De cette manière, vous instaurez des limites sans être désagréable ou en sous-entendant que vos préférences font loi.

S’il existe des règles communautaires, vous pouvez également les partager de façon bienveillante. “Comme indiqué sur cette page, notre communauté attend que les questions comprennent X, Y et Z. Pourriez-vous les ajouter ?”

**Instaurer des limites est quelque chose d’important pour votre propre bien-être. Cela vous évitera de faire un burn out, et vous aidera également à adopter un comportement plus compatissant envers les autres.**

Et même s’il existe des personnes avec de mauvaises intentions qui tenteront de vous faire travailler à leur place, comme le conseille Derek Sivers dans [Anything You Want](https://www.goodreads.com/book/show/11878168-anything-you-want) :

> Résistez à l’envie de punir tout le monde pour l’erreur d’une seule personne.

Ce n’est pas parce qu’une personne — ou même plusieurs personnes — tente de tirer avantage de votre aide que cela signifie que vous devez faire le choix de traiter tout le monde de façon offensante.

### Une dernière demande

Lorsque quelqu’un vient vous poser une question que vous considérez comme “stupide” ou “fainéante”, arrêtez-vous quelques instants et demandez-vous ce que cette personne peut ressentir — et ce que vous ressentez actuellement.

**Plutôt que de répondre avec une version quelconque du RTFM — une expression qui manque d’empathie, suppose une intention négative, encourage la honte, empêche l’apprentissage et contribue à l’inefficacité — considérez plutôt ces alternatives plus bienveillantes :**

1. Le silence
1. Instaurer clairement des limites
1. Poser des questions complémentaires

Tout comme Ryan Holiday l’écrit dans _[The Obstacle is the Way](https://www.goodreads.com/book/show/18668059-the-obstacle-is-the-way)_ :

> Aucune rudesse, aucune privation, aucun travail ne devrait interférer avec notre empathie envers les autres. La compassion est toujours une option.

**C’est en opérant de petits changements tels que ne plus utiliser le RTFM que nous pouvons tous contribuer à créer une communauté tech plus bienveillante, accueillante et fertile.**

### Notes de bas de page

1. Tout du moins chez les [hommes blancs](https://insights.stackoverflow.com/survey/2018/#demographics).
1. Techniquement, la communauté StackOverflow [décourage l’utilisation du RTFM](https://meta.stackexchange.com/questions/23628/how-should-we-deal-with-rtfm-comments); néanmoins, vous noterez que leur page “Demander de l’aide” comprend un lien vers [ce document](https://stackoverflow.com/help/how-to-ask), qui encourage le RTFM. De même, et comme discuté dans cet article, cela fait partie d’une pratique plus générale d’humiliation qui arrive fréquemment sur StackOverflow.
1. Oui, il existe des [alternatives plus indulgentes](https://en.wikipedia.org/wiki/RTFM).
1. Je n’endosse aucune responsabilité pour ce qu’il a réalisé grâce à ces connaissances. :-P
