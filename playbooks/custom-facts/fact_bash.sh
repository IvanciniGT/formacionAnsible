#!/bin/bash
variable1="SCRIPT DE LA BASH"

cat <<EOF
{
    "clave1": 44,
    "clave2": "${variable1}",
    "clave3": true
}
EOF