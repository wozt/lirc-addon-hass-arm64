docker run -d \
  --name lirc-addon-test \
  --privileged \
  --device /dev/bus/usb/001/005:/dev/bus/usb/001/005:rwm \
  -p 8765:8765 \
  lirc-addon-hass
