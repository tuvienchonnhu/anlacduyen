REM Chạy Trên powershell
REM powershell -Command "$b = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes('admin@shopizer.com:password'))
REM Invoke-WebRequest -Uri 'http://localhost:8080/services/private/DEFAULT/search/index' -Headers @{Authorization="Basic $b"} -Method GET

powershell -Command "$b = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes('admin@shopizer.com:password')); Invoke-WebRequest -Uri 'http://localhost:8080/services/private/DEFAULT/search/index' -Headers @{Authorization=\"Basic $b\"} -Method GET"


REM chạy trên CMD
REM curl -X GET "http://localhost:8080/services/private/DEFAULT/search/index" -u admin@shopizer.com:password  
