---
title: "Marre du JavaScript, j'apprends un vrai langage: Rust (Jour 1)"
description: Lancement du carnet de bord d'un développeur Node.js dans son apprentissage d'un nouveau langage moins foireux que le JavaScript
published_at: 2021-12-05
opengraph:
  image: https://blog.otso.fr/images/2021-12-05-marre-javascript-apprendre-rust/langage-programmation-rust.jpg
---

# Marre du JavaScript, j'apprends un vrai langage: Rust (Jour 1)

![Un Rustacéen sauvage apparait !](images/2021-12-05-marre-javascript-apprendre-rust/rustaceen-sauvage.jpg)

Salut à toi jeune développeur·se, cale bien tes fesses sur ta chaise et rejoins moi dans mon apprentissage de [Rust](https://www.rust-lang.org/fr/), un langage de programmation créé par Mozilla en 2010 et qui promet **performance, fiabilité et productivité** (*rien que ça*).

Depuis toujours j’aime découvrir de nouvelles choses pour continuer à évoluer et apprendre, Rust est donc le prochain langage à atterrir dans une liste qui a commencé par le vénérable [Turbo Pascal](https://fr.wikipedia.org/wiki/Turbo_Pascal) quand j’étais gamin, en passant par plein d’autres (*avec plus ou moins de succès ou d’intérêt*) tels que PHP, Python, Ruby, Node.js, Typescript, Go, Solidity et j’en oublie probablement.

Comme je n’ai pas envie de paraphraser [le site officiel](https://www.rust-lang.org/fr/) (*qui a une traduction française, oui oui*) ou Wikipedia, je ne vous dirai donc pas que, parmi ses nombreux avantages, Rust est un **langage compilé extrêmement rapide** qui **garantit la sécurité mémoire**, possède un **système de typage très puissant** et un compilateur qui vous veut du bien (*l’avenir nous le dira*).

Du coup, plutôt que prendre quelques notes dans mon coin, je me suis dit que ça serait plus intéressant de créer une série sur mon **apprentissage de Rust**. Ca me permettra par la même occasion de corriger toute erreur qui pourrait apparaître si d’aventure des Rustacéens tombent sur ces quelques lignes.

## Installer Rust

La manière **la plus simple d’installer Rust** est d’utiliser `rustup` avec la commande suivante, que l’on retrouve sur [rustup.rs](https://rustup.rs/)

`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

Cette commande installera les 3 utilitaires suivants :

- **cargo** : il fonctionne un peu comme npm et permet entre autres de créer un nouveau projet, lancer un build ou encore installer des dépendances externes présentes sur [crates.io](https://crates.io/)
- **rustc** : le compilateur qui... compile votre projet dans le dossier `target/`
- **rustdoc** : il s’occupe de générer une documentation au format HTML à partir des commentaires présents dans le code

## Hello, world!

Passage obligé dans l’apprentissage de tout nouveau langage, nous allons créer un simple “Hello, world!” en **créant un nouveau projet Rust** via la commande `cargo new hello-world`.

Et... c’est tout ! La fonction a été créée automatiquement dans le fichier `src/main.rs`. Il ne reste plus qu’à lancer un petit `cargo run` qui va compiler le programme dans le dossier `target/` et le lancer dans la foulée. Magique non ?

```
$ cargo run
Finished dev [unoptimized + debuginfo] target(s) in 0.04s
Running `target/debug/hello-world`
Hello, world!
```

## Liens utiles

- [Le langage de programmation Rust](https://www.rust-lang.org/fr/)
- [Le “Book” traduit en français](https://jimskapt.github.io/rust-book-fr/)
- [Rust By Example](https://doc.rust-lang.org/stable/rust-by-example/)
- [Que choisir entre Rust et Go](https://blog.otso.fr/2020-11-09-choisir-entre-rust-et-go)

C’est tout pour aujourd’hui. On est dimanche après tout non ? La suite pour un autre jour !
