# claude-code-boilerplate

Template per progetti Claude Code con memoria persistente, documentazione strutturata e regole comportamentali.

## Cosa include

| File | Scopo |
|------|-------|
| `CLAUDE.md` | Istruzioni operative + Karpathy rules + riferimenti |
| `CLAUDE_MEMORY.md` | Stato sessione corrente (generato da setup.sh — vedi nota gitignore sotto) |
| `docs/architecture.md` | Architettura, stack, infrastruttura, schema I/O |
| `docs/lessons.md` | Lezioni operative e pattern consolidati |
| `.gitignore` | Creato da setup.sh con istruzioni su CLAUDE_MEMORY.md |
| `setup.sh` | Script di inizializzazione interattivo |

## Utilizzo

### 1. Clona o usa come template GitHub

```bash
git clone https://github.com/simonediroma/claude-code-boilerplate.git mio-progetto
cd mio-progetto
```

### 2. Esegui il setup

```bash
chmod +x setup.sh
./setup.sh
```

Lo script chiede:
- Nome del progetto
- File invariati da non toccare

E genera automaticamente `CLAUDE_MEMORY.md` con la data odierna.

> **Modello di lavoro:** ogni task è una sessione separata su un branch dedicato, generato automaticamente da Claude Code. Non esiste un branch fisso — ogni sessione parte da `main` e apre la sua PR.

### 3. Compila `docs/architecture.md`

Riempi le sezioni con l'architettura del tuo progetto. È il documento tecnico che Claude legge prima di ogni scelta importante.

### 4. Avvia Claude Code

```bash
claude
```

La prima volta Claude chiederà di approvare gli import `@docs/architecture.md` e `@docs/lessons.md` — approva entrambi.

## Struttura della memoria

```
CLAUDE.md          → regole fisse (committato)
CLAUDE_MEMORY.md   → stato sessione (aggiornato da Claude — vedi "Locale vs Web" sotto)
docs/architecture.md → riferimento tecnico (committato, aggiornato quando cambia l'architettura)
docs/lessons.md    → lezioni operative (committato, cresce nel tempo)
```

## Locale vs Web

Il comportamento di `CLAUDE_MEMORY.md` dipende dall'ambiente di lavoro:

| Ambiente | Comportamento |
|----------|--------------|
| **Locale** (CLI / IDE) | Aggiungere `CLAUDE_MEMORY.md` al `.gitignore` — il file persiste sul disco tra sessioni. Il file `.gitignore` creato da `setup.sh` include già la riga commentata da decommentare. |
| **Web** (claude.ai/code / remote) | **Non** ignorare il file — l'ambiente è efimero. Claude deve committare e pushare `CLAUDE_MEMORY.md` ad ogni fine sessione, altrimenti lo stato viene perso. |

## Plugin consigliati

```bash
# Graphify — trova funzionalità esistenti prima di reimplementarle
pip install graphifyy && graphify install
# Poi in Claude Code: /graphify . --mode deep

# Caveman — compressione output token
# github.com/JuliusBrussee/caveman
```

## Fine sessione

Claude aggiorna automaticamente `CLAUDE_MEMORY.md` prima del commit finale con:
- Task completati
- Prossimi step
- Blockers aperti
- PR corrente e branch

In uso web (claude.ai/code), Claude committa e pusha anche `CLAUDE_MEMORY.md` insieme agli altri file, in modo che la sessione successiva parta dallo stato corretto.
