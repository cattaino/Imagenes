#!/bin/bash
URL="$1"
SUM="$2"
HTPS="https://*"
if [[ ! $URL =~ $HTPS || ! $# -eq 2 ]]; then
echo "Datos ingresados incorrectamente"
exit 1
fi
descargar(){ # Recibe la URL y devuelve el archivo .jpg
wget "$1"
}
cotejar(){ # Recibe la suma ingresada por el usuario y la del archivo .zip
if [ "$1" = "$2" ]; then
exit 0
else
exit 2
fi
}
obtener_suma(){ # Recibe un archivo y devuelve su suma de verificacion
sha256sum "$1"
}
nombre_archivo(){ # Recibe la URL de un archivo y devuelve su nombre
echo "$1" | tr "/" "\n" | tail -n 1
}
descargar "$URL"
IMG="nombre_archivo $URL"
SUMA="obtener_suma $IMG"
cotejar "$SUM" "$SUMA"
if [ $? -eq 0 ]; then
echo "Operacion terminada correctamente"
else
echo "Suma de verificacion incorrecta" && rm $"nombre_archivo $URL"
fi
