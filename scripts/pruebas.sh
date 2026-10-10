#!/bin/sh
# Comandos de prueba de la Infraestructura 1 - Gregorys Morel Duluc 2025-0035

# ===== PC1 (VLAN 10) =====
udhcpc -i eth0 -q && ip addr show eth0                                   # DHCP /25
curl -s http://10.20.35.2                                                # Caja: permitido
curl -s http://10.20.35.3 | grep -i -E "title|blocked|URLfilter"         # Inventario: bloqueado por Web Filter
curl -sk -m 5 https://10.20.35.3 || echo "HTTPS a Inventario BLOQUEADO"  # HTTPS: denegado
ssh -o ConnectTimeout=5 root@10.20.35.2 || echo "SSH BLOQUEADO"          # SSH: denegado
traceroute -I -n 10.20.35.2                                              # 10.20.25.1 -> 10.20.35.2

# ===== PC2 (VLAN 20) =====
udhcpc -i eth0 -q && ip addr show eth0                                   # DHCP /25
curl -s http://10.20.35.3                                                # Inventario: permitido
ssh root@10.20.35.4                                                      # SSH a DB: permitido

# ===== CAJA (DMZ) =====
apk update                                                               # Repositorio de actualizaciones: permitido
ping -c 2 8.8.8.8 || echo "INTERNET GENERAL BLOQUEADO"                   # Resto de Internet: bloqueado
