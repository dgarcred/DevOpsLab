#!/bin/bash

# Variables
ARGOCD_URL="https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
ARGOCD_CLI_URL="https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64"
ARGOCD_CLI_TMP="/tmp/argocd-linux-amd64"
ARGOCD_CLI_PATH="/usr/local/bin/argocd"

# Install ArgoCD in the Kubernetes cluster if not already installed
if kubectl get ns argocd >/dev/null 2>&1 && kubectl get pods -n argocd | grep argocd-server >/dev/null 2>&1; then
  echo "ArgoCD ya está instalado en el clúster."
else
  echo "Instalando ArgoCD en el clúster..."
  kubectl create namespace argocd 2>/dev/null || true
  kubectl apply -n argocd -f $ARGOCD_URL
fi

# Install the ArgoCD CLI if not already installed
if command -v argocd >/dev/null 2>&1; then
  echo "La CLI de ArgoCD ya está instalada."
else
  echo "Instalando la CLI de ArgoCD..."
  curl -sSL -o $ARGOCD_CLI_TMP $ARGOCD_CLI_URL
  sudo install -m 555 $ARGOCD_CLI_TMP $ARGOCD_CLI_PATH
  rm $ARGOCD_CLI_TMP
fi
