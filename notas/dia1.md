# Qué es Ansible?

Es una familia de productos de software.

¿Quién está detrás del desarrollo de Ansible? Redhat

## Redhat

Empresa Reina en el mundo del Opensource!
Vende sus productos ... o como funciona eso?  son gratis? 

Tiene una política peculiar:
- Todos sus productos se ofrecen de 2 formas:
    - Existe una versión de pago (bajo un modelo de subscripción): SOPORTE + ESTABILIDAD
        Opensource
                ^^^^
    - Existe una versión gratuita : MAS FUNCIONALIDAD... Se incorporán aquí las novedades y se depuran.
        Opensource

Productos que fabrica / desarrolla Redhat:

| PAGO                                  |   Proyecto upstream   |
| ------------------------------------- | --------------------- |
| Rhel                                  |   Fedora              |
| Openshift Container Platform          |   OKD                 |
| Redhat Openstack                      |   Openstack           |
| JBoss                                 |   Wildfly             |
| Ansible Engine                        |   Ansible project     | 
| Ansible Tower                         |   AWX                 |


# Qué productos encontramos dentro del ecosistema Ansible?

## Ansible Project

Es el proyecto upstream de Ansible Engine.
Es una herramienta de software que nos ofrece:
- Un lenguaje (Schema de YAML) para la creación de SCRIPTS de AUTOMATIZACION -> Playbook
- Varias sintaxis (3) para definir Inventarios
- Una serie de comandos, con los que poder aplicar operaciones sobre esos inventarios / Scripts

### Para qué se usa?
- AUTOMATIZACION del lado de sistemas:
    - Automatizar la creación de máquinas en un cloud                   ~>  Terraform
    - Automatizar la configuración / planchado de un entorno (servidor, contenedor, router, firewall) remoto
    - Autopmatizar el despliegues de software 
    - Automatizar el control de entornos

#### Nota

Básicamente los playbooks de ansible son un reemplazo de los scripts que antes hacíamos con bash, python, ps1...

Ya no queremos usar esas herramientas. Por qué? Usan una sintaxis IMPERATIVA
En los playbooks se usa una SINTAXIS DECLARATIVA !

Y eso lo cambia todo.

Todas las herramienats que están triunfando usan SINTAXIS DECLARATIVA... por eso triunfan!
- Ansible
- Terrqform
- Puppet
- Kubernetes
- Docker-compose

### Quién la usa?

Los administradores de sistemas


## Ansible Engine

La versión de pago de Ansible project 

## AWX

Herramienta centralizada, que se instala en un servidor.
En él cargaremos TODOS los playbooks y los inventarios de nuestra empresa .
Realmente esto es un truco... donde están los playbooks e inventarios en AWX? En un conjunto de repos de GIT
Al hacer:
- Entorno gráfico donde consultarlos
- Ejecutar de forma asistida ciertos playbooks (usando formularios)
- Ayudan en la gestión de inventarios... Inventarios autogenerados
- Orquestar playbooks 
- API REST: Integración con otras herramientas

    JENKINS -> AWX -> playbooks


## Ansible Tower

Versión de pago de AWX

- Generación de inventarios
- Para centralizar datos que necesitemos usar al gestionar entornos

## Ansible galaxy

- Herramienta que nos permite la creación y gestión de roles de Ansible
- Servicio/sitio web que nos permite compartir roles entre usuarios

Role: Conjunto de tareas reutilizable en los playbooks de Ansible.

# Herramientas de la misma GAMA que ANSIBLE

Puppet, Chef, Salt... se han quedado atrás !

Ansible se está llevando el mercado: Sintaxis + Arquitectura

# YAML

Lenguaje de estructuración de información.
Es esquivalente a XML/JSON(de proposito general)... HTML (es de dominio específico)

YAML
 XML
HTML
SGML
  ML: Markup language... a qué se refieren con esa palñabra "markup".. a los famosos tags: <usuario>Ivan</usuario>

Yet Another Markup Language... pudo haber sido... pero no! 
YAML ain't Markup Language: NO BUSUES AQUI MARQUITAS QUE NOS VAS A ENCONTRAR POR NINGUNA LAO !!!!!

De hecho YAML se ha comido a JSON  ( me refiero literalmente)
Hoy en día estamos en la spec v 1.2 de YAML... dentro de la cuál se ha incluido la sintaxis de JSON.

Cualquier documento JSON válido por definición es un documento YAML válido
NUNCA AL REVÉS. 

# YAML Es un lenguaje

