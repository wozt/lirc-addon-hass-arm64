# Utiliser une image de base compatible ARM (aarch64)
FROM arm64v8/alpine:latest

# Vérifier l'accès au périphérique USB (facultatif, pour déboguer)
RUN ls -l /dev/bus/usb/001/005 || echo "Périphérique USB non détecté"


# Installer les paquets nécessaires pour la compilation et LIRC
RUN apk add --no-cache gcc build-base libusb-dev lirc-dev linux-headers git lirc

# Cloner le projet tiqiaa_lirc depuis GitHub
RUN git clone https://github.com/cclairmont/tiqiaa_lirc /opt/tiqiaa_lirc

# Compiler le plugin LIRC tiqiaa
RUN cd /opt/tiqiaa_lirc \
    && gcc -shared -fPIC tiqiaa.c -lusb-1.0 -llirc -llirc_driver -o tiqlibusb.so \
    && mv tiqlibusb.so /usr/lib/lirc/plugins/

# Copier les fichiers de configuration dans le conteneur
COPY lircmd.conf /usr/etc/lirc/lircmd.conf
COPY lircd.conf /usr/lirc/lircd.conf
COPY lirc_options.conf /usr/etc/lirc/lirc_options.conf
COPY lircd.conf.d/salon.lircd.conf /usr/etc/lirc/lircd.conf.d/salon.lircd.conf

# Commande de démarrage LIRC
CMD ["/usr/sbin/lircd", "--nodaemon"]
