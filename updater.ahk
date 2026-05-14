; updater.ahk — Inazuma Mango auto-updater (AHK v2)
; ─────────────────────────────────────────────────────────────────────────────
; Recebe o caminho do .exe atual como primeiro parametro.
; Fluxo:
;   1. Espera o processo principal fechar
;   2. Baixa InazumaMango.exe (release mais recente)
;   3. Baixa AutoRamTrim.ahk (release mais recente)
;   4. Relança o InazumaMango.exe
; ─────────────────────────────────────────────────────────────────────────────

#Requires AutoHotkey v2.0

REPO_OWNER := "pedropagode"
REPO_REPO  := "inazuma-mango"
BASE_URL   := "https://github.com/" . REPO_OWNER . "/" . REPO_REPO . "/releases/latest/download/"

EXE_NAME   := "InazumaMango.exe"
AHK_NAME   := "AutoRamTrim.ahk"

; Recebe o caminho do exe como arg ou detecta pelo script location
exePath := A_Args.Length > 0 ? A_Args[1] : A_ScriptDir . "\" . EXE_NAME
exeDir  := RegExReplace(exePath, "\\[^\\]+$", "")

; Garante que o diretorio termina sem barra
if SubStr(exeDir, -1) = "\"
    exeDir := SubStr(exeDir, 1, -1)

exeUrl  := BASE_URL . EXE_NAME
ahkUrl  := BASE_URL . AHK_NAME
exeDest := exeDir . "\" . EXE_NAME
ahkDest := exeDir . "\" . AHK_NAME

; ── 1. Aguarda o processo principal encerrar (até 30s) ───────────────────────
exeBase := RegExReplace(EXE_NAME, "\.exe$", "")
Loop 60 {
    if !ProcessExist(exeBase)
        break
    Sleep(500)
}

; Pausa extra para liberar file handles do SO
Sleep(1500)

; ── 2. Baixa o novo InazumaMango.exe ─────────────────────────────────────────
try {
    if FileExist(exeDest)
        FileDelete(exeDest)
    Download(exeUrl, exeDest)
} catch as e {
    MsgBox("Falha ao baixar " . EXE_NAME . "`n" . e.Message, "Inazuma Updater", 16)
    ExitApp(1)
}

; ── 3. Baixa AutoRamTrim.ahk ─────────────────────────────────────────────────
try {
    if FileExist(ahkDest)
        FileDelete(ahkDest)
    Download(ahkUrl, ahkDest)
} catch {
    ; Falha no AutoRamTrim nao deve bloquear o update do exe principal
    ; Apenas continua — o arquivo antigo já foi deletado, mas o trim funciona
    ; sem ele (só não trimará até o próximo ciclo)
}

; ── 4. Relança o exe atualizado ──────────────────────────────────────────────
try {
    Run(exeDest)
} catch as e {
    MsgBox("Update concluido mas falha ao relançar.`n" . e.Message
           . "`nAbra manualmente: " . exeDest, "Inazuma Updater", 48)
}

ExitApp(0)
