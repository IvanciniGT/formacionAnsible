# Quiero instalar el servidor web nginx y lo quiero montar en máquinas UBUNTU
# Lo único que quiero dejar el nginx funcionando en un puerto de mi interés
# Quiero poder trabajar con mi propio document root
# Que se rellene con los ficheros que tengamos en un repo de git
# https://github.com/IvanciniGT/webEjemploAnsible
# RESPETANDO EL PRINCIPIO DE IDEMPOTENCIA !

#---
# Escenarios de uso de nuestros tags:

# Hay un bug en la version de nginx actual... ME MANDAN UN REQUEST QUE ES NECESARIO ACTUALIZAR TODOS NUESTROS NGINX
#    --tag: instalacion
#    // Quiero refrescar la app? Quizás no... aun habiendo una nueva versión
    
# Tengo un sistema de monitorización
#    --tag: pruebas
