---
title: Compiler une API Rust en WebAssembly et la déployer sur Cloudflare Workers  
description: Une introduction rapide au déploiement serverless sur un worker Cloudflare grâce à WASM
published_at: 2023-11-03 10:00:00
categories: [ rust ]
---

# Compiler une API Rust en WebAssembly et la déployer sur Cloudflare Workers

Tout le monde n'a d'yeux que pour AWS et ses concurrents traditionnels Google Cloud et Azure, mais saviez-vous que Cloudflare possède également [son propre service serverless](https://workers.cloudflare.com/) ? Il est basé sur les [Web Workers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API) et on peut même y déployer un langage backend comme Rust grâce à la puissance de [WebAssembly](https://developer.mozilla.org/en-US/docs/WebAssembly).

## Créer le projet

Pour mettre en place votre premier projet avec toutes les dépendances nécessaires il suffit de lancer les commandes suivantes, où `api-cloudflare` représente le nom du projet que l'on souhaite créer.

```shell
npx wrangler generate api-cloudflare https://github.com/cloudflare/workers-sdk/templates/experimental/worker-rust
cd api-cloudflare
npm install
```

Le contenu du worker se trouve dans le fichier `src/lib.rs` et peut être lancé localement avec la commande `npm run dev`. Pour le moment ce n'est qu'une simple fonction qui renvoie le traditionel texte `"Hello, World!"` lorsque l'on se rend sur l'url [127.0.0.1:8787](http://127.0.0.1:8787/) mais nous allons la modifier pour mettre en place un routeur et des réponses formattées en json.

```rust
use worker::*;

#[event(fetch)]
async fn main(req: Request, env: Env, ctx: Context) -> Result<Response> {
    Response::ok("Hello, World!")
}

```

## Mettre en place un routeur

On va utiliser le crate `worker` déjà présent dans le projet Rust et qui intègre un routeur, mais pour renvoyer du json il faut également ajouter deux crates à notre projet en ajoutant les dépendances suivantes dans le fichier `Cargo.toml`.

```toml
serde = { version = "1", features = ["derive"] }
serde_json = "1"
```

Ensuite, on va modifier notre fichier `src/lib.rs` de la manière suivante :

```rust
use serde_json::json;
use worker::*;

#[event(fetch)]
async fn main(req: Request, env: Env, _ctx: Context) -> Result<Response> {
    Router::new()
        .get_async("/", root)
        .run(req, env)
        .await
}

pub async fn root(_req: Request, _ctx: RouteContext<()>) -> Result<Response> {
    let payload = json!({
        "code": 200,
        "data": "Hello, world!"
    });

    Response::from_json(&payload)
}
```

Désormais, lorsque l'on se rend sur l'url [127.0.0.1:8787](http://127.0.0.1:8787/), le serveur nous renverra du json avec un header `content-type: "application/json"` et non plus du texte avec un header `content-type: "text/plain"` comme précédemment.

```json
{
  "code": 200,
  "data": "Hello, world!"
}
```

### Renvoyer une réponse structurée

On va modifier le routeur pour lui ajouter une route `/user` qui permet de renvoyer un struct qui sera sérialisé automatiquement grâce à la feature `derive` de `serde`.

```rust
async fn main(req: Request, env: Env, _ctx: Context) -> Result<Response> {
    Router::new()
        .get_async("/", root)
        .get_async("/user", user) // <- Ajouter cette ligne
        .run(req, env)
        .await
}

#[derive(Serialize)]
struct User {
    name: String,
    age: usize,
}

pub async fn user(_req: Request, _ctx: RouteContext<()>) -> Result<Response> {
    let user = User {
        name: "Adrian".to_string(),
        age: 37,
    };

    let payload = json!({
        "code": 200,
        "data": user
    });

    Response::from_json(&payload)
}
```

Lorsque l'on se rend sur l'url [127.0.0.1:8787/user](http://127.0.0.1:8787/user) on aura donc le résultat suivant :

```json
{
  "code": 200,
  "data": {
    "age": 37,
    "name": "Adrian"
  }
}
```

### Aller plus loin

Le routeur permet tout un tas d'autre choses telles que la gestion des autres actions HTTP (`POST`, `DELETE`, `PATCH`, ...), la récupération des variables d'environnement, la gestion de routes complexes, etc. N'hésitez donc pas à jeter un oeil aux ressources suivantes :
- [La page de la lib sur crates.io](https://crates.io/crates/worker)
- [La documentation](https://docs.rs/worker/0.0.18/worker/)
- [Le dépôt GitHub avec plusieurs exemple](https://github.com/cloudflare/workers-rs)

## Déployer le projet

Avant de **déployer votre projet sur Cloudflare Workers**, vous pouvez modifier le champ `name` du fichier `wrangler.toml` qui représente le nom du worker qui sera déployé et que vous pourrez retrouver sur votre dashboard.

Vérifiez également que votre `package.json` contient bien le script `"publish": "wrangler publish"` et non `"deploy": "wrangler deploy"` car ce dernier n'existe plus et vous renverra une erreur.

Il ne reste plus ensuite qu'à lancer la commande `npm run publish` et valider l'autorisation ouverte automatiquement dans une nouvelle fenêtre navigateur pour **déployer votre lambda Rust sur Cloudflare** et profiter de l'autoscaling automatique !

L'adresse de déploiement sera affichée à la fin du processus de déploiement (elle se termine par `worker.dev`)`, et vous pouvez également la retrouver dans votre Dashboard dans le menu "Workers & Pages" sur la gauche.

> **Important**
> 
> A l'heure de l'écriture de cet article vous aurez probablement une alerte indiquant que la commande `generate` n'est plus supportée et [sera supprimée dans la v4 de wrangler](https://developers.cloudflare.com/workers/wrangler/deprecations/#wrangler-v3), mais il manque encore pas mal de choses pour que cette nouvelle version soit compatible avec les workers Rust, je mettrai donc à jour l'article lorsque tout sera stabilisé.