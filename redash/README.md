# Redash

## Getting Started

### Production Variable Changes Required

You should at bare minimum change the following variables in your production environment:

__file:__ env/postgres.env

```bash
POSTGRES_PASSWORD: "redash1234" # Should be set to the same as the REDASH_POSTGRES_PASSWORD in redash.env

```

__file:__ caddy/Caddyfile

```bash
redash.example.com {
    reverse_proxy server:5000

    # Uncomment the following line to enable TLS
    #tls /root/certs/cert.crt /root/certs/cert.key

    log {
        level error
    }
}

```

__file:__ env/redash.env

```bash
# DATABASE SETTINGS
REDASH_DATABASE_URL: "postgresql://postgres:redash1234@postgres/postgres"
REDASH_POSTGRES_PASSWORD: "redash1234" # Should be set to the same as the POSTGRES_PASSWORD in postgres.env

# MAIN SETTINGS
REDASH_HOST: "redash.example.com"
REDASH_COOKIE_SECRET: "redash"
REDASH_SECRET_KEY: "redash1234"

# # Uncomment & updated the following lines to enable LDAP & MAIL settings
# # LDAP SETTINGS
# REDASH_LDAP_LOGIN_ENABLED: "true"
# REDASH_LDAP_URL: "ldaps://ldap.example.com:636"
# REDASH_LDAP_BIND_DN: "cn=redash,ou=users,dc=example,dc=com"
# REDASH_LDAP_BIND_DN_PASSWORD: "redash"
# REDASH_LDAP_SEARCH_TEMPLATE: "(sAMAccountName={username}s)"
# REDASH_LDAP_SEARCH_DN: "ou=users,dc=example,dc=com"
#
# # MAIL SETTINGS
# REDASH_MAIL_SERVER: "smtp.example.com"
# REDASH_MAIL_PORT: 587
# REDASH_MAIL_DEFAULT_SENDER: "redash@example.com"
# REDASH_MAIL_USERNAME: "redash"
# REDASH_MAIL_PASSWORD: "redash"
# REDASH_MAIL_USE_TLS: "true"
# REDASH_MAIL_USE_SSL: "false"

```

### First Time Startup

For first time setup, you need to run the setup script first.  After that, you can `docker-compose up` like any other docker-compose setup.

```bash
# Setup the Redash Database
$~/repos/docker-compose_examples/redash$./setup.sh
[+] Running 2/0
 ⠿ Container redash-postgres-1          Running                        0.0s
 ⠿ Container redash-redis-1             Running                        0.0s
You can now run 'docker-compose up -d'

# Start the Redash Containers
$~/repos/docker-compose_examples/redash$docker-compose up -d
[+] Running 7/0
 ⠿ Container redash-postgres-1          Running                        0.0s
 ⠿ Container redash-redis-1             Running                        0.0s
 ⠿ Container redash-server-1            Running                        0.0s
 ⠿ Container redash-adhoc_worker-1      Running                        0.0s
 ⠿ Container redash-scheduled_worker-1  Running                        0.0s
 ⠿ Container redash-scheduler-1         Running                        0.0s
 ⠿ Container redash-caddy-1             Running                        0.0s
```

### Normal Startup

```bash
# Start the Redash Containers
$~/repos/docker-compose_examples/redash$docker-compose up -d
[+] Running 7/0
 ⠿ Container redash-postgres-1          Running                        0.0s
 ⠿ Container redash-redis-1             Running                        0.0s
 ⠿ Container redash-server-1            Running                        0.0s
 ⠿ Container redash-adhoc_worker-1      Running                        0.0s
 ⠿ Container redash-scheduled_worker-1  Running                        0.0s
 ⠿ Container redash-scheduler-1         Running                        0.0s
 ⠿ Container redash-caddy-1             Running                        0.0s
```

## Components Used

- [Redash](https://redash.io) - Scheduler, workers, and main server
- [Redis](https://redis.io) - Cache and task queues
- [Postgres](https://www.postgresql.org) - Redash's supported database (for the application, but it can support numberous datasources)
- [Caddy](https://caddyserver.com) - HTTPS reverse proxy & HTTP redirection (feel free to use your own)

## Notes

- Redash latest image as of 2022-10-07 is 10.1.0.b50633
- You cannot leverage the latest tag because as of 2022-10-07, the image is 3 years old and does not work with this setup.

## Resources

- [Redash Documentation](https://redash.io/help/)
- [Redash Community Forum](https://discuss.redash.io/)
- [Redash Slack](https://redash.io/slack)
- [Redash on GitHub](https://github.com/getredash/redash)
- [Redash on Docker Hub](https://hub.docker.com/r/redash/redash/)
- [Redash Docker Compose Dev Example](https://github.com/getredash/redash/blob/master/docker-compose.yml)
- [Redash Docker Compose PROD Example](https://github.com/getredash/setup/blob/master/data/docker-compose.yml)
- [Redash Self Hosted Docker Guide](https://redash.io/help/open-source/dev-guide/docker)
