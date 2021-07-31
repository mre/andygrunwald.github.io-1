+++
draft = false

title = "your database connection deserves a name"
description = "Assigning a name to your database connection can lower your time to debug. We provide an overview of how to do this for various database systems and programming languages."
images = [
    "/img/posts/your-database-connection-deserves-a-name/assign-a-name-to-your-connection.png",
    "/img/posts/your-database-connection-deserves-a-name/perfect-engineering-world-vs-reality-shared-database.png"
]
keywords = [
    "Database",
    "Lessons learned",
    "Engineering",
    "Programming",
    "PHP",
    "Go",
    "Python",
    "Redis",
    "RabbitMQ",
    "PostgreSQL",
    "MySQL",
    "MongoDB",
    "HTTP",
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
lastmod = 2021-07-31T15:30:00+02:00

featureimage = ""
menu = ""
aliases = [
    "/blog/your-datastore-connection-deserves-a-name/",
    "/blog/your-connection-deserves-a-name/"
]
+++

{{<
    figure src="/img/posts/your-database-connection-deserves-a-name/assign-a-name-to-your-connection.png"
    alt="Provide a name to your database connection"
>}}

**tl;dr**: When multiple apps interact with the same database, nasty side-effects can happen:
One app keeps the database busy; all other apps might stop responding.
In this case, you are dealing with an incident that is difficult to debug due to a non-obvious root cause.
**Assigning a name to each database connection** can make a difference.
It will reduce the time to debug by multiple hours and finding the root cause faster.
From the perspective of the database, you can differentiate the apps and their commands to identify the bad client.

➡️ Want to see how it works? Checkout examples for
[MongoDB]({{< ref "your-database-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_mongodb_-connection" >}}), [MySQL]({{< ref "your-database-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_mysql_-connection" >}}), [PostgreSQL]({{< ref "your-database-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_postgresql_-connection" >}}), [redis]({{< ref "your-database-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_redis_-connection" >}}), and non-database systems like [RabbitMQ]({{< ref "your-database-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_rabbitmq_-connection" >}}) or [HTTP]({{< ref "your-database-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_http_-connection" >}}).

<!--more-->

## Why does naming your database connection make sense?

Many of the applications on this planet interact with some kind of database.
In a perfect world:

* Every application has its own database
* Several applications do not share the same database
* Direct access to the stored data is shielded by an application via an API

The thing is: We don't live in a perfect world.
The reality often is:

* Several applications share one or multiple databases
* These applications are developed independently
* and receive different types of traffic patterns

This may lead to a situation where one application requests many compute resources from the database by inefficient queries.
At the same time, other applications might suffer from unexpected behavior or a partial outage due to limited resources available on the database to serve the requests.

{{<
    figure src="/img/posts/your-database-connection-deserves-a-name/perfect-engineering-world-vs-reality-shared-database.png"
    alt="A perfect world where everyone has its own database vs. Reality where databases are shared."
    caption="A perfect world where everyone has its own database vs. Reality where databases are shared."
>}}

This situation is typically hard to debug because the root cause is not that obvious:
Application B is failing because the database cannot answer in time due to Application A sending expensive queries.

In my last eight years working mainly on the scalability and reliability of [trivago](https://www.trivago.com/), I have seen many outages that contained similar things like:

* [blocked and unresponsive Redis instances](https://tech.trivago.com/2017/01/25/learn-redis-the-hard-way-in-production/ "Learn Redis the hard way (in production) @ trivago tech blog")
* blocked database tables due to inefficient queries
* overloaded database servers due to raising traffic and query volumes
* services that receive a large number of HTTP requests from unknown sources

In all cases, identifying the client responsible for the trouble was the main entry point for the final solution.
**Connection naming has helped us multiple times during an incident to find the root cause faster**.

Assigning a name to each client database connection can help to

* lower the debugging pain and reduce the time to recover in an outage
* implement rate limiting per connection name
* collect usage/resource metrics from the perspective of the database over each application

Furthermore, it is beneficial if you plan to **deprecate and shut down a "legacy" application that still receives traffic**.
Identifying all clients can help you achieve your goal quicker.
In this case, the alternatives to connection naming would be:

* Asking around "_Who is using the old currency conversion service?_" in the company chat
* Shutting down the service and wait until other applications crash or people start to scream why something is not working as expected

Both alternatives can be professionally solved with connection naming.

## What is a good connection name?

In general, everything to identify the client application that sends the request or query.
Two quick suggestions:

**If you control all applications and databases**, choose the name of the application itself.
If the application opens several connections, add another identifier like a package or a class name.
Like `currency-conversion-app` or `stock-exchange-rate-importer`.

**If you don't own the database or operate the external service**, use the application name followed by some contact information.
Like `currency-conversion - currency@mycompany.com`.
In case of trouble, the administrator can reach out.

## How to assign a name to a database connection

This is different for each system.
Below you find instructions for

- [MongoDB]({{< ref "your-database-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_mongodb_-connection" >}})
- [MySQL]({{< ref "your-database-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_mysql_-connection" >}})
- [PostgreSQL]({{< ref "your-database-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_postgresql_-connection" >}})
- [redis]({{< ref "your-database-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_redis_-connection" >}})

Non-database systems like Message Queues or HTTP based APIs also support connection naming:

- [RabbitMQ]({{< ref "your-database-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_rabbitmq_-connection" >}})
- [HTTP]({{< ref "your-database-connection-deserves-a-name.md#how-to-assign-a-name-to-your-_http_-connection" >}})

Keep in mind: **Not every database supports connection naming**.
In such cases, often there are **workarounds**.
For systems that support user authentication, using separate user accounts for each application can have a similar effect.

Once **connection naming is supported**, it is usually **straightforward to implement without any engineering overhead**.

In [andygrunwald/your-connection-deserves-a-name @ Github](https://github.com/andygrunwald/your-connection-deserves-a-name "Code examples on how to name a connection for Redis, RabbitMQ, PostgreSQL and more") I provide complete examples for different programming languages and systems on how to assign a name to a connection.

### How to assign a name to your _MongoDB_ connection

While creating a connection to MongoDB, you can provide an [`appName`](https://docs.mongodb.com/manual/reference/connection-string/#mongodb-urioption-urioption.appName) in the connection string.

```go
dsn := "mongodb://root:secret@127.0.0.1:27017/?appName=currency-conversion-app"
client, err := mongo.Connect(ctx, options.Client().ApplyURI(dsn))
```

To see which clients are connected, you can query [`db.currentOp()`](https://docs.mongodb.com/manual/reference/method/db.currentOp/):

{{<
    figure src="/img/posts/your-database-connection-deserves-a-name/mongodb-db.currentOp-result.png"
    alt="MongoDB: Output of db.currentOp() including the `appName` setting"
    caption="MongoDB: Output of db.currentOp() including the `appName` setting"
>}}

or check the server logs:

```json
{
    "t": {
        "$date": "2021-07-30T16:30:18.042+00:00"
    },
    "attr": {
            "application": {
                "name": "currency-conversion-app"
            }
        }
    }
}
```

➡️ Checkout [screenshots and code examples for MongoDB at Github](https://github.com/andygrunwald/your-connection-deserves-a-name/tree/main/mongodb).

🙏 Thanks to [Andreas Braun](https://twitter.com/alcaeus), who pointed me to this feature in MongoDB.

### How to assign a name to your _MySQL_ connection

While creating a [connection to MySQL, you can set connection attributes](https://dev.mysql.com/doc/refman/8.0/en/performance-schema-connection-attribute-tables.html).
Depending on the client library, this is either part of the data source name (DSN) or provided via a function call (mostly setting a kind of `set_option`).

For the application name, the connection attribute `program_name` is suggested.
Applications like [ProxySQL](https://github.com/sysown/proxysql/blob/5ede60ec9fb4217095fcf792c07cc515c195ea5f/lib/mysql_connection.cpp#L633) and [MySQL Workbench](https://github.com/mysql/mysql-workbench/blob/5e10b42aa539155128bd97d54ed2cdd7ca283b34/plugins/migration/copytable/copytable.cpp#L1799) using the same feature to identify themselves against the MySQL server.

Here is an example in Python with the [PyMySQL library](https://pypi.org/project/PyMySQL/):

```python
connection = pymysql.connect(
                host='127.0.0.1',
                user='root',
                password='secret',
                database='dummy',
                charset='utf8mb4',
                cursorclass=pymysql.cursors.DictCursor,
                program_name='unit-conversion-app',
            )
```

To see which clients are connected, you can query the [`performance_schema`](https://dev.mysql.com/doc/refman/8.0/en/performance-schema.html) and [`information_schema`](https://dev.mysql.com/doc/refman/8.0/en/information-schema.html) schema:

```sql
SELECT
    session_connect_attrs.ATTR_VALUE AS program_name,
    processlist.*
FROM information_schema.processlist
LEFT JOIN performance_schema.session_connect_attrs ON (
    processlist.ID = session_connect_attrs.PROCESSLIST_ID
    AND session_connect_attrs.ATTR_NAME = "program_name"
)
```

The result should look similar to:

```sql
program_name        | ID | USER | HOST             | DB    | [...]
--------------------+----+------+------------------+-------+------
unit-conversion-app | 11 | root | 172.17.0.1:56382 | dummy | [...]
```

➡️ Checkout [screenshots and code examples for MySQL at Github](https://github.com/andygrunwald/your-connection-deserves-a-name/tree/main/mysql).

🙏 Thanks to [Johannes Schlüter](https://twitter.com/johannescode), who pointed me to this feature in MySQL.

### How to assign a name to your _PostgreSQL_ connection

While creating a connection to PostgreSQL, you can provide a [`application_name`](https://www.postgresql.org/docs/9.0/runtime-config-logging.html#GUC-APPLICATION-NAME) in the data source name (DSN):

```go
dsn := "postgres://user:pass@127.0.0.1/database?application_name=currency-conversion-app"
conn, err := sql.Open("postgres", dsn)
```

To see which clients are connected with their application name, you can query the [`pg_stat_activity`](https://www.postgresql.org/docs/9.2/monitoring-stats.html) table:

```sql
postgres=# SELECT usename, application_name, client_addr, backend_type FROM pg_stat_activity;

 usename  |     application_name     | client_addr |  backend_type
----------+--------------------------+-------------+-----------------
 postgres | stock-exchange-rates-app | 172.17.0.1  | client backend
 postgres | currency-conversion-app  | 172.17.0.1  | client backend
```

➡️ Checkout [screenshots and code examples for PostgreSQL at Github](https://github.com/andygrunwald/your-connection-deserves-a-name/tree/main/postgresql).

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
    figure src="/img/posts/your-database-connection-deserves-a-name/rabbitmq-connection-client-name.png"
    alt="RabbitMQ Connections: Showing clients name under the IP address"
    caption="RabbitMQ Connections: Showing clients name under the IP address"
>}}

➡️ Checkout [screenshots and code examples for RabbitMQ at Github](https://github.com/andygrunwald/your-connection-deserves-a-name/tree/main/rabbitmq).

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