Nos define: 
Alfabeto: [] {} - ~ !! 
Gramatica:
    Sintaxis (Cómo colocar esos vocablos que montamos con el alfabeto)
    Semantica [] = Lista
              -  = Item de lista
ESO NO ES SUFICIENTE A LA HORA DE TRABAJAR !

Cuando Ansible, Kubernetes, Docker-compose usan YAML, no basta con que se sigan estas reglas. Ejemplo:
---
3
---
^ Ese documento es válido en YAML?    SI
^ Ese documento, se lo traga ANSIBLE? NO

Los programas que usan YAML, definen lo que se denomina SU PROPIO ESQUEMA de datos.
En el ESQUEMA se define la estructura que debe teenr el documento:
Si es un diccionario, que claves admite, que tipos de datos se admiten en cada clave...

# En este curso 

DEBEMOS APRENDER EL ESQUEMA YAML que define Ansible!

# Arquitectura de Ansible Project y cómo trabajamos con Ansible Engine

## Objetivos de diseño

- Tener un sistema descentralizado!
    - No es encesario un servidor central de ANSIBLE !
    - Uso de un lenguaje declarativo! => IDEMPOTENCIA
        - Idempo-qué???? Da igual el estado inicial, siempre obtendré el mismo estado final
                        Como consecuencia,  si ejecuto un script varias veces, siempre queda igual
                                            si ejecuté parte de un script, da igual q si no he ejecutado nada previamente
                                            Siempre quedará igual!
        - ANSIBLE Es idempotente per sé?  NO
               - Ofrece una sintaxis declarativa, que invita a montar rogramas que respeten la idempotencia.
               - Los modulos se deben montar de forma que respeten la idempotencia.
               - HAY CHAPUZAS POR AHI GIGANTES ! SON Chapuzas... se saltan todas las buenas prácticas de Ansible!


## Lenguaje declarativo

Al usar un idioma, ese idioma lo podemos usar de distintas formas:

    HAY UNA SILLA DEBAJO DE LA VENTANA !        Enunciativa Afirmativa
    NO HAY UNA SILLA DEBAJO DE LA VENTANA !     Enunciativa Negativa
    ¿Hay UNA SILLA DEBAJO DE LA VENTANA?        Interrogativa
    PON UNA SILLA DEBAJO DE LA VENTANA !        Imperativa... El verbo está en tiempo IMPERATIVO !
    QUIERO UNA SILLA DEBAJO DE LA VENTANA       DESIDERATIVA !
    DEBE HABER UNA SILLA DEBAJO DE LA VENTANA   Declarativo

script bash:   IMPERATIVO !
script python: IMPERATIVO !

Palabras típicas de un lenguaje imperativo:
    Ejecuta: call 
    IF
    ELSE
    CASE
    FOR
    WHILE

No nos gustan tanto los lenguajes imperativos. Preferimos los declarativos:

Computadora !!!! Crea la carpeta del usuario Ivan       Imperativo
IF no usuario Ivan: Crea el usuario
if [ ! -d /home/ivan ]
then 
    mkdir /home/ivan        Make directory /home/ivan       Imperativo  Aquí doy instrucciones:   CÓMO !
fi

Debe haber una carpeta del usuario Ivan.                Declarativo Aquí no doy instrucciones:  QUE !
                        
# Termonilogía en ANSIBLE

## Nodo de control: 

Es el entorno que ejecuta ANSIBLE (engine/project)

En un momento dado, puede ser uno... y mañana otro!

Requerimientos de este nodo:
    -   LINUX !
    -   Python (una versión que no tenga más de 10 años)

Puedo correr Ansible en una máquina WINDOWS ? NO ... A no ser que haga trucos rastreros... 
                                              básicamente montar un linux dentro del windows 

## Nodos gestionados:

Los entornos/recursos remotos que vamos a administrar desde scripts (PLAYBOOKS) de Ansible

Ansible necesitará conectarse con esos entornos/recursos... de alguna forma:
    ssh
    winrm
    ...

Los entornos que vayamos a administrar desde ansible, hemos de darlos de alta en un INVENTARIO.

Pueden ser Windows?
- Sin problema.... pero no NODOS DE CONTROL... estos no pueden ser Windows

## Inventarios

Conjunto de entornos remotos sobre los que vamos a ejecutar playbooks (scripts)

Se definen en ficheros o carpetas... Con 3 sintaxis diferentes:
- .ini      \
- .yaml     / El inventario será un fichero
- Carpeta donde mezclamos .ini .yaml ****** En esta sintaxis, el inventario es UNA CARPETA !!!

