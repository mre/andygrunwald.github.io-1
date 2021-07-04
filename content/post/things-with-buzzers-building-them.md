+++
draft = false

title = "things with buzzers: building them"
description = ""
images = ["/img/posts/things-with-buzzers-building-them/buzzers-raspberrypi.jpg"]
keywords = []
tags = [
    "things-with-buzzers",
    "hardware",
    "diy"
]
categories = [
    "Community",
    "things with buzzers"
]

date = 2019-11-01T12:00:00+01:00
lastmod = 2019-11-01T12:00:00+01:00

featureimage = ""
menu = ""
+++

**tl;dr**: We built custom game show buzzers, wrote a WebSocket server, and connected them to various applications.
Finally, we documented and open-sourced everything. Check out the **things with buzzers** series _[hardware](https://github.com/andygrunwald/things-with-buzzers-hardware)_, _[websocket](https://github.com/andygrunwald/things-with-buzzers-websocket)_ and a frontend like _[Jeopardy!](https://github.com/andygrunwald/things-with-buzzers-jeopardy)_.
Start today, and build your own!

<!--more-->

{{< figure src="/img/posts/things-with-buzzers-building-them/buzzers-raspberrypi.jpg" alt="things with buzzers: The final result - four buzzers and a custom printed circuit board." caption="The final result - four buzzers and a custom printed circuit board.">}}

> If you like this article, you might want to read [things with buzzers: playing Jeopardy!](/blog/things-with-buzzers-playing-jeopardy/) and [things with buzzers: a sports competition](/blog/things-with-buzzers-a-sports-competition/) also.

## Why we did it

Every year, between Christmas and New Year's Eve, the [Chaos Computer Club](https://www.ccc.de/en/) is running their conference called [Chaos Communication Congress](https://events.ccc.de/).
An inspiring event with a lot of exciting and insightful content.
For many attendees, one session is their yearly highlight: [Hacker Jeopardy](https://media.ccc.de/search/?q=Hacker+Jeopardy).
A self-built version of the popular game show [_Jeopardy!_](https://en.wikipedia.org/wiki/Jeopardy!) with a modified set of answers/questions to target the hacker audience.

Inspired by this, I had two motivational goals:

1. to build the same and **to have fun with friends** and colleagues
2. to **combine software** (a field I know) **with hardware** (an area I don't know) and create something real

The idea slept for a long time.
On the 1st of December 2017, I remembered it and ordered [four big red buzzers](https://www.amazon.de/gp/product/B07F9W55FX/ref=as_li_qf_asin_il_tl?ie=UTF8&tag=andygrunwal0a-21&creative=6742&linkCode=as2&creativeASIN=B07F9W55FX&linkId=59ed8f2e2dc0a14374e5dadce1705d2f).
Nothing happened again for some time until my employer ([trivago](https://www.trivago.com/)) announced an internal tech conference planned for March 2019.

This was the chance!
I motivated my two friends [Lars](https://twitter.com/derebbe) and [Matthias](https://endler.dev), and we gave it a shot!

## How it works

{{< figure src="/img/posts/things-with-buzzers-building-them/buzzer-setup.png" alt="things with buzzers: Architecture diagram of how it works" caption="Architecture diagram of how it works.">}}

We split the project into three parts: _(1) frontends_, _(2) websocket_, and the _(3) hardware_.

The _[(3) hardware](https://github.com/andygrunwald/things-with-buzzers-hardware)_ part contains the actual buzzers, the cables, and a custom printed circuit board (PCB).
The buzzers connect via USB sockets to a [Raspberry Pi](https://www.raspberrypi.org/) (Pi).
A PCB was built and placed onto the GPIO of the Pi (a so-called _hat_).

The _[(2) websocket](https://github.com/andygrunwald/things-with-buzzers-websocket)_ part is a software installed on the Pi.
It does two things:

1. Listen to the GPIO for signals and transforms them into "a buzzer was pushed" activity.
2. Host a webserver to serve static files, and a WebSocket server to push out the buzzer-push signals to clients.

The _(1) frontends_ (e.g., [Jeopardy!](https://github.com/andygrunwald/things-with-buzzers-jeopardy) or [a sports competition scoreboard](https://github.com/andygrunwald/things-with-buzzers-sports-competition)) can be either static single-page apps served by the web server or applications written in a language of your choice installed on the Pi.
The Pi itself either opens its wireless network or will be configured to join an existing one.
A laptop connects to the webserver and provides the game to the audience via a projector.

## Build your own

I **documented everything and open-sourced it**!

These repositories contain a lot of detailed information with picture guides to replicate this project and have fun with people:

* _[the buzzer and Pi hat hardware (things with buzzers: hardware)](https://github.com/andygrunwald/things-with-buzzers-hardware)_
* _[the WebSocket server software (things with buzzers: websocket)](https://github.com/andygrunwald/things-with-buzzers-websocket)_
* _[the Jeopardy! frontend (things with buzzers: Jeopardy!)](https://github.com/andygrunwald/things-with-buzzers-jeopardy)_
* _[a sports competition scoreboard (things with buzzers: sports competition)](https://github.com/andygrunwald/things-with-buzzers-sports-competition)_

## Building them

With a little bit of preparation, on the 15th of January 2019, we met at Lars' home to get things going.
Here are a few insights:

{{< figure src="/img/posts/things-with-buzzers-building-them/buzzer-build-station.jpg" alt="things with buzzers: The workplace to solder everything together." caption="The workplace to solder everything together.">}}

{{< figure src="/img/posts/things-with-buzzers-building-them/creating-the-pcb-prototype.jpg" alt="things with buzzers: Creating the custom printed circuit board." caption="Hacky thing: Creating the custom printed circuit board.">}}

{{< figure src="/img/posts/things-with-buzzers-building-them/lars-fixing-andys-bugs.jpg" alt="things with buzzers: Lars needs to fix Andy's hardware bugs." caption="Lars needs to fix Andy's hardware bugs.">}}

{{< figure src="/img/posts/things-with-buzzers-building-them/coding-session.jpg" alt="things with buzzers: Coding session to figure out how different GPIO libraries work to catch buzzer signals." caption="Coding session to figure out how different GPIO libraries work to catch buzzer signals.">}}

{{< youtube pAQNX0Fhxk4 >}}
<div class="video-caption">
The buzzer hardware <-> software test.
</div>

## Credits

A big **thank you** to [Lars](https://twitter.com/derebbe) and [Matthias](https://twitter.com/matthiasendler).
Without them, this project would not happen.
Lars has designed and built the complete hardware.
Matthias helped a lot with the software and motivation part. 😀
