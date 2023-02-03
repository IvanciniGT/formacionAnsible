 # Otro ejemplo

    paquetes:
        -  nombre: mariadb
            versionMinima:
            repo:
                url:
                claves:
        -  nombre: nginx
            version:
            versionMinima:
            repo:
                url:
                claves:
    puertos:
        - 80
        - 443
        - 3306

    ficherosConfiguracion:
        - mariadb.conf
        - nginx.conf
        - ruta/despiegue.conf
    
YO A ESTE LE VEO UN INCONVENIENTE GRANDE !

No tengo la información ligada, relacionada:
- En caso de fallo... De donde?
- Mantenibilidad