# Tecnologia database

Si è scelto di utilizzare **PostgreSQL** come DBMS in quanto è quello con il quale i membri del gruppo erano più famigliari.

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
