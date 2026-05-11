import hashlib
import subprocess
import sys
import uuid

SERVER = "https://inazuma-license.onrender.com"


def wmic(query: str) -> str:
    try:
        out = subprocess.check_output(
            "wmic " + query, shell=True,
            stderr=subprocess.DEVNULL, timeout=5,
        ).decode(errors="ignore")
        lines = [l.strip() for l in out.splitlines() if l.strip()]
        return lines[1] if len(lines) > 1 else ""
    except Exception:
        return ""


def get_hwid() -> str:
    mac  = hex(uuid.getnode())
    cpu  = wmic("cpu get ProcessorId")
    disk = wmic("diskdrive get SerialNumber")
    raw  = f"{mac}|{cpu}|{disk}"
    return hashlib.sha256(raw.encode()).hexdigest()[:24].upper()


def copy_to_clipboard(text: str) -> bool:
    """Copia o texto para o clipboard do Windows via clip.exe (stdlib)."""
    try:
        subprocess.run(
            "clip", input=text.encode("utf-16le"),
            shell=True, check=True, timeout=5,
        )
        return True
    except Exception:
        return False


def main():
    hwid = get_hwid()

    print()
    print("  ============================================")
    print("   Inazuma Mango -- Verificacao de Acesso")
    print("  ============================================")
    print()
    print(f"   HWID: {hwid}")
    print()

    copied = copy_to_clipboard(hwid)
    if copied:
        print("   [OK] Seu HWID foi copiado para a area de transferencia!")
        print("        Cole com Ctrl+V onde quiser enviar.")
    else:
        print("   [!] Nao foi possivel copiar automaticamente.")
        print("       Selecione o codigo acima e copie manualmente.")
    print()
    print("  Verificando licenca no servidor...")
    print()

    # Usa urllib (stdlib) para nao depender de requests
    import json
    import urllib.parse
    import urllib.request

    url = f"{SERVER}/check?hwid={urllib.parse.quote(hwid)}"

    try:
        req = urllib.request.Request(url, headers={"User-Agent": "InazumaHWID/1.0"})
        with urllib.request.urlopen(req, timeout=30) as resp:
            data = json.loads(resp.read().decode("utf-8"))
    except Exception as e:
        print("  [ERRO] Nao foi possivel contactar o servidor.")
        print(f"  Detalhes: {e}")
        print()
        print(f"  URL testada: {url}")
        print()
        return

    allowed = data.get("allowed", False)
    print()
    if allowed:
        print("  ============================================")
        print("   Acesso Liberado")
        nome = data.get("user", "")
        if nome:
            print(f"   Bem-vindo, {nome}!")
        print("  ============================================")
    else:
        print("  ============================================")
        print("   Acesso Bloqueado")
        print()
        print("   Seu HWID nao esta autorizado.")
        print()
        print(f"   {hwid}")
        print()
        if copy_to_clipboard(hwid):
            print("   [OK] HWID copiado para a area de transferencia.")
            print("        Cole com Ctrl+V e envie ao administrador.")
        else:
            print("   Envie o codigo acima ao administrador.")
        print("  ============================================")
    print()


if __name__ == "__main__":
    try:
        main()
    except Exception:
        import traceback
        traceback.print_exc()
