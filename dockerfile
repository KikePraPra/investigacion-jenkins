# Dockerfile para app HTML/CSS/JS vanilla
FROM nginx:alpine

# Copia todos los archivos de tu proyecto al directorio que Nginx usa por defecto
COPY . /usr/share/nginx/html

# Expone el puerto 80
EXPOSE 80

# Mantener Nginx corriendo en primer plano
CMD ["nginx", "-g", "daemon off;"]
