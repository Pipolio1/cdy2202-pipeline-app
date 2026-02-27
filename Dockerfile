# Imagen base con Tomcat y Java 17
FROM tomcat:10-jdk17

# Elimina aplicaciones por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia el WAR generado por Maven
COPY target/vehiculosBuild.war /usr/local/tomcat/webapps/ROOT.war

# Expone el puerto 8080 dentro del contenedor
EXPOSE 8080

# Inicia Tomcat
CMD ["catalina.sh", "run"]
