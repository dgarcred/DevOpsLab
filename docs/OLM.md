# 📘 Operator Lifecycle Manager (OLM)

## 📑 Tabla de Contenidos
1. [Referencias](#-referencias)  
2. [Introducción](#-introducción)  
3. [Conceptos clave](#-conceptos-clave)  
    - [¿Qué es un Operator?](#qué-es-un-operator)
    - [¿Qué es OLM?](#qué-es-olm)
    - [Recursos principales de olm](#recursos-principales-de-olm)
4. [Instalación](#️-instalación)
5. [Quickstart](#-quickstart)  
6. [Comandos útiles](#️-comandos-útiles)  
7. [Tips](#-tips-y-buenas-prácticas)  
8. [Próximos pasos](#-próximos-pasos)  

---

## 📚 Referencias

- [Documentación oficial de OLM](https://olm.operatorframework.io/docs/)
- [OperatorHub.io](https://operatorhub.io/)
- [OLM en GitHub](https://github.com/operator-framework/operator-lifecycle-manager)
- [OLM Quick Start](https://olm.operatorframework.io/docs/getting-started/)

---

## 🔹 Introducción
[Operator Lifecycle Manager (OLM)](https://olm.operatorframework.io/) es un componente del [Operator Framework](https://operatorframework.io/) que facilita la gestión, instalación, actualización y eliminación de Operators en clústeres Kubernetes.  
OLM automatiza el ciclo de vida de los Operators, permitiendo a los usuarios instalar y mantener Operators y sus dependencias de forma declarativa y segura.

En este laboratorio, OLM se utiliza para experimentar con la instalación y gestión de Operators en Minikube, facilitando la adopción de patrones avanzados de automatización en Kubernetes.

---

## 🧩 Conceptos Clave

### ¿Qué es un Operator?
Un **Operator** en el contexto de Kubernetes es una extensión que automatiza la gestión de aplicaciones complejas y sus recursos dentro del clúster.
Utiliza los conceptos nativos de Kubernetes (como Custom Resource Definitions y controladores) permitiendo instalar, configurar, actualizar, escalar y recuperar aplicaciones de forma automática y declarativa.

---

### ¿Qué es OLM?
OLM es el gestor de ciclo de vida de Operators. Se encarga de:
- Instalar y actualizar Operators y sus dependencias.
- Gestionar versiones y actualizaciones automáticas.
- Proveer un catálogo de Operators (OperatorHub).
- Gestionar la suscripción y el ciclo de vida de los recursos personalizados.

---

### Recursos principales de OLM
- **ClusterServiceVersion (CSV):** Describe una versión de un Operator y sus capacidades.
- **Subscription:** Define qué Operator instalar y cómo actualizarlo.
- **InstallPlan:** Plan de instalación o actualización de un Operator.
- **CatalogSource:** Fuente de Operators disponibles (local o remota).

---

## ⚙️ Instalación

1. **Ejecutar el script de instalación**
    ```bash
    ./scripts/setup/install-olm.sh
    ```

2. **Verificar la instalación**
    ```bash
    kubectl get pods -n olm
    kubectl get csv -A   # Ver los ClusterServiceVersions instalados
    ```

---

## ⚡ Quickstart

1. **Instalar un Operator desde OperatorHub**
    - Encuentra el nombre del Operator en [OperatorHub.io](https://operatorhub.io/).
    - Descarga el manifiesto de instalación, por ejemplo, para el Operator de etcd:
    ```bash
    kubectl apply -f https://operatorhub.io/install/etcd.yaml
    ```

2. **Verificar la instalación del Operator**
    ```bash
    kubectl get csv -n operators
    kubectl get pods -n operators
    ```

3. **Crear una instancia del recurso gestionado por el Operator**
    - Consulta la documentación del Operator para crear un recurso personalizado (CR).
    - Ejemplo (para etcd):
    ```yaml
    piVersion: etcd.database.coreos.com/v1beta2
    kind: EtcdCluster
    metadata:
      name: example
      namespace: default
    spec:
      size: 3
      version: "3.2.13"
    ```
    - Aplica el manifiesto:
    ```bash
    kubectl apply -f etcd-cluster.yaml
    ```

---

## 🛠️ Comandos Útiles

```bash
# VERIFICAR RECURSOS DE OLM
kubectl get pods -n olm
kubectl get deployment -n olm
kubectl get csv -A                      # Ver todos los ClusterServiceVersions
kubectl get installplan -A              # Ver planes de instalación de Operators
kubectl get subscription -A             # Ver suscripciones activas

# INSTALAR/ELIMINAR OPERATORS
kubectl apply -f <operator.yaml>        # Instalar un Operator desde OperatorHub
kubectl delete -f <operator.yaml>       # Eliminar un Operator

# GESTIÓN DE OPERATORS
kubectl describe csv <csv-name> -n operators
kubectl get crd                         # Ver CustomResourceDefinitions instaladas
kubectl get <custom-resource> -A        # Ver recursos gestionados por el Operator
```

---

## 💡 Tips y buenas prácticas

1. **Namespaces**
    - OLM instala sus recursos en el namespace `olm` y los Operators suelen desplegarse en `operators` o en el namespace que elijas.

2. **Actualizaciones**
    - OLM gestiona automáticamente las actualizaciones de Operators si la suscripción está configurada en modo automático.

3. **OperatorHub**
    - Puedes instalar Operators directamente desde OperatorHub.io copiando el manifiesto de instalación.

4. **Desinstalación limpia**
    - Elimina primero las instancias de los recursos personalizados antes de eliminar el Operator para evitar recursos huérfanos.

5. **Troubleshooting**
    - Usa `kubectl describe csv <csv-name>` y revisa los eventos para diagnosticar problemas de instalación o actualización.

6. **Desarrollo local**
    - OLM es útil para probar Operators desarrollados localmente antes de publicarlos en OperatorHub.

---

## 🚀 Próximos pasos

- **Explora OperatorHub.io:**  
    Instala y prueba diferentes Operators en tu laboratorio.
- **Crea tus propios recursos personalizados:**  
    Experimenta con la creación y gestión de CRDs y recursos gestionados por Operators.
- **Automatiza despliegues:**  
    Usa OLM en pipelines de CI/CD para instalar y actualizar Operators automáticamente.
- **Investiga la creación de Operators:**  
    Aprende a desarrollar y empaquetar tus propios Operators usando el [Operator SDK](https://sdk.operatorframework.io/).
- **Prueba la actualización de Operators:**  
    Cambia la versión de un Operator y observa cómo OLM gestiona el proceso.
- **Contribuye a la documentación:**  
    Añade ejemplos y buenas prácticas según tu experiencia con OLM.

---