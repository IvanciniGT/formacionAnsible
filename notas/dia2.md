# HANDLERS 

Los handlers nos dan la oportunidad de ejecutar tareas CONDICIONALES, lanzadas mediante eventos.
Para activar un handler:
    1º Se usa una sintaxis : "notify"
        - Podemos poner el nombre           <<<< NUNCA !
        - NOMBRE_DE_UN_EVENTO               <<<< GUAY !!
    2º Para que el handler sea activado, la tarea que tiene el notify tiene que haber provocado cambios !
    
    
## Eventos????

Los eventos me permiten:
- Trabajar con algo más robusto que un nombre (que lleva espacios en blanco, acentos...) y que es fácil que cambie
- Activar varios handlers de UNA 
    
PLAYBOOK1

PRE
    1 -> b
----------------> Ejecución de los handlers
TASKS
    2 -> a
    ------------> Si hago un flush de los handlers. Esto lo puedo hacer con la tarea: meta: flush-handlers
    3 -> a
    4
----------------> Ejecución de los handlers
POST
    5 -> a
----------------> Ejecución de los handlers
HANDLERS
    a
    b


Tiempo de ejecución
    1
    2
    3
    4
    5
    
Si un handler es activado varias veces dentro del mismo bloque de tareas se ejecuta UNA SOLA VEZ 

# Estados de las tareas de un playbook

Estados de ejecución de una tarea:

- ok: succeded    Que ha ido bien 
- changed         Que ha ido bien, pero que ha provocado cambios en el entorno administrado/remoto
- failed          Que ha fallado

- unreachable     ?
- skipped         La tarea se ha saltado / ignorado

¿ Cómo sabe Ansible que la tarea ha acabado en uno de esos estados ? 

- Eso es información que devuelve el módulo... 
  - Me fío del módulo?
  - El módulo tiene capacidad para saber el estado real de ejecución de la tarea? NO SIEMPRE !
        - ok: succeded    Que ha ido bien 
        - changed         Que ha ido bien, pero que ha provocado cambios en el entorno administrado/remoto
        - failed          Que ha fallado
    
    Si el módulo es sencillo... o hace operaciones MUY CONCRETAS, tendrá opción de saberlo.
    Podrá meter SU LOGICA dentro de su CODIGO, para averiguarlo.

    Imaginad un módulo: ejecuta en script que tengo por aqui... 
                        No hay que imaginar mucho:                  shell
    
    Hay módulos QUE NO TIENEN CAPACIDAD PARA ELLO... como el módulo shell
    En esos casos, Ansible me da la opción de controlar externamente el estado en el que acaba una tarea
        - changed_when      Si en la salida estandar aparece CHANGED
        - failed_when       Si en la salida estandar aparece FAILED o return code > 0

    MODULO A: Quiero que me asegures que existe una carpeta llamada /datos


------
MODULO A:
- Debe asegurar que la caprtea queda creada
- Debe informar si la tarea ha provocado un cambio

    #!/bin/bash

    # Solución 1            # Funciona si la carpeta no existe
    #mkdir /datos

    # Solución 2            # Esto funciona siempre. Ahora... Se si esta tarea ha provocado un cambio ? 
    #mkdir -p /datos
    
    # Solución 3
    ruta_a_crear_como_directorio=$1
    if [ -d "$ruta_a_crear_como_directorio" ]
    then
        echo OK
        exit 0
    else if [ ! -e "$ruta_a_crear_como_directorio" ]
    then 
        mkdir /datos
        echo CHANGED
        exit 0
    else
        echo FAILED
        exit 1
    fi
    
# NOTA: meta: flush-handlers

NO ESTA CONSIDERADO UNA BUENA PRACTICA !

El problema es que se salta la LOGICA NATURAL DEL PLAYBOOK.
El playbook deja de comportarse como se espera que se comporte un playbook....
Y eso al que venga detrás dentro de 6 meses ha tocar el código, le va a volver loco !

HAY QUE USARLO CON EXTREMO CUIDADO !

# JINJA 2

## Lo qué?????

Es un sistema para montar plantillas que existe en PYTHON.

## Qué entendemos por una plantilla?

UN TEXTO ! que se genera desde otro texto en el cual podemos usar una sintaxis (JINJA2)
para:
- Reemplazar placeholders: MARCAS que se reemplazan por valores de variables


        {{ NOMBRE_VARIABLE }} => valor_variable

- Meter lógica de programación: if, for, ...


        {% if condicion %}
        {% endif %}

        {% for elemento in coleccion %}
        {% endfor %}

JINJA OPERA mediante FILTROS


    El primer puerto del servicio {{ servicio.nombre | upper }} es el {{ servicio.puertos[0] }}

Jinja de serie vienen con un MONTONON de filtros predefinidos:

[Página con los filtros de JINJA2](https://jinja.palletsprojects.com/en/3.1.x/templates/#list-of-builtin-filters)

Ansible añade un huevo más de filtros a JINJA
[Página con los filtros adicionales de ANSIBLE](https://docs.ansible.com/ansible/2.8/user_guide/playbooks_filters.html)

