docker run -d \
  --name lirc-addon-test \
  --privileged \
  --device "$(lsusb | grep 'Silicon Labs Tview' | awk '{printf "/dev/bus/usb/%03d/%03d\n",$2,$4}' | sed 's/://')":/dev/bus/usb/001/003:rwm \
  -p 8765:8765 \
  -p 3000:3000 \
  lirc-addon-hass-arm64
