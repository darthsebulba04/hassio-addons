# Home Assistant Add-on: SCP Copy

## Installing

From the supervisor add-on store, add the following repository:

https://github.com/darthsebulba04/hassio-addons

Then, in the new list of add-ons, install `SCP Copy`

## How to use

1. Take a manual snapshot or write an automation to take one.
2. Start the add-on.

### As an automation

```
alias: Backup
description: Create a snapshot every night and copy to remote location for replication.
trigger:
  - at: '00:40'
    platform: time
condition: []
action:
  - data:
      name: 'hass-{{ now().strftime(''%Y-%m-%d-%H-%M'') }}'
    service: hassio.snapshot_full
  - delay: '00:15:00'
  - service: hassio.addon_start
    data:
      addon: 0bd49cf9_scp_copy
mode: single
```

## Configuration

Add-on configuration:

### Option `private_key`

The private key to use to initiate the SCP.

Default: `/config/.ssh/id_rsa`

### Option `remote_host`

The remote ip address or hostname to copy the snapshot to.

### Option `remote_user`

The remote user to use when logging into the host.

### Option `remote_path`

The location to copy the snapshots.