## task, TAREA

Unidad mínima de acción dentro de ansible. 
Las tareas se ejecutan a través de MODULOS

Podemos pedirle a ansible que ejecute una tarea... ESO NOLO HACEMOS !!!! No es buena práctica.
Las tareas las agrupamos en ...

## MODULO en ANSIBLE

Programa externo a Ansible, especializado en realizar un tipo muy concreto de TAREA (en conseguir un determinado ESTADO)
Por ejemplo, tendrmos un modulo para:
- Crear un usuario / Asegurar que un usuario existe en un entorno
- Instalar un paquete de una máquina UBUNTU / Asegurar que un paquete queda instalado en ubn entorno UBUNTU
- Instalar un paquete de una máquina RHEL / Asegurar que un paquete queda instalado en ubn entorno RHEL

## PLAYs

conjunto de tareas que vamos a ejecutar sobre unos entornos de entre los definidos en un INVENTARIO.

A su vez, los PLAYS los agrupamos en :

## PLAYBOOKS

Es un fichero, escrito en YAML (o conjunto de ficheros), donde definimos:
- Tareas
- Variables
- Donde queremos ejecutar esas tareas (de entre los entornos de un inventario)
- Cómo las vamos a ejecutar....

# Los playbooks y los inventarios se guardan en 

Un Source Code Manager (SCM) : Sistema de control de código fuente
- CVS : Control Version System -> Sistema de control de versiones <<<<  MUY ANTIGUO Y EN DESUSO
- SUBVERSION : YA está también más que obsoleto!!!
- TFS: OBSOLTEO Y LIQUIDADO !

