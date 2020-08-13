#!/usr/bin/with-contenv bashio

rpi-rf_receive -g $(bashio::config 'gpio')
