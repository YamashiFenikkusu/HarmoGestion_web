FROM eclipse-temurin:25-jre
WORKDIR /app
COPY *.jar app.jar
EXPOSE 9001
ENTRYPOINT ["java","-jar","app.jar"]