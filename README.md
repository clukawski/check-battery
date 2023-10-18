# check-battery

Simple battery checker notify script and systemd service/timer for barebones WM setups. By default this script alerts at < 30 minutes of estimated battery remaining, see below to customize this.

## Dependencies

The following packgaes must be installed: `acpi`, `notify-osd`. For notifications, `dunst` is recommended and should be started alongside your window manager. Consult your distribution on how to install these packages.

## Usage

If you do not have root access and cannot copy `check-battery.sh` to `/usr/local/bin/`, install it to a local path and update the `ExecStart=` parameter in the systemd unit file before copying it.

```
git clone https://github.com/clukawski/check-battery
cd check-battery
mkdir -p  ~/.config/systemd/user/
sudo cp check-battery.sh /usr/local/bin/
cp check-battery.timer check-battery.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now check-battery.timer
```

## Customization

Adjust the following line in `check-battery.sh` to customize when the alert for time remaining fires (in hours, minutes, and seconds). Default is 30 minutes.

```
TIME_REMAINING="00:30:00"
```
