# 📘 ArgoCD

## 📑 Tabla de Contenidos
1. [Referencias](#-referencias)  
2. [Introducción](#-introducción)  
3. [Conceptos clave](#-conceptos-clave)  
    - [¿Qué es ArgoCD?](#qué-es-argocd)  
    - [Application](#application)
    - [Project](#project)
    - [Sincronización (sync)](#sincronización-sync)
    - [Kustomize](#kustomize)
    - [Jsonnet](#jsonnet)
    - [Hooks y Waves](#hooks-y-waves)
    - [Health y Status](#health-y-status)
    - [Rollback y History](#rollback-y-history)
    - [RBAC y Seguridad](#rbac-y-seguridad)
    - [Integración con CI/CD y GitOps](#integración-con-cicd-y-gitops)
    - [Notificaciones y Webhooks](#notificaciones-y-webhooks)
4. [Estrategias de gestión de manifiestos](#-estrategias-de-gestión-de-manifiestos)
5. [Instalación](#️-instalación)  
6. [Quickstart](#-quickstart)  
7. [Comandos útiles](#️-comandos-útiles)  
8. [Tips y buenas prácticas](#-tips-y-buenas-prácticas)  
9. [Próximos pasos](#-próximos-pasos)  

---

## 📚 Referencias
- [Documentación oficial de ArgoCD](https://argo-cd.readthedocs.io/)
- [ArgoCD Quick Install](https://www.armand.nz/notes/ArgoCD/ArgoCD%20Quick%20Install)
- [Tracking strategies](https://argo-cd.readthedocs.io/en/stable/user-guide/tracking_strategies/)
- [ArgoCD Cheatsheet](https://medium.com/@kirankumar282/argocd-cheat-sheet-dfca7654c5d9) 

---

## 🔹 Introducción
[ArgoCD](https://argo-cd.readthedocs.io/) es una herramienta de GitOps para Kubernetes que permite gestionar el ciclo de vida de aplicaciones declarativas.  
Sincroniza automáticamente el estado del clúster con los manifiestos almacenados en un repositorio Git, facilitando despliegues, rollbacks y auditoría de cambios.  
En este laboratorio, ArgoCD se utiliza para desplegar y gestionar aplicaciones en Minikube de forma declarativa y reproducible.

---

## 🧩 Conceptos Clave

### ¿Qué es ArgoCD?
ArgoCD es una herramienta de **GitOps** para Kubernetes que permite gestionar el ciclo de vida de aplicaciones declarativas.  
ArgoCD sincroniza automáticamente el estado del clúster con los manifiestos almacenados en un repositorio Git, facilitando despliegues, rollbacks, auditoría de cambios y control de versiones de la infraestructura.

---

### Application
El recurso principal de ArgoCD es la **Application**.  
Una Application representa una aplicación Kubernetes gestionada por ArgoCD, definiendo:
- El repositorio Git fuente y la ruta donde están los manifiestos.
- El clúster y namespace destino.
- El tipo de manifiestos (YAML, Helm, Kustomize, Jsonnet, etc.).
- Opciones de sincronización, auto-sync, políticas de salud y hooks.

---

### Project
Un **Project** en ArgoCD es una agrupación lógica de aplicaciones bajo un conjunto de políticas comunes.  
Permite:
- Restringir en qué clústeres y namespaces pueden desplegarse las aplicaciones.
- Limitar los repositorios Git permitidos.
- Definir políticas de sincronización y eliminación de recursos.
- Aplicar reglas RBAC específicas para equipos o entornos.

Esto aporta control, seguridad y segmentación en la gestión de aplicaciones.

---

### Sincronización (Sync)
La **sincronización** es el proceso mediante el cual ArgoCD compara el estado deseado (definido en Git) con el estado real del clúster y aplica los cambios necesarios para alinearlos.  
Puede ser manual o automática (auto-sync).  
ArgoCD detecta el "drift" (desviación) y puede restaurar el estado correcto si se detectan cambios no deseados.

---

### Kustomize
**Kustomize** es una herramienta nativa de Kubernetes para la personalización de manifiestos YAML sin necesidad de plantillas. Permite definir una base común y aplicar "overlays" (capas de personalización) para distintos entornos (dev, staging, prod) o configuraciones.  
ArgoCD soporta aplicaciones basadas en Kustomize de forma nativa, detectando automáticamente la presencia de un archivo `kustomization.yaml` en el path del repositorio Git.  

**Ventajas de Kustomize en ArgoCD:**
- Permite reutilizar y mantener DRY los manifiestos.
- Facilita la gestión de configuraciones por entorno.
- No requiere plantillas ni variables, todo es YAML puro.

---

### Jsonnet
**Jsonnet** es un lenguaje de generación de datos estructurados (JSON/YAML) que permite crear manifiestos Kubernetes de forma programática y reutilizable.  
Con Jsonnet puedes definir plantillas complejas, importar librerías y componer configuraciones de manera avanzada.

ArgoCD soporta aplicaciones basadas en Jsonnet, permitiendo renderizar los manifiestos antes de aplicarlos al clúster.

**Ventajas de Jsonnet en ArgoCD:**
- Permite lógica condicional, bucles y composición avanzada.
- Facilita la reutilización y el mantenimiento de configuraciones complejas.
- Ideal para organizaciones con necesidades de configuración dinámica.

---

### Hooks y Waves
ArgoCD permite definir **hooks** (pre-sync, post-sync, sync-fail, etc.) para ejecutar tareas adicionales durante el ciclo de vida de la sincronización.  
También soporta **waves** para controlar el orden de aplicación de recursos.

---

### Health y Status
ArgoCD evalúa el **estado de salud** (Health) y el **estado de sincronización** (Sync Status) de cada Application y recurso gestionado, mostrando información visual y alertas en la interfaz web.

---

### Rollback y History
ArgoCD mantiene un historial de sincronizaciones y permite hacer **rollback** a versiones anteriores de la aplicación, facilitando la recuperación ante errores.

---

### RBAC y Seguridad
ArgoCD soporta control de acceso basado en roles (RBAC), integración con SSO (OIDC, LDAP), y políticas de acceso granular a nivel de Application y Project.

---

### Integración con CI/CD y GitOps
ArgoCD se integra fácilmente con pipelines de CI/CD, permitiendo automatizar despliegues tras cada commit en Git y habilitando flujos GitOps completos.

---

### Notificaciones y Webhooks
ArgoCD puede enviar notificaciones y disparar webhooks ante eventos relevantes (sincronización, fallo, drift, etc.), facilitando la integración con sistemas externos de alertas y monitorización.

---

### Ventajas de ArgoCD
- **Declarativo y reproducible:** Todo el estado está en Git.
- **Auditoría y trazabilidad:** Cada cambio queda registrado y versionado.
- **Automatización:** Sincronización automática y detección de drift.
- **Visualización:** Interfaz web intuitiva para gestionar y auditar aplicaciones.
- **Escalabilidad:** Soporta múltiples clústeres y cientos de aplicaciones.
- **Extensibilidad:** Plugins, hooks y soporte para múltiples formatos de manifiestos.

---


## 🔍 Estrategias de gestión de manifiestos

ArgoCD soporta varios mecanismos de gestión de manifiestos:  

1. **Directory app**  
- Usa manifiestos Kubernetes en YAML dentro de un directorio.  
- Útil si tienes manifiestos simples sin Helm/Kustomize.  
    ```bash
    argocd app create my-dir-app \
        --repo https://github.com/org/repo.git \  
        --path manifests \  
        --dest-namespace default \  
        --dest-server https://kubernetes.default.svc \  
        --directory-recurse  
    ```
<br>

2. **Helm app (desde repo Git con Chart)**  
- Usa un Helm Chart que vive en un repo Git. 
- Puedes pasar los valores con `--helm-set` o `helm-values`. 
    ```bash
    argocd app create helm-guestbook \
        --repo https://github.com/argoproj/argocd-example-apps.git \
        --path helm-guestbook \
        --dest-namespace default \
        --dest-server https://kubernetes.default.svc \
        --helm-set replicaCount=2
    ```
<br>

3. **Helm app (desde repo de charts)**
- Descarga directamente un chart desde un Helm repo.
    ```bash
    argocd app create nginx-ingress \
        --repo https://charts.helm.sh/stable \
        --helm-chart nginx-ingress \
        --revision 1.24.3 \
        --dest-namespace default \
        --dest-server https://kubernetes.default.svc
    ```
<br>

4. **Kustomize app**
- Usa kustomization.yaml para overlays y bases. 
    ```bash
    argocd app create kustomize-guestbook \
        --repo https://github.com/argoproj/argocd-example-apps.git \
        --path kustomize-guestbook \
        --dest-namespace default \
        --dest-server https://kubernetes.default.svc
    ```
<br>

5. **Jsonnet app**
- Usa Jsonnet como generador de manifiestos. 
    ```bash
    argocd app create jsonnet-guestbook \
        --repo https://github.com/argoproj/argocd-example-apps.git \
        --path jsonnet-guestbook \
        --dest-namespace default \
        --dest-server https://kubernetes.default.svc \
        --jsonnet-ext-str replicas=2
    ```
<br>

6. **Multi-source app**
- Combina varios orígenes (ej: un repo Git con Kustomize y un repo de Helm). 
- Se define con un manifest `Application` YAML y se aplica vía `kubectl`. 

<br>

7. **Custom tool app (plugins)**
- Puedes registrar un plugin de renderizado (ej. Kasane) y usarlo con ArgoCD. 
- Esto te permite integrar tu propio *config management tool*. 

<br>

---

## ⚙️ Instalación

1. **Ejecutar el script de instalación**  
    El siguiente script instala ArgoCD en el clúster de Minikube, y también la CLI de ArgoCD.  
    Requisitos: `kubectl`  
    ```bash
    ./scripts/setup/install-argocd.sh
    ```

2. **Verificar la instalación**
    ```bash
    kubectl get all -n argocd
    ```

---

## ⚡ Quickstart

1. **Exponer el servidor de ArgoCD**  
    Por defecto, el servicio es interno (ClusterIP). Exponerlo: 
    ```bash
    kubectl port-forward svc/argocd-server -n argocd 8080:443
    ```
    Accede a la interfaz en [https://localhost:8080](https://localhost:8080)

2. **Obtener la contraseña inicial del usuario admin**
    Se puede usar cualquiera de estos dos comandos:
    ```bash
    kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d && echo
    argocd admin initial-password -n argocd
    ```

3. **Loguearse en el clúster de ArgoCD de minikube**
    ```bash
    argocd login localhost:8080 --username admin --password <password> --insecure
    argocd cluster list
    ```

4. **Actualizar la contraseña del usuario admin**
    ```bash
    argocd account update-password
    ```

5. **Eliminar secreto de la contraseña inicial del admin**
    ```bash
    kubectl delete secret argocd-initial-admin-secret -n argocd
    ```

6. **Registrar un repositorio de prueba**
    ```bash
    argocd repo add https://github.com/argoproj/argocd-example-apps.git
    argocd repo list
    ```

7. **Crear namespace para la aplicación de prueba**
    ```bash
    kubectl create namespace argocd-test-app
    ```

8. **Registrar una aplicación de prueba**
    ```bash
    argocd app create guestbook \
        --repo https://github.com/argoproj/argocd-example-apps.git \
        --path guestbook \
        --dest-server https://kubernetes.default.svc \
        --dest-namespace argocd-test-app
    argocd app list
    ```

9. **Ver el estado de la app**
    ```bash
    argocd app list
    argocd app get guestbook
    ```

10. **Sincronizar la aplicación**
    ```bash
    argocd app sync guestbook
    ```

11. **Ver la aplicación corriendo**
    ```bash
    kubectl get pods -n argocd-test-app
    ```

12. **Exponer la aplicación con minikube**
    ```bash
    minikube service guestbook-ui -n argocd-test-app
    ```

---

## 🛠️ Comandos Útiles

```bash
# LOGIN Y CONFIGURACIÓN
argocd version
argocd login <host>:<port> --username <user> --password <pass> --insecure
argocd logout <host>:<port>
argocd account update-password
argocd account list
argocd context
argocd cluster add <cluster>
argocd cluster list
argocd cluster rm

# APLICACIONES
argocd app create <app> [flags]
argocd app list
argocd app get <app>
argocd app sync <app>
argocd app resources <app>
argocd app delete <app>
argocd app diff <app>

# REPOSITORIOS
argocd repo add <repo-url> --username <user> --password <pass>
argocd repo list
argocd repo rm <repo>
argocd repo list-resources <repo>

# PROYECTOS
argocd proj create <proj>
argocd proj get <proj>
argocd proj delete <proj>
argocd proj list

# ROLLBACK Y HISTÓRICO
argocd app history <app>
argocd app rollback <app> <revision>
```

---

## 💡 Tips y buenas prácticas

1. **GitOps puro:**  
    Realiza todos los cambios en el repositorio Git; ArgoCD sincroniza el clúster automáticamente.
2. **Uso de Projects:**  
    Aísla ambientes y define políticas de seguridad y despliegue.
3. **Declarativo:**  
    Define tus apps en YAML (`Application` CR) y aplica con `kubectl apply -f`, en lugar de usar siempre `argocd app create`.
4. **Repositorios privados:**  
    Crea un Secret de repo en ArgoCD y asígnalo al Project para acceder a repos privados.
5. **Auto-sync:**  
    Actívalo solo en entornos donde quieras que cada cambio en Git se aplique automáticamente.
6. **Gestión de valores Helm:**  
    Prefiere guardar los valores en un `values.yaml` versionado en Git antes que usar `--helm-set` en CLI.
7. **Organización:**  
    Usa nombres claros y consistentes para apps y projects (`guestbook-dev`, `guestbook-prod`).
8. **UI de ArgoCD:**  
    La interfaz web es muy útil para ver diferencias (drift detection), sincronizar y auditar cambios.
9. **RBAC:**  
    Aprovecha las políticas de acceso para controlar quién puede operar sobre cada Project o aplicación.

---

## 🚀 Próximos pasos

- **Practica con diferentes tipos de aplicaciones:**  
    Despliega apps usando manifiestos simples, Helm, Kustomize y Jsonnet.
- **Crea y gestiona Projects:**  
    Define políticas de acceso y restricciones para distintos equipos o entornos.
- **Automatiza flujos GitOps:**  
    Integra ArgoCD con pipelines de CI/CD para despliegues automáticos tras cada commit.
- **Configura repositorios privados:**  
    Prueba la gestión de credenciales y acceso seguro a repos Git privados.
- **Explora la API y CRDs de ArgoCD:**  
    Familiarízate con los recursos `Application`, `AppProject`, etc.
- **Prueba la detección de drift:**  
    Modifica recursos manualmente en el clúster y observa cómo ArgoCD detecta y corrige las diferencias.
- **Investiga la integración con notificaciones:**  
    Configura alertas para eventos de sincronización o fallos de despliegue.
- **Explora la integración con SSO y RBAC avanzado:**  
    Configura autenticación con OIDC, LDAP, etc., y políticas de acceso granular.
- **Contribuye a la documentación:**  
    Añade ejemplos, troubleshooting y buenas prácticas según tu experiencia.

---