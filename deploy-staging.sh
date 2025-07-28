#!/bin/bash
echo "[INFO] Simulando deploy em staging..."
docker network create segfin-net || true
docker run -d --rm --name segfin-frontend --network segfin-net -p 3000:80 segfin-frontend
docker run -d --rm --name segfin-backend --network segfin-net -p 8080:8080 segfin-backend
echo "[INFO] Falco será executado separadamente (host ou container)"
