if !A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}
#Persistent
#NoEnv
#SingleInstance, Force

GoSub, ReadInterval
return

; ── Lê intervalo do config ────────────────────────────────────────────────────
ReadInterval:
    iniFile    := A_ScriptDir . "\ram_trim_config.ini"
    IniRead, rawVal, %iniFile%, Settings, IntervalMinutes, 6
    intervalMs := rawVal * 60000
    if (intervalMs < 120000)
        intervalMs := 120000
    if (intervalMs > 900000)
        intervalMs := 900000
    SetTimer, AutoRamTrim, %intervalMs%
return

; ── Ciclo de trim ─────────────────────────────────────────────────────────────
AutoRamTrim:
    GoSub, ReadInterval

    WinGet, robloxList, List, ahk_exe RobloxPlayerBeta.exe
    if (robloxList = 0)
        return

    totalSavedBytes := 0

    Loop, %robloxList%
    {
        this_id  := robloxList%A_Index%
        WinGet, this_pid, PID, ahk_id %this_id%

        hProcess := DllCall("OpenProcess", "UInt", 0x1F0FFF, "Int", 0, "UInt", this_pid, "Ptr")
        if (!hProcess)
            continue

        ; Lê WorkingSetSize ANTES do trim
        ; PROCESS_MEMORY_COUNTERS (72 bytes, 64-bit): WorkingSetSize em offset 16
        VarSetCapacity(pmc, 72, 0)
        NumPut(72, pmc, 0, "UInt")
        DllCall("psapi.dll\GetProcessMemoryInfo", "Ptr", hProcess, "Ptr", &pmc, "UInt", 72)
        wssBefore := NumGet(pmc, 16, "UInt64")

        DllCall("psapi.dll\EmptyWorkingSet", "Ptr", hProcess)

        ; Lê WorkingSetSize DEPOIS do trim
        VarSetCapacity(pmc2, 72, 0)
        NumPut(72, pmc2, 0, "UInt")
        DllCall("psapi.dll\GetProcessMemoryInfo", "Ptr", hProcess, "Ptr", &pmc2, "UInt", 72)
        wssAfter := NumGet(pmc2, 16, "UInt64")

        DllCall("CloseHandle", "Ptr", hProcess)

        saved := wssBefore - wssAfter
        if (saved > 0)
            totalSavedBytes += saved
    }

    ; Converte para MB e escreve no result file para o GUI ler
    savedMB := totalSavedBytes / 1048576.0
    resultFile := A_ScriptDir . "\ram_trim_result.ini"
    IniWrite, %savedMB%, %resultFile%, Result, SavedMB
return
