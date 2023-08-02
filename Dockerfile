# Use the official OpenJDK image as a parent image
FROM openjdk:17-jdk-slim-buster

# Set the working directory to /app
WORKDIR /app


# Install Maven and other required packages
ENV MAVEN_VERSION=3.8.6
RUN apk add --no-cache curl tar bash \
    && mkdir -p /opt \
    && curl -L https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar -xzC /opt \
    && mv /opt/apache-maven-${MAVEN_VERSION} /opt/maven \
    && ln -s /opt/maven/bin/mvn /usr/bin/mvn

# Build the Java application using Maven
RUN mvn clean package -DskipTests


# Copy the packaged JAR file into the container at /app
COPY target/cloud-config-server-0.0.1-SNAPSHOT.jar cloud-config-server.jar

# Expose port 9000
EXPOSE 9000

# Run the JAR file when the container starts
CMD ["java", "-jar", "cloud-config-server.jar"]
