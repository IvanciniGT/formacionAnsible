# Contenedor

Es un entorno aislado dentro de un kernel Linux donde poder ejecutar procesos.

Entorno aislado porque:
- Tiene su propia configruación de red
- Tiene su propio filesystem
    - Dentro de ese sistema de archivos habitualmente montamos volumenes,
        igual que hacemos en un host linux (POSIX) con el mount
- Tiene sus propias variables de entorno independientes de las del host
- Puede tener limitaciones deacceso al hardware

Los contenedores los creamos desde imagenes de contenedor.
Esas imagenes las encontramos en REGISTROS DE REPOSITORIOS DE IMAGENES DE CONTENEDOR:
- docker hub
- quay.io           REDHAT

# Una imagen de contenedor

Es un triste fichero comprimido (tar) que contiene:
- una software YA INSTALADO Y PRECONFIGURADO por alguien, que yo descargo y descomprimo.
- todas las librerias y dependencias requeridas para poder ejecutar ese software.
- Y YA ESTA LISTO PARA SU USO

Se han convertido en el estándar para distribuir software.
TODO EL SOFTWARE (empresarial) A DIA DE HOY se distribuye mediante imágenes de contenedor.

# Contenedores vs Máquinas Virtuales

Se parecen como un huevo a una castaña !

La diferencia más grande que tenemos entre ellos es que en los contenedores :
NO ES POSIBLE EJECUTAR UN SO propio.
En una máquina virtual, que habitualmente la usamos porque, es un entorno aislado que nos da:
- Tiene su propia configruación de red
- Tiene su propio filesystem
- Tiene sus propias variables de entorno independientes de las del host
- Puede tener limitaciones deacceso al hardware

lo primero que necesitamos es instalar un SO. Eso complica el proceso de sobremanera, 
y mete una capa extra de complejidad enorme, además de matar el rendimiento de las apps
y de comer recursos innecesariamente a mi host.

Las máquinas virtuales han quedado desde hace MUCHOS AÑOS relegadas a tareas muy concretas.

NO ESTOY DICIENDO QUE LOS CONTENEDORES SEAN UN REEMPLAZO DE LAS MAQUINAS VIRTUALES en el 100% de los casos. 
Si en el 95% de ellos.

En el curso vamos a usar contenedores para simular entornos remotos sobre los que ejecutar playbooks.

Vamos a crear contenedores desde una imagen de contenedor que lleva dentro:
- python
- servidor ssh

Al trabajar con contenedores necesitamos un gestor de contenedores:
- Docker
    - Por una lado un demonio: dockerd
    - Por otro lado, tenemos un cliente : docker -> dockerd
    - No es el único cliente de docker que existe:
        - docker-compose < Trabaja mediante ficheros YAML
- Podman
- Crio
- Containerd

Kubernetes no es un gestor de contenedores:
Kubernetes es la herramienta que hoy en día controla LOS ENTORNOS DE PRODUCCION DE CASI CUALQUIER EMPRESA.
Kubernetes es un orquestador de gestores de contenedores 

Openshift es una distribución de Kubernetes, la de redhat, como muchas otras que hay:: K8S, K3S, Tamzu(VMWare)



Imagen de fedora:
Los 10 comandos básicos que Fedora pone por encima del kernel de linux:
- ls
- cat
- mkdir
- sh
- bash
- tac
- touch
- yum
- dnf

Imagen de ubuntu:
Los 10 comandos básicos que Fedora pone por encima del kernel de linux:
- ls
- cat
- mkdir
- sh
- bash
- tac
- touch
- apt
Imagen de alpine:

Los 5 comandos básicos que Fedora pone por encima del kernel de linux:
- ls
- cat
- mkdir
- sh
- touch

Junto con una estructura de directorios compatible con POSIX
/bin
    ls
    mkdir
    rm
    mv
/tmp
/var
/usr
/opt
.... VACIAS !

172.18.0.2
172.18.0.3
172.18.0.4
172.18.0.5
172.18.0.6


###
Para poder conectar via ssh, la máquina hay que darla de alta en el knownhosts
export ANSIBLE_HOST_KEY_CHECKING=False
--ssh-common-args='-o StrictHostKeyChecking=no'

# Inventarios dinámicos

Podríamos hacer un programa en un lenguaje de programación
que autoamticamente generase el inventario por nosotros.

Eso es lo que entendemos por un inventario dinámico.

Podemos hacerlo en:
bash
python <<<< 

# Roles

Es el equivalente en cualquier lenguaje de programación a UNA FUNCION, METODO, PROCEDIMIENTO, LIBRERIA

Capacidad de reutilizar código ANSIBLE.

# Cuando escribimos un Playbook>Play, que ponemos ahi?

-   hosts:              x
    order:              x
    vars:               √
    gather_facts:       x
    tasks:              √
    pre_tasks:          √
    post_task:          √

