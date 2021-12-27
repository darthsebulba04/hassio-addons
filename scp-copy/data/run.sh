#!/usr/bin/with-contenv bashio

bashio::log.info "Starting SCP copy"

files=`find /backup -name *.tar -maxdepth 1 -mtime -1`

bashio::log.info "files to be copied:" $files 

/usr/bin/scp -i "$(bashio::config 'private_key')" -o \
	StrictHostKeyChecking=no \
	$files \
	$(bashio::config 'remote_user')@$(bashio::config 'remote_host'):"$(bashio::config 'remote_path')"
RESULT=$?

bashio::log.info "SCP completed to $(bashio::config 'remote_host')"

bashio::log.info "Post scp_copy_complete event"
bashio::log.info `curl --no-progress-meter -X POST -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" -H "Content-Type: application/json" --data "{\"result\":\"${RESULT}\"}" "http://supervisor/core/api/events/scp_copy_complete" 2>&1`

bashio::log.info "Posted event"


bashio::log.info "Done  `date`"