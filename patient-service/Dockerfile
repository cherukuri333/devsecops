#Build stage (optional, JAR already built by Maven)v
FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app
COPY target/patient-service-0.0.1-SNAPSHOT.jar app.jar

# Stage 2: Runtime stage
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/app.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]














