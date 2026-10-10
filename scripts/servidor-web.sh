#!/bin/sh
# Publica la página del sistema por HTTP (puerto 80) en nginx, sin tocar el sitio HTTPS existente.
# Uso:  sh servidor-web.sh "Sistema de Caja"        (en CAJA)
#       sh servidor-web.sh "Sistema de Inventario"  (en INVENTARIO)
# Gregorys Morel Duluc - 2025-0035

NOMBRE="$1"
mkdir -p /www
echo "<h1>${NOMBRE} - Gregorys Morel 2025-0035</h1>" > /www/index.html
printf 'server {\n listen 80;\n root /www;\n index index.html;\n}\n' > /etc/nginx/http.d/p80.conf
nginx -t && nginx -s reload
wget -qO- http://127.0.0.1
