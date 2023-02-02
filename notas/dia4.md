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