---
title: Les 10 erreurs les plus fréquentes que j'ai rencontrées sur des projets Go
description: Cet article représente mon top 10 des erreurs les plus fréquemment rencontrées sur mes projets Go
published_at: 2019-12-26 10:00:00
image: https://blog.otso.fr/images/2019-12-26-top-10-erreurs-communes-projets-golang/facepalm.jpg
---

# Les 10 erreurs les plus fréquentes que j'ai rencontrées sur des projets Go

> Ce texte est une traduction de l’article [The Top 10 Most Common Mistakes I’ve Seen in Go Projects](https://itnext.io/the-top-10-most-common-mistakes-ive-seen-in-go-projects-4b79d4f6cd65) avec l’aimable autorisation de son auteur [Teiva Harsanyi](https://twitter.com/teivah)

![Credit: teachertoolkit.co.uk](images/2019-12-26-top-10-erreurs-communes-projets-golang/facepalm.jpg)

Cet article représente mon top 10 des erreurs les plus fréquemment rencontrées sur mes projets Go. L'ordre n'a pas d'importance.

## Valeur d'Enum inconnue

Jetons un oeil à cet exemple très simple :

```go
type Status uint32

const (
    StatusOpen Status = iota
    StatusClosed
    StatusUnknown
)
```

Nous avons créé ici un Enum utilisant `iota` qui se traduit par le résultat suivant :

    StatusOpen = 0
    StatusClosed = 1
    StatusUnknown = 2

Imaginons désormais que ce type de statut fait partie d'une requête JSON qui sera marshalled/unmarshalled. On peut créer la structure suivante :

```go
type Request struct {
    ID        int    `json:"Id"`
    Timestamp int    `json:"Timestamp"`
    Status    Status `json:"Status"`
}
```

Et ensuite recevoir des requêtes comme ceci :

```json
{
  "Id": 1234,
  "Timestamp": 1563362390,
  "Status": 0
}
```

Rien de bien spécial ici, le statut sera converti en `StatusOpen` n'est-ce pas ?

Prenons maintenant une autre requête dans laquelle le statut n'est pas renseigné (quelle qu'en soit la raison) :

```json
{
  "Id": 1235,
  "Timestamp": 1563362390
}
```

Dans ce cas, le champ statut de la structure `Request` sera intialisé à sa **valeur zéro** (pour un type uint32 : 0). Dans le cas présent, `StatusOpen` sera donc utilisé au lieu de `StatusUnknown`.

La bonne pratique est donc de fixer la valeur inconnue d'un Enum à 0 :

```go
type Status uint32

const (
    StatusUnknown Status = iota
    StatusOpen
    StatusClosed
)
```

Cette fois, si le statut ne fait pas partie de la requête JSON, il sera initialisé à `StatusUnknown` comme on pourrait s'y attendre.

## Le benchmarking

Réaliser un benchmark de la bonne façon est difficile. Il y a beaucoup de facteurs qui peuvent impacter un résultat donné.

