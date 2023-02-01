-   # Definir un play


    hosts:          # Definir en que entornos (de entre los del inventario)
                    # vamos a ejecutar este play

    gather_facts: true|false    # Nos permitía decir de forma sencilla (ya veremos formas más complejas)
                                # Si queríamos desde el principio del play obtener TODOS los facts 
                                # de un entorno
    vars:           # Variables
    
    # El detalle de tareas que queremos ejecuatr

    pre_tasks:

    tasks:

    post_tasks:

    handlers:
    
# A nivel de una tarea:

    -   name: 
        modulo:                             |
            configuración del módulo        |   Tengo que ir a la docu
        
        # Control del estado de ejecución
        failed_when: Expresion lógica
        changed_when: Expresion lógica
        ignore_errors: Expresion lógica
        
        # Capturar la salida del módulo
        register: nombre_de_una_nueva_variable
        
        # Con respecto a controlar la ejecución de la tarea
        when:   Expresión lógica
        tags:   Lista de tags (identificadores)
        loop:   
            Una lista metida en el YAML
            Una plantilla jinja que devolviera una lista
            "{{ var.puertos }}"
            Nos permite ejecutar una tarea varias veces
        
        NOTA: En caso de tener u loop y un when, en que orden se ejecutan:
            El loop antes que el when:
                El when se aplica sobre cada iteración del loop
                    Esto nos permite que para algunos de los valores de la lista se ejeute o no la tarea
        
        # Variables
        vars:
        
Sobre las variables, había algunas comprobaciones que podemos hacer:

    var_name is defined
    var_name is undefined
    
Sobre las variables que apuntan a la salida de un módulo:

    modulo_var is success
    modulo_var is failed
    modulo_var is changed
    modulo_var is skipped
    
Además las tareas las podíamos agrupar en bloques de tareas:

    -   name: Nombre del bloque
        block:
            - Lista de tareas del bloque
        rescue:
            - Lista de tareas que queremos ejecutar si FALLA alguna de las del block
        always:
            - Lista de tareas que queremos ejecutar SIEMPRE con independencia de si las del boque fallaron o no
        vars:
        when:
        tags:
        
Modulos:

Hemos visto... de pasada... pero visto que Ansible tiene algo así como TROPECIENTOS modulos

Esos módulos tienen funcionalidades MUY CONCRETAS... 

Cuando se desarrolla un módulo se hace mucho hincapie en el concepto de IDEMPOTENCIA

Nosotros ya hemos juagdo con algunos módulos:
- debug:
    msg:
    var:

- shell:        ****
    cmd:    

**** Modulo shell NOTAS:

- El estado de una tarea shell siempre es changed por defecto (ESTO NO ES BUENO) conviene cambiarlo
- HEMOS DE TRATAR DE EVITAR A TODA COSTA SU USO
  Y eso no es fácil... es muy goloso !
  Por qué? ES UNO de los poco módulos que NO RESPECTAN el principio de IDEMPOTENCIA !
    ME TOCA CURRARMELO A MI.
    Y aunque estoy más que acostumbrado (soy un mago de la bash) a escribir scripts
    NO ESTOY NADA ACOSTUMBRADO A RESPETAR EL PRINCIPIO DE IDEMPOTENCIA
    RESULTADO: Seguro que la cago !
    MUCHO CUIDADO !

shell:
    cmd: mkdir -p /datos         >>> WARNING 
    
---

# Inventarios

Es un catalogo de entornos remotos sobre los que potencialmente vamos a aplicar unos playbooks

## Sintaxis para escribir eso:

3 sintaxis diferentes.

### INI

Son muy muy muy sencillos de escribir. NOS ENCANTAN.... 
Siempre claro, que no quiera escribir mucho... especialmente VARIABLES
Porque entonces son MUY MUY MUY COMPLEJOS y voy jodido... hasta limites INIMAGINABLES !

### YAML

Son geniales, PERO NO LOS USARIA NI AUNQUE DEPENDIERA MI PUESTO DE TRABAJO DE ELLO
Geniales en cuanto a cómo estructuran la infromación....
Y en cuanto a cómo me permiten meter las variables
PERO: 
    SON UNA MIERDA GIGANTE !!!!!
    Que no tenga 1000 máquinas con 10 variables cada una
    Que me sale un fichero con 10000 lineas
        Y a ver quien le mete mano

### CARPETAS con archivos INI y YAML                *******

GENIAL !!!!!
Lo mejor de los 2 mundos!


---

Cómo nos vamos a conectar con nuestros 5578 servidores linux que tengo contratados en AWS
    ssh

2º Desde donde vamos a ejecutar un playbook
    Donde esté instalado ansible:
        AWX/TOWER
            -> contenedor

3º Para conectarme con ssh con un entorno remoto, necesito
    - Conectividad
    - Usuario
    - Clave
    
playbook: De de alta los servidores en el known hosts

