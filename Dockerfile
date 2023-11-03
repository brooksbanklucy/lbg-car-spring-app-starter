# Build stage
FROM maven:3.8.5-openjdk-17-slim as build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY . .
RUN mvn package && rm -rf target/src

# Runtime stage
FROM openjdk:17-alpine3.14
COPY --from=build /app/target/*.jar cardatabase-0.0.1-SNAPSHOT.jar
CMD ["java", "-jar", "cardatabase-0.0.1-SNAPSHOT.jar"]