- git ( 9#% ) ... creado por Linus Torvals
- mercurial (se usa poquito.. no es malo... pero no se ha impuesto)

En una máquina (NODO DE CONTROL) instalamos Ansible Engine / Ansible project
En esa máquina descargamos los playbooks / inventarios que queremos ejecutar
Y le solicitamos a Ansible que los ejecute.
En ocasiones harán falta datos adicionales, como por ejemplo: CREDENCIALES!
Qué ambién habrá que suministrar... de donde las sacaré? Lo veremos!

# NOTA !!!!

En Ansible hay una CONTRADICCION MUY GRANDE EN SU ESQUEMA !... en su terminología... 
que si no lo controlamos mucho, nos vuelve locos, sobre todo al principio.

La palabra TAREAS es HORRIBLE !!!!!! Está elegida con MUY MAL GUSTO esa palabra. 
Que no nos vuelva locos. Donde dice Tarea... Leer ESTADO !

Tarea -> Lenguaje imperativo. Y eso es una contradicción grande dentro de Ansible.
El concepto del que deberíuamos hablar en lugar de TAREAS es el concepto de ESTADO !

Quiero el sistema en este estado --- √√√√√√√√√√ GUAY
Quiero esta tarea sobre el sistema ----- xxxxxx MIERDA !!!!!! imperativa 

Cómo defino típicamente una tarea: Lenguaje imperativo:  Crea una carpeta
Cómo defino típicamente un estado: Lenguaje declarativo: Debe haber una caperta *** ESTO ES LO QUE QUEREMOS 

## FACT

Información, una propiedad de un entorno administrado / remoto, que ansible es capaz de leer y utilizar

Por defecto, al conectarnos con un entorno, ANSIBLE Extrae unos "7-10" kilos de FACTS. HUEVON DE FACTS.... Esto es un desastre !!!!

Y lo vamos a querer cambiar SIEMPRE. ESE COMPORTAMIENTO


# GIT 

Git es un SCM de tipo: DISTRIBUIDO / DESCENTRALIZADO ( a diferencia de cvs, svn que son centralizados)

Eso qué significa? 
- Significa que tengo una copia del REPO en varios sitios? NO
- Lo que significa es que el PROYECTO es la SUMA de un conjunto de REPOSITORIOS 
  (diferentes entre si, con contenido diferente) 
  que existen en distintos entornos

Forma de trabajo en GIT:
    1 - Nosotros tenemos nuestro proyecto en una carpeta... con todos sus archivos
    2 - Y en un momento dado queremos generar un COMMIT ->  Repositorio Local (que tengo en mi computadora)
                                                            En una carpeta que se llama .git
    3 - Qué va a ir en ese backup (commit):
        - Todo lo que tuviera en el backup anterior (commit anterior)
        + Los nuevos cambios que se hayan solicitado
    4 - Cómo se solicitan que unos cambios se guarden el el siguiente commit? 
        Haciendo una copia de los ficheros que contengan cambios en el ÁREA DE STAGING (área de preparación)
            git add Añade nuevos ficheros al área a de staging
            git rm  Elimina ficheros del área de staging ( y de mi directorio si quiero)
            git mv  Mueve ficheros / carpetas de una ruta a otra
            
Hay un concepto que diferencia a los SCM de los sistemas de backup: RAMAS !
Qué es una RAMA en un SCM? 
    Una linea de tiempo paralela en que el proyecto va evolucionando de forma independiente.
    LOKI !!!!
    
            
                                        GITLAB | GITHUB | BITBUCKET
                                    Servidor capaz de alojar repos remotos de git
                                            desarrollo: C1>C2>C3>C4
                                                    |
        ------->>>> push >>>-------------------------------------->>> fetch >>>>----------------
        |                                                                                      |
    IvanPC                                                                                   LucasPC
        |                                                                                      |
        ProyectoA            add.                       commit                                 | 
            - Carpetas      ---->   Área de Staging.     ----> Repositorio Local            Repositorio local   --> Carpeta
                Ficheros                Ficheros sueltos.        Commit backup (~ZIP)          desarrollo: C1>C2>C3>C4
                    RAMA: ivan                                   Rama ivan C1>C3.               RAMA Lucas: C1>C2   ficheroA 
                                                                 Rama desarrollo: C1 > C2 > C3 > C4
                                                                        Fusión de cambios:
                                                                            - merge
                                                                            - rebase
                                                                            - cherry pick
                                                                 Copia de la rama desarrollo REMOTO: C1 > C2 (fetch) > C3 > C4(fusion)
                pull = "fetch + merge" (por defecto), se puede cambiar a "fetch + rebase"

# COMMIT: 

Qué se guarda en un commit? UNA FOTO COMPLETA DEL PROYECTO EN UN MOMENTO: UN BACKUP COMPLETO DE TODOS LOS ARCHIVOS
                            Git NO GUARDA CAMBIOS ! a diferencia de CVS GUARDA BACKUPS COMPLETOS !!!!!

Si en un momento hay que saber las diferencias entre 2 versiones de un proyecto/fichero/carpeta se CALCULAN BAJO DEMANDA
Comparando lo guardado en 2 backups distintops (COMMITS)

Uso:
- Punto de retorno

# Habitualmente en todo proyecto de GIT tenemos las ramas:

- Maestra: master/main          - Lo que hay aquí se entiende que está listo para producción
                                - NUNCA, JAMAS, DE LOS JAMASES hacemos un commit en esta rama!
                                       Solo esta permitido (por las buenas prácticas, la moralidad y la ética... la decencia) copiar commits de otras ramas
- Desarrollo: desarrollo, development, dev  
    Aquí está el código que se está cocinando... y es donde se van integrando los cambios que van haciendo todos los participantes en un proyecto   
- Ramas por cada desarrollados
- Ramas por funcionalidades
    - Usual es tener ambos tipos de ramas

IMPORTANTE: ESTAMOS DESARROLLANDO SOFTWARE !
Si a los desarrolladores les obligamos a que tengan su código en un SCM, y que lo hagan de forma decente....
NO PUEDO APLICARME LA REGLA DEL EMBUDO....
Osea... que si yo desarrollo software... también debo hacer lo propio.... Y ESTAMOS DESARROLLANDO SOFTWARE: SCRIPTS,    a través de ansoble
                                                                                                                        con sintaxis declarativa...
                                                                                                                        PERO SCRIPTS !

Máxime en Ansible... donde al final, todo el código obligatoriamente cae en GIT (AWX / TOWER) lo imponen!
Y es necesario aplicar estas prácticas... de lo contrario:
Podría pasar que?
- Que tenga una versión configurada en TOWER, que se eesté ejecutando en producción
- Y en un momento dado, uno del equipo (de cuyo nombre no quiero acordarme) se le ocurre hacer su cambio y subirlo a la rama MAIN
- Y el tower lo trinca y lo ejecuta en los 3000 entornos de producción... Sin pruebas, ni na'
- TO CAIDO el entorno de producción. NO VALE !

# Estados de ejecución de una tarea:

- ok: succeded    Que ha ido bien 
- changed         Que ha ido bien, pero que ha provocado cambios en el entorno administrado/remoto
- unreachable     ?
- failed          Que ha fallado
