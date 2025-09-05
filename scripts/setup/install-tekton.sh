#!/bin/bash

# Variables
TKN_PIPELINES_URL="https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml"
TKN_DASHBOARD_URL="https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml"
TKN_TRIGGERS_URL="https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml"
TKN_TRIGGERS_INTERCEPTORS_URL="https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml"

TKN_CLI_VERSION="$(curl -s https://api.github.com/repos/tektoncd/cli/releases/latest | grep tag_name | cut -d '"' -f 4)"
TKN_CLI_URL="https://github.com/tektoncd/cli/releases/download/${TKN_VERSION}/tkn_${TKN_VERSION:1}_Linux_x86_64.tar.gz"
TKN_CLI_TMP="/tmp/tkn_${TKN_VERSION:1}_Linux_x86_64.tar.gz"
TKN_CLI_PATH="/usr/local/bin/tkn"


# Comprobar si kubectl está instalado
if ! command -v kubectl &> /dev/null; then
    echo "kubectl no está instalado. Instálalo antes de continuar."
    exit 1
fi

# Comprobar si minikube está corriendo
if ! minikube status &> /dev/null; then
    echo "Minikube no está corriendo. Inícialo antes de instalar Tekton."
    exit 1
fi

# Comprobar si Tekton Pipelines ya está instalado
if kubectl get deployment tekton-pipelines-controller -n tekton-pipelines &> /dev/null; then
    echo "Tekton Pipelines ya está instalado en el clúster."
else
    echo "Instalando Tekton Pipelines en minikube..."
    kubectl apply --filename $TKN_PIPELINES_URL
    echo "Esperando a que los pods de Tekton estén listos..."
    kubectl wait --for=condition=Available --timeout=180s deployment --all -n tekton-pipelines
    echo "Tekton Pipelines se ha instalado correctamente"
fi

# Comprobar si Tekton Dashboard ya está instalado
if kubectl get deployment tekton-dashboard -n tekton-pipelines &> /dev/null; then
    echo "Tekton Dashboard ya está instalado en el clúster."
else
    echo "Instalando Tekton Dashboard en minikube..."
    kubectl apply --filename $TKN_DASHBOARD_URL
    echo "Esperando a que los pods de Tekton Dashboard estén listos..."
    kubectl wait --for=condition=Available --timeout=180s deployment tekton-dashboard -n tekton-pipelines
    echo "Tekton Dashboard se ha instalado correctamente"
fi

# Instalar Tekton Triggers y sus interceptors si no están instalados
if kubectl get deployment tekton-triggers-controller -n tekton-pipelines &> /dev/null; then
    echo "Tekton Triggers ya está instalado en el clúster."
else
    echo "Instalando Tekton Triggers en minikube..."
    kubectl apply --filename $TKN_TRIGGERS_URL
    kubectl apply --filename $TKN_TRIGGERS_INTERCEPTORS_URL
    echo "Esperando a que los pods de Tekton Triggers estén listos..."
    kubectl wait --for=condition=Available --timeout=180s deployment tekton-triggers-controller -n tekton-pipelines
    echo "Tekton Triggers se ha instalado correctamente"
fi

# Instalar Tekton CLI (tkn) si no está instalado
if command -v tkn &> /dev/null; then
    echo "Tekton CLI (tkn) ya está instalado. Versión: $(tkn version | head -n 1)"
else
    echo "Descargando e instalando Tekton CLI (tkn)..."
    curl -L $TKN_CLI_URL -o $TKN_CLI_TMP
    tar -xzf $TKN_CLI_TMP tkn
    sudo mv tkn $TKN_CLI_PATH
    rm $TKN_CLI_TMP
    echo "Tekton CLI (tkn) se ha instalado correctamente. Versión: $(tkn version | head -n 1)"
fi