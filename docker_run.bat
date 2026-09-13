REM cd sm-shop
REM docker rm -f anlacduyen
REM docker build -t anlacduyen .
REM cd ..
REM docker run -p 8081:8080 -v shopizer-data:/build shopizer
docker run --name shopizer-app -p 8081:8080 ^
  -e SPRING_APPLICATION_JSON="{\"db.jdbcUrl\":\"jdbc:mysql://host.docker.internal:3306/SALESMANAGER?useUnicode=true^&characterEncoding=UTF-8\",\"db.user\":\"root\",\"db.password\":\"password\",\"db.driverClass\":\"com.mysql.cj.jdbc.Driver\",\"hibernate.dialect\":\"org.hibernate.dialect.MySQL5InnoDBDialect\",\"db.schema\":\"SALESMANAGER\",\"db.preferredTestQuery\":\"SELECT 1\"}" ^
  shopizer