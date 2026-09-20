docker ps
docker exec -it mysql-server mysqldump -u root -p SALESMANAGER > salemanager_backup.sql
REM rồi nhập password