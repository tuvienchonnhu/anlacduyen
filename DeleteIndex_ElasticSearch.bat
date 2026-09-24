REM powershell -Command Invoke-WebRequest  -Uri "http://localhost:9200/keyword_vi_default"   -Method Delete
# Xóa các index keyword và product
curl -X DELETE "http://localhost:9200/keyword_*"
curl -X DELETE "http://localhost:9200/product_*"
#kiểm tra trạng thái
curl -X GET "http://localhost:9200/_cluster/health?pretty"