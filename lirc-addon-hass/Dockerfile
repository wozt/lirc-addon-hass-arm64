FROM arm64v8/alpine:latest

# Installer les paquets nécessaires pour la compilation et LIRC
RUN apk add --no-cache gcc build-base libusb-dev lirc-dev linux-headers git lirc nodejs npm

# Vérifier l'accès au périphérique USB (facultatif, pour déboguer)
RUN echo "$(lsusb | grep 'Silicon Labs Tview' | awk '{printf "/dev/bus/usb/%03d/%03d\n",$2,$4}' | sed 's/://')" || echo "Périphérique USB non détecté"

# Cloner le projet tiqiaa_lirc depuis GitHub
RUN git clone https://github.com/cclairmont/tiqiaa_lirc /opt/tiqiaa_lirc

# Compiler le plugin LIRC tiqiaa
RUN cd /opt/tiqiaa_lirc \
    && gcc -shared -fPIC tiqiaa.c -lusb-1.0 -llirc -llirc_driver -o tiqlibusb.so \
    && mv tiqlibusb.so /usr/lib/lirc/plugins/

# Copier les fichiers de configuration dans le conteneur
COPY lircmd.conf /etc/lirc/lircmd.conf
COPY lircd.conf /etc/lirc/lircd.conf
COPY lirc_options.conf /etc/lirc/lirc_options.conf
#COPY lircd.conf.d/salon.lircd.conf /etc/lirc/lircd.conf.d/salon.lircd.conf
COPY lircd.conf.d/chambre.lircd.conf /etc/lirc/lircd.conf.d/chambre.lircd.conf

# Cloner et installer LIRC Web
RUN git clone https://github.com/alexbain/lirc_web.git /opt/lirc_web \
    && cd /opt/lirc_web \
    && npm install

# Exposer le port utilisé par LIRC Web
EXPOSE 3000

COPY runrun.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]

# Commande de démarrage LIRC et LIRC Web en parallèle
#CMD /usr/sbin/lircd --nodaemon & node /opt/lirc_web/app.js
