# Windows Privilege Escalation - Unattended Installation Files

## Description
This project demonstrates a privilege escalation technique in Windows environments
by extracting sensitive credentials from unattended installation files.

---

## Objective
Extract administrative credentials from unattended installation files and
gain elevated access to retrieve a target flag.

---

## Target
- **Machine:** LAB01 (Windows 10 64-bit)
- **Initial User:** Student
- **Target User:** SuperAdministrator

---

## Technique: Unattended Installation Files

### What are Unattended Files?
Unattended installation files are XML/INF configuration files used for
automated Windows installations. These files sometimes contain
plaintext or Base64-encoded administrator passwords.

### Common File Locations
| File | Path |
|------|------|
| Unattend.xml | `C:\Windows\Panther\Unattend.xml` |
| Unattended.xml | `C:\Windows\Panther\Unattended.xml` |
| sysprep.inf | `C:\Windows\System32\sysprep\sysprep.inf` |
| autounattend.xml | `C:\autounattend.xml` |

---

## Steps

### 1. Scan for Unattended Files
The script scans all common locations for unattended installation files.

### 2. Extract Password
Uses regular expressions to extract the password value from:
```xml
<AdministratorPassword>
    <Value>PASSWORD_HERE</Value>
    <PlainText>true/false</PlainText>
</AdministratorPassword>
```

### 3. Decode Password
- If `PlainText=true`  → password is used directly
- If `PlainText=false` → password is Base64 decoded

### 4. Gain Admin Access
Uses `runas` command with extracted credentials:
```powershell
runas /user:SuperAdministrator "powershell.exe"
```

### 5. Retrieve Flag
```powershell
C:\Users\SuperAdministrator\Desktop\flag.exe
```

---

## Usage

```bash
python extract_password.py
```

### Expected Output
