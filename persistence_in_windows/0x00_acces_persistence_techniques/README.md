# Persistence Using Startup Folder

## What is Startup Folder?
Windows Startup folder içindeki her fayl user login olduqda avtomatik işləyir.

## Startup Folder Paths
- User: `C:\Users\<Username>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`
- Global: `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup`

## Steps
1. Open PowerShell as Administrator
2. List files in Startup folders
3. Found malicious file: `vmtoolsd.bat`
4. Got MD5 hash using Get-FileHash

## Commands Used
```powershell
Get-ChildItem "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup" -Force
Get-FileHash -Path "C:\Users\SuperAdministrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\vmtoolsd.bat" -Algorithm MD5
```

## Result
- Malicious File: `vmtoolsd.bat`
- MD5 Hash: `05809C521098E03F0BCC7CC878399D0F`

## Tools
- PowerShell
