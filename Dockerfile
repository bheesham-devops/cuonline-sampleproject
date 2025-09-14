FROM maven:3.9.9-eclipse-temurin-21 AS builder

WORKDIR /app

COPY . .

RUN mvn clean package

# Tomcat image for deployment

FROM tomcat:9.0.108-jdk21-temurin

WORKDIR /usr/local/tomcat/webapps

# Copy the built WAR file from the Maven builder stage to the Tomcat webapps directory
COPY --from=builder /app/webapp/target/*.war .

EXPOSE 8080

# Command to run Tomcat
CMD ["catalina.sh", "run"]
