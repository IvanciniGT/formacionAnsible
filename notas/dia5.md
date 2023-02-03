# FACTS

Un fact es como llamamo en ANSIBLE a una VARIABLE DINÁMICA.

Hay distintos tipos de facts en ANSIBLE:

(ESTO ES LO MAS PARECIDO A una variable, en el concepto de variable que tenemos en la cabeza)
- SET_FACT: Crear un fact nuevo, o reasignarle un valor  
    - no persistente, pero que estará disponible a lo largo de todo el play (SCOPE: PLAY)
    - persistente , donde además se almacena para poder usarlo en futuras ejecuciones
- CUSTOM FACTS:
    Son FACTS que dejo almacenados (persistidos) en los entornos remotos.
    Es una miga de pan que dejo alli...
    - estáticos: Qué versión del nginx he instalado
                 Qué versión de la app he desplegado
        ESTO ES UN FICHERO QUE DEJO EN UNA CARPETA DEL REMOTO, 
            - que contrendrá un JSON, que será el valor del FACT
            - y el nombre del fichero será el nombre del fact
    - dinámicos
        Es el mismo concepto que los CUSTOM_FACT estáticos, pero
        - en lugar de tener un fichero JSON
        - voy a tener un script ejecutable que devuelve un JSON
    
    Los FACTS también se recuperan con:
    - un gather_facts
    - O con el módulo setup
    Pero se me almacenan en una variable independiente para que no se mezclen y no tenga que filtrar:
        "ansible_local"

- ANSIBLE_FACTS: Detales del entorno objetivo (montonón de detalles propios del entorno)
    - se pueden también cachear
    
    - Son los que recuperamos con un gather_facts
    - O con el módulo setup


## VARIABLES?

Un valor almacenado que se puede cambiar, cuándo?

## En el mundo de la programación, una variable

### es un espacio en memoria RAM donde almancenar un dato.

Usando el lenguaje somos capaces de cambiar el datos que tenemos almacenado en ese espacio de MEMORIA RAM

### es una referencia a un espacio en memoria RAM donde almancenar un dato.

Usando el lenguaje somos capaces de cambiar a donde apunta esa referencia,
de forma que la variable apunte a un nuevo dato que tenemos almacenado en otro espacio de MEMORIA RAM

### En ANSIBLE una VARIABLE NO ES NINGUNA DE ESAS DOS COSAS !!!!

Qué entendemos por una variable en ANSIBLE? 

Parámetro preconfigurable de entrada al play/playbook... en un montón de sitios los puedo preconfigurar:

PLAY
    TAREAS
ROLE
    DEFAULT
    VARS
    TASKS
INVENTARIO
    GRUPOS
    HOSTS
POR LINEA DE COMANDOS al llamar a ansible-playbook
EN UN FICHERO que suministro al llamar a ansible-playbook

Son valores ESTATICOS, que alguien preconfigura en uno de esos sitios

VARIABLE DE ANSIBLE = CONFIGURACION, PARAMETRO DE ENTRADA                       = VARIABLE DE TERRAFORM 

Ejemplo: Qué firewall está instalado en un entorno para poder abrir los puertos 



# Trabajar con variables / datos estructurados más complejos

Vamos a montar playbooks / roles con bastante parametrización

Por ejemplo, esas variables las podemos usar para:
que una tarea se haga un montón de veces, en bucle!

A la hora de usar estructuras de datos, en ocasiones nos vamos a encontrar con estructuras de datos complejas:

# Pregunta: Dónde pensais que vamos a ester una estructura de datos más compleja?

- En un role?       Reutilizable
  Habitualmente tienen muchas variables. Por quñe? porque queremos que el componente (role) sea muy reutilizable
  Pero en general las variables de los roles son variables con una estructura muy sencilla de datos.

- En un playbook?   Adhoc para conseguir un planchado
  Por contra un playbook, va muy dirigido a una tarea muy contreta, con unos parametros de configuración muy concretos
  Eso nos da que los playbooks no suele tener tantas variables como un role.
  Pero usualmente estas variables VAN A TENER UNA ESTRUCTURA MAS COMPLEJA !

PLAYBOOK: Quiero montar un LAMP en un servidor: Apache + Mysql + PHP

Sencillo o complejo? Pa montar el apache... ya nos llevamos el otro dia tropetantas tareas para el nginx!
Sencillo sencillo, no!

Seguro que voy a encontrar montonones de roles por ahi disponibles que me van a facilitar la vida.

