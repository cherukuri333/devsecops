# =========================
# Stage 1: Build JAR
# =========================

FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app

COPY target/scan-service-0.0.1-SNAPSHOT.jar app.jar

# =========================
# Stage 2: Runtime
# =========================

FROM eclipse-temurin:17-jre-jammy AS runtime
WORKDIR /app

# Install patched libpng to avoid Trivy HIGH CVEs
RUN apt-get update && \
    apt-get install -y --no-install-recommends libpng16-16 && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /app/app.jar app.jar

EXPOSE 8080

# (Optional) Use non‑root user
RUN useradd -m appuser
USER appuser

ENTRYPOINT ["java", "-jar", "app.jar"]
