# Home Assistant Add-on: SCP Copy

## Installing

From the supervisor add-on store, add the following repository:

https://github.com/darthsebulba04/hassio-addons

Then, in the new list of add-ons, install `SCP Copy`

## How to use

1. Take a manual snapshot or write an automation to take one.
2. Start the add-on.

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