Une des erreurs les plus fréquentes est de se faire avoir par une pseudo-optimisation du compilateur. Prenons un exemple concret de la bibliothèque [_teivah/bitvector_](https://github.com/teivah/bitvector/) :

```go
func clear(n uint64, i, j uint8) uint64 {
    return (math.MaxUint64<<j | ((1 << i) - 1)) & n
}
```

Cette fonction supprime les bits dans une plage donnée. On pourrait en faire un benchmark de la façon suivante :

```go
func BenchmarkWrong(b *testing.B) {
    for i := 0; i < b.N; i++ {
        clear(1221892080809121, 10, 63)
    }
}
```

Dans ce benchmark, le compilateur va détecter que `clear` est une fonction orpheline (qui n'est pas appelée par une autre fonction), il va donc la rendre **inline**. Une fois inline, il va également détecter qu'il n'y a pas **d'effets de bord**. L'appel à la fonction `clear` sera donc tout simplement supprimé, menant à des résultats inexacts.

La solution peut être de déclarer le résultat dans une variable globale comme ceci :

```go
var result uint64

func BenchmarkCorrect(b *testing.B) {
    var r uint64
    for i := 0; i < b.N; i++ {
        r = clear(1221892080809121, 10, 63)
    }
    result = r
}
```

Dans ce cas, le compilateur ne pourra pas déterminer si l'appel à la fonction produit un effet de bord ou pas, menant à un benchmark plus précis.

### En savoir plus

- [Watch out for compiler optimisations](https://dave.cheney.net/high-performance-go-workshop/dotgo-paris.html#watch_out_for_compiler_optimisations)

## Des pointeurs ! Des pointeurs partout !

Transmettre une variable par valeur va créer une copie de cette variable. Alors que la transmettre avec un pointeur renverra simplement une copie de son adresse dans la mémoire.

Logiquement, passer un pointeur sera toujours **plus rapide**, n'est-ce pas ?

Si vous en êtes persuadés, jetez un oeil à [cet example](https://gist.github.com/teivah/a32a8e9039314a48f03538f3f9535537). C'est un benchmark d'une structure de données de 0.3kb que nous passons d'abord par référence, et ensuite par valeur. 0.3kb ne représente pas une taille très importante mais ne devrait pas être trop éloignée du type de structure de données que l'on rentre chaque jour (pour la majorité d'entre nous).

Lorsque j'exécute ces benchmarks sur mon environnement local, passer par valeur est plus de **4 fois plus rapide** que passer par pointeur. Cela peut sembler quelque peu contre-intuitif, n'est-ce pas ?

L'explication de ce résultat est liée à la manière dont la mémoire est gérée dans Go. Je ne pourrais pas l'expliquer aussi brillament que [William Kennedy](https://www.ardanlabs.com/blog/2017/05/language-mechanics-on-stacks-and-pointers.html) mais essayons d'en faire un résumé.

Une variable peut être allouée sur le **tas** (_heap_) ou la **pile** (_stack_). Voici un exemple très simple :

- La pile contient les variable **entrantes** pour une **goroutine** donnée. Une fois la fonction terminée, les variables sont retirées de la pile.
- Le tas regroupe les variables **partagées** (variables globales, etc.).

Prenons cet exemple très simple où nous retournons une valeur :

```go
func getFooValue() foo {
    var result foo
    // Do something
    return result
}
```

Dans le cas présent, une variable `result` est créée par la goroutine courante. La variable est ajoutée à la stack existante. Une fois que la fonction se termine, le client reçoit une copie de cette variable. La variable elle-même est retirée de la pile. Elle existe toujours en mémoire jusqu'à ce qu'elle soit supprimée par une autre variable, mais **on ne peut plus y accéder**.

Voici désormais le même exemple, mais avec un pointeur :

```go
func getFooPointer() *foo {
    var result foo
    // Do something
    return &result
}
```

La variable `result` est toujours créée par la goroutine courante, mais le client va recevoir un pointeur (une copie de l'adresse de la variable). Si la variable `result` était retirée de la pile, le client de cette fonction **ne pourrait plus y accéder**.

Dans ce scénario, le compilateur Go va **sauvegarder** la variable `result` dans un endroit où les variables peuvent être partagées : **le tas** (_heap_)

Passer par des pointeurs représente néanmoins un autre scénario. Par exemple :

```go
func main()  {
  p := &foo{}
  f(p)
}
```

Etant donné que l'on appelle `f` dans la même goroutine, la variable `p` n'a pas besoin d'être sauvegardée. Elle est simplement ajoutée à la pile et la sous-fonction peut y accéder.

Nous pouvons prendre en exemple la méthode `Read` de `io.Reader` qui reçoit un slice au lieu d'en retourner un. Retourner un slice (qui est un pointeur) l'aurait sauvegardé dans le tas.

Pourquoi est-ce que la pile est si **rapide** alors ? Il y a deux raisons principales à cela :

- Il n'y a pas besoin d'un **garbage collector** dans la pile. Comme nous le disions, une variable est simplement ajoutée lorsqu'elle est créée, pour être ensuite retirée une fois que la fonction se termine. Il n'y a donc pas besoin d'un processus complexe de gestion de variables inutilisées, etc.
- Une pile appartient à une seule goroutine, il n'y a donc pas lieu de **synchroniser** une variable pour la stocker, au contraire du tas. Cela se traduit donc par un gain de performance.

En conclusion, lorsque nous créons une fonction, nous devrions utiliser par défaut **des valeurs à la place de pointeurs**. Un pointeur ne devrait être utilisé que si nous voulons **partager** une variable.

Dans le cas où nous rencontrons des problèmes de performance, une optimisation possible est de vérifier si un pointeur pourrait nous aider ou pas dans certaines situations bien spécifiques. Il est possible de savoir quand le compilateur va sauvegarder une variable dans le tas en utilisant la commande suivante : `go build -gcflags "-m -m"`.

Mais ne perdez pas de vue que les valeurs sont généralement le meilleur choix dans la majorité des cas d'utilisation du quotidien.

### En savoir plus

- [Language Mechanics On Stacks And Pointers](https://www.ardanlabs.com/blog/2017/05/language-mechanics-on-stacks-and-pointers.html)
- [Understanding Allocations: the Stack and the Heap](https://www.youtube.com/watch?v=ZMZpH4yT7M0)

## Sortir d'un for/switch ou d'un for/select

Que se passe-t-il dans l'exemple ci-dessous si `f` renvoie `true` ?

```go

for {
  switch f() {
  case true:
    break
  case false:
    // Do something
  }
}
```

Lorsque nous appelons le `break`, celui-ci nous sortira uniquement du `switch` et **pas de la boucle for**.

C'est le même problème avec :

```go
for {
  select {
  case <-ch:
  // Do something
  case <-ctx.Done():
    break
  }
}
```

Le `break` est lié au `select` et non à la boucle `for`.

Une solution possible pour sortir d'un `for/switch` ou d'un `for/select` est d'utiliser un **break nommé** comme ceci :

```go
loop:
    for {
        select {
        case <-ch:
        // Do something
        case <-ctx.Done():
            break loop
        }
    }
```

## La gestion des erreurs

Go est encore un peu jeune dans sa façon de gérer les erreurs. Ce n'est donc pas une coïncidence si c'est une des fonctionnalités les plus attendues de Go 2.

La bibliothèque standard actuelle (avant Go 1.13) offre seulement des fonctions pour construire des erreurs, c'est pourquoi vous aurez probablement envie de jeter un oeil à [_pkg/errors_](https://github.com/pkg/errors) (si ce n'est pas déjà fait).

Cette bibliothèque est une bonne manière de respecter la règle d'or suivante qui n'est pas toujours suivie :

> Une erreur ne devrait être gérée qu'**une seule fois**. Logger une erreur **est** une façon de gérer une erreur. Une erreur devrait donc soit être loggée, soit être propagée.

Avec la biliothèque standard actuelle, il est difficile de respecter cela car nous voulons ajouter un peu de contexte à une erreur et avoir une forme d'hiérarchie.

Regardons un exemple de ce que nous pourrions attendre d'un appel à un endpoint REST qui mène à une erreur de base de données :

```
unable to serve HTTP POST request for customer 1234
    |_ unable to insert customer contract abcd
        |_ unable to commit transaction
```

Si nous utilisons _pkg/errors_, nous pouvons le faire de cette manière :

```go
func postHandler(customer Customer) Status {
    err := insert(customer.Contract)
    if err != nil {
        log.WithError(err).Errorf("unable to serve HTTP POST request for customer %s", customer.ID)
        return Status{ok: false}
    }
    return Status{ok: true}
}

func insert(contract Contract) error {
    err := dbQuery(contract)
    if err != nil {
        return errors.Wrapf(err, "unable to insert customer contract %s", contract.ID)
    }
    return nil
}

func dbQuery(contract Contract) error {
    // Do something then fail
    return errors.New("unable to commit transaction")
}
```

L'erreur initiale (si elle n'est pas retournée par une bibilothèque externe) peut être créée avec `errors.New`. La couche intermédiaire, `insert`, enveloppe cette erreur en y ajoutant plus de contexte. Finalement, le parent gère l'erreur en la loggant. Chaque niveau retourne ou gère donc l'erreur.

Nous pourrions également vouloir vérifier la cause de l'erreur elle-même afin de renouveler l'action par exemple. Partons du principe que nous utilisons un paquet `db` d'une bibliothèque externe gérant les accès à la base de données. Cette bilbiothèque pourrait retourner une erreure transitoire (temporaire) appelée `db.DBError`. Pour déterminer si l'on doit retenter l'action ou pas, nous devons vérifier la cause de l'erreur :

```go
func postHandler(customer Customer) Status {
    err := insert(customer.Contract)
    if err != nil {
        switch errors.Cause(err).(type) {
        default:
            log.WithError(err).Errorf("unable to serve HTTP POST request for customer %s", customer.ID)
            return Status{ok: false}
        case *db.DBError:
            return retry(customer)
        }

    }
    return Status{ok: true}
}

func insert(contract Contract) error {
    err := db.dbQuery(contract)
    if err != nil {
        return errors.Wrapf(err, "unable to insert customer contract %s", contract.ID)
    }
    return nil
}
```

Nous pouvons le faire en utilisant `errors.Cause` qui est également intégré à _pkg/errors_.

Une erreur courante que je rencontre est de n'utiliser _pkg/errors_ que partiellement. Vérifier une erreur est par exemple effectué de la manière suivante :

```go
switch err.(type) {
  default:
    log.WithError(err).Errorf("unable to serve HTTP POST request for customer %s", customer.ID)
    return Status{ok: false}
  case *db.DBError:
    return retry(customer)
}
```

Dans cet exemple, si `db.DBError` est enveloppé, cela ne relancera jamais la nouvelle tentative.

### En savoir plus

- [Don't just check errors, handle them gracefully](https://dave.cheney.net/2016/04/27/dont-just-check-errors-handle-them-gracefully)

## Initialisation d'un slice

Parfois, nous savons par avance quelle sera la taille finale d'un slice. Par exemple, dans le cas où nous souhaitons convertir un slice de `Foo` vers un slice de `Bar`, ce qui implique qu'ils auront tous deux la même taille.

Je vois régulièrement des slices initialisés de la façon suivante :

```go
var bars []Bar
bars := make([]Bar, 0)
```

Un slice n'est pas une structure magique. Sous le capot, il implémente une stratégie de **croissance** s'il n'y a plus assez d'espace disponible. Dans ce cas, un nouveau tableau est créé automatiquement (avec une [capacité plus grande](https://www.darkcoding.net/software/go-how-slices-grow/)) et tous les éléments sont recopiés.

Imaginons maintenant que nous devons répéter cette opération de croissance à de multiples reprises car que notre `[]Foo` contient des centaines d'éléments ? La complexité d'un ajout restera la même - O(1) - mais en pratique cela aura un **impact sur les performances**.

Par conséquent, si nous connaissons la taille finale, nous pouvons :

- Soit initaliser avec une taille prédéfinie :

```go
func convert(foos []Foo) []Bar {
    bars := make([]Bar, len(foos))
    for i, foo := range foos {
        bars[i] = fooToBar(foo)
    }
    return bars
}
```

- Soit initialiser avec une taille nulle et une capacité prédéfinie :

```go 
func convert(foos []Foo) []Bar {
    bars := make([]Bar, 0, len(foos))
    for _, foo := range foos {
        bars = append(bars, fooToBar(foo))
    }
    return bars
}
```

Quelle est la meilleure option ? La première est légèrement plus rapide, mais vous pourriez préférer la seconde car elle rend les choses plus consistantes : que l'on connaisse ou pas la taille initiale, l'ajout d'un élément à la fin du slice se fera avec la fonction `append`.

## La gestion du contexte

`context.Context` est régulièrement mal compris par les développeurs. Suivant la documentation officielle :

> Un Context transporte une deadline, un signal d'annulation et d'autres valeurs à travers l'API.

Cette description est assez générique pour que certaines personnes soient un peu perplexes sur le pourquoi et le comment il doit être utilisé.

Essayons de le détailler un peu. Un contexte peut transporter :

- Une **deadline**. Cela représente soit une durée (p. ex. 250 ms) soit une date-time (p. ex. 2019-01-08 01:00:00) qui, si elle est atteinte, doit annuler une activité en cours (une requête entrée/sortie, l'attente du retour d'un channel, etc.)
- Un **signal d'annulation** (fondamentalement un `<-chan struct{}`). Le comportement ici est similaire. Une fois que nous avons reçu le sigal, nous devons stopper une activité en cours. Par exemple, imaginons que nous recevions deux requêtes. Une pour insérer des données, et une autre pour annuler la première requête (car elle n'est plus pertinente par exemple). Cela peut être mis en place en utilisant un contexte annulabe dans le premier appel, qui serait ensuite annulé une fois que nous recevons la deuxième requête.
- Une liste de clé/valeur (basées toutes deux sur un type `interface{}`).

Il y a deux choses à ajouter : premièrement, un contexte est **composable**. Nous pouvons donc, par exemple, avoir un contexte qui transporte une deadline mais également une liste de clé/valeur. De plus, plusieurs goroutines peuvent **partager** le même contexte, ce qui signifie qu'une annulation peut potentiellement stopper **plusieurs activités**.

Pour en revenir à notre sujet, voici une erreur concrète que j'ai pu rencontrer.

Une application Go était basée sur [_urfave/cli_](https://github.com/urfave/cli) (si vous ne connaissez pas, c'est une chouette biliothèque qui permet de créer des applications en ligne de commande en Go). Une fois lancé, le développeur _hérite_ d'une sorte de contexte d'application. Cela signifie que si l'application s'arrête, la bibliothèque utilisera le contexte pour envoyer un signal d'annulation.

Dans cet exemple, le-dit contexte était passé directement en appelant un endpoint gRPC. Ce n'est **pas** ce que nous voulons faire.

A la place, nous voulons indiquer à la bibliothèque gRPC : _Merci d'annuler cette requête si l'application est en cours d'arrêt ou après 100 ms par exemple_.

Pour y parvenir, nous pouvons simplement créer un contexte composé. Si `parent` est le nom du contexte d'application (créé par _urfave/cli_), nous pouvons simplement faire ceci :

```go
ctx, cancel := context.WithTimeout(parent, 100 * time.Millisecond)
response, err := grpcClient.Send(ctx, request)
```

Les contextes ne sont pas si complexes à comprendre et c'est une des meilleures fonctionnalités du langage à mon avis.

### En savoir plus

- [Understanding the context package in golang](http://p.agnihotry.com/post/understanding_the_context_package_in_golang/)
- [gRPC and Deadlines](https://grpc.io/blog/deadlines/)

## Ne pas utiliser l'option -race

Une erreur que je rencontre régulièrement est de tester une application Go sans l'option `-race`.

Comme le décrit ce [compte rendu](https://blog.acolyer.org/2019/05/17/understanding-real-world-concurrency-bugs-in-go/), et bien que Go ait été _"conçu pour rendre la programmation concurrente plus simple et moins sujette aux erreurs"_, nous continuons de rencontrer de nombreux problèmes relatifs à la concurrence.

Il est évident que le détecteur de race condition de Go ne détectera pas tous les problèmes de concurrence. C'est néanmoins un outil **précieux** que nous devrions toujours activer lorsque nous testons notre application.

### En savoir plus

- [Does the Go race detector catch all data race bugs?](https://medium.com/@val_deleplace/does-the-race-detector-catch-all-data-races-1afed51d57fb)

## Utiliser un nom de fichier en entrée

Une autre erreur communément faite est de passer un nom de fichier dans une fonction.

Disons que nous souhaitons implémenter une fonction pour compter le nombre de lignes vides dans un fichier. L'implémentation la plus naturelle pourrait ressembler à ceci :

```go
func count(filename string) (int, error) {
    file, err := os.Open(filename)
    if err != nil {
        return 0, errors.Wrapf(err, "unable to open %s", filename)
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    count := 0
    for scanner.Scan() {
        if scanner.Text() == "" {
            count++
        }
    }
    return count, nil
}
```

Le nom de fichier est reçu en entrée, nous pouvons donc l'ouvrir et implémenter notre logique, n'est-ce pas ?

Ensuite, nous souhaitons implémenter des **tests unitaires** pour cette fonction pour tester avec un fichier normal, un fichier vide, un fichier avec un encodage différent, etc. Cela peut rapidement devenir difficile à gérer.

De même, si nous voulons réutiliser la même logique pour le contenu d'un appel HTTP, par exemple, nous devrons créer une nouvelle fonction pour cela.

Go est livré avec deux abstractions très pratiques : `io.Reader` et `io.Writer`. Au lieu de transmettre un nom de fichier, nous pouvons simplement passer un `io.Reader` qui pourra **abstraire** la source des données.

Est-ce un fichier ? Le contenu d'un appel HTTP ? Un buffer ? Ce n'est désormais plus important car nous utiliserons toujours la même méthode `Read`.

Das notre cas, nous pouvons même utiliser la mémoire tampon pour lire le contenu ligne par ligne. De fait, nous pouvons utiliser `bufio.Reader` et sa méthode `ReadLine` :

```go
func count(reader *bufio.Reader) (int, error) {
    count := 0
    for {
        line, _, err := reader.ReadLine()
        if err != nil {
            switch err {
            default:
                return 0, errors.Wrapf(err, "unable to read")
            case io.EOF:
                return count, nil
            }
        }
        if len(line) == 0 {
            count++
        }
    }
}
```

La responsabilité de l'ouverture du fichier lui-même est désormais déléguée à la fonction parente :

```go
file, err := os.Open(filename)
if err != nil {
  return errors.Wrapf(err, "unable to open %s", filename)
}
defer file.Close()
count, err := count(bufio.NewReader(file))
```

Grâce à cette seconde implémentation, la fonction peut être appelée **quelle que soit** la source des données. Cela **facilite** donc grandement nos tests unitaires car nous pouvons simplement créer un `bufio.Reader` à partir d'une chaine de caractères :

```go
count, err := count(bufio.NewReader(strings.NewReader("input")))
```

## Les Goroutines et les variables de boucles

La dernière erreur que je recontre régulièrement est d'utiliser des goroutines avec des variables de boucles.

Quelle est la sortie de l'exemple suivant ?

```go
ints := []int{1, 2, 3}
for _, i := range ints {
  go func() {
    fmt.Printf("%v\n", i)
  }()
}
```

`1 2 3` dans n'importe quel ordre ? Non !

Dans cet exemple, chaque goroutine **partage** la même instance de variable, cela produira (probablement) donc `3 3 3`.

Il y a deux manières de gérer ce problème. La première est de passer la valeur de la variable `i` dans la closure (la fonction interne) :

```go
ints := []int{1, 2, 3}
for _, i := range ints {
  go func(i int) {
    fmt.Printf("%v\n", i)
  }(i)
}
```

La seconde est de créer une autre variable à l'intérieur du scope de la boucle for :

```go
ints := []int{1, 2, 3}
for _, i := range ints {
  i := i
  go func() {
    fmt.Printf("%v\n", i)
  }()
}
```

Cela peut sembler contre-intuitif d'utiliser `i := i` mais c'est quelque chose de tout à fait valide. La boucle représente un scope différent. `i := i` crée donc une nouvelle instance de variable appelée `i`. Il est évident que nous pourrions la nommer différemment pour améliorer la lisibilité.

### En savoir plus

- [Common Mistakes: Using goroutines on loop iterator variables](https://github.com/golang/go/wiki/CommonMistakes#using-goroutines-on-loop-iterator-variables)

> Ce texte est une traduction de l’article [The Top 10 Most Common Mistakes I’ve Seen in Go Projects](https://itnext.io/the-top-10-most-common-mistakes-ive-seen-in-go-projects-4b79d4f6cd65) avec l’aimable autorisation de son auteur [Teiva Harsanyi](https://twitter.com/teivah)
