# PoC Evertec

## Descripción

Proyecto para cumplimiento de prueba técnica cumpliendo las especificaciones solicitadas por \*\*\*\*Evertec

## Instalación

### IaC

Para el aprovisionamiento de la infraestructura se realiza con el IaC de terraform, se utiliza la versión 1.2.2 de tf y 3.10 de azurerm. Se aprovisiona un grupo de recursos, una cuenta de storage y un servicio para la funcione, se utiliza variables para el aprovisionamiento.

Para la instalación utilizamos los siguientes comando:

```
terraform init

terraform plan

terraform apply
```

Para la configuración de la infraestructura se utiliza las siguientes variables de entorno, las cuales se pueden editar en el archivo variables.tf o inyectar en el comando `terraform apply -var-file= filvars.tfvars`

```
storage_account_name  = "evertecpocstorage"

app_service_plan_name  = "evertecPoC"

function_app_name  = "evertecPoC"

resource_group_name  = "evertecPoCResourceGroup"

resource_group_location  = "Central US"
```

## api-calculator

Proyecto API, es muy basico un unico endpoint para validar si un numero es primo.

Archivo azure-pipeline.yml con las instrucciones de despliegue para azure DevOps con las siguientes caracteristicas.

1. Se debe crea un services connections de tipo Azure Resource manager y elegir la suscripción activa de la infraestructura y paso seguido el Resource Group aprovicionado con el IaC (resource_group_name).
2. Se debe tener activo el Jobs parralles o agregan un agente externo para poder ejecutar el pipeline.
3. Crear el pipeline importando el archivo .yml que se encuentra en el repositorio.

Las variables de entorno para el despliegue del pipeline son las siguientes.

```
azureSubscription  # Nombre del Service Connections
environmentName    # Ambiente del proyecto
functionAppName    # Nombre de la function creada la IaC
poolAgent          # Pool para la ejecución del pipelien, compatible con paralles
vmImageName        # Imagen para compilar el pipeline (ubuntu-latest)
```

4. Agregar los permisos de ejecución en el service connections al pipeline craedo en el paso 3

### Validación del despliegue

Para ingresar a la API se realiza metodo POST a la URI https://functionsname.azurewebsites.net/api/isItAPrime/api/isItAPrime con body {prime: int}
