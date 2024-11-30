# Use the official OpenJDK base image
FROM openjdk:20-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file into the container
COPY banking-service-0.0.1-SNAPSHOT.jar app.jar

# Expose the port the app runs on
EXPOSE 8090

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]