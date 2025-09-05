#!/bin/bash

# Variables
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
KUBECTL_URL="https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
KUBECTL_TMP="/tmp/kubectl"
KUBECTL_PATH="/usr/local/bin/kubectl"

# Comprobar si kubectl ya está instalado
if command -v kubectl &> /dev/null; then
    echo "kubectl ya está instalado. Versión: $(kubectl version)"
    exit 0
fi

# Descargar la última versión estable de kubectl
echo "Instalando kubectl..."
curl -L $KUBECTL_URL -o $KUBECTL_TMP

# Instalar kubectl
sudo install -o root -g root -m 0755 $KUBECTL_TMP $KUBECTL_PATH

# Limpiar archivo descargado
rm $KUBECTL_TMP

# Verificar la instalación
if command -v kubectl &> /dev/null; then
    echo "kubectl se ha instalado correctamente. Versión: $(kubectl version)"
else
    echo "Hubo un problema instalando kubectl."
fi
