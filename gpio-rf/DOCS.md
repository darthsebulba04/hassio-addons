# Home Assistant Add-on: GPIO Receiver

## Installing

From the supervisor add-on store, add the following repository:

https://github.com/darthsebulba04/hassio-addons

Then, in the new list of add-ons, install `GPIO RF Receiver`

## How to use

1. Set the `gpio` option per how you wired the rf receiver, e.g., `17`.
2. Save the add-on configuration by clicking the "SAVE" button.
3. Turn OFF protection mode.  This add-on currently requires 'full_access' to the underlying hardware to read the GPIO pins.
4. Start the add-on.
5. Point your RF remote at the receiver and look in the add-on log for the data read from the receiver.  You may have to hit refresh.
6. You can then use these codes to add your outlets to [Home Assistant] via the [Raspberry Pi RF Integration].

## Configuration

The GPIO Receiver add-on can be changed to your likings. This section
describes each of the add-on configuration options.

Example add-on configuration:

```yaml
gpio: 17
```

### Option: `gpio`

The gpio pin to listen for data from.  NOTE: This is the GPIO number, not the physical pin number.

## Support

In case you've found a bug, please [open an issue on my GitHub][issue].

[issue]: https://github.com/darthsebulba04/hassio-gpio-recv/issues
[repository]: https://github.com/darthsebulba04/hassio-gpio-recv/
[Home Assistant]: https://www.home-assistant.io
[Raspberry Pi RF Integration]: https://www.home-assistant.io/integrations/rpi_rf/
