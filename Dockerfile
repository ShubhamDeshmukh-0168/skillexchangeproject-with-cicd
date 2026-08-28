# ---- Stage 1: build the WAR with Maven ----
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /build
COPY pom.xml .
# Cache dependencies separately from source for faster rebuilds
RUN mvn -B dependency:go-offline || true
COPY src ./src
RUN mvn -B clean package

# ---- Stage 2: run it on Tomcat 10.1 (Jakarta / Servlet 6.0) ----
FROM tomcat:10.1-jdk17-temurin
# Remove default apps and deploy ours as ROOT so it serves at "/"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /build/target/SkillExchangeProject.war /usr/local/tomcat/webapps/ROOT.war

# DB connection is read from environment variables by the app/JDBC config.
# Override these at "docker run" or in docker-compose.yml / your orchestrator.
ENV DB_URL="jdbc:mysql://REPLACE_ME_ENDPOINT:3306/skillexchange?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
ENV DB_USER="REPLACE_ME_USERNAME"
ENV DB_PASSWORD="REPLACE_ME_PASSWORD"

EXPOSE 8080
CMD ["catalina.sh", "run"]
