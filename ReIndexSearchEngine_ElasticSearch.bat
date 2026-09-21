REM Chạy Trên powershell
REM powershell -Command "$b = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes('anlacduyen01@gmail.com:password'))
REM Invoke-WebRequest -Uri 'http://localhost:8080/services/private/DEFAULT/search/index' -Headers @{Authorization="Basic $b"} -Method GET

REM powershell -Command "$b = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes('anlacduyen01@gmail.com:password')); Invoke-WebRequest -Uri 'http://localhost:8080/services/private/DEFAULT/search/index' -Headers @{Authorization=\"Basic $b\"} -Method GET"


REM chạy trên CMD
curl -X GET "http://localhost:8080/services/private/DEFAULT/search/index" -u anlacduyen01@gmail.com:password  
