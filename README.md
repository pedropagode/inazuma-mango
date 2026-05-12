# Inazuma's Mango

Macro para **Anime Vanguards** no Roblox. Automatiza runs de Cid Raid (Pain Strat) e Spring LTM com auto-rejoin, notificações via Discord e detecção visual por template matching.

**Versão atual:** `1.0.1`

---

## Requisitos

- Windows 10 ou 11
- Roblox instalado
- Licença ativa (HWID autorizado pelo administrador)
- Conexão com a internet (validação de licença ao abrir)

---

## Instalação

1. Baixe o arquivo `.zip` na aba **Releases** do repositório
2. Extraia todos os arquivos para uma pasta de sua escolha
3. Certifique-se de que a estrutura final ficou assim:

```
pasta/
├── InazumaMango.exe
├── Images/
├── tesseract/
├── config.json
├── get_hwid.bat
└── get_hwid.py
```

> **Importante:** o `.exe` precisa estar na mesma pasta que `Images/` e `tesseract/`. Não mova somente o executável.

---

## Primeira Utilização — Liberação de Licença

O macro usa validação por **HWID** (identificador único do seu PC). Antes de usar pela primeira vez:

1. Execute `get_hwid.bat`
2. Copie o código exibido na janela
3. Envie o código ao administrador para liberar o acesso
4. Após a liberação, abra `InazumaMango.exe` normalmente — não é necessário baixar nada de novo

---

## Configuração

Abra o `InazumaMango.exe`. Na interface, preencha os campos:

| Campo | Descrição |
|---|---|
| **Private Server** | Código ou link do servidor privado do AV |
| **Webhook URL** | URL do webhook do Discord para notificações de run (opcional) |
| **Run Timeout** | Tempo máximo por run em segundos antes de considerar softlock (padrão: 90s) |
| **Auto-Rejoin** | Quantidade de runs antes de reiniciar o Roblox automaticamente para evitar leak de FPS (padrão: 300) |
| **VC Chat** | Ative se estiver usando o chat de voz do Roblox (ajusta coordenadas do chat) |
| **Strategy** | Escolha entre **Pain Strat** (padrão) ou **Spring LTM** |
| **Gems / Flowers** | Quantidade atual da moeda — usada para calcular o total ganho na sessão |

As configurações são salvas automaticamente em `config.json` ao lado do `.exe`.

---

## Estratégias

### Pain Strat (padrão)
- Modo: **Cid Raid — Ruined City Act 2**
- Unidades: Pain, Ainz, Minato, Nami, Naruto
- Detecta automaticamente Kurama Mode e ajusta os posicionamentos
- Moeda rastreada: **Gems** (+150 por vitória)

### Spring LTM
- Modo: **Spring LTM**
- Seleciona automaticamente o modo Endless após o lobby
- Moeda rastreada: **Flowers** (+5400 por vitória/restart)

---

## Resolução da Janela do Roblox

O macro foi calibrado para a janela do Roblox em **800 × 600**. O alinhamento automático posiciona a janela nessa resolução ao entrar no jogo. Não redimensione manualmente durante a execução.

---

## Notificações Discord (Webhook)

Ao configurar um Webhook URL, o macro envia automaticamente:
- Resumo de cada run (vitória/derrota, tempo, gemas acumuladas)
- Notificação de rejoin automático

Para criar um webhook: **Discord → Canal → Configurações → Integrações → Webhooks → Novo Webhook → Copiar URL**.

---

## Auto-Update

Ao abrir o macro, ele verifica automaticamente se existe uma versão mais recente. Se houver, um botão de atualização aparece na interface — clique para baixar e substituir o `.exe` automaticamente.

---

## Solução de Problemas

**O macro não abre / trava na validação**
- Verifique sua conexão com a internet
- Confirme que seu HWID foi liberado pelo administrador

**Imagens não são detectadas / macro não clica no lugar certo**
- Confirme que a pasta `Images/` está ao lado do `.exe`
- Certifique-se de que o Roblox está em **800 × 600** e na posição correta (use o alinhamento automático da GUI)
- Não use escalas de DPI diferentes de 100% no Windows

**O macro ficou travado (softlock)**
- O watchdog de softlock reinicia automaticamente runs travadas após o timeout configurado

**Logs de erro**
- Crashes são salvos em `crash/` ao lado do `.exe`
- Ative **Save Log** na interface para gravar o log completo da sessão

---

## Arquivos do Release

| Arquivo | Descrição |
|---|---|
| `InazumaMango.exe` | Executável principal |
| `Images/` | Imagens de template matching (necessário ao lado do exe) |
| `tesseract/` | OCR para detecção de wave number (Spring LTM) |
| `config.json` | Configurações — editado automaticamente pela GUI |
| `get_hwid.bat` | Utilitário para obter seu HWID |
| `get_hwid.py` | Script invocado pelo `get_hwid.bat` |
