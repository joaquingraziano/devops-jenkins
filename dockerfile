# Un archivo docker (dockerfile) comienza siempre importanto la imagen base. 
# Utilizamos la palabra clave 'FROM' para hacerlo.
# En nuestro ejemplo, queremos importar la imagen de python.
# Así que escribimos 'python' para el nombre de la imagen y 'latest' para la versión.
FROM nginx:1.24-alpine

# Para lanzar nuestro código python, debemos importarlo a nuestra imagen.
# Utilizamos la palabra clave 'COPY' para hacerlo.
# El primer parámetro 'main.py' es el nombre del archivo en el host.
# El segundo parámetro '/' es la ruta donde poner el archivo en la imagen.
# Aquí ponemos el archivo en la carpeta raíz de la imagen. 
COPY index.html /usr/share/nginx/html/index.html 

# Necesitamos definir el comando a lanzar cuando vayamos a ejecutar la imagen.
# Utilizamos la palabra clave 'CMD' para hacerlo.
# El siguiente comando ejecutará "python ./main.py".
