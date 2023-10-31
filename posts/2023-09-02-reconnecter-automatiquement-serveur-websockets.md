---
title: Comment se reconnecter automatiquement à un serveur WebSockets
description: Ou comment utiliser setInterval et clearInterval à notre avantage
published_at: 2023-09-02 10:00:00
---

# Comment se reconnecter automatiquement à un serveur WebSockets

J'ai récemment repris en main une **application web de chat instantané** que je n'avais pas mise à jour depuis des années. Elle est basée sur React pour le frontend et Firebase pour l'authentification et la base de données en temps réel.

J'avais envie d'utiliser Rust pour réécrire le backend et me débarasser de Firebase, je suis donc parti sur les technologies suivantes : 
- [axum](https://crates.io/crates/axum) pour la petite partie API (register, login) et le serveur WebSockets
- [jsonwebtokens](https://crates.io/crates/jsonwebtokens) pour authentifier l'utilisateur depuis le frontend avec des [JWT](https://datatracker.ietf.org/doc/html/rfc7519)
- [argon2](https://crates.io/crates/argon2) pour le hashage des mots de passe
- [L'API WebSockets](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API) pour la communication bidirectionnelle instantanée entre le frontend et le serveur
- [SQLite](https://www.sqlite.org) pour la base de données, avec la librairie [SQLx](https://crates.io/crates/sqlx) pour les requêtes
- Une instance STARDUST pas chère chez [Scaleway](https://www.scaleway.com/en/), le tout déployé automatiquement grâce à GitHub Actions.

Un des problèmes que j'ai rapidement rencontrés en redémarrant mon backend régulièrement (*[cargo-watch](https://crates.io/crates/cargo-watch) est ton ami*), c'est que le front perdait toute connexion Websocket et était **incapable de se reconnecter automatiquement** au serveur lorsqu'il était de nouveau disponible.

Après réflexion, la solution la plus simple a été de **faire un polling de la connexion** à intervale régulier grâce à la fonction JavaScript `setInterval()`, et d'ensuite l'annuler avec la fonction `clearInterval()` lorsqu'on arrive à se connecter à nouveau.

```javascript
export const init = (token) => {
  let interval;
  const socket = new WebSocket(`wss://<WEBSOCKET_URL>?token=${token}`)

  socket.onmessage = (event) => {
    // C'est ici qu'on reçoit les messages envoyés par le serveur
  }

  socket.onopen = (event) => {
    // Lorsqu'on se (re)connecte au serveur WebSockets, on annule l'action récurrente lancée par setInterval()
    interval = clearInterval(interval)
  }

  socket.onclose = (event) => {
    // Lorsque le serveur s'arrête, on reçoit un event "close"
    if (!interval) {
      interval = setInterval(
        init,
        1000, // On reteste la connection toutes les secondes (1000 ms)
        token
      )
    }
  }
}
```
