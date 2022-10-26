#!/bin/bash
######## Variables ###########
MAIN_SCHEMA_NAME="C" ##ENDURANCE_MAIN
# MAIN SCHEMA PASSWORD is required only when working with Oracle DB
MAIN_SCHEMA_PASSWORD="C" ##ENDURANCE_MAIN
# POSTGRESQL USERNAME & PASSWORD are required only when working with PostgreSQL
POSTGRESQL_USERNAME="postgres"
POSTGRESQL_PASSWORD="root"
DB_SERVER="IL02VWDB5011.cfrm.dev.local"
DB_PORT="1521"
DB_SID="orcl"
# DB can be only one of (oracle|postgresql)
DB="oracle"

function update_config_yaml(){
change_string_on_file %MAIN_SCHEMA_NAME% "$MAIN_SCHEMA_NAME" /var/config.yaml
        if [ "$DB" == "oracle" ]; then
                DSN="oracle+cx_oracle://${MAIN_SCHEMA_NAME}:${MAIN_SCHEMA_PASSWORD}@${DB_SERVER}:${DB_PORT}/${DB_SID}"
                change_string_on_file %DSN% "$DSN" /var/config.yaml
        elif [ "$DB" == "postgresql" ]; then
                DSN="postgresql+psycopg2://${POSTGRESQL_USERNAME}:${POSTGRESQL_PASSWORD}@${DB_SERVER}:${DB_PORT}/${DB_SID}?${MAIN_SCHEMA_NAME}"
                change_string_on_file %DSN% "$DSN" /var/config.yaml
        else
                echo "ERROR: Unsupported DB type. Please set the DB variable to (oracle|postgresql)"
                exit 1
        fi
}
update_config_yaml
