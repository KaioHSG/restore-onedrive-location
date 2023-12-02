:: Created by: Shawn Brink
:: https://www.tenforums.com/tutorials/23504-users-personal-folders-restore-default-location-windows-10-a.html

:: Modified by: Kaio HSG
:: https://github.com/kaiohsg/RestoreOneDriveLocation

@echo off
title Restore OneDrive Location
net session
cls
if %ErrorLevel% neq 0 (
   echo Accept to continue...
   echo Set UAC = CreateObject^("Shell.Application"^) > "%Temp%\%~n0.vbs"
   echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%Temp%\%~n0.vbs"
   "%Temp%\%~n0.vbs"
   del "%Temp%\%~n0.vbs"
   exit
)
taskkill /f /im explorer.exe > nul
timeout /t 2 /nobreak > nul
echo Pictures:
if not exist "%UserProfile%\Pictures" mkdir "%UserProfile%\Pictures"
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "My Pictures" /t REG_SZ /d "C:\Users\%USERNAME%\Pictures" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{0DDD015D-B06C-45D5-8C4C-F59713854639}" /t REG_EXPAND_SZ /d %%USERPROFILE%%"\Pictures" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "My Pictures" /t REG_EXPAND_SZ /d %%USERPROFILE%%"\Pictures" /f
attrib +r -s -h "%USERPROFILE%\Pictures" /S /D
echo -------------------------------------------------
echo Documents:
if not exist "%UserProfile%\Documents" mkdir "%UserProfile%\Documents"
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Personal" /t REG_SZ /d "C:\Users\%USERNAME%\Documents" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{f42ee2d3-909f-4907-8871-4c22fc0bf756}" /t REG_EXPAND_SZ /d %%USERPROFILE%%"\Documents" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "Personal" /t REG_EXPAND_SZ /d %%USERPROFILE%%"\Documents" /f
attrib +r -s -h "%USERPROFILE%\Documents" /S /D
echo -------------------------------------------------
echo Desktop:
if not exist "%UserProfile%\Desktop" mkdir "%UserProfile%\Desktop"
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop" /t REG_SZ /d "C:\Users\%USERNAME%\Desktop" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "Desktop" /t REG_EXPAND_SZ /d %%USERPROFILE%%"\Desktop" /f
attrib +r -s -h "%USERPROFILE%\Desktop" /S /D
echo =================================================
timeout /t 1 /nobreak > nul
start explorer.exe
echo Finish.
pause > nul
