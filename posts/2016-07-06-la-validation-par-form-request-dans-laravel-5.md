---
title: La validation par Form Request dans Laravel 5.2
description: Les différentes manières de valider ses données et celle qui me parait la plus pratique à mettre en place
published_at: 2016-07-06 10:00:00
categories: [ tech ]
---

# La validation par Form Request dans Laravel 5.2

Depuis que j’utilise Laravel, j’ai toujours cherché à avoir des Controllers les plus simples possibles. Et pourtant, des fois, c’est pas si simple que ça, surtout quand on commence à intégrer de la validation de formulaires.

## La validation dans le Controller

En effet, je me suis vite retrouvé à remplir les fonctions de mes Controllers avec des **dizaines de lignes de validation** avant de pouvoir traiter mes données. Niveau simplicité on repassera !

```php
public function postNew(Request $request) {
  $this->validate($request, [
    'title' => 'required',
    'description' =>     'required',
    'commercialized' =>  'required',
    'product-type' =>    'required',
    'duration' =>        'required',
    'feedback' =>        'required',
    'automatic-cover' => 'image|required'
  ]);

  // ...
}
```

## La validation dans le Model

Après quelques recherches sur les interouebs, j’ai testé la **validation dans les Models**. En gros on déplace la liste des règles de validation dans une variable (_ou une fonction, si on a besoin de quelque chose de plus complexe_) du Model, et on la récupère dans le Controlleur avant de valider. Ca donne un truc du style :

```php
$company = new Company();
$this->validate( $request, $company->rules );
```

**Moins de code, mais plus complexe** (_j’ai vu des exemples bien plus capilotractés_), et j’estime que la validation n’a **pas sa place dans les Models** (_ouais j’suis comme ça, des fois j’ai un avis !_).

## La validation par Form Request

En poursuivant ma quête de la validation (_presque_) parfaite, j’ai trouvé un article qui présentait **la validation par Form Request**. Et là, je suis instantanément tombé sous le charme. Comment ai-je fait pour ne pas voir cela dans la doc de Laravel 5, [au milieu de la page](https://laravel.com/docs/5.2/validation#form-request-validation) monolithique sur la validation ? Personne ne le saura jamais.

Comment ça fonctionne ? C’est simple ! Un coup d’artisan pour créer une Class Form Request où l’on renseigne les conditions de validation, une injection de dépendance dans le Controller, et… c’est tout ! Plus aucune ligne de validation dans le Controller !

## La marche à suivre

```php
php artisan make:request UserAddRequest
```

Cette commande va **créer une Class** UserAddRequest.php dans le répertoire _app/Http/Requests/_. Voici un exemple du contenu de ce fichier, repris d’un de mes projets :

```php
namespace App\Http\Requests;

use App\Http\Requests\Request;

class UserAddRequest extends Request {
  public function authorize() {
    return true;
  }

  public function rules() {
    return [
      'name'                  => 'required|min:5|max:255|unique:users,name',
      'email'                 => 'required|email|max:255|unique:users,email',
      'rank'                  => 'required',
      'customer_id'           => 'required',
      'password'              => 'required|confirmed|min:6',
      'password_confirmation' => 'required'
    ];
  }

  public function messages() {
    return [
      'name.required' => 'Le pseudo est obligatoire',
      'name.unique'   => 'Une personne utilise déjà ce pseudo'
    ];
  }
}
```

Comme vous pouvez le constater, il y a également une fonction très pratique qui permet de **personnaliser les messages d’erreurs** renvoyés. Plus d’infos sur la fonction _authorize_ dans la doc !

Il ne reste plus qu’à **injecter cette Form Request dans votre fonction**, et c’est fini, adieu la validation dans le Controller, puisque celle-ci a désormais lieu **avant le chargement du Controller**.

```php
namespace App\Http\Controllers;

use App\Http\Requests\UserAddRequest;
use App\Models\User;

class UserController extends Controller {
  public function add(UserAddRequest $request) {
    $user = new User;
    $user->name = $request->name;
    $user->email = $request->email;
    $user->rank = (int) $request->rank;
    $user->level = 1;
    $user->customer_id = (int) $request->customer_id;
    $user->password = bcrypt($request->password);

    $user->save();

    return redirect('admin/user/' . $user->id)
  }
}
```

## Conclusion

Les Form Request sont clairement un **outil très pratique de Laravel 5**, simples à utiliser, et néanmoins très puissants en cas de validation plus poussée. N’hésitez donc pas à les utiliser dès aujourd’hui, votre code vous en sera reconnaissant !
