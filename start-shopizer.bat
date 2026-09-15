@echo off
chcp 65001 >nul
title Shopizer - Start All
color 0A

echo ============================================
echo   SHOPIZER - KHOI DONG HE THONG
echo ============================================
echo.

set ES_HOME=C:\.m2\repository\elasticsearch-7.5.2
set SHOPIZER_HOME=C:\Users\thichnu huong nguyen\shopizer
set SHOPIZER_WAR=%SHOPIZER_HOME%\sm-shop\target\ROOT.war

:: ===== 1. Kiem tra ElasticSearch da chay chua (port 9200) =====
echo [1/3] Kiem tra ElasticSearch (port 9200)...
powershell -NoProfile -Command "try { Invoke-WebRequest -Uri 'http://localhost:9200' -UseBasicParsing -TimeoutSec 3 | Out-Null; exit 0 } catch { exit 1 }" >nul 2>&1
if %errorlevel%==0 (
    echo       ^>^> ElasticSearch DANG CHAY san - bo qua.
) else (
    if not exist "%ES_HOME%\bin\elasticsearch.bat" (
        echo       ^>^> LOI: Khong tim thay "%ES_HOME%\bin\elasticsearch.bat"
        echo           Hay sua bien ES_HOME trong file nay.
        pause
        exit /b 1
    )
    echo       ^>^> Dang khoi dong ElasticSearch (doi toi da 60 giay)...
    start "ElasticSearch" /min "%ES_HOME%\bin\elasticsearch.bat"
    powershell -NoProfile -Command "$ok=$false; for($i=0;$i -lt 30;$i++){ Start-Sleep 2; try { Invoke-WebRequest -Uri 'http://localhost:9200' -UseBasicParsing -TimeoutSec 2 | Out-Null; $ok=$true; break } catch {} }; if($ok){exit 0}else{exit 1}" >nul 2>&1
    if %errorlevel%==0 (
        echo       ^>^> ElasticSearch SAN SANG.
    ) else (
        echo       ^>^> CANH BAO: ElasticSearch chua phan hoi sau 60 giay.
        echo           Co the van dang khoi dong - kiem tra cua so ElasticSearch.
    )
)

:: ===== 2. Kiem tra Shopizer da chay chua (port 8080) =====
echo [2/3] Kiem tra Shopizer (port 8080)...
powershell -NoProfile -Command "try { Invoke-WebRequest -Uri 'http://localhost:8080/shop' -UseBasicParsing -TimeoutSec 3 | Out-Null; exit 0 } catch { exit 1 }" >nul 2>&1
if %errorlevel%==0 (
    echo       ^>^> Shopizer DANG CHAY san - bo qua.
    goto :done
)

if not exist "%SHOPIZER_WAR%" (
    echo       ^>^> LOI: Khong tim thay "%SHOPIZER_WAR%"
    echo           Hay chua lai du an truoc: mvn -DskipTests clean install
    echo           Hoac sua bien SHOPIZER_HOME trong file nay.
    pause
    exit /b 1
)

echo       ^>^> Dang khoi dong Shopizer (doi toi da 120 giay)...
start "Shopizer" /min cmd /c "cd /d "%SHOPIZER_HOME%" && java -jar "%SHOPIZER_WAR%" --server.port=8080"
powershell -NoProfile -Command "$ok=$false; for($i=0;$i -lt 60;$i++){ Start-Sleep 2; try { Invoke-WebRequest -Uri 'http://localhost:8080/shop' -UseBasicParsing -TimeoutSec 2 | Out-Null; $ok=$true; break } catch {} }; if($ok){exit 0}else{exit 1}" >nul 2>&1
if %errorlevel%==0 (
    echo       ^>^> Shopizer SAN SANG.
) else (
    echo       ^>^> CANH BAO: Shopizer chua phan hoi sau 120 giay.
    echo           Co the van dang khoi dong - kiem tra cua so Shopizer.
)

:done
echo.
echo ============================================
echo   HOAN TAT!
echo   Trang web    : http://localhost:8080/shop
echo   Quan tri     : http://localhost:8080/admin
echo   ElasticSearch: http://localhost:9200
echo ============================================
echo.
echo Mo trang web trong 5 giay...
timeout /t 5 >nul
start http://localhost:8080/shop
