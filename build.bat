REM mvnw clean install -DskipTests
mvnw compile -DskipTests
REM docker build -t shopizer -f sm-shop/Dockerfile .