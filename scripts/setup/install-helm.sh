#!/bin/bash

# Variables
HELM_URL="https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3"
HELM_TMP="/tmp/get_helm.sh"

# Comprobar si Helm ya está instalado
if command -v helm &> /dev/null; then
    echo "Helm ya está instalado. Versión: $(helm version --short)"
    exit 0
fi

# Descargar el script de instalación oficial de Helm
echo "Instalando Helm..."
curl -fsSL $HELM_URL -o $HELM_TMP
chmod 700 $HELM_TMP
sh $HELM_TMP
rm $HELM_TMP

# Verificar la instalación
if command -v helm &> /dev/null; then
    echo "Helm se ha instalado correctamente. Versión: $(helm version --short)"
else
    echo "Hubo un problema instalando Helm."
    exit
fi