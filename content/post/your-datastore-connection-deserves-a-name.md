+++
draft = false

title = "your datastore connection deserves a name"
description = "Assigning a name to your database connection can lower your time to debug. We provide an overview of how to do this for various database systems."
images = [
    "/img/posts/your-datastore-connection-deserves-a-name/assign-a-name-to-your-connection.png",
    "/img/posts/your-datastore-connection-deserves-a-name/perfect-engineering-world-vs-reality-shared-database.png"
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
    "MySQL",
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
lastmod = 2021-07-28T17:55:00+02:00

featureimage = ""
menu = ""
aliases = [
    "/blog/your-database-connection-deserves-a-name/",
    "/blog/your-connection-deserves-a-name/"
]
+++

{{<
    figure src="/img/posts/your-datastore-connection-deserves-a-name/assign-a-name-to-your-connection.png"
    alt="Provide a name to your database connection"
>}}

**tl;dr**: When multiple apps interact with the same database, bad side-effects can happen:
One app keeps the database busy, that all other apps stop to respond.
In this case, you are dealing with an incident that difficult to debug due to a not that obvious root cause.
**Assigning a name to each database connection** can make your life easier.
It will reduce the time to debug by multiple hours and finding the root cause faster.

➡️ Want to see how it works? Checkout examples for [redis]({{< ref "your-datastore-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_redis_-connection" >}}), [RabbitMQ]({{< ref "your-datastore-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_rabbitmq_-connection" >}}), [PostgreSQL]({{< ref "your-datastore-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_postgresql_-connection" >}}), [MySQL]({{< ref "your-datastore-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_mysql_-connection" >}}) and [HTTP]({{< ref "your-datastore-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_http_-connection" >}}).

<!--more-->

## Why does naming your datastore connection make sense?

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
    figure src="/img/posts/your-datastore-connection-deserves-a-name/perfect-engineering-world-vs-reality-shared-database.png"
    alt="A perfect (engineering) world where everyone has its own datastore vs. Reality where datastores are shared."
    caption="A perfect (engineering) world where everyone has its own datastore vs. Reality where datastores are shared."
>}}

This situation is typically hard to debug because the root cause is not that obvious:
Application B is failing because the datastore cannot answer in time due to Application A sending expensive requests.

If you are in control of the applications, assigning a name to each connected client wise can help to

* lower the debugging pain and reduce the time to recover in an outage
* collect usage/resource metrics from the perspective of the datastore over each application

## How helpful is this in reality?

