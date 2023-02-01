
# Qué nombre damos a las tareas en ansible, VERBOS en imperativo? o en infinitivo. NO
## SIEMPRE RESPETANDO EL CONCEPTO DE IDEMPOTENCIA !
# De paso... teniendo en cuenta que NO LA LIO EN PRODUCCION !

# Quien podría llamar al script? 
#   Automáticamente por patrte de un servidor de automatición: JENKINS
# Ante qué eventos? 
    # Actualización del repo
    # Cambio en la confg de nginx
    # Quiera subir a una version de nginx
    # sistema de monitorización: Maquina KO -> 
    # Añadir máquinas ESCALAR

# Firewall

# Tareas pendientes
# REQUISITO:
#    - Saber lo que estoy automatizando y cómo es ese proceso... Mas me vale haberlo hecho alguna que otra vez
#    - Si no voy más perdido que una rosquilla en el desierto !

#TODO:
#    - Reestructurar mejor las variables     > Cuando sepa qué variables (REFACTORIZACION))
#    - Investigar los módulos... cuando vaya a escribir los módulos !
#        - Ponerme como loco a escribir modulos  > Si... pero quizás no aún
#    - Dar valores INICIALES a las variables > Cuando pruebe

#Podríamos crear un play DUMMY, con la estructura pero haga na' > NO ESTA MAL...


#DONE:
#    - Estructura de tareas (play)
#    - Variables previas que se me han ocurrido y su estructura
#    - Lógica del play ?         SEGUIR ENTENDIENDO EL PLAYBOOK, que no es nada facil
#        when
#        loop
#        tag
        