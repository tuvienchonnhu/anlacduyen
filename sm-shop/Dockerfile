# ============================================================
# Stage 1: build WAR with Maven (inside Docker)
# ============================================================
FROM maven:3.8-openjdk-8 AS builder

WORKDIR /build

# Copy all modules (build context = project root)
COPY pom.xml .
COPY sm-core-model ./sm-core-model
COPY sm-core-modules ./sm-core-modules
COPY sm-core ./sm-core
COPY sm-shop-model ./sm-shop-model
COPY sm-shop ./sm-shop

# Build the shop WAR (skip tests)
RUN mvn clean install -DskipTests

# ============================================================
# Stage 2: run with Spring Boot (mvn spring-boot:run)
# ============================================================
FROM maven:3.8-openjdk-8

WORKDIR /build

# Reuse dependencies compiled in stage 1
COPY --from=builder /root/.m2 /root/.m2
COPY --from=builder /build /build

# H2 database (SALESMANAGER.h2.db) is created automatically on first run
ENV JAVA_OPTS="-Xmx1024m"

# files dir used by shopizer content manager
RUN mkdir -p /build/files

# Database configuration can be overridden at `docker run` time, e.g.:
#   docker run -e SPRING_APPLICATION_JSON='{"db.jdbcUrl":"jdbc:mysql://shopizer-db:3306/SALESMANAGER",...}' shopizer
# Default (below) = MySQL at host shopizer-db, user shopizer / password password
ENV SPRING_APPLICATION_JSON='{"db.jdbcUrl":"jdbc:mysql://shopizer-db:3306/SALESMANAGER?autoReconnect=true&serverTimeZone=UTC&useUnicode=true&characterEncoding=UTF-8","db.user":"shopizer","db.password":"password","db.driverClass":"com.mysql.cj.jdbc.Driver","hibernate.dialect":"org.hibernate.dialect.MySQL5InnoDBDialect","db.schema":"SALESMANAGER","db.preferredTestQuery":"SELECT 1"}'

CMD ["mvn", "-q", "-pl", "sm-shop", "spring-boot:run", "-DskipTests"]

EXPOSE 8080