In my last eight years working mainly on the scalability and reliability of [trivago](https://www.trivago.com/), connection naming has **helped us multiple times during an incident to find the root cause faster**.
We saw things like:

* [blocked and unresponsive Redis instances](https://tech.trivago.com/2017/01/25/learn-redis-the-hard-way-in-production/ "Learn Redis the hard way (in production) @ trivago tech blog")
* blocked database tables due to inefficient queries
* overloaded database servers due to raising traffic and query volumes
* services that receive a large number of HTTP requests from unknown sources

In all cases, identifying the client was the main entry point for the final solution.

Additionally, if you plan to **deprecate and shut down "legacy" applications and those still receive traffic**, identifying the clients can help you achieve your goal quicker.
The alternatives would be:

* Asking around "_Who is using the old currency conversion service?_" in the company chat
* Shutting down the service and wait until other services crash or people start to scream why something is not working

Both alternatives can be professionally solved with connection naming.

## What is a good connection name?

In general, everything to identify who sends the request or query.
Two quick suggestions:

**If you control all applications and datastores**, choose the name of the application itself.
If the application opens several connections, add another identifier like a package or a class name.
Like `currency-conversion-app` or `thor` (if this is your project's codename).

**If you don't own the datastore or operate with an external service**, use the application name followed by some contact information.
Like `currency-conversion - currency@mycompany.com`.
In case of trouble, the operator can reach out.

## How to assign a name to a connection

This depends on the system you are using.
Below you find instructions for

- [redis]({{< ref "your-datastore-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_redis_-connection" >}})
- [RabbitMQ]({{< ref "your-datastore-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_rabbitmq_-connection" >}})
- [PostgreSQL]({{< ref "your-datastore-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_postgresql_-connection" >}})
- [MySQL]({{< ref "your-datastore-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_mysql_-connection" >}})
- [HTTP]({{< ref "your-datastore-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_http_-connection" >}})

Keep in mind: **Not every datastore supports connection naming**.
E.g., MySQL does not.
In such cases **there are workarounds**.
For systems that support user authorization and authentication, using separate user accounts for each application can have a similar effect.
Read more about this in the instructions for [MySQL]({{< ref "your-datastore-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_mysql_-connection" >}}).

Once **connection naming is supported**, it is usually **straightforward without any engineering overhead**.

In [andygrunwald/your-connection-deserves-a-name @ Github](https://github.com/andygrunwald/your-connection-deserves-a-name "Code examples on how to name a connection for Redis, RabbitMQ, PostgreSQL and more") I provide complete examples for different programming languages and systems on how to assign a name to a connection.

### How to assign a name to your _redis_ connection

After creating a connection to redis, send the [`CLIENT SETNAME`](https://redis.io/commands/client-setname "CLIENT SETNAME @ redis docs") command:

```sh
CLIENT SETNAME currency-conversion-app
```

Via [`CLIENT LIST`](https://redis.io/commands/client-list "CLIENT LIST @ redis docs") you can see all clients, including their name:

```sh
$ CLIENT LIST
id=3 addr=172.17.0.1:62668 name=currency-conversion-app [...]
id=4 addr=172.17.0.1:62676 name=stock-exchange-rates-app [...]
```

➡️ Checkout [screenshots and code examples for redis at Github](https://github.com/andygrunwald/your-connection-deserves-a-name/tree/main/redis).

### How to assign a name to your _RabbitMQ_ connection

While creating a connection to RabbitMQ, you can provide AMQP options.
One of the options is [`connection_name`](https://www.rabbitmq.com/connections.html#client-provided-names "AMQP Client-Provided Connection Name @ RabbitMQ docs").

This is how it looks like in Go:

```go
config := amqp.Config{
    Properties: amqp.Table{
        "connection_name": "currency-conversion-app",
    },
}
conn, err := amqp.DialConfig("amqp://guest:guest@127.0.0.1:5672/", config)
```

In the UI of Rabbit under the Connection tab, you can see all connected clients, including their names:

{{<
    figure src="/img/posts/your-datastore-connection-deserves-a-name/rabbitmq-connection-client-name.png"
    alt="RabbitMQ Connections: Showing clients name under the IP address"
    caption="RabbitMQ Connections: Showing clients name under the IP address"
>}}

➡️ Checkout [screenshots and code examples for RabbitMQ at Github](https://github.com/andygrunwald/your-connection-deserves-a-name/tree/main/rabbitmq).

### How to assign a name to your _PostgreSQL_ connection

While creating a connection to PostgreSQL, you can provide a client name in the connection string.
The property is called [`application_name`](https://www.postgresql.org/docs/9.0/runtime-config-logging.html#GUC-APPLICATION-NAME) and is part of [libpq](https://www.postgresql.org/docs/9.0/libpq-connect.html).

```go
dsn := "postgres://user:pass@127.0.0.1/database?application_name=currency-conversion-app"
conn, err := sql.Open("postgres", dsn)
```

To see which clients are connected (incl. their application name), you can query the `pg_stat_activity` table:

```sql
postgres=# SELECT usename, application_name, client_addr, backend_type FROM pg_stat_activity;

 usename  |     application_name     | client_addr |  backend_type
----------+--------------------------+-------------+-----------------
 postgres | stock-exchange-rates-app | 172.17.0.1  | client backend
 postgres | currency-conversion-app  | 172.17.0.1  | client backend
```

➡️ Checkout [screenshots and code examples for PostgreSQL at Github](https://github.com/andygrunwald/your-connection-deserves-a-name/tree/main/postgresql).

### How to assign a name to your _MySQL_ connection

_The sad news_:
The MySQL protocol does not support naming your connection.

_The good news_:
There is a workaround → Using a separate username for each application.

For this, a few things need to be done:
* Get to know which database operations (e.g., `SELECT`, `INSERT`, ...) the application is executing
* Create a new database user with particular permissions on the executed database operations

The [`CREATE USER`](https://dev.mysql.com/doc/refman/8.0/en/create-user.html) and [`GRANT`](https://dev.mysql.com/doc/refman/8.0/en/grant.html) statements provide instructions on how to create a user and assign individual permissions.

Use this new user to build up the connection:

```go
// <user>:<password>@<ip>:<port>/<database-namee>
dsn := "stock-exchange-rates-app:newyork@/connection_name"
conn, err := sql.Open("mysql", dsn)
```

To see which clients are connected (incl. their username), you can query the [processlist](https://dev.mysql.com/doc/refman/8.0/en/show-processlist.html):

```sql
SHOW PROCESSLIST;

Id  User                        Host                db              Command Time    State                   Info
8   root                        172.17.0.1:59426    connection_name Query   0       init                    SHOW PROCESSLIST
10  stock-exchange-rates-app    172.17.0.1:59434    connection_name Sleep   5                               NULL
12  currency-conversion-app     172.17.0.1:59442    connection_name Query   5                               SELECT * FROM item;
```

➡️ Checkout [screenshots and code examples for MySQL at Github](https://github.com/andygrunwald/your-connection-deserves-a-name/tree/main/mysql).

### How to assign a name to your _HTTP_ connection

The [User-Agent HTTP header field](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent "User-Agent at Mozilla Developer Network") was explicitly created for this use-case:

> [...] string that lets servers and network peers identify the application, operating system, vendor, and/or version [...]

How the value looks is not specified.
Here are a few suggestions:

* [Mozilla Developer Network](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent "User-Agent at Mozilla Developer Network"): `<product> / <product-version> <comment>`
* [MediaWiki](https://www.mediawiki.org/wiki/API:Etiquette#The_User-Agent_header "API:Etiquette of MediaWiki"): `clientname/version (contact information e.g. username, email)`
* [GitHub API](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#user-agent-required "User-Agent section @ GitHub API docs"): your GitHub username, or the name of your application

➡️ Checkout [screenshots and code examples for HTTP at Github](https://github.com/andygrunwald/your-connection-deserves-a-name/tree/main/http).

## You know a system that supports connection naming?

I would love to hear from you.
Contribute to [andygrunwald/your-connection-deserves-a-name @ GitHub](https://github.com/andygrunwald/your-connection-deserves-a-name) via an Issue or Pull Request.