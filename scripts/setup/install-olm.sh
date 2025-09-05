#!/usr/bin/env bash
set -euo pipefail

echo "Instalando OLM + Operator SDK en Kubernetes..."

# Variables
ARCH=$(case $(uname -m) in
    x86_64) echo -n amd64 ;;
    aarch64) echo -n arm64 ;;
    *) echo -n $(uname -m) ;;
esac)

OS=$(uname | awk '{print tolower($0)}')
OPERATOR_SDK_VERSION=v1.41.1
OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/download/${OPERATOR_SDK_VERSION}

# Crear dir temporal
TMP_DIR=$(mktemp -d -t operator-sdk-XXXX)
echo "Usando directorio temporal: $TMP_DIR"
cd "$TMP_DIR"

# Descargar binario operator-sdk
echo "Descargando operator-sdk..."
curl -sSL -O ${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH}

# Instalar binario
echo "Instalando operator-sdk en /usr/local/bin..."
chmod +x operator-sdk_${OS}_${ARCH}
sudo mv operator-sdk_${OS}_${ARCH} /usr/local/bin/operator-sdk

# Instalar OLM en el cluster (última versión estable)
echo "Instalando OLM en el cluster..."
operator-sdk olm install

# Limpiar
echo "Limpiando temporales..."
cd ~
rm -rf "$TMP_DIR"

echo "Instalación completada. Verifica con:"
echo "  kubectl get pods -n olm"
echo "  operator-sdk version"
echo "  operator-sdk olm status"