Podría tener una variable con el software que quiero instalar.

    software:
        - mariab
        - nginx

    software:
        mariadb:
            instalacion: 
                version:
                versionMinima:
                repo:
                    url:
                    claves:
            ficherosConfiguracion:
                -
                -
                -
            puertos:
                - 3306
        nginx:
            instalacion: 
                version:
                versionMinima:
                repo:
                    url:
                    claves:
            ficherosConfiguracion:
            puertos:
                - 80
                - 443   # Abrir en un firewall

        
pos oficiales... y voy a instalar via apt.

Imaginad que quiero abrir puertos en un firewall... en mi playbook... que hago?
Facil o dificil? El tema es... quién me gestiona el firewall?

Todo el tráfico de red al final quien lo controla en una máquina Linux? KERNEL: netFilter

iptables -> netFilter
firewalld
ufw

Es decir, que en función de donde sea que esté ejecutando... tendré distintos programas para hacer ese trabajo...
Y cada uno de esos programas tendrá en Ansible un modulo (ufw, firewalld, iptables)

Qué me podría interesar crear? UN ROLE que usemos en la empresa cada vez que queramos abrir puertos en un firewall
Tarea frecuente en nuestros playbooks? SI

    ROLE: abrirPuertosFirewall
            variables: 
                puertos

Habitualmente haremos que el role haga operaciones atomicas. Es decir:

    ROLE: abrirPuertoFirewall
                variables: 
                    puerto:     ~
                    protocolo:  tcp
                    origen:     0.0.0.0
                    destino:    0.0.0.0


    ROLE: instalarPaquete
                variables: 
                    nombre:     ~
                    repo:  
                        url:
                        claves:
                    version:
                        minima:
                        ultima: true
                        actualizarSiempre:
                        downgrade: true


-   name: Instalar paquetes
    include_role: 
        name: superinstalador
    loop: "{{ paquetes }}"
    vars:
        - nombre: {{ item.nombre }}
        - version:
            minima: {{ item.versionMinima }}
            downgrade: false























# AWX ~= TOWER




-----


# script de la bash

PARAMETROS DE ENTRADA: $1, $2, $3...                            VARIABLE !

### FICHERO miscript.sh
    
    ```bash
    function saluda(){
        echo $1                 # $1 ? Amigo: Ivan
    }
    
    # FACT
    nombre="Amigo: $1"          # VARIABLE nombre = Amigo: Ivan         
    saluda "Amigo: $1"          # $1 ? Ivan
    nombre="Adios amigo $1"     ## Reasigno enl valor de la variable
    
    export nombre=Felipin!      # Que el valor de la variable quede persistido 
                                # en el entorno de la bash que esté ejecutando
                                    # Quedaría guardado en el environment de la bash
                                    # Ese environment es la CACHE DE FACTS de Ansible
                                    
    # Que pasa si ejecuto un programa que quiera acceder a $nombre posteriormente, podrá? 
        # Siempre y cuando ese programa se ejecutado desde la misma bash
        # Y ESTO ES LO QUE ME PASA EN ANSIBLE. La cache de facts está guardada en UN HOST CONTROLADOR
        
        # Pero en otro host controlador, no la tengo
    
    # Como resolvería esto en la bash... quiero una variable que siempre está asignada
        # Dar de alta el export en el .bash_rc >>>> Algo así es lo que nos resuelve TOWER/AWX
    ```

./miscript.sh Ivan


---

# Ansible = Ansible engine > Ansible project (Ansible core) 

- Un lenguaje (esquema de YAML) para playbooks e inventarios
- Un montonon de modulos (programas que ansible interactua con ellos y que son los que hacen las cosas)
- Yo lo instalo donde quiero

Esto no siempre es lo que me interesa

git > Distribuido > Si tiene repos centralizados (repos remotos, son necesarios)

# Ansible Tower / AWX

- Entorno CENTRALIZADO para trabajar con Inventarios y Playbooks (ejecutar) de ansible
- Interfaz WEB para acceder a los playbooks (ejecutarlos) y los inventarios desde cualquier sitio.
- API para gestiona inventarios y playbooks (ejecutarlos)
- Herramienta para "monitorizar" lo que va pasando con los playbooks
    - Incluyendo un registro de su ejecución
- Informes
- Nos permite programar el lanzamento automático de playbooks (automatizar la llamada al playbook)
- Nos genera entornos de ejecución independientes (de un solo uso) donde ejecutar esos playbooks (contenedores)
- Orquestar playbooks en WORKFLOWS COMPLEJOS !
- Mantener un registro centralizado de CREDENCIALES !

TODO EN ANSIBLE TOWER SE BASA EN repositorios de git!
- Inventarios
- Playbooks

## Tower aporta su nuevo y propio vocabulario, que no existe en ANSIBLE

### Proyecto

Un repo de git

### Plantilla

Un playbook 
