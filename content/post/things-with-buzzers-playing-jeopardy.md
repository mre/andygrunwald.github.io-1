+++
draft = false
title = "things with buzzers: playing Jeopardy!"
date = 2019-11-01T15:00:00+01:00
tags = ["things-with-buzzers", "frontend", "diy", "game"]
categories = ["Community", "things with buzzers"]
featureimage = ""
menu = ""
images = ["/img/posts/things-with-buzzers-playing-jeopardy/jeopardy-frontend-board.png"]
+++

**tl;dr**: For the _[**things with-buzzers** series](https://github.com/andygrunwald/things-with-buzzers-hardware)_ we have integrated a Jeopardy! Game show frontend to have a good time with friends. Check it out at _[things with buzzers: Jeopardy!](https://github.com/andygrunwald/things-with-buzzers-jeopardy)_.
Start playing today, and have an awesome time!

<!--more-->

{{< figure src="/img/posts/things-with-buzzers-playing-jeopardy/jeopardy-frontend-board.png" alt="things with buzzers: The Jeopardy! frontend game board." caption="things with buzzers: The Jeopardy! frontend game board.">}}

> If you like this article, you might want to read [things with buzzers: building them](/blog/things-with-buzzers-building-them) and [things with buzzers: a sports competition](/blog/things-with-buzzers-a-sports-competition/) also.

## things with buzzers

Inspired by [Hacker Jeopardy](https://media.ccc.de/search/?q=Hacker+Jeopardy) from the [Chaos Computer Club](https://www.ccc.de/en/), we got motivated to build a Jeopardy! Game and have fun with friends and colleagues.
We 3d-printed game show buzzers, created a custom printed circuit board, and wrote software to connect with the hardware to be able to play games like Jeopardy!

Finally, we **open-sourced everything**.
Check out the **things with buzzers** series **_[hardware](https://github.com/andygrunwald/things-with-buzzers-hardware)_ and _[websocket](https://github.com/andygrunwald/things-with-buzzers-websocket)_**.

This article is about a **Jeopardy! Frontend**.
For more context about the hardware, I recommend reading the [things with buzzers: building them](/blog/things-with-buzzers-building-them/) article.

{{< figure src="/img/posts/things-with-buzzers-playing-jeopardy/buzzer-setup-frontends.png" alt="things with buzzers: A Jeopardy! frontend" caption="A frontend for things with buzzers.">}}

## A Jeopardy! frontend

When we started this frontend, we asked ourselves if we want to develop the game from scratch or if we build upon something existing.
One of our goals was to get this game ready to a specific date.
Creating such a game from scratch will consume a few weekends.

A quick [_jeopardy_ search on GitHub](https://github.com/search?q=jeopardy) revealed many repositories containing this game already.
A love to open source!
We tested ~ten different game implementations and decided to go with [theGrue/jeopardy](https://github.com/theGrue/jeopardy) as a foundation.

The base functionality of this project is excellent, but to integrate it correctly with the game show buzzers, we had to do some work.
We forked it into [andygrunwald/things-with-buzzers-jeopardy](https://github.com/andygrunwald/things-with-buzzers-jeopardy) and started coding.
A few things that we have done:

* Modify the app that it can run offline.
* Connect to [things with buzzers: websocket](https://github.com/andygrunwald/things-with-buzzers-websocket) and react on pressed buzzers.
* Enable our own sets of questions/answers.
* Added documentation on how to use the Jeopardy! game in the context of things-with-buzzers.

The frontend itself is a NodeJS application with an AngularJS frontend.
We installed it on the Pi and started it next to the WebSocket server.

## Start your game today

The complete project is available on GitHub: [things with buzzers: Jeopardy!](https://github.com/andygrunwald/things-with-buzzers-jeopardy).

The repository contains all instructions you need to set it up, create your own set of answers/questions, and play a session with your friends.

## Playing it

In the meantime, we played it a couple of times at smaller events and farewell parties.
Below you find a few insights from the first event.

{{< figure src="/img/posts/things-with-buzzers-playing-jeopardy/playing-jeopardy-tech-get-together-2019.jpg" alt="Playing a Jeopardy! Session at trivago's internal tech conference on the 19th of March 2019." caption="Playing a Jeopardy! session at trivago's internal tech conference on the 19th of March 2019.">}}

{{< youtube -be2fD5neGU >}}
<div class="video-caption">
The official event video from [trivago](https://www.trivago.com/).
The Jeopardy! game is visible from 0:59 min to 1:04 min.
</div>

## Credits

The main acknowledgments belongs to [theGrue](https://github.com/theGrue), [btford](https://github.com/btford) + contributors for their work on [theGrue/jeopardy](https://github.com/theGrue/jeopardy) and [btford/angular-socket-io-seed](https://github.com/btford/angular-socket-io-seed).

Thanks a lot! You created a huge thing.
