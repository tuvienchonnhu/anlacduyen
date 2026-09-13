REM docker rm -f anlacduyen
REM docker build -t anlacduyen .
REM docker run -d -p 8080:8080 --name anlacduyenEcommerce anlacduyen
docker build -t shopizer -f sm-shop/Dockerfile .