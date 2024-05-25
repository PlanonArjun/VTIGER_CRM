#FROM openjdk:17
#EXPOSE 8080
#COPY Vtiger.CRM.Framework-0.0.1-SNAPSHOT/app/Vtiger.CRM.Framework-0.0.1-SNAPSHOT
#ENTRYPOINT ["java", "-jar", "/app/Vtiger.CRM.Framework-0.0.1-SNAPSHOT"]

FROM maven:3.8.4-openjdk-17-slim as maven
COPY ./pom.xml ./pom.xml
COPY ./src ./src
RUN mvn dependency:go-offline -B
RUN mvn package
FROM openjdk:17
EXPOSE 8080
WORKDIR /automation-framework
COPY --from=maven target/Vtiger.CRM.Framework-0.0.1-SNAPSHOT /app/Vtiger.CRM.Framework-0.0.1-SNAPSHOT
ENTRYPOINT ["java", "-jar", "/app/Vtiger.CRM.Framework-0.0.1-SNAPSHOT"]