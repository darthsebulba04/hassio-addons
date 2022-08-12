#!/usr/bin/env bashio

LOG_LEVEL=$(bashio::config 'log_level' 'info')
bashio::log.level $LOG_LEVEL

bashio::log.debug "get database_connection_url"
#postgresql://homeassistant:PASSWORD_GOES_here@77b2833f-timescaledb/homeassistant
DBURL=$(bashio::config 'database_connection_url')

bashio::log.debug "process db parameters"
dbProto="$(echo $DBURL | grep :// | sed -e's,^\(.*://\).*,\1,g')"
# remove the protocol
dbUrlCooked="$(echo ${DBURL/$dbProto/})"
# extract the user (if any)
dbUserPass="$(echo $dbUrlCooked | grep @ | cut -d@ -f1)"
dbPass="$(echo $dbUserPass | grep : | cut -d: -f2)"
if [ -n "$dbPass" ]; then
	dbUser="$(echo $dbUserPass | grep : | cut -d: -f1)"
else
	dbUser=$dbUserPass
fi

# extract the host
dbHost="$(echo ${dbUrlCooked/$dbUserPass@/} | cut -d/ -f1)"
# fails due to set -o pipefail
# by request - try to extract the port
#set +o pipefail
#dbPort="$(echo $dbHost | grep : | sed -e 's,.*:,:,g' -e 's,.*:\([0-9]*\),\1,g' -e 's,[^0-9],,g')"
#set -o pipefail
# extract the path (if any)
dbName="$(echo $dbUrlCooked | grep / | cut -d/ -f2-)"

unset dbUserPass
unset dbUrlCooked
unset dbProto

if [[ -z ${dbPort-} ]] ; then
	dbPort=5432
fi
bashio::log.info "DB info: user: $dbUser @ $dbHost:$dbPort database: $dbName"

bashio::log.debug "Creating PGPASSFILE"
export PGPASSFILE=/tmp/pgpass.conf
touch $PGPASSFILE
chmod 600 $PGPASSFILE
echo "$dbHost:$dbPort:$dbName:$dbUser:$dbPass" > $PGPASSFILE

bashio::log.info "Starting loop"
while `true` ; do
	loop_datetime=$(date +%s)
	bashio::log.debug "start loop $loop_datetime"
	for view in $(bashio::config 'views|keys') ; do
		bashio::log.debug "index $view"

		viewname=$(bashio::config "views[$view].name")
		refresh_frequency_minutes=5

		if bashio::config.exists "views[$view].refresh_frequency_minutes" ; then
			refresh_frequency_minutes=$(bashio::config "views[$view].refresh_frequency_minutes")
		fi

		bashio::log.debug "view: $viewname $refresh_frequency_minutes"

		statFile="/tmp/$viewname"

		last_changed=0
		if [[ -f $statFile ]] ; then
			last_changed=$(stat -c%Y $statFile)
		fi

		let next_change_time="last_changed + (refresh_frequency_minutes * 60)"
		bashio::log.debug "last changed: $last_changed next change time: $next_change_time"

		if [[ $next_change_time -lt $loop_datetime ]] ; then
			bashio::log.debug "updating view $viewname"
			psql -h $dbHost -U $dbUser -d $dbName -c "REFRESH MATERIALIZED VIEW \"$viewname\"" || true
			touch $statFile
		fi

	done

	bashio::log.debug "Starting sleep"
	sleep 50s
done

bashio::log.error "Exited loop, shouldn't get here"