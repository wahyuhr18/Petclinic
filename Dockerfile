# Gunakan base image JDK untuk runtime
FROM eclipse-temurin:17-jdk-jammy as build

# Set working directory
WORKDIR /app

# Copy seluruh project dan build langsung
COPY . .

# Build project dan hasilkan app.jar
RUN ./mvnw clean install -DskipTests

# Gunakan base image untuk menjalankan Spring Boot
FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

# Salin file JAR hasil build
COPY --from=build /app/target/app.jar app.jar

# Jalankan aplikasi
ENTRYPOINT ["java", "-jar", "app.jar"]
