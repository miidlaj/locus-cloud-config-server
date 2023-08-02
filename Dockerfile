# Use Alpine Linux with OpenJDK 17 as the base image
FROM openjdk:17-jdk-alpine3.14

# Set the working directory inside the container
WORKDIR /app

# Set the Maven version environment variable
ENV MAVEN_VERSION=3.8.6

# Copy the necessary files to the container
COPY pom.xml .
COPY src ./src

# Install Maven and other required packages
RUN apk add --no-cache curl tar bash \
    && mkdir -p /opt \
    && curl -L "https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" | tar -xzC /opt \
    && mv /opt/apache-maven-${MAVEN_VERSION} /opt/maven \
    && ln -s /opt/maven/bin/mvn /usr/bin/mvn

# Build the Java application using Maven
RUN mvn clean package -DskipTests

# Expose port 9000
EXPOSE 9000

# Set the command to run the application (assuming your main class is com.example.Application)
CMD ["java", "-jar", "target/clound-config-server.jar"]
