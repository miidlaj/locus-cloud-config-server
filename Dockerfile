# Use the official OpenJDK image as a parent image
FROM openjdk:17-jdk-slim-buster

# Set the working directory to /app
WORKDIR /app

# Copy the packaged JAR file into the container at /app
COPY target/cloud-config-server-0.0.1-SNAPSHOT.jar cloud-config-server.jar

# Expose port 9000
EXPOSE 9000

# Run the JAR file when the container starts
CMD ["java", "-jar", "cloud-config-server.jar"]
