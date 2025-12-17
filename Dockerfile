FROM maven:3.8.8-eclipse-temurin-17 AS build
WORKDIR /workspace
COPY pom.xml .
COPY .mvn .mvn
COPY src src
RUN mvn -T 1C -DskipTests clean package

FROM tomcat:10.1-jre17
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=build /workspace/target/*.war /usr/local/tomcat/webapps/ROOT.war
RUN mkdir -p /usr/local/tomcat/bin && \
    echo '#!/bin/bash' > /usr/local/tomcat/bin/setenv.sh && \
    echo 'export CATALINA_OPTS="-Dspring.datasource.url='${SPRING_DATASOURCE_URL:=jdbc:mysql://db:3306/shop_quan_ao}' -Dspring.datasource.username='${SPRING_DATASOURCE_USERNAME:=myuser}' -Dspring.datasource.password='${SPRING_DATASOURCE_PASSWORD:=mypassword}' -Dspring.jpa.hibernate.ddl-auto='${SPRING_JPA_HIBERNATE_DDL_AUTO:=update}'"' >> /usr/local/tomcat/bin/setenv.sh && \
    chmod +x /usr/local/tomcat/bin/setenv.sh
EXPOSE 8080
CMD ["catalina.sh", "run"]
