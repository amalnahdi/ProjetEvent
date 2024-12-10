FROM openjdk:17
EXPOSE 8089

WORKDIR /app

COPY target/*.jar /app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]