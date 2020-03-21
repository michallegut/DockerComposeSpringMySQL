FROM alpine/git
WORKDIR /usr
RUN git clone https://github.com/callicoder/spring-boot-mysql-rest-api-tutorial

FROM maven:3.6.1-jdk-8-alpine
WORKDIR /usr
COPY --from=0 /usr/spring-boot-mysql-rest-api-tutorial /usr
COPY application.properties /usr/src/main/resources
RUN mvn install -Dmaven.test.skip=true

FROM openjdk:8-jre-alpine
WORKDIR /usr
COPY --from=1 /usr/target/easy-notes-1.0.0.jar /usr
CMD ["java", "-jar", "easy-notes-1.0.0.jar"]