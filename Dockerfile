FROM maven:3.9.9-eclipse-temurin-21 AS builder

WORKDIR /app

COPY . .

RUN mvn clean package

# Tomcat image for deployment

FROM tomcat:9.0.108-jdk21-temurin

WORKDIR /usr/local/tomcat/webapps

# Remove default ROOT app and deploy as ROOT.war so the app is
# accessible at / instead of /webapp
RUN rm -rf ROOT

COPY --from=builder /app/webapp/target/*.war ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
