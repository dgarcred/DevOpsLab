# 📘 Kubernetes

## 📑 Tabla de Contenidos
1. [Referencias](#-referencias)  
2. [Introducción](#-introducción)  
3. [Conceptos clave](#-conceptos-clave)  
    - [¿Qué es Kubernetes?](#qué-es-kubernetes)
    - [¿Qué es Minikube?](#qué-es-minikube)
    - [¿Qué es kubectl?](#qué-es-kubectl)
    - [Recursos básicos de Kubernetes](#recursos-básicos-de-kubernetes)
    - [Declarativo vs Imperativo](#declarativo-vs-imperativo)
    - [Arquitectura básica de Kuberentes](#arquitectura-básica-de-kubernetes)
4. [Instalación](#️-instalación)  
    - [Minikube](#minikube)
    - [kubectl](#kubectl)
5. [Quickstart](#-quickstart)  
6. [Comandos útiles](#️-comandos-útiles)  
    - [Minikube](#minikube-1)  
    - [kubectl](#kubectl-1)  
7. [Tips y buenas prácticas](#-tips-y-buenas-prácticas)  

---

## 📚 Referencias
- [Documentación oficial de Kubernetes](https://kubernetes.io/docs/home/)  
- [Documentación oficial de Minikube](https://minikube.sigs.k8s.io/docs/)
- [Documentación oficial de Kustomize](https://kubectl.docs.kubernetes.io/references/kustomize/)
- [Referencia de kubectl](https://kubernetes.io/docs/reference/kubectl/quick-reference/)
- [Cheatsheet de kubectl](https://kubernetes.io/docs/reference/kubectl/)
- [Cheatsheet de docker](https://www.hackingnote.com/en/cheatsheets/docker/)
- [Cheatsheet de k9s](https://www.hackingnote.com/en/cheatsheets/k9s/)
- [Cheatsheet de jq](https://www.hackingnote.com/en/cheatsheets/jq/)
- [Freelens: Free IDE for Kubernetes](https://github.com/freelensapp/freelens) 
- [Headlamp: IDE for Kubernetes, install via Helm](https://artifacthub.io/packages/helm/headlamp/headlamp) 
- [Headlamp docs](https://headlamp.dev/docs/latest/)
- [Working with Kubernetes in Podman Desktop](https://developers.redhat.com/articles/2023/11/06/working-kubernetes-podman-desktop#)

---

## 🔹 Introducción
[Kubernetes](https://kubernetes.io/) es la plataforma estándar para la orquestación de contenedores. Permite desplegar, escalar y gestionar aplicaciones en contenedores de forma declarativa.  
En este laboratorio se utiliza [Minikube](https://minikube.sigs.k8s.io/) como entorno local de Kubernetes y la CLI [kubectl](https://kubernetes.io/docs/reference/kubectl/) como herramienta principal de administración.  
El objetivo es simular un entorno de clúster real en tu máquina local para practicar con las herramientas DevOps modernas.

---

## 🧩 Conceptos Clave

### ¿Qué es un contenedor?
Un **contenedor** es una unidad ligera, portátil y autosuficiente que incluye todo lo necesario para ejecutar una aplicación: código, dependencias, librerías y configuración.  
Los contenedores se ejecutan de forma aislada sobre el mismo sistema operativo, compartiendo el kernel, pero manteniendo entornos independientes.  
Son la base de la portabilidad y escalabilidad en Kubernetes, permitiendo desplegar aplicaciones de manera consistente en cualquier entorno.

---

### ¿Qué es Kubernetes?
Kubernetes es una plataforma de orquestación de contenedores open source que automatiza el despliegue, la gestión, el escalado y la operación de aplicaciones en contenedores. Utiliza una arquitectura basada en clústeres y recursos declarativos para garantizar alta disponibilidad, escalabilidad y resiliencia.

---

### ¿Qué es Minikube?
Minikube es una herramienta que permite ejecutar un clúster de Kubernetes de un solo nodo de forma local, ideal para desarrollo, pruebas y aprendizaje. Simula un entorno real de Kubernetes en tu máquina, facilitando la experimentación con recursos y herramientas del ecosistema.

---

### ¿Qué es kubectl?
kubectl es la interfaz de línea de comandos oficial para interactuar con clústeres de Kubernetes. Permite gestionar recursos, desplegar aplicaciones, consultar el estado del clúster y realizar tareas administrativas de forma sencilla y potente.

---

### Recursos básicos de Kubernetes
- **Pod:** Unidad mínima de ejecución en Kubernetes, que puede contener uno o varios contenedores.
- **Deployment:** Controlador que gestiona el ciclo de vida de los pods, permitiendo actualizaciones y escalado declarativo.
- **Service:** Abstracción que expone una aplicación en ejecución en un conjunto de pods como un servicio de red estable.
- **Namespace:** Espacio lógico para aislar y organizar recursos dentro de un clúster.
- **ConfigMap y Secret:** Recursos para gestionar configuración y datos sensibles de forma desacoplada de las imágenes de contenedor.

---

### Declarativo vs Imperativo
- **Declarativo:** Definir el estado deseado del sistema (por ejemplo, mediante manifiestos YAML) y dejar que Kubernetes lo alcance y mantenga.
- **Imperativo:** Ejecutar comandos directos para modificar el estado del sistema (por ejemplo, usando `kubectl run`, `kubectl delete`, etc.).

---

### Arquitectura básica de Kubernetes
- **Master/Control Plane:** Gestiona el estado global del clúster (scheduler, API server, controller manager, etcd).
- **Nodos (Nodes):** Máquinas (físicas o virtuales) donde se ejecutan los pods y los servicios de usuario.
- **Add-ons:** Herramientas adicionales como dashboards, gestores de ingress, monitorización, etc.

---

## ⚙️ Instalación

### Minikube
1. **Ejecutar el script de instalación** 
    ```bash
    ./scripts/setup/install-minikube.sh 
    ```
    También se puede hacer manualmente, siguiendo la [guía de instalación oficial](https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download).  

2. **Verificar la instalación**
    ```bash
    minikube version
    ```

### kubectl
1. **Ejecutar el script de instalación**
    ```bash
    ./scripts/setup/install-kubectl.sh 
    ```

2. **Verificar la instalación**
    ```bash
    kubectl version --client
    ```

---

## ⚡ Quickstart
1. **Iniciar minikube**
    ```bash
    minikube start
    minikube start --cpus=2 --memory=4096 --driver=docker
    # Nota: tener en cuenta los recursos asignados a WSL (.wslconfig) a la hora de especificar los de Minikube
    ```

2. **Verificar el clúster**
    ```bash
    kubectl cluster-info
    kubectl get nodes
    ```

3. **Desplegar una aplicación de prueba**
    ```bash
    kubectl create deployment hello-minikube --image=kicbase/echo-server:1.0
    kubectl expose deployment hello-minikube --type=NodePort --port=8080
    ```

4. **Acceder a la aplicación**
    ```bash
    minikube service hello-minikube
    ```
    Esto abrirá un navegador con la URL de acceso a la aplicación. 

---

## 🛠️ Comandos Útiles

### Minikube 
```bash
minikube start                      # Inicia el clúster local
minikube stop                       # Detiene el clúster
minikube delete                     # Elimina el clúster
minikube dashboard                  # Abre el dashboard de Kubernetes. 
minikube service <service-name>     # Abre un servicio expuesto en el navegador
```

### kubectl 
```bash
# CONFIGURACIÓN
kubectl config view                           # Observar configuración actual del kubeconfig
kubectl config get-contexts                   # Observar los diferentes clústeres disponibles (contextos) y al que apunta actualmente kubectl
kubectl config use-context <cluster-name>     # Cambiar de contexto

# LISTAR RECURSOS
kubectl get pods -n <namespace>               # Listar los pods del namespace indicado 
kubectl get deployments -A                    # Lista los deployments de todos los namespaces
kubectl get svc -n default -o wide            # Lista los servicios del namespace "default" con información más detallada

# MANIFIESTOS
kubectl apply -f <file.yaml>                  # Aplicar manifiestos
kubectl delete -f <file.yaml>                 # Eliminar recursos desde manifiestos

# ANALIZAR RECURSOS
kubectl describe pod <pod-name>               # Información detallada de un pod
kubectl logs <pod-name>                       # Ver logs de un pod
kubectl exec -it <pod-name> -- sh             # Acceder al shell dentro de un pod
kubectl get pod <pod-name> -o json | jq .     # Obtener información del pod en formato JSON, y formatear con la herramienta jq
kubectl get pod <pod-name> -o yaml | yq .     # Obtener información del pod en formato YAML, y formatear con la herramienta yq
kubectl get deployment petclinic -o json | jq '.spec.replicas'      # Obtener el número de réplicas del deployment "petclinic"
kubectl get deploy <deployment-name> -o json | jq '.spec | keys'    # Analizar la sección 'spec' de un deployment, obteniendo las keys hijas
kubectl get pod <service-name> -o json | jq '.spec.containers[0] | {image: .image, imagePullPolicy: .imagePullPolicy}'    # Obtener la imagen:tag y la imagePullPolicy del primer contenedor de un pod
```

---

## 💡 Tips y buenas prácticas

1. **Configurar alias útiles**
    - Abrir el archivo `~/.bashrc` con el comando `vim ~/.bashrc`
    - Agregar al final del archivo los alias que se deseen, guardar y salir
    - Ejecutar `source ~/.bashrc` para recargar los alias definidos
    - Ejemplos de alias útiles:
        - `alias k="kubectl"`
        - `alias kgp="kubectl get pods -o wide"` 

2. **Consultar documentación integrada**  
    - Ejecutar `kubectl explain <resource>` para consultar documentación integrada del recurso de Kubernetes

3. **Herramientas de formateo: jq | yq**
    - Instalar herramientas de formateo de JSON y de YAML
    - Ejecutar `sudo apt update && sudo apt install jq -y && sudo apt install yq -y`
    - En la sección [Comandos Útiles](#️-comandos-útiles), apartado *kubectl*, se encuentra una guía de comandos útiles que hacen uso de estas herramientas
    - Son muy potentes a la hora de formatear las salidas JSON y YAML, lo que es muy útil a la hora de consultar información de determinados recursos, de hacer troubleshooting, etc.

4. **k9s**
    - [k9s](https://k9scli.io/) es una herramienta de terminal interactiva para gestionar clústeres de Kubernetes de forma visual y eficiente.
    - Permite navegar, observar y gestionar recursos del clúster (pods, deployments, servicios, etc.) desde una interfaz tipo TUI (Text User Interface).
    - Es ideal para troubleshooting, monitorización y operaciones diarias sin necesidad de recordar comandos largos de `kubectl`.

    **Instalación rápida en Linux:**  
    Ejecutar el siguiente comando desde una terminal de WSL
    ```bash
    curl -sS https://webinstall.dev/k9s | bash
    ```
    O descarga el binario desde la [página de releases](https://github.com/derailed/k9s/releases).

    **Uso básico:**
    ```bash
    k9s
    ```
    Esto abrirá la interfaz interactiva conectada al contexto de Kubernetes actual.  
    Consultar el siguiente [cheatsheet](https://www.hackingnote.com/en/cheatsheets/k9s/) de k9s para aprender a utilizar la herramienta.

5. **IDE para Kubernetes**
    - Existen IDEs dedicados para Kubernetes, con el objetivo de administrar los clústeres desde una interfaz amigable. 
    - Algunos ejemplos conocidos son:
        - [Freelens](https://github.com/freelensapp/freelens)
        - [Headlamp](https://headlamp.dev/)

---