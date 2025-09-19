#!/bin/sh
echo "Démarrage de LIRC..."
/usr/sbin/lircd --nodaemon &

# Attendre un instant pour s'assurer que lircd démarre bien
sleep 10

echo "Démarrage de LIRC Web..."
exec node /opt/lirc_web/app.js
