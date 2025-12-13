# Stage 1  stage (JAR already built by Maven)
FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app

# Copy scan-service JAR produced by Maven
COPY target/scan-service-0.0.1-SNAPSHOT.jar app.jar

# Stage 2: Runtime stage
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

COPY --from=build /app/app.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