Cuáles de esas cosas serían las que yo querria meter en algo REUTILIZABLE? 

    
Nosotros vamos amontar un playbook
Dentro de las tareas de ese playbook, llamaremos a UN ROLE

En el playbook, es donde definiremos: 
- hosts
- order
- gather_facts
- tasks         >
- pre_tasks     >
- post_tasks    >       ROLE
- handlers      >


Los roles se pueden compartir por ejemplo, a través de ansible-galaxy

Cualquier cosa que hicieramos en la empresa y que tuviera sentido reusarla en varios proyectos, 
DEBERIA IR EN UN ROLE!
NUNCA EN UN PLAYBOOK !

## Creación de un role

$ ansible-galaxy init NOMBRE:

NOMBRE
    ├── README.md           Descripcion del role... y cómo usarlo, requerimientos
    ├── defaults            Variables QUE ME SUMINISTRARAN... y yo les doy por cortesía un valor por defecto
    │   └── main.yml
    ├── files               Otros ficheros que necesito que no son plantillas
    ├── handlers
    │   └── main.yml        Los handlers propios del rol
    ├── meta                Datos descriptivos del role que irian a Ansible-Galaxy
    │   └── main.yml
    ├── tasks               Las tareas que va a hacer el rol
    │   └── main.yml
    ├── templates           Plantillas que usamos con el modulo "template"
    ├── tests               Pruebas automatizadas que hacemos de que el role funciona
    │   ├── inventory       Inventario de prueba
    │   └── test.yml        Playbook de prueba
    └── vars                Variables INTERNAS 
        └── main.yml
        
        
# Tareas de ansible en un play

Inventario:
    máquina 1: ssh

- gather_facts
- tarea 1   Copiar un archivo al remoto
- tarea 2   Instalar via apt unos paquetes
- tarea 3   Crear una carpeta

## Cuántas conexiones ssh va a necesitar este play?  4

Cada tarea que requiere conexión con un remoto, abre su propio ssh.

## Qué pasa si una tarea tarda muuuuUUUUUUUuuucho tiempo en ejecutarse? 

Timeout de ssh < UPS !!!!!! > Playbook se detiene, fallido... Y TODO A LA MIERDA

Solución a este dilema? 
    async: 
            No mantengas la conexión abierta. 
             - Abrela
             - Lanza el comando
             - Cierra, dejando el comando ejecutándose
    pool: > Cada cuanto preguntas al remoto, a ver si la tarea ha terminado
    
Una tarea que lleve un async se ejecuta de forma ¡asíncrona!

Qué significa eso? Que puedo lanzar en paralelo MUCHAS TAREAS !
Eso lo consigo con pool: 0

Y esto nos obliga posteriormente a meter una tarea de sincronización



|1|myI15MH0DTlEV8aHhbz3vA1vdw4=|yD/5msmWMbQGzB4gIqbnld2f+H0= ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9NiRfkrMv08eGphrb0Nu1dXrf+8FRTPCjI+FXO5SJM1xj2bDknSMy4ncavZ/0qMWNB5YkGxPIn1DkOm9gYuOy8PGlcL1rLrG+jE1YjGqDy3HrIP3CKkyA5YrZDQut1EvETmlVOK/VW9d6lAC+6qtjk+Npm4IsmaUAlJoG2E9dU2FpCio2eAknGe4ZvCQZrTk49qyrpj5XAOa/TWBgJE/9kktl7amQoqRSoB4RGnnpoKGlpJswqIFmsZhHRgX+nPqIxcGbJ22z8EDjDUDt9z8lY4/UTIPWkjSkyRpwgMJar7baFzuV4IA3yH8Q+sLuEbMP5NWHdIAk8RyMwG7ifUsT\n
|1|Mth9jgMZYvkYT3g2jj/Dql4gVgQ=|UJfkR/iJ8JnlsxOhZfrXCoB6Ec0= ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9NiRfkrMv08eGphrb0Nu1dXrf+8FRTPCjI+FXO5SJM1xj2bDknSMy4ncavZ/0qMWNB5YkGxPIn1DkOm9gYuOy8PGlcL1rLrG+jE1YjGqDy3HrIP3CKkyA5YrZDQut1EvETmlVOK/VW9d6lAC+6qtjk+Npm4IsmaUAlJoG2E9dU2FpCio2eAknGe4ZvCQZrTk49qyrpj5XAOa/TWBgJE/9kktl7amQoqRSoB4RGnnpoKGlpJswqIFmsZhHRgX+nPqIxcGbJ22z8EDjDUDt9z8lY4/UTIPWkjSkyRpwgMJar7baFzuV4IA3yH8Q+sLuEbMP5NWHdIAk8RyMwG7ifUsT\n"