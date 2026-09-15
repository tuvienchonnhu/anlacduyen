@echo off
chcp 65001 >nul
title Shopizer - Stop All
color 0C

echo ============================================
echo   DUNG SHOPIZER VA ELASTICSEARCH
echo ============================================
echo.

echo [1/2] Dung Shopizer (java port 8080)...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :8080 ^| findstr LISTENING') do (
    echo       ^>^> Kill PID %%a
    taskkill /F /PID %%a >nul 2>&1
)

echo [2/2] Dung ElasticSearch (java port 9200)...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :9200 ^| findstr LISTENING') do (
    echo       ^>^> Kill PID %%a
    taskkill /F /PID %%a >nul 2>&1
)

echo.
echo HOAN TAT - Tat ca da duoc dung.
timeout /t 3 >nul
