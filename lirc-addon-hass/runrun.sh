#!/usr/bin/with-contenv bashio
set -e

echo "Démarrage de LIRC..."

DEVICE=$(bashio::config 'device')

if [ -z "$DEVICE" ]; then
    bashio::log.error "Aucun périphérique sélectionné. Configurez l'add-on avant de le démarrer."
    exit 1
fi

bashio::log.info "Utilisation du périphérique IR: $DEVICE"

/usr/sbin/lircd --nodaemon --device="$DEVICE" &

# Attendre un instant pour s'assurer que lircd démarre bien
sleep 10

echo "Démarrage de LIRC Web..."
exec node /opt/lirc_web/app.js
