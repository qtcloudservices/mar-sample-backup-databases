# Managed Application Runtime - Database Backup Example Service

This is an example Backup service for Qt Cloud Service - Managed Application Runtime.
More information about [Backup gem](meskyanichi.github.io/backup/v4/).

## Getting Started

* create a new MAR instance (mini should be enough)
* clone this repository
* add MAR as a git remote:

  `git remote add qtc <git remote from console>`

* set environment variables (depends on what databases you want to backup, see below)
* deploy service:

  `git push qtc master`

* start backup worker:

  `qtc-cli mar scale worker=1`

### Supported Databases

To enable database backup, set following environment variables (using qtc-cli tool):

#### MongoDB

```
MONGODB_HOST=<host>
MONGODB_PORT=<port>
MONGODB_USER=<user>
MONGODB_PASSWORD=<password>
```

#### MySQL

```
MYSQL_HOST=<host>
MYSQL_PORT=<port>
MYSQL_USER=<user>
MYSQL_PASSWORD=<password>
```

#### Redis

```
REDIS_HOST=<host>
REDIS_PORT=<port>
REDIS_PASSWORD=<password>
```


### Supported Encryptors

To enable backup encryptor, set following environment variables:

#### OpenSSL

```
OPENSSL_PASSWORD=<password>
```


### Supported Notificators

To enable backup notificators, set following environment variables:

#### Email

```
EMAIL_HOST=<host>
EMAIL_PORT=<port>
EMAIL_TO=<to>
EMAIL_USERNAME=<username>
EMAIL_PASSWORD=<password>
```

#### Flowdock

```
FLOWDOCK_TOKEN=<token>
```


### Supported Storage


#### Amazon S3

```
S3_BUCKET=<bucket>
S3_REGION=<region>
S3_ACCESS_KEY_ID=<access_key_id>
S3_SECRET_ACCESS_KEY=<secret_access_key>

```
