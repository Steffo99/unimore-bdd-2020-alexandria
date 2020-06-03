# Tecnologia database

## Database Management System

Si è scelto di utilizzare **PostgreSQL** (_Postgres_) come DBMS in quanto è quello con il quale i membri del gruppo erano più famigliari.

## Strumenti aggiuntivi

Per assistere nella progettazione fisica, sono stati usati due strumenti per la manipolazione di database Postgres:

- [pgAdmin 4](https://www.pgadmin.org/)
- Il plugin [Database Tools and SQL](https://plugins.jetbrains.com/plugin/10925-database-tools-and-sql) per IDE basati su IntelliJ

## Hosting

Per facilitare la collaborazione, si è scelto di condividere un'**istanza remota** di PostgreSQL installata su un server Ubuntu 18.04.4 LTS, alla quale ci si è connessi con username e password individuali.

________________________________________________

```bash
lsb_release -a
```
```text
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 18.04.4 LTS
Release:        18.04
Codename:       bionic
```

________________________________________________

```sql
SELECT version();
```

| version |
|---------|
| PostgreSQL 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1) on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0, 64-bit |

## Riproduzione del database

È allegato alla relazione il file [`5-database.sql`](5-database.sql), contenente tutte le istruzioni necessarie per ricreare il database descritto in questo capitolo.

Esso è stato ottenuto tramite [`pg_dump`](https://www.postgresql.org/docs/9.3/app-pgdump.html), un'utilità per l'archiviazione di database Postgres, eseguito con il seguente comando Bash:

```bash
pg_dump --dbname="alexandria" --schema="public" --file="5-database.sql"
```

È possibile ricreare il database eseguendo manualmente tutte le istruzioni contenute nel file `.sql`, oppure eseguendo [`pg_restore`](https://www.postgresql.org/docs/9.3/app-pgrestore.html), la controparte di `pg_dump` per il ripristino, con il seguente comando Bash:

```bash
pg_restore --dbname="alexandria" --schema="public" --file="5-database.sql"
```
