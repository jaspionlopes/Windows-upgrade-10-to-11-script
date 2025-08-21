@echo off
REM Ajusta política de execução temporária para PowerShell
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp010to11.ps1'"
pause