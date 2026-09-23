
@echo off

@echo  "restrcted weisite"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v ":Range" /t REG_SZ /d 10.120.*.* /f
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range1" /v "http" /t REG_DWORD /d 2 /f

@echo  "1..NET Framework---XAML browser applications"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2400" /t REG_DWORD /d 0 /f

@echo "2..NET Framework---XPS documents"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2401" /t REG_DWORD /d 0 /f

@echo  "3..NET Framework---Loose XAML"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2402" /t REG_DWORD /d 0 /f

@echo "4..NET Framework-reliant  components---Permissions for components with manifests	"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2007" /t REG_DWORD /d 0x00010000 /f

@echo  "5..NET Framework-reliant  components---Run components not signed with Authenticode"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2004" /t REG_DWORD /d 0 /f

@echo "6..NET Framework-reliant  components---Run components signed with Authenticode"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2001" /t REG_DWORD /d 0 /f

@echo "7.ActiveX controls and plug-ins---Automatic prompting for ActiveX controls"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2201" /t REG_DWORD /d 0 /f

@echo "8.ActiveX controls and plug-ins---Script ActiveX controls marked safe for scripting"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1405" /t REG_DWORD /d 0 /f

@echo "9.ActiveX controls and plug-ins---Initialize and script ActiveX controls not marked as safe for scripting"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1201" /t REG_DWORD /d 0 /f

@echo "10.ActiveX controls and plug-ins---Binary and script behaviors"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2000" /t REG_DWORD /d 0 /f

@echo "11.ActiveX controls and plug-ins---Only allow approved domain to use ActiveX without prompt"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "120B" /t REG_DWORD /d 0 /f

@echo "12.ActiveX controls and plug-ins---Download unsigned ActiveX controls	"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1004" /t REG_DWORD /d 0 /f

@echo "13.ActiveX controls and plug-ins---Download signed ActiveX controls"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1001" /t REG_DWORD /d 0 /f

@echo "14.ActiveX controls and plug-ins---Allow ActiveX Filtering"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2702" /t REG_DWORD /d 0 /f

@echo "15.ActiveX controls and plug-ins---Allow Scriptlets"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1209" /t REG_DWORD /d 0 /f

@echo "16.ActiveX controls and plug-ins---Allow previously unused ActiveX controls to run without prompt"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1208" /t REG_DWORD /d 0 /f

@echo "17.ActiveX controls and plug-ins---Run ActiveX controls and plug-ins"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1200" /t REG_DWORD /d 0 /f

@echo "18.ActiveX controls and plug-ins---Run antimalware software on ActiveX controls"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "270C" /t REG_DWORD /d 0 /f

@echo "19.ActiveX controls and plug-ins---Display video and animation on a webpage that does not use external media player"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "120A" /t REG_DWORD /d 0 /f

@echo "20.Scripting---Scripting of java applets"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1402" /t REG_DWORD /d 0 /f

@echo "21.Scripting---Active scripting"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1400" /t REG_DWORD /d 0 /f

@echo "22.Scripting---Enable XSS filter"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1409" /t REG_DWORD /d 0 /f

@echo "23.Scripting---Allow Programmatic clipboard access"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1407" /t REG_DWORD /d 0 /f

@echo "24.Scripting---Allow status bar updates via script"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2103" /t REG_DWORD /d 0 /f

@echo  "25.Scripting---Allow websites to prompt for information using scripted windows"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2105" /t REG_DWORD /d 0 /f

@echo "26.Miscellaneous---Render legacy filters"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "270B" /t REG_DWORD /d 0 /f

@echo "27.Miscellaneous---Userdata persistence"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1606" /t REG_DWORD /d 0 /f

@echo "28.Miscellaneous---Websites in less privileged with content zone can navigate into this zone"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2101" /t REG_DWORD /d 0 /f

@echo "29.Miscellaneous---Launching applications and unsafe files"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1806" /t REG_DWORD /d 0 /f

@echo "30.Miscellaneous---Inclue local directory path when uploading files to a serve"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "160A" /t REG_DWORD /d 0 /f

@echo  "31.Miscellaneous---Navigate windows and frames across different domains"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1607" /t REG_DWORD /d 0 /f

echo "32.Miscellaneous---Enable MIME Sniffing"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2100" /t REG_DWORD /d 0 /f

echo "33.Miscellaneous---Use SmartScreen Filter"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2301" /t REG_DWORD /d 0 /f

echo "34.Miscellaneous---Use Pop-up Blocker"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1809" /t REG_DWORD /d 0x00000003 /f

echo "35.Miscellaneous---Submit non-encrypted form data"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1601" /t REG_DWORD /d 0 /f

@echo "36.Miscellaneous---Access data sources across domains"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1406" /t REG_DWORD /d 0 /f

@echo "37.Miscellaneous---Drag and drop or copy and paste files"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1802" /t REG_DWORD /d 0 /f

@echo "38.Miscellaneous---Display mixed content"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1609" /t REG_DWORD /d 0 /f

@echo "39.Miscellaneous---Allow META REFRESH"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1608" /t REG_DWORD /d 0 /f

@echo "40.Miscellaneous---Allow scripting of Microsoft web bowser control"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1206" /t REG_DWORD /d 0 /f

@echo "41.Miscellaneous---Allow script-initiated windows without size or position constraints"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2102" /t REG_DWORD /d 0 /f

@echo "42.Miscellaneous---Allow webpages to use restricted protocols for active content"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2300" /t REG_DWORD /d 0 /f

@echo "43.Miscellaneous---Allow websites to open windows without address or status bars"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2104" /t REG_DWORD /d 0 /f

@echo "44.Miscellaneous---Allow dragging of content between domains into separate windows"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2709" /t REG_DWORD /d 0 /f

@echo "45.Miscellaneous---Allow dragging of content between domains into the same window"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2708" /t REG_DWORD /d 0 /f

@echo "46.Miscellaneous---Launching programs and files in an IFRAME"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1804" /t REG_DWORD /d 0 /f

@echo "47.Miscellaneous---Don’t prompt for client certificate selection when only one certificate exists"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1A04" /t REG_DWORD /d 0 /f

@echo "48.Enable .NET Framework setup"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2600" /t REG_DWORD /d 0 /f

@echo "49.Downloads---File download"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1803" /t REG_DWORD /d 0 /f

@echo "50.Downloads---Font download"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1604" /t REG_DWORD /d 0 /f

@echo "51.Downloads---Logon"
@ reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1A00" /t REG_DWORD /d 0 /f

@echo  "add registry options for security domain of IE  successfully"

pause