+++
draft = false

title = "your connection deserves a name"
description = "Assigning a name to your database connection can lower your time to debug. We provide an overview of how to do this for various database systems."
images = [
    "/img/posts/your-connection-deserves-a-name/assign-a-name-to-your-connection.png",
    "/img/posts/your-connection-deserves-a-name/perfect-engineering-world-vs-reality-shared-database.png"
]
keywords = [
    "Database",
    "Lessons learned",
    "Engineering",
    "Programming",
    "PHP",
    "Go",
    "Redis",
    "RabbitMQ",
    "PostgreSQL",
    "Best practice"
]
tags = [
    "Lessons learned",
    "Programming",
    "Engineering"
]
categories = [
    "Engineering",
    "Lessons learned"
]

date = 2021-07-25T08:30:00+02:00
lastmod = 2021-07-25T08:30:00+02:00

featureimage = ""
menu = ""
+++

{{<
    figure src="/img/posts/your-connection-deserves-a-name/assign-a-name-to-your-connection.png"
    alt="Provide a name to your database connection"
>}}

**tl;dr**: When your app interacts with an external system (e.g., a datastore), **assign a name to the connection**.
The goal should be: **the external system knows who you are**.
During an incident, it will reduce the time to debug by multiple hours and often save other applications from failing.
Check out [andygrunwald/your-connection-deserves-a-name @ Github](https://github.com/andygrunwald/your-connection-deserves-a-name "Code examples on how to name a connection for redis, RabbitMQ, PostgreSQL and more") for code examples how to do it.

<!--more-->

Most of the applications on this planet interact with some datastore (used as a synonym for things like a database, cache, queuing system).
In a perfect (engineering) world:

* Every application has its own datastore
* Datastores are not shared across applications
* Direct access to the stored data is shielded by an application (e.g., an API)

The thing is: We don't live in a perfect (engineering) world.
The reality is like this:

* Several applications share one or multiple datastore
* These applications get independent developed from each other
* and even may receive different types of traffic patterns

This leads to a situation where one application requests many datastore resources (e.g., through traffic spikes or expensive and inefficient queries).
At the same time, all other applications might suffer from unexpected behavior or a (partial) outage due to limited resources available on the datastore to serve the requests.

{{<
    figure src="/img/posts/your-connection-deserves-a-name/perfect-engineering-world-vs-reality-shared-database.png"
    alt="A perfect (engineering) world where everyone has its own datastore vs. Reality where datastores are shared."
    caption="A perfect (engineering) world where everyone has its own datastore vs. Reality where datastores are shared."
>}}

This situation is typically hard to debug because the root cause is not that obvious:
Application B is failing because the datastore cannot answer in time due to Application A sending expensive requests.

If you are in control of the applications, assigning a name to each connected client wise can help to

* lower the debugging pain and reduce the time to recover in an outage
* collect usage/resource metrics from the perspective of the datastore over each application

## What is a good connection name?

In general, everything to identify who sends the request or query.
Two quick suggestions:

**If you control all applications and datastores**, choose the name of the application itself.
If the application opens several connections, add another identifier like a package or a class name.

**If you don't own the datastore or operate with an external service**, use the application name followed by some contact information.
In case of trouble, the operator will reach out.

## How to assign a name to a connection

This depends on the system you are using.
Below you find instructions for

- [redis](#how-to-assign-a-name-to-your-redis-connection)
- [RabbitMQ](#how-to-assign-a-name-to-your-rabbitmq-connection)
- [PostgreSQL](#how-to-assign-a-name-to-your-postgresql-connection)
- [HTTP](#how-to-assign-a-name-to-your-http-connection)

Keep in mind: Not every datastore supports this.
Once supported, it is usually straightforward to assign a name to a connection without any engineering overhead.

In [andygrunwald/your-connection-deserves-a-name @ Github](https://github.com/andygrunwald/your-connection-deserves-a-name "Code examples on how to name a connection for Redis, RabbitMQ, PostgreSQL and more") I provide complete examples for different programming languages and systems on how to assign a name to a connection.

### ... with redis

After creating a connection to redis, send the [*CLIENT SETNAME*](https://redis.io/commands/client-setname "CLIENT SETNAME @ redis docs") command:

`CLIENT SETNAME your-connection-deserves-a-name-go`

Via [`CLIENT LIST`](https://redis.io/commands/client-list "CLIENT LIST @ redis docs") you can see all clients, including their name:

```
$ CLIENT LIST
id=3 addr=172.17.0.1:61516 name=your-connection-deserves-a-name-go [...]
```

➡️ Checkout [screenshots and code examples for redis at Github](https://github.com/andygrunwald/your-connection-deserves-a-name/tree/main/redis).

### ... with RabbitMQ

While creating a connection to RabbitMQ, you can provide AMQP options.
One of the options is [`connection_name`](https://www.rabbitmq.com/connections.html#client-provided-names "AMQP Client-Provided Connection Name @ RabbitMQ docs").

This is how it looks like in Go:

```go
config := amqp.Config{
    Properties: amqp.Table{
        "connection_name": "your-connection-deserves-a-name-go",
    },
}
conn, err := amqp.DialConfig("amqp://guest:guest@127.0.0.1:5672/", config)
```

In the UI of Rabbit under the Connection tab, you can see all connected clients, including their names:

{{<
    figure src="/img/posts/your-connection-deserves-a-name/rabbitmq-connection-client-name.png"
    alt="RabbitMQ Connections: Showing clients name under the IP address"
    caption="RabbitMQ Connections: Showing clients name under the IP address"
>}}

➡️ Checkout [screenshots and code examples for RabbitMQ at Github](https://github.com/andygrunwald/your-connection-deserves-a-name/tree/main/rabbitmq).

### ... with PostgreSQL

While creating a connection to PostgreSQL, you can provide a client name in the connection string.
The property is called [`application_name`](https://www.postgresql.org/docs/9.0/runtime-config-logging.html#GUC-APPLICATION-NAME) and is part of [libpq](https://www.postgresql.org/docs/9.0/libpq-connect.html).

```go
dsn := "postgres://user:pass@127.0.0.1/database?application_name=your-connection-deserves-a-name-go"
conn, err := sql.Open("postgres", dsn)
```

To see which clients are connected (incl. their application name), you can query the `pg_stat_activity` table:

```sql
postgres=# SELECT usename, application_name, client_addr, backend_type FROM pg_stat_activity;

 usename  |          application_name          | client_addr |         backend_type
----------+------------------------------------+-------------+------------------------------
 postgres | your-connection-deserves-a-name-go | 172.17.0.1  | client backend
```

➡️ Checkout [screenshots and code examples for PostgreSQL at Github](https://github.com/andygrunwald/your-connection-deserves-a-name/tree/main/postgresql).

### ... with HTTP

The [User-Agent HTTP header field](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent "User-Agent at Mozilla Developer Network") was explicitly created for this use-case:

> [...] string that lets servers and network peers identify the application, operating system, vendor, and/or version [...]

How the value looks is not specified.
Here are a few suggestions:

* [Mozilla Developer Network](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent "User-Agent at Mozilla Developer Network"): `<product> / <product-version> <comment>`
* [MediaWiki](https://www.mediawiki.org/wiki/API:Etiquette#The_User-Agent_header "API:Etiquette of MediaWiki"): `clientname/version (contact information e.g. username, email)`
* [GitHub API](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#user-agent-required "User-Agent section @ GitHub API docs"): your GitHub username, or the name of your application

➡️ Checkout [screenshots and code examples for HTTP at Github](https://github.com/andygrunwald/your-connection-deserves-a-name/tree/main/http).

## How helpful is this in reality?

In my last eight years working mainly on the reliability of [trivago](https://www.trivago.com/), connection naming has helped us multiple times to find the root cause faster.
We saw multiple times:

- blocked Redis instances
- blocked database tables due to inefficient queries
- overloaded database servers due to traffic spikes

In all cases, identifying the client was the main entry point for the solution.

## You know a system that supports connection naming?

I would love to hear from you.
Contribute to [andygrunwald/your-connection-deserves-a-name @ GitHub](https://github.com/andygrunwald/your-connection-deserves-a-name) via an Issue or Pull Request.