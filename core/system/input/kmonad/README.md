# How to Find Bluetooth Keyboards

- ```sh
  cat /proc/bus/input/devices | grep -i bluetooth
  ```

- ```sh
  udevadm info -a -n /dev/input/event22
  ```

  Take note of `ATTRS{uniq}`.

- Add udev rule based on `ATTRS{uniq}`.
