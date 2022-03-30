FROM maven:3.6.2-jdk-11 as builder

WORKDIR /app
COPY pom.xml pom.xml
COPY src ./src/
RUN mvn clean package -DskipTests

FROM openjdk:11-jre-slim as runtime
WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar
CMD ["java", "-Xms64M", "-Xmx64M", "-jar", "app.jar"]
