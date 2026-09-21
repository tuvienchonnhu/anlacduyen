
REM chay bằng powershell
 Invoke-WebRequest -UseBasicParsing "http://localhost:9200/product_vi_default/_mapping" | Select-Object -ExpandProperty Content

