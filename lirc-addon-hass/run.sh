docker run -d \
  --name lirc-addon-test \
  --privileged \
  --device /dev/bus/usb/001/004:/dev/bus/usb/001/004:rwm \
  -p 8765:8765 \
  lirc-addon-hass
