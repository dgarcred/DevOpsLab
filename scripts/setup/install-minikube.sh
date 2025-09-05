#!/bin/bash

# Variables
MINIKUBE_URL="https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64"
MINIKUBE_TMP="/tmp/minikube-linux-amd64"
MINIKUBE_PATH="/usr/local/bin/minikube"

# Comprobar si minikube ya está instalado
if command -v minikube &> /dev/null; then
    echo "minikube ya está instalado. Versión: $(minikube version | head -n 1)"
    exit 0
fi

echo "Instalando minikube..."

# Descargar la última versión de minikube para Linux amd64
curl -L $MINIKUBE_URL -o $MINIKUBE_TMP

# Instalar minikube
sudo install $MINIKUBE_TMP $MINIKUBE_PATH

# Limpiar archivo descargado
rm $MINIKUBE_TMP

# Verificar la instalación
if command -v minikube &> /dev/null; then
    echo "minikube se ha instalado correctamente. Versión: $(minikube version | head -n 1)"
else
    echo "Hubo un problema instalando minikube."
fi
