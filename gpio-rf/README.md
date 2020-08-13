# Home Assistant Add-on: GPIO RF Reader

Reads radio frequency signal codes off of a Raspberry Pi GPIO pin.

![GPIO pin layout][gpio-pins]

This add-on provides a simple way to read the radio frequency codes from a GPIO pin of a Raspberry Pi wired with generic 433/315MHz capable modules.

![RF hardware][rf-hardware]

Uses the Python library [rpi-rf] and script rpi-rf_receive .  More details about wiring and hardware can be found on the [rpi-rf] site.

This add-on has been tested with a RPi 4b running [Home Assistant] and will probably work with a 3/3b/3+ .

![Supports armv7 Architecture][armv7-shield]

[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[rpi-rf]: https://pypi.org/project/rpi-rf/
[gpio-pins]: https://github.com/darthsebulba04/hassio-gpio-rf/raw/master/GPIO.png
[rf-hardware]: https://github.com/darthsebulba04/hassio-gpio-rf/raw/master/rf-boards.png
[Home Assistant]: https://www.home-assistant.io
