# 📘 Helm

## 📑 Tabla de Contenidos
1. [Referencias](#-referencias)  
2. [Introducción](#-introducción)  
3. [Conceptos clave](#-conceptos-clave)  
    - [¿Qué es un Chart?](#qué-es-un-chart)  
    - [Estructura de un Chart](#estructura-de-un-chart)  
4. [Instalación](#️-instalación)  
5. [Quickstart](#-quickstart)  
6. [Comandos útiles](#️-comandos-útiles)  
7. [Tips y buenas prácticas](#-tips-y-buenas-prácticas)  
8. [Próximos pasos](#-próximos-pasos)  

---

## 📚 Referencias
- [Documentación oficial de Helm](https://helm.sh/docs/)
- [Cheatsheet de Helm](https://www.hackingnote.com/en/cheatsheets/helm/) 
- [Charts oficiales de Bitnami](https://bitnami.com/stacks/helm)
- [Helm Hub (Artifact Hub)](https://artifacthub.io/)
- [Artículo: Helm vs Kustomize](https://dev.to/israoo/helm-vs-kustomize-cual-es-mejor-para-gestionar-manifiestos-en-kubernetes-3d7)

---

## 🔹 Introducción
[Helm](https://helm.sh/) es el gestor de paquetes oficial para Kubernetes. Permite definir, instalar y actualizar aplicaciones Kubernetes mediante "charts", que son plantillas reutilizables de recursos.  
En este laboratorio, Helm se utiliza para desplegar aplicaciones de ejemplo (como Spring Petclinic) y gestionar dependencias de forma sencilla y declarativa.

---

## 🧩 Conceptos Clave

### ¿Qué es un Chart?
Un **Chart** es un paquete de Helm que contiene todos los recursos necesarios para desplegar una aplicación, herramienta o servicio en Kubernetes.  
Incluye plantillas de manifiestos, archivos de configuración (`values.yaml`) y metadatos (`Chart.yaml`).

---

### Estructura de un Chart
Un chart típico tiene la siguiente estructura:
```
mychart/
  Chart.yaml          # Metadatos del chart (nombre, versión, descripción)
  values.yaml         # Valores por defecto para las plantillas
  charts/             # Dependencias de otros charts
  templates/          # Plantillas de manifiestos Kubernetes
  README.md           # Documentación opcional
```
Esto permite reutilizar y versionar despliegues de aplicaciones de forma sencilla.

---

## ⚙️ Instalación

1. **Ejecutar el script de instalación**
    ```bash
    ./scripts/setup/install-helm.sh
    ```
    También puedes instalarlo manualmente siguiendo la [guía oficial](https://helm.sh/docs/intro/install/).

2. **Verificar la instalación**
    ```bash
    helm version
    ```

---

## ⚡ Quickstart

1. **Agregar un repositorio de charts externo (opcional)**
    ```bash
    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm repo update
    ```

2. **Desplegar tu propio chart local (`./helm/petclinic`)**
    ```bash
    # Desde la raíz del repositorio
    helm install petclinic ./helm/petclinic
    ```

3. **Listar releases instaladas**
    ```bash
    helm list
    ```

4. **Actualizar el release con nuevos valores**
    ```bash
    helm upgrade petclinic ./helm/petclinic --set replicaCount=2
    ```

5. **Eliminar el release**
    ```bash
    helm uninstall petclinic
    ```

6. **(Opcional) Desplegar un chart externo de ejemplo**
    ```bash
    helm install my-nginx bitnami/nginx
    ```

---

## 🛠️ Comandos Útiles

```bash
# REPOSITORIOS
helm repo add <nombre> <url>     # Añadir un repositorio
helm repo update                 # Actualizar índices de repositorios
helm search repo <palabra>       # Buscar charts en los repositorios añadidos

# RELEASES
helm install <release> <chart>   # Instalar un chart
helm upgrade <release> <chart>   # Actualizar un release
helm rollback <release> <rev>    # Volver a una versión anterior
helm uninstall <release>         # Eliminar un release
helm list -A                     # Listar releases en todos los namespaces

# DEBUG Y VALIDACIÓN
helm template <chart>            # Renderizar los manifiestos sin instalarlos
helm lint <chart>                # Validar la sintaxis de un chart
helm status <release>            # Ver estado de un release
helm show values bitnami/nginx   # Ver los valores por defecto de un chart
helm get manifest <release>      # Ver los recursos desplegados por un release
helm get values <release>        # Ver los valores usados en un release
```

---

## 💡 Tips y buenas prácticas

1. **Creación de charts**
    - Usa `helm create <nombre>` para generar la estructura básica de un nuevo chart.
    - Añade documentación en el `README.md` de cada chart.

2. **Personalización de despliegues**
    - Usa archivos `values.yaml` para personalizar la configuración de los charts.
    - Puedes sobrescribir valores puntuales con `--set clave=valor`.

3. **Control de versiones**
    - Versiona tus charts en `Chart.yaml`.
    - Etiqueta releases en tu repositorio Git para correlacionar con despliegues en el clúster.

4. **Gestión de dependencias**
    - Los charts pueden tener dependencias definidas en `Chart.yaml`.
    - Ejecuta `helm dependency update` en el directorio del chart para descargarlas.

5. **Debug y troubleshooting**
    - Usa `helm template` para renderizar los manifiestos sin aplicar nada al clúster.
    - El comando `helm status <release>` muestra el estado actual del despliegue.

6. **Integración con repositorios privados**
    - Puedes añadir repositorios privados con autenticación usando `helm repo add` y las opciones `--username` y `--password`.

---

## 🚀 Próximos pasos

- **Crea tus propios charts:**  
    Practica generando charts personalizados para tus aplicaciones: `helm create <release>`
- **Explora Artifact Hub:**  
    Descubre y prueba charts de la comunidad en [Artifact Hub](https://artifacthub.io/).
- **Integra Helm en pipelines CI/CD:**  
    Automatiza despliegues usando Helm en tus pipelines de integración y entrega continua.
- **Prueba la gestión de valores:**  
    Usa diferentes archivos `values.yaml` para distintos entornos (dev, staging, prod).
- **Experimenta con dependencias:**  
    Añade y gestiona dependencias entre charts complejos.
- **Contribuye a la documentación:**  
    Añade ejemplos, troubleshooting y buenas prácticas según tu experiencia.

---