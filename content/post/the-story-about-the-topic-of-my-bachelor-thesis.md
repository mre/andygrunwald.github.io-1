+++
categories = ["Conferences", "Open Source"]
date = "2014-03-21T13:01:50+02:00"
draft = false
featureimage = ""
menu = ""
tags = ["bachelor of science", "community", "cvsanaly", "fosdem", "Jacobine", "open source", "python", "software repository mining"]
title = "The story about the topic of my bachelor thesis"
+++

This post is about my bachelor thesis, a conference, cool people from Spain, some academic paper, a lot of open source and how it can be if you let the flow runs :)

Everything started in February 2013.
At this time I studied business informatics next to my fulltime job at [wmdb Systems GmbH](https://www.wmdb.de/) as a software developer (mainly as web developer for [TYPO3](https://typo3.org/) related projects).

<!--more-->

The regular time of this course of studies is seven semester.
In February 2013 I was in the 5th semester, and I passed every exam.
Just in (regular) time.

In the 7th semester, I had to write my bachelor thesis.
A scientific paper about a specific topic with ~40-60 pages.
I was thinking a lot about a possible topic, and I knew that I wanted to write something about software, software development and so on.
But I did not have a specific topic in mind at this time.

At 2nd & 3rd February 2013 I visited [FOSDEM](https://archive.fosdem.org/2013/) in Brussels, Belgium for the first time with some of my friends.
It was not far away from my hometown (~200 km), so it was a very short ride.
And due to the big range of topics, this conference sounds very interesting!

At the conference, I attend many talks about different topics.
But one talk was kind of special for me: [Do you want to measure your project?](https://archive.fosdem.org/2013/schedule/event/do_you_want_to_measure_your_project/) by [Jesus M. Gonzalez-Barahona](https://archive.fosdem.org/2013/schedule/speaker/jesus_m_gonzalez_barahona/) ([Video](https://ftp.fau.de/fosdem/2013/lightningtalks/Do_you_want_to_measure_your_project_.webm), [Slides](https://speakerdeck.com/jgbarah/do-you-want-to-measure-your-project)).
Jesus talks about [Metrics Grimoire](https://metricsgrimoire.github.io/), a toolset to crawl data which were produced during software development and [Viz Grimoire](https://vizgrimoire.bitergia.org/), a toolset to visualize the received data.
Some tools of MetricsGrimoire are [CVSAnalY](https://github.com/MetricsGrimoire/CVSAnalY) to crawl VCS (CVS, Subversion, Git, ...), [Bicho](https://github.com/MetricsGrimoire/Bicho) to extract data from Bugtracker (Jira, Redmine, Mantis, ...) or [MLStats](https://github.com/MetricsGrimoire/MailingListStats) to get email content from mailing lists.

After every conference, I`m very motivated to start new things and have a more in-depth look at topics where I attend talks too.
This was the same for FOSDEM.
After the conference, I had a more in-depth look at CVSAnaly.
Downloaded it, installed it and started to crawl some repositories I know (e.g. [TYPO3.CMS.git](https://git.typo3.org/Packages/TYPO3.CMS.git)).
16 days after the conference, I began to contribute to CVSAnaly with [a small notice about the max_allowed_packet of MySQL](https://github.com/MetricsGrimoire/CVSAnalY/commit/d69e569d2dff5fa8e98cc0f3c414071eaaf37984) for the first time.

At this time I didn`t write one line [Python](https://www.python.org/).
But every programmer has to learn one language per year.
I started to learn Python and [continued contribution to CVSAnaly](https://github.com/MetricsGrimoire/CVSAnalY/commits?author=andygrunwald).
In the same time ([Apr 19, 2013](https://github.com/andygrunwald/Jacobine/commit/b44dd91e359ad55478919cc94278d26fffbdde03)) I started [TYPO3-Analytics](https://github.com/andygrunwald/Jacobine), a project to analyze and visualize various data sources of the TYPO3 ecosystem based on open/standard APIs.
CVSAnaly was integrated into this analysis suite.

From my point of view, the topic of analyzing data which will be produced during software development was fascinating, because I'm a software developer.
And how cool is it to get new information and knowledge from data you have produced?!? I continued to develop TYPO3-Analytics and started to make some small research about the [Mining Software Repositories](https://en.wikipedia.org/wiki/Mining_Software_Repositories) field.

Due to this enthusiasm, I found my topic for my bachelor thesis: Software Repository Mining - Concept and Potentials.
In October / November 2013, I looked for a professor as an adviser, registered this topic at my university and started to research and to write this paper.
I continued to work at TYPO3-Analytics and CVSAnaly.
During this time I found a lot of interesting paper about programming topics.
Here is a tiny list of this paper (if you want more just ping me ;)):

* [An Analysis of the Dynamic Behavior of JavaScript Programs](https://sss.cs.purdue.edu/projects/dynjs/pldi275-richards.pdf)
* [Analysis of Signature Change Patterns](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.76.3203&rep=rep1&type=pdf)
* [Will My Patch Make It? And How Fast? Case Study on the Linux Kernel](https://dergipark.org.tr/tr/download/article-file/729012)

At [1st & 2nd February 2014 the FOSDEM event](https://fosdem.org/2014/) retakes places in Brussels, Belgium.
Due to the communication at the [MetricsGrimoire mailinglist](https://lists.libresoft.es/listinfo/metrics-grimoire) i knew that people from [Bitergia](https://bitergia.com/) ([@jgbarah](https://twitter.com/jgbarah/), [@sanacl](https://twitter.com/sanacl), [@dizquierdo](https://twitter.com/dizquierdo), etc.) were there as well.
I [twittered that I want to meet them](https://twitter.com/andygrunwald/status/428850540228132864) and ~1 hour later we had a lovely chat in the cafeteria of the University of Brussels.
I showed and talked about the concepts of TYPO3-Analysis and got positive feedback.

~13 months later (since FOSDEM 2013), many things happen.
I learned new tools (CVSAnaly, Bicho, ...), a new programing language (Python), a lot of programing experience and concepts with new tools (TYPO3-Analytics, [RabbitMQ](https://www.rabbitmq.com/), [supervisord](https://supervisord.org/), [Vagrant](https://www.vagrantup.com/), [Chef](https://www.getchef.com/chef/)...), new friendly and interesting people (Jesus, Luis, Daniel, ...), a fresh business concept (Bitergia) and many new knowledge about a exciting research field I did not know before (Mining Software Repositories).
And finally, I passed my Bachelor of Science degree today.

And the whole story might be another one if I had not visit FOSDEM in February 2013.
A big and huge THANK YOU to all people who were part of this story (creator of tools, speaker, twitterer, IRC chat attendees and other community members of the open source world).
The whole time was a lot of fun.
Of course, there was stress, too.
But the fun was much more prominent.

And what is the conclusion of this story? I do not know.
Maybe visit conferences and be part of an impressive community? I do not know.
But I can recommend this way to try it out! If you need help to get into it, because you do not know how: Ping me :)
I will help you do get the right foot in!