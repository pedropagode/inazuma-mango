; updater.ahk
; ─────────────
; Updater do InazumaMango.exe — logica identica ao padrao AHK:
;   FileDelete  → apaga o exe atual
;   Download    → baixa o novo direto no lugar
;   Run         → relanca
;
; Chamado pelo update_api.py via subprocess quando o usuario confirma o update.
; Recebe o caminho do exe como primeiro parametro (%1%).
; Se nao receber parametro, assume o proprio diretorio do script.

#Requires AutoHotkey v2.0
#SingleInstance Force

EXE_NAME  := "InazumaMango.exe"
GH_USER   := "pedropagode"
GH_REPO   := "inazuma-mango"

; Caminho do exe passado pelo update_api.py, ou detectado automaticamente
if A_Args.Length >= 1
    macro_path := A_Args[1]
else
    macro_path := A_ScriptDir "\" EXE_NAME

download_url := "https://github.com/" GH_USER "/" GH_REPO "/releases/latest/download/" EXE_NAME

; Espera o InazumaMango.exe realmente fechar antes de mexer no arquivo.
; O Python chama Popen(ahk) e DEPOIS QApplication.quit(), entao eles correm
; em paralelo — o exe pode levar segundos para finalizar, e enquanto o
; processo existe o Windows mantem lock exclusivo no executavel, causando
; erro 32 ("arquivo em uso") tanto no FileDelete quanto no Download.
SplitPath(macro_path, &exe_basename)
ProcessWaitClose(exe_basename, 30)

; Mesmo apos o processo sair, o Windows pode demorar alguns ms liberando o
; handle. Tenta deletar em loop ate conseguir (ou desistir apos ~5s).
delete_ok := false
loop 25 {
    try {
        FileDelete(macro_path)
        delete_ok := true
        break
    } catch {
        Sleep 200
    }
}
if !delete_ok and FileExist(macro_path) {
    MsgBox "Nao foi possivel remover o exe atual — feche o InazumaMango e tente novamente.",
           "InazumaMango Update", 16
    ExitApp()
}

; Baixa o novo exe direto no mesmo caminho
try {
    Download(download_url, macro_path)
} catch Error as e {
    MsgBox "Falha ao baixar a atualizacao:`n" e.Message, "InazumaMango Update", 16
    ExitApp()
}

Sleep 500

; Relanca o exe atualizado
Run macro_path
ExitApp()
