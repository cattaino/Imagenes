# A corregir: cuando descomprimo imagenes.zip encuentro el directorio
# deberia encontrar solo las imagenes - Si descargo 2 imagenes tengo solo 1
#!/bin/bash
if [[ ! $1 =~ ^[0-9]*$ || $# != 1 ]]; then
echo "Cantidad ingresada erroneamente"
exit 1
fi
descargar_imagen() { # Recibe la url y la ruta donde se guardara
wget -O "$2/imagen.jpg" "$1"
# La opc -O sirve para especificar el archivo de salida
# Args: 1) ruta del archivo de salida incluida su extension 2) URL
}
aleatorizar_nombres() { # Recibe el archivo .csv
NOMBRES=$1
sort -R <<< "$NOMBRES"
}
armar_dir() { # Recibe $1 de generar.sh, la url de la imagen y el .csv
# Devuelve el directorio con las imagenes renombradas
mkdir dir_imagenes
for i in $(seq "$1"); do
descargar_imagen "$2" "dir_imagenes"
NOMBRE=$(aleatorizar_nombres "$3" | tail -n $i | head -n 1)
mv "dir_imagenes/imagen.jpg" "dir_imagenes/$NOMBRE.jpg"
done
}
comprimir_carpeta() { # Recibe la carpeta con las imegenes
zip -r imagenes.zip "$1" # Devuelve el archivo comprimido
rm -r "$1"
}
armar_dir "$1" "https://source.unsplash.com/random/900%C3%97700/?person" "https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv"

comprimir_carpeta "./dir_imagenes"
exit 0
