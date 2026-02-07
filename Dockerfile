# Dockerfile para app HTML/CSS/JS vanilla
FROM nginx:alpine

# Copia todos los archivos de tu proyecto al directorio que Nginx usa por defecto
COPY index.html /usr/share/nginx/html/
COPY css/ /usr/share/nginx/html/css/
COPY js/ /usr/share/nginx/html/js/
COPY images/ /usr/share/nginx/html/images/

# Expone el puerto 80
EXPOSE 80

# Mantener Nginx corriendo en primer plano
CMD ["nginx", "-g", "daemon off;"]
