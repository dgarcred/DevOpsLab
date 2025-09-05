# 📘 Tekton

## 📑 Tabla de Contenidos
1. [Referencias](#-referencias)  
2. [Introducción](#-introducción)  
3. [Conceptos clave](#-conceptos-clave)  
    - [Task](#task)  
    - [TaskRun](#taskrun)
    - [Pipeline](#pipeline)  
    - [PipelineRun](#pipelinerun)
    - [Workspace](#workspace)
    - [Param](#param)
    - [Result](#result)
    - [Trigger](#trigger)  
    - [Tekton Dashboard](#tekton-dashboard)
    - [Namespaces y RBAC](#namespaces-y-rbac)
    - [Ventajas de Tekton](#ventajas-de-tekton)
4. [Instalación](#️-instalación)  
5. [Quickstart](#-quickstart)  
    - [Crear y ejecutar una Task de ejemplo](#crear-y-ejecutar-una-task-de-ejemplo)
    - [Crear y ejecutar un Pipeline de ejemplo](#crear-y-ejecutar-un-pipeline-de-ejemplo)
    - [Crear y probar un trigger de ejemplo](#crear-y-probar-un-trigger-de-ejemplo)
6. [Comandos útiles](#️-comandos-útiles)  
7. [Tips y buenas prácticas](#-tips-y-buenas-prácticas)  
8. [Próximos pasos](#-próximos-pasos)  

---

## 📚 Referencias
- [Documentación oficial de Tekton](https://tekton.dev/docs/)
- [Tekton Quickstart](https://tekton.dev/docs/getting-started/tasks/)
- [Ejemplos de Tekton Pipelines](https://github.com/tektoncd/pipeline/tree/main/examples)
- [Tekton CLI (tkn)](https://github.com/tektoncd/cli)
- [Tekton Dashboard](https://github.com/tektoncd/dashboard)

---

## 🔹 Introducción
[Tekton](https://tekton.dev/) es un framework open source para crear pipelines de CI/CD nativos en Kubernetes. Permite definir tareas, pipelines y triggers como recursos de Kubernetes, facilitando la automatización de procesos de construcción, test y despliegue de aplicaciones en contenedores.  
En este laboratorio, Tekton se utiliza para practicar la creación y ejecución de pipelines declarativos sobre Minikube.

---

## 🧩 Conceptos Clave

### ¿Qué es Tekton?
Tekton es un framework de CI/CD nativo de Kubernetes que permite definir y ejecutar pipelines de integración y entrega continua como recursos personalizados (CRDs) dentro del clúster. Tekton abstrae los conceptos de tareas, pipelines y triggers, facilitando la automatización, reutilización y portabilidad de los flujos de trabajo DevOps.

---

### Task
Una **Task** es la unidad básica de trabajo en Tekton. Define uno o varios pasos (steps), cada uno ejecutado en un contenedor, para realizar acciones como construir una imagen, ejecutar tests, analizar código, etc.  
Las Tasks pueden parametrizarse y reutilizarse en diferentes pipelines.

---

### TaskRun
Un **TaskRun** es una instancia de ejecución de una Task. Permite lanzar una Task concreta con parámetros y workspaces específicos, y monitorizar su estado y logs.

---

### Pipeline
Un **Pipeline** es una secuencia de Tasks conectadas, que define el flujo completo de CI/CD. Permite orquestar tareas complejas, pasar resultados entre ellas y definir dependencias y condiciones de ejecución.

---

### PipelineRun
Un **PipelineRun** es una instancia de ejecución de un Pipeline. Permite lanzar un pipeline completo, pasando parámetros, workspaces y recursos, y monitorizando el estado de cada TaskRun asociado.

---

### Workspace
Un **Workspace** es un volumen compartido entre Tasks o Steps dentro de un Pipeline o Task. Permite compartir archivos, artefactos o resultados entre diferentes etapas del pipeline.

---

### Param
Los **Params** son parámetros que permiten personalizar la ejecución de Tasks y Pipelines, facilitando la reutilización y la configuración dinámica.

---

### Result
Los **Results** permiten que una Task exponga valores de salida, que pueden ser consumidos por otras Tasks dentro de un Pipeline.

---

### Trigger
Un **Trigger** permite ejecutar Pipelines automáticamente en respuesta a eventos externos, como un push a un repositorio Git, una petición HTTP o un webhook. Los triggers se componen de varios recursos:

- **EventListener:** Servicio que recibe eventos externos y los procesa.
- **TriggerTemplate:** Plantilla que define qué PipelineRun o TaskRun crear al recibir un evento.
- **TriggerBinding:** Mapea los datos del evento a los parámetros del TriggerTemplate.
- **Interceptor:** (Opcional) Permite filtrar, transformar o validar eventos antes de lanzar el pipeline.

---

### Tekton Dashboard
**Tekton Dashboard** es una interfaz web que permite visualizar, monitorizar y gestionar Tasks, Pipelines, Runs y Triggers de Tekton de forma gráfica.

---

### Namespaces y RBAC
Tekton utiliza namespaces de Kubernetes para aislar recursos y soporta RBAC para controlar el acceso y la ejecución de pipelines y tasks.

---

### Ventajas de Tekton
- **Nativo de Kubernetes:** Usa CRDs y se integra perfectamente con el ecosistema.
- **Extensible y modular:** Tasks y Pipelines reutilizables y componibles.
- **Portabilidad:** Los pipelines definidos en Tekton pueden ejecutarse en cualquier clúster Kubernetes compatible.
- **Integración con otras herramientas:** Fácil de integrar con ArgoCD, GitOps, Quay, etc.

---

## ⚙️ Instalación

1. **Ejecutar el script de instalación**  
    Instala Tekton Pipelines, Tekton Triggers y Tekton Dashboard.
    ```bash
    ./scripts/setup/install-tekton.sh
    ```

2. **Verificar la instalación**
    ```bash
    kubectl get pods -n tekton-pipelines
    ```

---

## ⚡ Quickstart

### Crear y ejecutar una Task de ejemplo
```bash
# Crear la Task
kubectl apply -f ./tekton/tasks/task-hello-world.yaml
kubectl get tasks
tkn task list

# Crear una instancia de la Task (TaskRun)
kubectl apply -f ./tekton/tasks-runs/taskrun-hello-world.yaml
kubectl get taskruns
tkn taskrun list

# Ver logs de la ejecución
kubectl get pods
kubectl logs hello-task-run-pod
tkn taskrun logs hello-task-run
```

### Crear y ejecutar un Pipeline de ejemplo
```bash
# Crear otra Task
kubectl apply -f ./tekton/tasks/task-goodbye-world.yaml
kubectl get tasks
tkn task list

# Crear Pipeline
kubectl apply -f ./tekton/pipelines/pipeline-hello-goodbye.yaml
kubectl get pipelines
tkn pipeline list

# Crear una instancia del Pipeline (PipelineRun)
kubectl apply -f ./tekton/pipelines-runs/pipelinerun-hello-goodbye.yaml
kubectl get pipelineruns
tkn pipelinerun list

# Ver logs de la ejecución
tkn pipelinerun logs hello-goodbye-pipeline-run
```

### Crear y probar un Trigger de ejemplo
```bash
# Crear el EventListener
kubectl apply -f ./tekton/triggers/event-listeners/el-hello-listener.yaml
kubectl get eventlistener
tkn eventlistener list

# Crear el TriggerTemplate
kubectl apply -f ./tekton/triggers/trigger-templates/tt-hello-template.yaml
kubectl get triggertemplate
tkn triggertemplate list

# Crear el TriggerBinding
kubectl apply -f ./tekton/triggers/trigger-bindings/tb-hello-binding.yaml
kubectl get triggerbinding
tkn triggerbinding list

# Otorgar permisos a los recursos de roles de Tekton Triggers
kubectl apply -f ./tekton/config/tekton-triggers-permissions.yaml

# Exponer el servicio del EventListener
kubectl port-forward service/el-hello-listener 8080

# Probar el trigger con curl
curl -v \
    -H 'content-Type: application/json' \
    -d '{"username": "Tekton"}' \
    http://localhost:8080

# Monitorizar los PipelineRuns generados
kubectl get pipelineruns --sort-by='.status.startTime'
tkn pipelinerun list
tkn pipelinerun logs <name> -f
```

---

## 🛠️ Comandos Útiles

```bash
# INSTALACIÓN Y RECURSOS
kubectl get pods -n tekton-pipelines                # Ver pods de Tekton
kubectl get tasks                                   # Listar Tasks
kubectl get taskruns                                # Listar TaskRuns
kubectl get pipelines                               # Listar Pipelines
kubectl get pipelineruns                            # Listar PipelineRuns
kubectl get pipelinerun <name> -o json | jq '.status | keys'    # Explorar el estado de un PipelineRun

# APLICAR Y ELIMINAR RECURSOS
kubectl apply -f <recurso.yaml>                     # Aplicar Task, Pipeline, etc.
kubectl delete -f <recurso.yaml>                    # Eliminar recursos

# LOGS Y DEBUG
kubectl describe taskrun <nombre>                   # Ver detalles de un TaskRun
kubectl logs -l tekton.dev/taskRun=<nombre> --all-containers   # Ver logs de un TaskRun
kubectl describe pipelinerun <nombre>               # Ver detalles de un PipelineRun

# CLI ALTERNATIVA (tkn)
tkn version                                         # Ver versión de la CLI Tekton
tkn task list                                       # Listar Tasks
tkn taskrun list                                    # Listar TaskRuns
tkn pipeline list                                   # Listar Pipelines
tkn pipelinerun list                                # Listar PipelineRuns
tkn taskrun logs <nombre>                           # Ver logs de un TaskRun
tkn pipelinerun logs <nombre> -f                    # Ver logs de un PipelineRun en directo
tkn eventlistener describe <nombre>                 # Ver información de un EventListener
tkn triggerbinding describe <nombre>                # Ver información de un TriggerBinding
tkn triggertemplate delete <nombre>                 # Eliminar un TriggerTemplate
```

---

## 💡 Tips y buenas prácticas

1. **YAML reutilizable**
   - Usa parámetros (`params`) en Tasks y Pipelines para hacerlos reutilizables.
   - Puedes pasar workspaces para compartir datos entre tareas.

2. **CLI Tekton (`tkn`)**
    - Es recomendable utilizar la CLI de Tekton para administrar objetos Tekton en el clúster, para una experiencia más cómoda.

3. **Visualización**
    - Puedes instalar [Tekton Dashboard](https://github.com/tektoncd/dashboard) para visualizar pipelines y ejecuciones desde el navegador.
    - El script `./scripts/setup/install-tekton.sh` ya instala tekton-dashboard.
    - Exponer el dashboard: 
        ```bash
        minikube service tekton-dashboard -n tekton-pipelines
        ```
    - Accede a la URL que se haya mostrado por consola.

4. **Limpieza**
    - Se recomienda establecer una estrategia para limpiar los pods que se quedan "zombies" después de ejecutar cada Task (por cada Task se crea un pod), ya sea en estado completado o fallido. 
    - Opciones:
        1. En los TaskRun / PipelineRun, añadir `spec.ttlSecondsAfterFinished`.
        2. Etiquetar TaskRun y PipelineRun y tener un job que limpie los completados periódicamente (CronJob).
        3. Ajustar `tekton-pipelines-controller` con feature flags (`default-time-to-live` en el configmap `config-defaults`).
    - Ejemplo de limpieza con CronJob:
        ```bash
        kubectl apply -f ./tekton/config/tekton-cleaner-cronjob.yaml
        kubectl apply -f ./tekton/config/tekton-cleaner-permissions.yaml
        
        # Para probar el cleaner directamente:
        kubectl create job --from=cronjob/tekton-cleaner-cronjob tekton-cleaner-job -n default
        kubectl logs -l job-name=tekton-cleaner-job -n default
        ```

5. **Namespaced**
    - Los recursos de Tekton suelen estar en el namespace `default` o el que elijas, pero los pods del sistema están en `tekton-pipelines`.

6. **Debug**
    - Si una Task falla, revisa los logs del pod asociado y usa `kubectl describe` para ver eventos y errores.

---

## 🚀 Próximos pasos

- **Crea y prueba tus propias Tasks y Pipelines:**  
    Experimenta con diferentes pasos, parámetros y workspaces.
- **Integra Tekton con otras herramientas:**  
    Automatiza flujos de CI/CD completos usando Triggers y recursos externos.
    Recomendable: ver cómo [clonar un repositorio](https://tekton.dev/docs/how-to-guides/clone-repository/) y cómo [construir y pushear una imagen](https://tekton.dev/docs/how-to-guides/kaniko-build-push/) con Tekton. 
- **Explora Tekton Dashboard:**  
    Visualiza y monitoriza tus ejecuciones desde la interfaz web.
- **Automatiza la limpieza de recursos:**  
    Implementa estrategias para mantener el clúster limpio de pods y runs antiguos.
- **Contribuye a la documentación:**  
    Añade ejemplos, troubleshooting y buenas prácticas según tu experiencia.
- **Investiga la integración con ArgoCD y otras herramientas GitOps:**  
    Crea pipelines que desplieguen automáticamente usando ArgoCD tras la construcción.

---