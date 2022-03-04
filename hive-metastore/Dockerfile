FROM postgres:12.10

COPY hive-metastore/hive-schema-2.3.0.postgres.sql /hive/hive-schema-2.3.0.postgres.sql
COPY hive-metastore/hive-txn-schema-2.3.0.postgres.sql /hive/hive-txn-schema-2.3.0.postgres.sql
COPY hive-metastore/upgrade-2.3.0-to-3.0.0.postgres.sql /hive/upgrade-2.3.0-to-3.0.0.postgres.sql
COPY hive-metastore/upgrade-3.0.0-to-3.1.0.postgres.sql /hive/upgrade-3.0.0-to-3.1.0.postgres.sql

COPY hive-metastore/init-hive-db.sh /docker-entrypoint-initdb.d/init-user-db.sh
