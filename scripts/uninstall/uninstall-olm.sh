#!/usr/bin/env bash
set -euo pipefail

echo "Desinstalando OLM del cluster..."

# Eliminar OLM (usando operator-sdk)
if command -v operator-sdk &> /dev/null; then
  echo "Ejecutando: operator-sdk olm uninstall"
  operator-sdk olm uninstall
else
  echo "No se encontró 'operator-sdk' en el PATH. Desinstalando manualmente..."
  kubectl delete -n olm deployment olm-operator catalog-operator packageserver --ignore-not-found
  kubectl delete -n olm service catalog-operator-metrics olm-operator-metrics packageserver-metrics --ignore-not-found
  kubectl delete -n olm configmap olm-operators catalogsources --ignore-not-found
  kubectl delete namespace olm --ignore-not-found
  kubectl delete namespace operators --ignore-not-found
fi

echo "Eliminando CRDs de OLM..."
kubectl delete crd clusterserviceversions.operators.coreos.com --ignore-not-found
kubectl delete crd installplans.operators.coreos.com --ignore-not-found
kubectl delete crd subscriptions.operators.coreos.com --ignore-not-found
kubectl delete crd catalogsources.operators.coreos.com --ignore-not-found
kubectl delete crd operatorgroups.operators.coreos.com --ignore-not-found

echo "OLM desinstalado correctamente."
echo "   Verifica con: kubectl get pods -n olm"
echo "   (El namespace 'olm' debería estar eliminado o vacío)"
echo "   Verifica con: operator-sdk olm status"
echo "   (Debería indicar que OLM no está instalado)"
