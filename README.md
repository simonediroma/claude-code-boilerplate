# claude-code-boilerplate

Template per progetti Claude Code con memoria persistente, documentazione strutturata e regole comportamentali.

## Cosa include

| File | Scopo |
|------|-------|
| `CLAUDE.md` | Istruzioni operative + Karpathy rules + riferimenti |
| `CLAUDE_MEMORY.md` | Stato sessione corrente (gitignored, generato da setup.sh) |
| `docs/architecture.md` | Architettura, stack, infrastruttura, schema I/O |
| `docs/lessons.md` | Lezioni operative e pattern consolidati |
| `.gitignore` | Include CLAUDE_MEMORY.md + pattern comuni |
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
- Branch di sviluppo
- File invariati da non toccare

E genera automaticamente `CLAUDE_MEMORY.md` con la data odierna.

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
CLAUDE_MEMORY.md   → stato sessione (gitignored, aggiornato da Claude)
docs/architecture.md → riferimento tecnico (committato, aggiornato quando cambia l'architettura)
docs/lessons.md    → lezioni operative (committato, cresce nel tempo)
```

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
