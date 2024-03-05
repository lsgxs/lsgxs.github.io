@echo off  
setlocal enabledelayedexpansion  
  
echo ====1.Enable network discovery and file and printer sharing====
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Network\LanmanServer" /v "EnableNetBIOS" /t REG_DWORD /d 1 /f  
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\NetworkProvider" /v "NPAllowUniversalXPNSearch" /t REG_DWORD /d 1 /f  
net share * /GRANT:Everyone,FULL /REMARK:"Password Protected Shares Disabled"  
  
echo 2. 设置本地安全策略...  
REM 这里需要手动打开本地安全策略管理器并进行设置，无法通过批处理脚本自动完成。  
  
echo ====3.Enable the guest account and configure access permissions====  
net user Guest /active:yes  
net user Guest /add  
net localgroup "Guests" Guest /add  
net localgroup "Deny access to this computer from the network" | findstr /i /c:"Guest" > nul  
if %errorlevel%==0 (  
    net localgroup "Deny access to this computer from the network" /delete Guest > nul  
    if %errorlevel%==0 (  
        echo Guest user has been removed from the "Deny access to this computer from the network" list.  
    ) else (  
        echo Failed to remove Guest user from the list.  
    )  
) else (  
    echo Guest user is not in the "Deny access to this computer from the network" list.  
)  
  
echo ====4.Turn off the firewall and prompt the user to restart the computer====

netsh advfirewall set publicprofile state off  
netsh advfirewall set privateprofile state off  
set /p answer="Do you want to restart your computer to apply the new settings? (y/n): "  
if /i "%answer%"=="y" (  
    echo Restarting the computer...  
    shutdown /r /t 0  
) else (  
    echo No restart requested. Please restart manually to apply the changes.  
)

echo.  
echo Operations completed. Do you want to restart the computer? (Y/N):  
set /p choice="Please enter Y or N: "  
  
if /i "!choice!"=="Y" (  
    echo You have chosen to restart the computer.  
    shutdown /r /t 0  
) else if /i "!choice!"=="N" (  
    echo You have chosen not to restart the computer.  
) else (  
    echo Invalid input. Please enter Y or N.  
    pause  
)  

