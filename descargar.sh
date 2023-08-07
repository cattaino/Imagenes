#!/bin/bash
URL="$1"
SUM="$2"
HTPS="https://*"
if [[ ! $URL =~ $HTPS || ! $SUM =~ $HTPS || ! $# -eq 2 ]]; then
echo "Datos ingresados incorrectamente"
exit 1
fi
descargar(){ # Recibe la URL y devuelve el archivo img.jpg
wget -O img.jpg "$1"
}
cotejar(){ # Recibe la suma ingresada por el usuario y la del archivo .zip
[ $1 =~ $2 ] && exit 0
[ ! $1 =~ $2 ] && exit 2
}
SUMA=$"sha256sum $URL"
cotejar "$SUM" "$SUMA" && descargar "$URL"
