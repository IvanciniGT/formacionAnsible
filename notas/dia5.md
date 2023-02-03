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








Qué firewall está instalado en un entorno para poder abrir los puertos 





























# Trabajar con variables / datos estructurados más complejos

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


