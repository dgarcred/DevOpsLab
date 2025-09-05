# 🧪 DevOpsLab: Laboratorio Local en Minikube

Este repositorio proporciona una guía completa para levantar y gestionar un **laboratorio local de Kubernetes** sobre [Minikube](https://minikube.sigs.k8s.io/), orientado a la **práctica y aprendizaje de herramientas DevOps** utilizadas en MAEC.  
El propósito principal de este laboratorio es ofrecer un entorno controlado y reproducible donde cualquier desarrollador pueda:

- **Practicar la instalación, configuración y uso de herramientas DevOps** como Tekton, Helm, ArgoCD, OLM, entre otras, replicando escenarios reales de integración y despliegue continuo.
- **Familiarizarse con los flujos de trabajo y buenas prácticas** que se aplican en proyectos del MAEC, facilitando la transición al entorno real. 
- **Consultar guías detalladas y ejemplos prácticos** para cada herramienta, tanto para su despliegue local como para su uso en proyectos reales.
- **Experimentar y extender el laboratorio** con nuevos casos de uso, integraciones y automatizaciones, documentando el conocimiento adquirido y compartiéndolo en este repositorio.

Este laboratorio está pensado como un punto de partida para el autoaprendizaje, la experimentación y la mejora continua en el ámbito DevOps, permitiendo probar herramientas antes de su adopción en proyectos reales.

---

## 📑 Tabla de Contenidos
1. [Requisitos Previos](#-requisitos-previos)
2. [Estructura del Proyecto](#-estructura-del-proyecto)
3. [Setup Inicial](#-setup-inicial)
4. [Documentación por Herramienta](#-documentación-por-herramienta)
5. [Flujo de Trabajo Sugerido](#-flujo-de-trabajo-sugerido)
6. [Referencias Generales](#-referencias-generales)

---

## ✅ Requisitos Previos

- Permisos de administrador (perfil **Developer** en *Admin by Request*).
- Herramientas recomendadas:
    - [Visual Studio Code](https://code.visualstudio.com/)
    - [Notepad++](https://notepad-plus-plus.org/downloads/)
- Recursos mínimos: **2 CPUs** y **4 GB de RAM** libres.
- [Docker Desktop para Windows](https://docs.docker.com/desktop/release-notes/) (con integración WSL2).
- [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) y Ubuntu 24.04.
> **Nota**: en los apartados [Configuración de WSL](#2-configuración-de-wsl) y [Docker Desktop](#3-docker-desktop) se explica cómo instalar cada requisito. 

---

## 📂 Estructura del Proyecto

```
DevOpsLab/
│
├── docs/               # Documentación detallada de cada herramienta DevOps
│     ├── KUBERNETES.md
│     ├── HELM.md
│     ├── TEKTON.md
│     ├── ARGOCD.md
│     └── OLM.md
├── scripts/setup/      # Scripts de instalación automatizada de herramientas
├── helm/petclinic/     # Chart de Helm para desplegar la aplicación de prueba Spring Petclinic
└── tekton/             # Pipelines, tareas y triggers de ejemplo de Tekton
```

---

## ⚙️ Setup Inicial

### 1. Clonar el repositorio
```bash
git clone git@bitbucket.org:dgarcred/devopslab.git
cd devopslab
```

### 2. Configuración de WSL
Abre una terminal con permisos de administrador, ve al directorio raíz del proyecto y ejecuta:
```powershell
./scripts/setup/install-wsl.ps1
```
Este script instala **WSL** y una máquina **Ubuntu 24.04**.

Para controlar los recursos que utiliza WSL, copia el archivo:
```bash
./scripts/config/.wslconfig
```
al directorio raíz del usuario:
```
C:\Users\<usuario>\.wslconfig
```

### 3. Docker Desktop
Se recomienda instalar **Docker Desktop para Windows** (no instalar Docker dentro de WSL).

- Descarga desde: [Docker Desktop Release Notes](https://docs.docker.com/desktop/release-notes/)
- Durante la instalación, asegúrate de marcar la opción de integración con WSL.
- Tras la instalación, podrás usar `docker` desde WSL **sin permisos de root (sin sudo)**.

> ⚠️ Ignora el script `./scripts/setup/install-docker.sh`, ya que docker se instala con Docker Desktop para Windows.

---

## 📖 Documentación por Herramienta

La documentación detallada de cada herramienta DevOps utilizada en este laboratorio se encuentra en el directorio [`docs/`](./docs).  
Cada archivo `.md` incluye: Introducción, Conceptos clave, Instalación, Quickstart, Comandos útiles, Tips y buenas prácticas, Próximos pasos y Referencias.

- [Kubernetes & Minikube](./docs/KUBERNETES.md)
- [Helm](./docs/HELM.md)
- [Tekton](./docs/TEKTON.md)
- [ArgoCD](./docs/ARGOCD.md)
- [Operator Lifecycle Manager (OLM)](./docs/OLM.md)

---

## 🔄 Flujo de Trabajo Sugerido

1. **Configura el entorno local** (WSL, Docker Desktop, Minikube).
2. **Instala las herramientas base** usando los scripts en `scripts/setup/`.
3. **Consulta la documentación** de cada herramienta en el directorio `docs/` antes de instalar o probar.
4. **Despliega y prueba las herramientas DevOps** incluidas (Helm, Tekton, ArgoCD, OLM).
5. **Experimenta con los ejemplos** de pipelines, despliegues y registros.
6. **Extiende el laboratorio** con tus propios casos de uso, charts, pipelines o integraciones.
7. **Documenta tus aprendizajes** y buenas prácticas en los archivos correspondientes de `docs/`.

---

## 🌐 Referencias Generales

- [Kubernetes](https://kubernetes.io/docs/)
- [Minikube](https://minikube.sigs.k8s.io/docs/)
- [Helm](https://helm.sh/docs/)
- [Tekton](https://tekton.dev/docs/)
- [ArgoCD](https://argo-cd.readthedocs.io/)
- [Operator Framework / OLM](https://olm.operatorframework.io/)

---

📌 **Nota:** Este laboratorio está diseñado para uso **educativo y de práctica**. No debe utilizarse en entornos productivos.