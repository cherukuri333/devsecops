# =========================
# Stage 1: Build Stage
# =========================
FROM openjdk:17-slim AS build
WORKDIR /app

# Copy pre-built JAR
COPY target/patient-service-0.0.1-SNAPSHOT.jar app.jar

# =========================
# Stage 2: Runtime Stage
# =========================
FROM eclipse-temurin:17-jre-jammy AS runtime
WORKDIR /app

# Install latest libpng for security patches
RUN apt-get update && \
    apt-get install -y --no-install-recommends libpng16-16 && \
    rm -rf /var/lib/apt/lists/*

# Copy JAR from build stage
COPY --from=build /app/app.jar app.jar

EXPOSE 8080

# Use non-root user for better security (optional)
RUN useradd -m appuser
USER appuser

ENTRYPOINT ["java", "-jar", "app.jar"]
