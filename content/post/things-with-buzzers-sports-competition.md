+++
draft = false
title = "things with buzzers: a sports competition"
date = 2019-11-01T17:00:00+01:00
tags = ["things-with-buzzers", "frontend", "diy", "sports", "competition"]
categories = ["Community", "things with buzzers"]
featureimage = ""
menu = ""
images = ["/img/posts/things-with-buzzers-sports-competition/scoreboard.png"]
+++

**tl;dr**: For the _[**things with-buzzers** series](https://github.com/andygrunwald/things-with-buzzers-hardware)_ we created a frontend to run a sports competition at a local functional fitness gym. It stops the athlete's time and ranks them according to the fastest. It was an exceptional feeling to hit the buzzer at the end of the workout. Check it out at _[things with buzzers: sports competition](https://github.com/andygrunwald/things-with-buzzers-sports-competition)_.

<!--more-->

{{< figure src="/img/posts/things-with-buzzers-sports-competition/scoreboard.png" alt="things with buzzers: The sports competition frontend." caption="things with buzzers: The sports competition frontend.">}}

> If you like this article, you might want to read [things with buzzers: building them](/blog/things-with-buzzers-building-them/) and [things with buzzers: playing Jeopardy!](/blog/things-with-buzzers-playing-jeopardy/) also.

## things with buzzers

Inspired by [Hacker Jeopardy](https://media.ccc.de/search/?q=Hacker+Jeopardy) from the [Chaos Computer Club](https://www.ccc.de/en/), we got motivated to build a Jeopardy! Game and have fun with friends and colleagues.
We 3d-printed game show buzzers, created a custom printed circuit board, and wrote software to connect with the hardware to be able to play games like Jeopardy!

Finally, we **open-sourced everything**.
Check out the **things with buzzers** series **_[hardware](https://github.com/andygrunwald/things-with-buzzers-hardware)_, _[websocket](https://github.com/andygrunwald/things-with-buzzers-websocket)_ and _[the Jeopardy! Frontend](https://github.com/andygrunwald/things-with-buzzers-jeopardy)_**.

During the process of building it, a friend of mine approached me with an idea: Can we re-use the technology for a sports event?
Why not giving it a try?
This article is about a **frontend for sports competitions**.
For more context about the hardware, I recommend reading the [things with buzzers: building them](/blog/things-with-buzzers-building-them/) article.

{{< figure src="/img/posts/things-with-buzzers-sports-competition/buzzer-setup-frontends.png" alt="things with buzzers: A Jeopardy! frontend" caption="A frontend for things with buzzers.">}}

## A sports competition frontend

We built this frontend from scratch with the primary goal to automate manual effort of collecting athlete times and ranking them.
The idea was to have a stopwatch to see who is the fastest athlete.
On previous events, this was done manually with pen and paper.

Here is how it works:
Athletes are starting in groups (so-called _heats_) of four.
Every heat has a stopwatch that needs to be triggered manually once the heats start.
Every athlete got a color assigned (visible next to the athlete's name on the scoreboard).
Once the athlete completes the workout, she has to hit on the assigned buzzer color.
By this, the time of the athlete will be stopped and shown on the scoreboard.
All athletes are getting ranked according to their time.
The fastest athlete wins.

During the events, the set up works flawlessly.
A positive surprise: We underestimated how much fun it is for the athletes to hit the buzzer and stop their time at the end of an exhausting workout.
I attended as well and tried it myself.
Hitting the buzzer feels like a relief.

The frontend itself is a static HTML page and a few lines of JavaScript with JQuery.
The web server will serve the website, and the WebSocket server sends the buzzer pushes.

## Start your sports event today

The complete project is available on GitHub: [things with buzzers: sports competition](https://github.com/andygrunwald/things-with-buzzers-sports-competition).

The repository contains all instructions you need to set it up, create your workout, and compete with your friends.

## Impression of the events

In the meantime, we used the setup already twice in a local function fitness gym ([iFunc](https://www.ifunc.de/)).
Below you find a few insights from the events.

{{< figure src="/img/posts/things-with-buzzers-sports-competition/buzzer-installation-ongoing.jpg" alt="Buzzer installation still ongoing." caption="Buzzer installation still ongoing.">}}

{{< figure src="/img/posts/things-with-buzzers-sports-competition/final-buzzer-event-setup.jpg" alt="Final buzzer set up at the second event." caption="Final buzzer set up at the second event.">}}

{{< figure src="/img/posts/things-with-buzzers-sports-competition/rowing-scoreboard.jpg" alt="Rowing discipline and a visible scoreboard." caption="Rowing discipline and a visible scoreboard.">}}

{{< figure src="/img/posts/things-with-buzzers-sports-competition/wallballs-with-scoreboard.jpg" alt="Executing wallballs and a visible scoreboard." caption="Executing wallballs and a visible scoreboard.">}}

{{< youtube sXZbd52_UFk >}}
<div class="video-caption">
The official after event video from the first event.
The competition frontend is visible from 0:11 min to 0:13 min.
</div>