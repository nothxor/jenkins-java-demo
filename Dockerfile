FROM openjdk:21-jre-slim

# Set working directory
WORKDIR /app

# Copy the JAR file
COPY build/libs/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
